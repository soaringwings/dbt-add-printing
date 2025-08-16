with base as (
    select
        *
    from {{ source('quickbooks_staging', 'stg_quickbooks__item')}} i
    -- the i is set as the alias of the table
    where lower(type) != 'category'
),

mapped as (
    select
        m.parent_item_id,
        m.is_bag,
        m.is_box
    from {{ ref('category_map') }} m
)

select distinct 
    b.item_id,
    b.name as item_name,
    b.parent_item_id,
    nullif(b.purchase_cost, 0) as purchase_cost,
    b.inventory_start_date,
    coalesce(m.is_bag, false) as is_bag,
    coalesce(m.is_box, false) as is_box,
from base b
left join mapped m
using (parent_item_id)