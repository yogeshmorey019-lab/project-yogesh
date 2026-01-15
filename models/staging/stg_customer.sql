---create view

{{
    config(
        materialized='view'
    )
}}

select *
from (
    select
        emp_id,
        emp_name,
        email,
        row_number() over (
            partition by emp_id
            order by emp_id
        ) as rn
    from {{ source('dbtt', 'customer') }}
)
where rn = 1

