-- with invoice as (
--     select * from `splendid-strand-463617-k9.quickbooks.invoice`
-- ),

-- item as (
--     select * from `splendid-strand-463617-k9.quickbooks.item`
-- ), 

-- invoice_line as (
--     select * from `splendid-strand-463617-k9.quickbooks.invoice_line`
-- ),

-- final as (
--     select
--         inv.id as invoice_id,
--         inv.* except(id),
--         il.invoice_id as invoice_line_id,
--         il.* except(id, invoice_id, _fivetran_synced)
        

--     from invoice as inv

--     left join invoice_line as il
--         on inv.id = il.invoice_id
-- )

-- select * from final