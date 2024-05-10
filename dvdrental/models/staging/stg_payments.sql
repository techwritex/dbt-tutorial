{{ config(materialized='view') }}

select payment_id,
        customer_id,
        payment_date,
        amount
    
    from public.payment

    order by amount desc