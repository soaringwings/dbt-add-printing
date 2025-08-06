with invoice as (
    select * from splendid-strand-463617-k9.quickbooks.invoice
),

item as (
    select * from splendid-strand-463617-k9.quickbooks.item
), 

invoice_line as (
    select * from splendid-strand-463617-k9.quickbooks.invoice_line
),

final as (
    select
        * from invoice

    left join invoice_line
        on invoice.id = invoice_line.invoice_id
)

select * from final