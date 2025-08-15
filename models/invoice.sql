-- {{ config(materialized='table') }}



-- select
--     i.customer_id,
--     il.sales_item_item_id as item_id,
--     extract(month from i.transaction_date) as month,
--     sum(il.sales_item_quantity) as units_sold,
--     sum(il.amount) as revenue,
--     i.* except(customer_id),
--     il.* except(sales_item_item_id, id, _fivetran_synced, sales_item_quantity, amount)
-- from `splendid-strand-463617-k9.quickbooks.invoice` i
-- join `splendid-strand-463617-k9.quickbooks.invoice_line` il
-- on i.id = il.invoice_id
-- where il.detail_type = 'SalesItemLineDetail'
-- group by 1, 2, 3