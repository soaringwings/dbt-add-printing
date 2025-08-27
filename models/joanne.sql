{{ config(materialized='table') }}

select
    client_name as customer_name,
    total_amount_on_the_invoice as invoice_total,
    invoice_no_ as invoice_no,
    open_balance,
    month,
    -- defect/shortage is a dollar amount/number not a flag
    production_defect_or_shortage as defect_storage_amount,
    fully_paid_or_not_y_n_ as is_fully_paid,
    total_amount_before_tax as subtotal,
    payment_received,
    production_in_local_or_china,
    mer,
    order_status,
    printer_justin_or_raj_or_inhouse_
-- seems that columns that do not have any data in the original google sheet do not appear as columns in the exported table
from splendid-strand-463617-k9.google_drive.copy_of_add_sales_book_2025_joanne_sample_
