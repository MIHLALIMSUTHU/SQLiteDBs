-- SQLite
select count(*) from orders;

-- list all distinct order statuses--
select distinct order_status from orders; 

--count customers per state--
select customer_state, count(*) as "customer count"
from customers
group by customer_state;

-- sellers per state--
select seller_state, count(*) as seller_count
from sellers
group by seller_state;

-- count the number of orders by status--
select order_status, count(*) as order_count
from orders
group by order_status;

-- count the number of orders that were delivered late--
select count(*) as late_orders
from orders
where order_status = 'delivered'
and order_delivered_customer_date > order_estimated_delivery_date;

--how many unique customers have placed at least one order--
select count(distinct(customer_id)) as unique_customers
from orders;


--how many orders were paid in more than two installments--
select count(*) as orders_paid_in_installments
from order_payments
where payment_installments >=2;

--how many orders were placed each month, we are looking for a count of orders in cronological order--
select count(order_id) as order_count, order_purchase_timestamp
from orders
where order_purchase_timestamp is not null
order by order_purchase_timestamp asc;

select order_purchase_timestamp, count(order_id)
from orders
group by order_purchase_timestamp;

--count number of reviews per score--
select count(*) as review_count, review_score
from  order_reviews
group by review_score;

--count of how many products exist in each product category--
select product_category_name, count(*) as product_count
from products
group by product_category_name;

--how many orders were purchased each year--
select strftime('%Y', order_purchase_timestamp) as year, count(*) as 'number of orders'
from orders
group by year;

--how many payments were made using each payment type--
select 
count(*) as count_of_paymnets, payment_type
from order_payments
group by payment_type;

--count of how many orders were delivered on time vs late--
select 
    count(*) as order_count, 
    case 
        when order_delivered_customer_date <= order_estimated_delivery_date then 'on time'
        else 'late' end as delivery_status
from orders
where order_status = 'delivered'
group by delivery_status;

--count of how many customers exist in each state, yet only shopw states with at least 1000 customers--
select count(*) as customer_count, customer_state
from customers
group by customer_state
having count(*) > 1000;

--COUNT OF HOW MANY ORDERS WERE MADE WITH EACH PAYMENT INSTALLMENT NUMBER--
select distinct(payment_installments) from order_payments;

select count(*) as order_count, payment_installments
from order_payments
group by payment_installments;


--list all orders with customer states--
select 
    o.order_id, 
    c.customer_state
from orders o
join customers c
    on o.customer_id = c.customer_id;

--count of how many orders were placed by a customer in each state--
select 
    count(order_id), 
    customer_state
from orders o
join customers c
    on o.customer_id = c.customer_id
group by c.customer_state;

--top 5 states with the most orders--
select 
    count(o.order_id) as orders, 
    c.customer_state
from orders o 
join customers c
    on o.customer_id = c.customer_id
group by customer_state
order by orders desc
limit 5;

--Average delay for delivered orders--
select 
    AVG(
    julianday(order_delivered_customer_date) 
    - julianday(order_estimated_delivery_date)
    ) as average_delay_days
from orders
where order_status = 'delivered';

--Julianday is for doing math on dates, while strftime is for formatting dates as text.--


--Which product category has the highest avarage review score?--
select 
    p.product_category_name as product_category,
    avg(orv.review_score) as average_review_score
from order_items oi
join order_reviews orv
    on oi.order_id = orv.order_id
join products p 
    on p.product_id = oi.product_id
group by product_category_name
order by average_review_score desc;
