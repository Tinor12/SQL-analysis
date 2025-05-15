-- query 1 : total revenue
SELECT SUM(total_amount) AS total_revenue FROM orders;

-- query 2 :Number of Orders Per Month

SELECT 
    MONTH(order_date) AS month,
    COUNT(*) AS order_count
FROM orders
GROUP BY MONTH(order_date)
ORDER BY month;

-- query 3: Top 5 Products by Sales Volume

SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY oi.product_id
ORDER BY total_sold DESC
LIMIT 5;

-- query 4:Revenue by Category

SELECT 
    c.category_name,
    SUM(oi.quantity * oi.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_id;

-- query 5 : Repeat Customers (users with more than 1 order)

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(o.order_id) AS total_orders
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id
HAVING total_orders > 1;

-- query 6:Create a View

CREATE VIEW monthly_sales AS
SELECT 
    MONTH(order_date) AS month,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY MONTH(order_date);
SELECT * FROM monthly_sales;

-- query 7: indexing

CREATE INDEX idx_user_id ON orders(user_id);
