-- SQLite
select * from transactions;

--Get the total number of transactions--
select 
    count(*) as total_transactions, 
    round(sum(amt), 0) as total_amount, 
    round(avg(amt), 0) as average_amount, 
    round(min(amt), 0) as minimum_amount, 
    round(max(amt), 0) as maximum_amount
from transactions;

--Wich transaction categories drive the most money through the system?--
select 
    merchant, 
    category, 
    count(*) as Number_of_transactions,
    sum(amt) as Total_transactions_value
from transactions
group by merchant, category
order by Total_transactions_value desc;

--How do transaction volume and total transaction value change over time?--
select 
    strftime('%Y-%m', trans_date_trans_time) as transaction_months, 
    count(*) as Number_of_transactions_per_month,
    sum(amt) as Total_transaction_value_per_month
from transactions
group by transaction_months
order by transaction_months;

--Identifying high-risk transactions. Which transactions are unusually high and could pose a risk?--
--Top 10 high-value transactions above 10,000--
select 
    strftime('%Y-%m-%d', trans_date_trans_time) as transaction_date,
    trans_num as transaction_number,
    cc_num as credit_card_number,
    round(amt, 2) as transaction_amount,
    merchant
from transactions
where amt > 10000
order by transaction_amount desc
limit 10;

--Customer behavior analysis. Which customers are the most active and high value?--
--The following are the top ten customers by total spend, including transaction count and average transaction amount-- 
select 
    cc_num as credit_card_number,
    count(*) as total_transactions,
    round(sum(amt), 2) as total_spent,
    round(avg(amt), 2) as average_transaction_value
from transactions
group by cc_num
order by total_spent desc
limit 10;

-- Credit card brand analysis: number of transactions and total transaction value
select 
    case 
        when substr(cc_num, 1, 1) = '4' then 'Visa'
        when substr(cc_num, 1, 2) between '51' and '55' then 'Mastercard'
        when substr(cc_num, 1, 2) in ('34', '37') then 'American Express'
        else 'Discover'
    end as card_brand,
    count(*) as number_of_transactions,
    round(sum(amt), 2) as total_transaction_value
from transactions
group by card_brand
order by number_of_transactions desc;
