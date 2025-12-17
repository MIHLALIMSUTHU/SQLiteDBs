SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id 
GROUP BY c.customer_id
ORDER BY total_spent DESC;


SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM customers;
SELECT * FROM order_items;

SELECT 
    products.name, order_items.quantity, 
    SUM(order_items.quantity * order_items.price) AS Revenue
FROM order_items
JOIN products ON order_items. product_id = products.product_id
GROUP BY products.name 
ORDER BY Revenue DESC;



Select AVG(total_amount) AS Average_value,
FROM orders;

