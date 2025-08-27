{{ config(materialized='table') }}

select
  i.id                                as invoice_id,
  i.customer_id,
  date(i.transaction_date)            as invoice_date,
  il.id                               as invoice_line_id,
  il.sales_item_item_id               as item_id,
  il.sales_item_quantity              as quantity,
  il.amount                           as line_amount
from {{ source('quickbooks', 'invoice') }} i
join {{ source('quickbooks', 'invoice_line') }} il
  on i.id = il.invoice_id
where il.detail_type = 'SalesItemLineDetail'