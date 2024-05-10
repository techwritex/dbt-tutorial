{{ config(materialized='view') }}

WITH customers as (
    
    select * from {{ ref('stg_customers') }}
),

payment as (
    
    select * from {{ ref('stg_payments') }}
),

customer_payment as (
    
    select customer_id,
        min(payment_date) as first_payment_date,
        max(payment_date) as last_payment_date,
        count(payment_id) as number_of_payments
    
    from payment
    
    group by 1
),

final as (
    
    select customers.customer_id,
        customers.first_name,
        customers.last_name,
        coalesce(customer_payment.number_of_payments, 0) as number_of_payments
    
    from customers
        left join customer_payment on customers.customer_id = customer_payment.customer_id
    
    ORDER BY number_of_payments DESC
)

select * from final