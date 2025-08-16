{# CREATE OR REPLACE VIEW analytics.fact_sales_line AS #}
SELECT
  {# es.source_relation, #}
  es.transaction_id,             -- stable unique id per txn
  es.transaction_line_id,        -- stable unique id per line
  es.transaction_type,           -- 'Invoice','SalesReceipt','CreditMemo', etc.
  es.doc_number,                 -- invoice number / receipt #
  DATE(es.transaction_date) AS txn_date,
  es.customer_id,
  es.customer_name,
  es.item_id,
  dp.item_name,
  dp.is_bag,
  dp.is_box,
  {# dp.bag_type, #}
  SAFE_CAST(es.item_quantity AS NUMERIC)                             AS quantity,
  -- Use the model’s untaxed/converted amount if present; otherwise fallback:
  (CASE
     WHEN LOWER(es.transaction_type) = 'creditmemo' THEN -1
     ELSE 1
   END) *
   {# SAFE_CAST(COALESCE(es.amount_excluding_tax, es.amount) AS NUMERIC) AS line_revenue_excl_tax #}
   {# SAFE_CAST(es.amount AS NUMERIC) AS line_revenue_excl_tax #}
   SAFE_CAST(es.amount AS NUMERIC) AS line_revenue
FROM {{ source('quickbooks', 'quickbooks__expenses_sales_enhanced') }} es
LEFT JOIN {{ source('dbt_tyu', 'dim_product') }} dp
  ON dp.item_id = es.item_id
WHERE es.transaction_source = 'sales'  -- filters to sales-side lines only