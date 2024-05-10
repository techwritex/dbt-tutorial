{{ config(materialized='view') }}

select customer_id,
        first_name,
        last_name
    
    from public.customer

    order by customer_id asc