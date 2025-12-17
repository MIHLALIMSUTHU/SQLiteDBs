select 
    strftime('%Y-%m', order_purchase_timestamp) as purchase_month,
    count(*) as total_orders,

    sum(case 
        when order_status = 'delivered' then 1 
        else 0 
    end) as delivered_orders,

    sum(case 
        when order_status = 'delivered'
         and order_delivered_customer_date is not null
         and order_estimated_delivery_date is not null
         and order_delivered_customer_date <= order_estimated_delivery_date
        then 1 else 0 
    end) as on_time_deliveries,

    sum(case 
        when order_status = 'delivered'
         and order_delivered_customer_date is not null
         and order_estimated_delivery_date is not null
         and order_delivered_customer_date > order_estimated_delivery_date
        then 1 else 0 
    end) as late_deliveries,

    coalesce(
        round(
            100.0 * 
            sum(case 
                when order_status = 'delivered'
                 and order_delivered_customer_date is not null
                 and order_estimated_delivery_date is not null
                 and order_delivered_customer_date <= order_estimated_delivery_date
                then 1 else 0 end
            )
            / nullif(sum(case when order_status = 'delivered' then 1 else 0 end), 0),
            2
        ), 0
    ) as on_time_delivery_percentage
from orders
group by purchase_month
order by purchase_month;