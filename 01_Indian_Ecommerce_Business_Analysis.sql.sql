SELECT VERSION();

USE indian_ecommerce;

SHOW TABLES;
SHOW DATABASES;

CREATE DATABASE indian_ecommerce;
SHOW DATABASES;

USE indian_ecommerce;


SHOW GLOBAL VARIABLES LIKE 'local_infile';

SHOW SESSION VARIABLES LIKE 'local_infile';

-- import the customers data.    
    
LOAD DATA LOCAL INFILE 'C:/EcommerceData/customers.csv'
INTO TABLE customers
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    customer_id,
    @signup_date,
    gender,
    @age,
    age_group,
    state,
    city,
    pincode_prefix,
    customer_segment,
    preferred_device,
    preferred_payment_method,
    acquisition_channel,
    total_orders,
    total_spend,
    @last_order_date,
    average_order_value,
    customer_status,
    loyalty_tier
)
SET
    customer_signup_date = NULLIF(TRIM(@signup_date), ''),
    age = NULLIF(@age, ''),
    last_order_date = NULLIF(TRIM(@last_order_date), '');
    
    SELECT COUNT(*) AS total_customers
FROM customers;

USE indian_ecommerce;

-- import the orders data.

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    order_date DATE,
    order_time TIME,
    order_status VARCHAR(50),
    shipping_method VARCHAR(50),
    delivery_city VARCHAR(100),
    delivery_state VARCHAR(100),
    coupon_code VARCHAR(100),
    discount_percentage DECIMAL(5,2),
    marketing_channel VARCHAR(50),
    subtotal DECIMAL(15,2),
    shipping_fee DECIMAL(15,2),
    tax_amount DECIMAL(15,2),
    final_amount DECIMAL(15,2),
    campaign_id VARCHAR(50)
);

DESCRIBE orders;

DESCRIBE orders;

SELECT COUNT(*) AS total_orders
FROM orders;


-- import the orders data.

LOAD DATA LOCAL INFILE 'C:/EcommerceData/orders.csv'
INTO TABLE orders
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    order_id,
    customer_id,
    @order_date,
    order_time,
    order_status,
    shipping_method,
    delivery_city,
    delivery_state,
    coupon_code,
    discount_percentage,
    marketing_channel,
    subtotal,
    shipping_fee,
    tax_amount,
    final_amount,
    campaign_id
)
SET order_date = NULLIF(TRIM(@order_date), '');

SELECT COUNT(*) AS total_orders
FROM orders;

USE indian_ecommerce;

-- import the order_items data.

LOAD DATA LOCAL INFILE 'C:/EcommerceData/order_items.csv'
INTO TABLE order_items
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    order_item_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    discount_percentage,
    item_revenue,
    item_cost,
    profit
);

SELECT COUNT(*) AS total_order_items
FROM order_items;

-- import the products data.

USE indian_ecommerce;

CREATE TABLE products (
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(100),
    subcategory VARCHAR(100),
    brand VARCHAR(100),
    price DECIMAL(15,2),
    cost_price DECIMAL(15,2),
    discount_range VARCHAR(50),
    rating_average DECIMAL(3,2),
    rating_count INT,
    stock_quantity INT,
    product_launch_date DATE,
    product_type VARCHAR(50),
    return_rate_baseline DECIMAL(5,2)
);

DESCRIBE products;

SELECT COUNT(*) AS total_products
FROM products;


LOAD DATA LOCAL INFILE 'C:/EcommerceData/products.csv'
INTO TABLE products
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    product_id,
    product_name,
    category,
    subcategory,
    brand,
    price,
    cost_price,
    discount_range,
    @rating_average,
    rating_count,
    stock_quantity,
    @product_launch_date,
    product_type,
    return_rate_baseline
)
SET
    rating_average = NULLIF(@rating_average, ''),
    product_launch_date = NULLIF(TRIM(@product_launch_date), '');
    
SELECT COUNT(*) AS total_products
FROM products;

SELECT product_id, return_rate_baseline
FROM products
LIMIT 10;

SELECT COUNT(*) AS total_products
FROM products;

SELECT
    product_id,
    return_rate_baseline
FROM products
LIMIT 10;

SHOW WARNINGS;

USE indian_ecommerce;

CREATE TABLE payments (
    payment_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20),
    payment_date DATE,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    amount_paid DECIMAL(15,2),
    transaction_fee DECIMAL(15,2),
    refund_amount DECIMAL(15,2)
);

-- import the  payment data 

LOAD DATA LOCAL INFILE 'C:/EcommerceData/payments.csv'
INTO TABLE payments
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    payment_id,
    order_id,
    @payment_date,
    payment_method,
    payment_status,
    amount_paid,
    transaction_fee,
    refund_amount
)
SET payment_date = NULLIF(TRIM(@payment_date), '');

SELECT COUNT(*) AS total_payments
FROM payments;

USE indian_ecommerce;

CREATE TABLE shipments (
    shipment_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20),
    warehouse_city VARCHAR(100),
    delivery_city VARCHAR(100),
    shipping_method VARCHAR(50),
    dispatch_date DATE,
    expected_delivery_date DATE,
    actual_delivery_date DATE,
    delivery_days INT,
    delivery_status VARCHAR(50),
    delayed_flag TINYINT
);

DESCRIBE shipments;

SELECT COUNT(*) AS total_shipments
FROM shipments;

LOAD DATA LOCAL INFILE 'C:/EcommerceData/shipments.csv'
INTO TABLE shipments
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    shipment_id,
    order_id,
    warehouse_city,
    delivery_city,
    shipping_method,
    @dispatch_date,
    @expected_delivery_date,
    @actual_delivery_date,
    @delivery_days,
    delivery_status,
    delayed_flag
)
SET
    dispatch_date = NULLIF(TRIM(@dispatch_date), ''),
    expected_delivery_date = NULLIF(TRIM(@expected_delivery_date), ''),
    actual_delivery_date = NULLIF(TRIM(@actual_delivery_date), ''),
    delivery_days = NULLIF(@delivery_days, '');
    
    
SELECT COUNT(*) AS total_shipments
FROM shipments;

USE indian_ecommerce;

CREATE TABLE returns (
    return_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20),
    customer_id VARCHAR(20),
    product_id VARCHAR(20),
    return_date DATE,
    return_reason VARCHAR(100),
    refund_amount DECIMAL(15,2),
    return_status VARCHAR(50)
);

DESCRIBE returns;

SELECT COUNT(*) AS total_returns
FROM returns;

-- import the returns data .

LOAD DATA LOCAL INFILE 'C:/EcommerceData/returns.csv'
INTO TABLE returns
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    return_id,
    order_id,
    customer_id,
    product_id,
    @return_date,
    return_reason,
    refund_amount,
    return_status
)
SET return_date = NULLIF(TRIM(@return_date), '');

SELECT COUNT(*) AS total_returns
FROM returns;


USE indian_ecommerce;

CREATE TABLE customer_reviews (
    review_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20),
    customer_id VARCHAR(20),
    product_id VARCHAR(20),
    review_date DATE,
    rating INT,
    review_sentiment VARCHAR(30),
    verified_purchase TINYINT
);

DESCRIBE customer_reviews;

SELECT COUNT(*) AS total_reviews
FROM customer_reviews;

LOAD DATA LOCAL INFILE 'C:/EcommerceData/customer_reviews.csv'
INTO TABLE customer_reviews
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    review_id,
    order_id,
    customer_id,
    product_id,
    @review_date,
    rating,
    review_sentiment,
    verified_purchase
)
SET review_date = NULLIF(TRIM(@review_date), '');

SELECT *
FROM customer_reviews
LIMIT 5;

SELECT
    verified_purchase,
    COUNT(*) AS total
FROM customer_reviews
GROUP BY verified_purchase;

TRUNCATE TABLE customer_reviews;

LOAD DATA LOCAL INFILE 'C:/EcommerceData/customer_reviews.csv'
INTO TABLE customer_reviews
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    review_id,
    order_id,
    customer_id,
    product_id,
    @review_date,
    rating,
    review_sentiment,
    @verified_purchase
)
SET
    review_date = NULLIF(TRIM(@review_date), ''),
    verified_purchase = CASE
        WHEN LOWER(TRIM(REPLACE(@verified_purchase, '\r', ''))) = 'true' THEN 1
        WHEN LOWER(TRIM(REPLACE(@verified_purchase, '\r', ''))) = 'false' THEN 0
        ELSE NULL
    END;
    
SELECT
    verified_purchase,
    COUNT(*) AS total
FROM customer_reviews
GROUP BY verified_purchase;

USE indian_ecommerce;

CREATE TABLE marketing_campaigns (
    campaign_id VARCHAR(20) PRIMARY KEY,
    campaign_name VARCHAR(255),
    channel VARCHAR(50),
    campaign_start_date DATE,
    campaign_end_date DATE,
    campaign_type VARCHAR(100),
    target_segment VARCHAR(100),
    discount_percentage DECIMAL(5,2),
    conversions INT,
    revenue_generated DECIMAL(15,2),
    impressions BIGINT,
    clicks BIGINT,
    campaign_cost DECIMAL(15,2),
    roi DECIMAL(15,4)
);

DESCRIBE marketing_campaigns;

SELECT COUNT(*) AS total_campaigns
FROM marketing_campaigns;

LOAD DATA LOCAL INFILE 'C:/EcommerceData/marketing_campaigns.csv'
INTO TABLE marketing_campaigns
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    campaign_id,
    campaign_name,
    channel,
    @campaign_start_date,
    @campaign_end_date,
    campaign_type,
    target_segment,
    discount_percentage,
    conversions,
    revenue_generated,
    impressions,
    clicks,
    campaign_cost,
    roi
)
SET
    campaign_start_date = NULLIF(TRIM(@campaign_start_date), ''),
    campaign_end_date = NULLIF(TRIM(@campaign_end_date), '');
    
SELECT COUNT(*) AS total_campaigns
FROM marketing_campaigns;

-- final verification for all 9 datasets imported.

SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'shipments', COUNT(*) FROM shipments
UNION ALL
SELECT 'returns', COUNT(*) FROM returns
UNION ALL
SELECT 'customer_reviews', COUNT(*) FROM customer_reviews
UNION ALL
SELECT 'marketing_campaigns', COUNT(*) FROM marketing_campaigns;


-- Database relationships and validation.

-- we need to establish and verify relationship between tables using Primary key and Foreign Key.

USE indian_ecommerce;

-- Primary key

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'indian_ecommerce'
ORDER BY TABLE_NAME, COLUMN_NAME;

-- Foreign Key

SELECT
    COUNT(*) AS invalid_order_customers
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Validate Order items against orders.alter

SELECT
    COUNT(*) AS invalid_order_items
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Validate Products against order items.

SELECT
    COUNT(*) AS invalid_order_item_products
FROM order_items oi
LEFT JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;


-- Validate Payments against orders.

SELECT
    COUNT(*) AS invalid_payment_orders
FROM payments p
LEFT JOIN orders o
    ON p.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Validate shipments against orders.

SELECT
    COUNT(*) AS invalid_shipment_orders
FROM shipments s
LEFT JOIN orders o
    ON s.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Validate Returns against orders

SELECT
    COUNT(*) AS invalid_return_orders
FROM returns r
LEFT JOIN orders o
    ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Validate returns against customers.

SELECT
    COUNT(*) AS invalid_return_customers
FROM returns r
LEFT JOIN customers c
    ON r.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Validate returns against products.

SELECT
    COUNT(*) AS invalid_return_products
FROM returns r
LEFT JOIN products p
    ON r.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Validate customer reviews against orders.

SELECT
    COUNT(*) AS invalid_review_orders
FROM customer_reviews cr
LEFT JOIN orders o
    ON cr.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Validate Customer reviews against customers.
SELECT
    COUNT(*) AS invalid_review_customers
FROM customer_reviews cr
LEFT JOIN customers c
    ON cr.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Validate customer reviews against Products.

SELECT
    COUNT(*) AS invalid_review_products
FROM customer_reviews cr
LEFT JOIN products p
    ON cr.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Create the 11 Foreign Keys.

USE indian_ecommerce;

-- 1. Orders → Customers
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

-- 2. Order Items → Orders
ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- 3. Order Items → Products
ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);

-- 4. Payments → Orders
ALTER TABLE payments
ADD CONSTRAINT fk_payments_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- 5. Shipments → Orders
ALTER TABLE shipments
ADD CONSTRAINT fk_shipments_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- 6. Returns → Orders
ALTER TABLE returns
ADD CONSTRAINT fk_returns_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- 7. Returns → Customers
ALTER TABLE returns
ADD CONSTRAINT fk_returns_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

-- 8. Returns → Products
ALTER TABLE returns
ADD CONSTRAINT fk_returns_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);

-- 9. Customer Reviews → Orders
ALTER TABLE customer_reviews
ADD CONSTRAINT fk_reviews_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- 10. Customer Reviews → Customers
ALTER TABLE customer_reviews
ADD CONSTRAINT fk_reviews_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

-- 11. Customer Reviews → Products
ALTER TABLE customer_reviews
ADD CONSTRAINT fk_reviews_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);

-- Verify 11 Foreign Keys.

SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'indian_ecommerce'
AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME;

--
USE indian_ecommerce;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_orders
FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_products
FOREIGN KEY (product_id) REFERENCES products(product_id);

ALTER TABLE payments
ADD CONSTRAINT fk_payments_orders
FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE shipments
ADD CONSTRAINT fk_shipments_orders
FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE returns
ADD CONSTRAINT fk_returns_orders
FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE returns
ADD CONSTRAINT fk_returns_customers
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

ALTER TABLE returns
ADD CONSTRAINT fk_returns_products
FOREIGN KEY (product_id) REFERENCES products(product_id);

ALTER TABLE customer_reviews
ADD CONSTRAINT fk_reviews_orders
FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE customer_reviews
ADD CONSTRAINT fk_reviews_customers
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'indian_ecommerce'
AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME;

--
SELECT
    CONSTRAINT_NAME,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'indian_ecommerce'
AND CONSTRAINT_TYPE = 'FOREIGN KEY'
ORDER BY TABLE_NAME;


USE indian_ecommerce;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);

ALTER TABLE payments
ADD CONSTRAINT fk_payments_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

ALTER TABLE shipments
ADD CONSTRAINT fk_shipments_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

ALTER TABLE returns
ADD CONSTRAINT fk_returns_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

ALTER TABLE returns
ADD CONSTRAINT fk_returns_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE returns
ADD CONSTRAINT fk_returns_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);

ALTER TABLE customer_reviews
ADD CONSTRAINT fk_reviews_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

SELECT
    CONSTRAINT_NAME,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'indian_ecommerce'
AND CONSTRAINT_TYPE = 'FOREIGN KEY'
ORDER BY TABLE_NAME;

-- 1. Orders → Customers
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

-- 2. Order Items → Orders
ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- 3. Order Items → Products
ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);

-- 4. Payments → Orders
ALTER TABLE payments
ADD CONSTRAINT fk_payments_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- 5. Shipments → Orders
ALTER TABLE shipments
ADD CONSTRAINT fk_shipments_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- 6. Returns → Orders
ALTER TABLE returns
ADD CONSTRAINT fk_returns_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- 7. Returns → Customers
ALTER TABLE returns
ADD CONSTRAINT fk_returns_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

-- 8. Returns → Products
ALTER TABLE returns
ADD CONSTRAINT fk_returns_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);

SELECT
    CONSTRAINT_NAME,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'indian_ecommerce'
AND CONSTRAINT_TYPE = 'FOREIGN KEY'
ORDER BY TABLE_NAME;

-- Add Returns -> Customer
ALTER TABLE returns
ADD CONSTRAINT fk_returns_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

-- orders-> Customers

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

-- order_items-> orders.
ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- Order_items -> Products
ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);

-- Payment-> orders
ALTER TABLE payments
ADD CONSTRAINT fk_payments_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- Shipments-> orders
ALTER TABLE shipments
ADD CONSTRAINT fk_shipments_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- Returns->Orders
ALTER TABLE returns
ADD CONSTRAINT fk_returns_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- final verification.

SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'indian_ecommerce'
AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME;

-- SQL BUSINESS ANALYSIS..

-- How much total revenue has the e-commerce business generated..
USE indian_ecommerce;

SELECT
    SUM(final_amount) AS total_revenue
FROM orders;

-- How many total orders were placed in the e-commerce business.

SELECT
    COUNT(order_id) AS total_orders
FROM orders;

-- AVERAGE ORDER VALUE(AOV)
-- Find the average amount customers spend per order.

SELECT
    AVG(final_amount) AS average_order_value
FROM orders;

-- TOTAL CUSTOMERS..
-- How many unique customers are registered in the business.

SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM customers;

-- TOTAL PRODUCTS.
-- Find the total number of unique products available in the product catalogue.

SELECT
    COUNT(DISTINCT product_id) AS total_products
FROM products;

-- TOTAL PRODUCT CATEGORY.
-- Find how many different products categories the business sells.

SELECT
    COUNT(DISTINCT category) AS total_categories
FROM products;

-- TOTAL UNITS SOLD..
-- Calculate the total quantity of products sold across all order items.

SELECT
    SUM(quantity) AS total_units_sold
FROM order_items;

-- TOTAL PROFIT.
-- Calculate the total profit generated from all products sold.

SELECT
    SUM(profit) AS total_profit
FROM order_items;

-- OVERALL PROFIT MARGIN..
-- Calculate the Percentage of revenue retained as profit.

SELECT
    ROUND(
        (SUM(profit) / SUM(item_revenue)) * 100,
        2
    ) AS profit_margin_percentage
FROM order_items;

-- TOTAL RETURNED ORDERS..
-- Find how many unique orders have atleast one return.

SELECT
    COUNT(DISTINCT order_id) AS total_returned_orders
FROM returns;

-- ORDER RETURN RATE..
-- Calculate the percentage of orders that had atleast one return.

SELECT
    ROUND(
        (COUNT(DISTINCT r.order_id) /
         (SELECT COUNT(*) FROM orders)) * 100,
        2
    ) AS order_return_rate_percentage
FROM returns r;

-- TOTAL REFUND AMOUNT..
-- Calculate how much money the business refunded to customers.

SELECT
    ROUND(SUM(refund_amount), 2) AS total_refund_amount
FROM returns;

-- AVERAGE CUSTOMER SPENDING..
-- Calculate the average total spending per customer.

SELECT
    ROUND(AVG(total_spend), 2) AS average_customer_spending
FROM customers;

-- TOTAL PAYMENT METHODS..
-- Find how many different payments methods customers use.

SELECT
    COUNT(DISTINCT payment_method) AS total_payment_methods
FROM payments;

-- TOTAL MARKETING CAMPAIGNS..
-- Find the total number of marketing campaigns conducted by the business.

SELECT
    COUNT(DISTINCT campaign_id) AS total_campaigns
FROM marketing_campaigns;

-- TOTAL REVENUE BY ORDER STATUS.
-- Find how much revenue each order status contributes to the business.

SELECT
    order_status,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(final_amount), 2) AS total_revenue
FROM orders
GROUP BY order_status
ORDER BY total_revenue DESC;

-- MONTHLY REVENUE ANALYSIS..
-- Identify monthly revenue trends and understand how revenue change over time.

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(final_amount), 2) AS monthly_revenue
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    order_year,
    order_month;
    
    -- REVENUE BY PRODUCT CATEGORY..
    -- Identify which product categories generate the highest revenue..
    
    SELECT
    p.category,
    SUM(oi.quantity) AS total_units_sold,
    ROUND(SUM(oi.item_revenue), 2) AS total_revenue,
    ROUND(SUM(oi.profit), 2) AS total_profit
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- REVENUE BY STATE..
-- Identify which indian states generate the highest revenue.

SELECT
    delivery_state,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(final_amount), 2) AS total_revenue
FROM orders
GROUP BY delivery_state
ORDER BY total_revenue DESC;

-- TOP 10 BEST SELLING PRODUCTS..
-- Identify the 10 products with the highest sales quantity..

SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(oi.quantity) AS total_units_sold,
    ROUND(SUM(oi.item_revenue), 2) AS total_revenue,
    ROUND(SUM(oi.profit), 2) AS total_profit
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_units_sold DESC
LIMIT 10;

-- TOP 10 MOST PROFITABLE PRODUCTS..
-- Identify which products generate the highest total profit..

SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(oi.quantity) AS total_units_sold,
    ROUND(SUM(oi.item_revenue), 2) AS total_revenue,
    ROUND(SUM(oi.profit), 2) AS total_profit
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_profit DESC
LIMIT 10;

-- CUSTOMER SEGMENTATION ANALYSIS..
-- Understand customer distribution and spending across different customer segments.

SELECT
    customer_segment,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(total_orders) AS total_orders,
    ROUND(SUM(total_spend), 2) AS total_revenue,
    ROUND(AVG(total_spend), 2) AS average_customer_spending
FROM customers
GROUP BY customer_segment
ORDER BY total_revenue DESC;

-- CUSTOMER GENDER ANALYSIS..
-- Analyse customer distribution and spending by gender..

SELECT
    gender,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(total_orders) AS total_orders,
    ROUND(SUM(total_spend), 2) AS total_revenue,
    ROUND(AVG(total_spend), 2) AS average_customer_spending
FROM customers
GROUP BY gender
ORDER BY total_revenue DESC;

-- CUSTOMER ACQUISTION CHANNEL ANALYSIS..
-- Identify which marketing channels bring the most customers and revenue.

SELECT
    acquisition_channel,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(total_orders) AS total_orders,
    ROUND(SUM(total_spend), 2) AS total_revenue,
    ROUND(AVG(total_spend), 2) AS average_customer_spending
FROM customers
GROUP BY acquisition_channel
ORDER BY total_revenue DESC;

-- PAYMENT METHOD ANALYSIS..
-- Identify the most frequently used payment methods and the revenue collected through each method

SELECT
    payment_method,
    COUNT(payment_id) AS total_transactions,
    ROUND(SUM(amount_paid), 2) AS total_amount_paid,
    ROUND(SUM(transaction_fee), 2) AS total_transaction_fees,
    ROUND(SUM(refund_amount), 2) AS total_refunds
FROM payments
GROUP BY payment_method
ORDER BY total_amount_paid DESC;

-- PAYMENT STATUS ANALYSIS..
-- Analyse successful, failed, pending and other payment statuses..

SELECT
    payment_status,
    COUNT(payment_id) AS total_transactions,
    ROUND(SUM(amount_paid), 2) AS total_amount_paid,
    ROUND(SUM(refund_amount), 2) AS total_refunds
FROM payments
GROUP BY payment_status
ORDER BY total_transactions DESC;

-- DELIVERY PERFORMANCE ANALYSIS..
-- Analyse shipment delievery statuses , delays and delivery performance..

SELECT
    delivery_status,
    COUNT(shipment_id) AS total_shipments,
    SUM(delayed_flag) AS delayed_shipments,
    ROUND(AVG(delivery_days), 2) AS average_delivery_days
FROM shipments
GROUP BY delivery_status
ORDER BY total_shipments DESC;

-- OVERALL DELIVERY DELAY RATE..
-- Calculate the percentage of shipments that were delayed..

SELECT
    COUNT(shipment_id) AS total_shipments,
    SUM(delayed_flag) AS delayed_shipments,
    ROUND(
        SUM(delayed_flag) * 100.0 /
        COUNT(shipment_id),
        2
    ) AS delivery_delay_rate_percentage
FROM shipments;

-- AVERAGE DELIVERY TIME BY SHIPPING METHODS..
-- Identify which shipping methods deliver orders faster or slower..

SELECT
    shipping_method,
    COUNT(shipment_id) AS total_shipments,
    ROUND(AVG(delivery_days), 2) AS average_delivery_days,
    SUM(delayed_flag) AS delayed_shipments,
    ROUND(
        SUM(delayed_flag) * 100.0 /
        COUNT(shipment_id),
        2
    ) AS delay_rate_percentage
FROM shipments
WHERE delivery_days IS NOT NULL
GROUP BY shipping_method
ORDER BY average_delivery_days ASC;

-- RETURN REASONS ANALYSIS..
-- Identify the most common reasons customers return products..

SELECT
    return_reason,
    COUNT(return_id) AS total_returns,
    ROUND(SUM(refund_amount), 2) AS total_refund_amount
FROM returns
GROUP BY return_reason
ORDER BY total_returns DESC;

-- RETURN RATE BY PRODUCT CATEGORY ..
-- Identify which product categories have the highest return rates..

SELECT
    p.category,
    SUM(oi.quantity) AS total_units_sold,
    COUNT(DISTINCT r.return_id) AS total_returns,
    ROUND(
        COUNT(DISTINCT r.return_id) * 100.0 /
        SUM(oi.quantity),
        2
    ) AS return_rate_percentage
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN returns r
    ON oi.order_id = r.order_id
    AND oi.product_id = r.product_id
GROUP BY p.category
ORDER BY return_rate_percentage DESC;

-- MARKETING CAMPAIGN PERFORMANCE..
-- Identify which marketing campaigns generate the highest revenue, conversions, and return on investment (ROI).

SELECT
    campaign_id,
    campaign_name,
    channel,
    conversions,
    ROUND(revenue_generated, 2) AS revenue_generated,
    ROUND(campaign_cost, 2) AS campaign_cost,
    ROUND(roi, 2) AS roi
FROM marketing_campaigns
ORDER BY revenue_generated DESC;

-- MARKETING PERFORMANCE BY CHANNEL..
-- ompare marketing channels to identify which channels generate the most revenue, conversions, and return on investment.

SELECT
    channel,
    COUNT(campaign_id) AS total_campaigns,
    SUM(conversions) AS total_conversions,
    ROUND(SUM(revenue_generated), 2) AS total_revenue,
    ROUND(SUM(campaign_cost), 2) AS total_campaign_cost,
    ROUND(
        (SUM(revenue_generated) - SUM(campaign_cost))
        / NULLIF(SUM(campaign_cost), 0) * 100,
        2
    ) AS overall_roi_percentage
FROM marketing_campaigns
GROUP BY channel
ORDER BY total_revenue DESC;

-- CUSTOMER REVIEW ANALYSIS..
-- Analyse customer satisfaction using the customer_reviews table...

SELECT
    rating,
    COUNT(review_id) AS total_reviews,
    ROUND(AVG(rating), 2) AS average_rating
FROM customer_reviews
GROUP BY rating
ORDER BY rating DESC;

-- REVIEW SENTIMENT ANALYSIS..
-- Analyse customer sentiment:- Positive , negative , netural , and unknown.

SELECT
    review_sentiment,
    COUNT(review_id) AS total_reviews,
    ROUND(
        COUNT(review_id) * 100.0 /
        (SELECT COUNT(*) FROM customer_reviews),
        2
    ) AS review_percentage
FROM customer_reviews
GROUP BY review_sentiment
ORDER BY total_reviews DESC;

-- CUSTOMER SENTIMENT BY PRODUCT CATEGORY...
-- Which product categories receive the most negative customer feedback..

SELECT
    p.category,
    COUNT(cr.review_id) AS total_reviews,

    SUM(CASE
        WHEN cr.review_sentiment = 'Positive' THEN 1
        ELSE 0
    END) AS positive_reviews,

    SUM(CASE
        WHEN cr.review_sentiment = 'Neutral' THEN 1
        ELSE 0
    END) AS neutral_reviews,

    SUM(CASE
        WHEN cr.review_sentiment = 'Negative' THEN 1
        ELSE 0
    END) AS negative_reviews,

    ROUND(AVG(cr.rating), 2) AS average_rating

FROM customer_reviews cr
JOIN products p
    ON cr.product_id = p.product_id

GROUP BY p.category
ORDER BY negative_reviews DESC;

-- VERIFIED VS NON VERIFIED CUSTOMER REVIEWS..
-- Compare the ratings from customers who made verified purchases with those who did not..

SELECT
    CASE
        WHEN verified_purchase = 1 THEN 'Verified Purchase'
        WHEN verified_purchase = 0 THEN 'Non-Verified Purchase'
    END AS purchase_type,

    COUNT(review_id) AS total_reviews,
    ROUND(AVG(rating), 2) AS average_rating,

    SUM(CASE
        WHEN review_sentiment = 'Positive' THEN 1
        ELSE 0
    END) AS positive_reviews,

    SUM(CASE
        WHEN review_sentiment = 'Neutral' THEN 1
        ELSE 0
    END) AS neutral_reviews,

    SUM(CASE
        WHEN review_sentiment = 'Negative' THEN 1
        ELSE 0
    END) AS negative_reviews

FROM customer_reviews
GROUP BY verified_purchase
ORDER BY total_reviews DESC;

-- MONTHLY CUSTOMER REVIEW TRENDS..
-- Analyse how customers reviews and average ratings change month by month.

SELECT
    DATE_FORMAT(review_date, '%Y-%m') AS review_month,
    COUNT(review_id) AS total_reviews,
    ROUND(AVG(rating), 2) AS average_rating,

    SUM(CASE
        WHEN review_sentiment = 'Positive' THEN 1
        ELSE 0
    END) AS positive_reviews,

    SUM(CASE
        WHEN review_sentiment = 'Negative' THEN 1
        ELSE 0
    END) AS negative_reviews

FROM customer_reviews
GROUP BY DATE_FORMAT(review_date, '%Y-%m')
ORDER BY review_month;

-- BEST AND WORST RATED PRODUCTS..
-- Identify individual products that receive the highest and lowest customer ratings..

SELECT
    p.product_id,
    p.product_name,
    p.category,
    COUNT(cr.review_id) AS total_reviews,
    ROUND(AVG(cr.rating), 2) AS average_rating,

    SUM(CASE
        WHEN cr.review_sentiment = 'Negative' THEN 1
        ELSE 0
    END) AS negative_reviews

FROM customer_reviews cr
JOIN products p
    ON cr.product_id = p.product_id

GROUP BY
    p.product_id,
    p.product_name,
    p.category

HAVING COUNT(cr.review_id) >= 50

ORDER BY average_rating ASC, total_reviews DESC;

-- TOP 10 PRODUCTS BY CUSTOMER SATISFACTION.
-- Identify the products with the highest ratings, but this time require at least 100 reviews to make the comparison more reliable.

SELECT
    p.product_id,
    p.product_name,
    p.category,
    COUNT(cr.review_id) AS total_reviews,
    ROUND(AVG(cr.rating), 2) AS average_rating,

    SUM(CASE
        WHEN cr.review_sentiment = 'Positive' THEN 1
        ELSE 0
    END) AS positive_reviews

FROM customer_reviews cr
JOIN products p
    ON cr.product_id = p.product_id

GROUP BY
    p.product_id,
    p.product_name,
    p.category

HAVING COUNT(cr.review_id) >= 100

ORDER BY average_rating DESC, total_reviews DESC
LIMIT 10;

-- CUSTOMER LIFETIME VALUE(CLV) ANALYSIS..
-- Analyze the customer values using the customers table..

SELECT
    customer_segment,
    COUNT(customer_id) AS total_customers,

    ROUND(AVG(total_spend), 2) AS average_customer_spend,

    ROUND(MIN(total_spend), 2) AS minimum_customer_spend,

    ROUND(MAX(total_spend), 2) AS maximum_customer_spend,

    ROUND(SUM(total_spend), 2) AS total_customer_spend,

    ROUND(AVG(total_orders), 2) AS average_orders_per_customer

FROM customers
GROUP BY customer_segment
ORDER BY average_customer_spend DESC;

-- HIGH VALUE CUSTOMER IDENTIFICATION..
-- Identify the top 20 customers based on their total spending..

SELECT
    customer_id,
    customer_segment,
    acquisition_channel,
    total_orders,
    ROUND(total_spend, 2) AS total_spend,
    ROUND(
        total_spend / NULLIF(total_orders, 0),
        2
    ) AS average_order_value
FROM customers
ORDER BY total_spend DESC
LIMIT 20;

-- CUSTOMER RENTENTION BY SEGMENT..
-- Compare repeat customers across customer segment..

SELECT
    customer_segment,

    COUNT(customer_id) AS total_customers,

    SUM(CASE
        WHEN total_orders > 1 THEN 1
        ELSE 0
    END) AS repeat_customers,

    SUM(CASE
        WHEN total_orders = 1 THEN 1
        ELSE 0
    END) AS one_time_customers,

    ROUND(
        SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(customer_id),
        2
    ) AS repeat_customer_percentage,

    ROUND(AVG(total_orders), 2) AS average_orders

FROM customers
GROUP BY customer_segment
ORDER BY repeat_customer_percentage DESC;

-- CUSTOMER PURCHASE FREQUENCY..
-- Understand how frequently customers purchase..

SELECT
    CASE
        WHEN total_orders = 0 THEN 'No Orders'
        WHEN total_orders = 1 THEN '1 Order'
        WHEN total_orders BETWEEN 2 AND 3 THEN '2-3 Orders'
        WHEN total_orders BETWEEN 4 AND 5 THEN '4-5 Orders'
        WHEN total_orders BETWEEN 6 AND 10 THEN '6-10 Orders'
        ELSE 'More than 10 Orders'
    END AS purchase_frequency,

    COUNT(customer_id) AS total_customers,

    ROUND(
        COUNT(customer_id) * 100.0 /
        (SELECT COUNT(*) FROM customers),
        2
    ) AS customer_percentage,

    ROUND(AVG(total_spend), 2) AS average_customer_spend

FROM customers
GROUP BY purchase_frequency
ORDER BY
    CASE purchase_frequency
        WHEN 'No Orders' THEN 1
        WHEN '1 Order' THEN 2
        WHEN '2-3 Orders' THEN 3
        WHEN '4-5 Orders' THEN 4
        WHEN '6-10 Orders' THEN 5
        ELSE 6
    END;

-- CUSTOMER RECENCY ANALYSIS..
-- Analyse when customers last purchased. This helps identify recently active and potentially inactive customers.

SELECT
    CASE
        WHEN last_order_date IS NULL THEN 'Never Purchased'
        WHEN DATEDIFF(
            (SELECT MAX(order_date) FROM orders),
            last_order_date
        ) <= 30 THEN '0-30 Days'
        WHEN DATEDIFF(
            (SELECT MAX(order_date) FROM orders),
            last_order_date
        ) <= 90 THEN '31-90 Days'
        WHEN DATEDIFF(
            (SELECT MAX(order_date) FROM orders),
            last_order_date
        ) <= 180 THEN '91-180 Days'
        WHEN DATEDIFF(
            (SELECT MAX(order_date) FROM orders),
            last_order_date
        ) <= 365 THEN '181-365 Days'
        ELSE 'More than 365 Days'
    END AS recency_group,

    COUNT(customer_id) AS total_customers,

    ROUND(AVG(total_spend), 2) AS average_customer_spend

FROM customers
GROUP BY recency_group
ORDER BY
    CASE recency_group
        WHEN '0-30 Days' THEN 1
        WHEN '31-90 Days' THEN 2
        WHEN '91-180 Days' THEN 3
        WHEN '181-365 Days' THEN 4
        WHEN 'More than 365 Days' THEN 5
        ELSE 6
    END;

-- CUSTOMER RFM(RECENCY, FREQUENCY, MONETARY)
-- Recency: How recently a customer purchased.
-- Frequency: How many orders the customer made.
-- Monetary: How much the customer spent.

WITH customer_rfm AS (
    SELECT
        customer_id,
        DATEDIFF(
            (SELECT MAX(order_date) FROM orders),
            last_order_date
        ) AS recency_days,
        total_orders,
        total_spend
    FROM customers
    WHERE last_order_date IS NOT NULL
),
rfm_scores AS (
    SELECT
        customer_id,
        recency_days,
        total_orders,
        total_spend,

        NTILE(5) OVER (
            ORDER BY recency_days DESC
        ) AS recency_score,

        NTILE(5) OVER (
            ORDER BY total_orders
        ) AS frequency_score,

        NTILE(5) OVER (
            ORDER BY total_spend
        ) AS monetary_score

    FROM customer_rfm
)
SELECT
    customer_id,
    recency_days,
    total_orders,
    ROUND(total_spend, 2) AS total_spend,
    recency_score,
    frequency_score,
    monetary_score,
    recency_score + frequency_score + monetary_score AS rfm_total_score
FROM rfm_scores
ORDER BY rfm_total_score DESC, total_spend DESC;

-- RFM CUSTOMER SEGMENTATION
-- Convert the RFM scores into understandable business segments.

WITH customer_rfm AS (
    SELECT
        customer_id,
        DATEDIFF(
            (SELECT MAX(order_date) FROM orders),
            last_order_date
        ) AS recency_days,
        total_orders,
        total_spend
    FROM customers
    WHERE last_order_date IS NOT NULL
),
rfm_scores AS (
    SELECT
        customer_id,
        recency_days,
        total_orders,
        total_spend,

        NTILE(5) OVER (
            ORDER BY recency_days DESC
        ) AS recency_score,

        NTILE(5) OVER (
            ORDER BY total_orders
        ) AS frequency_score,

        NTILE(5) OVER (
            ORDER BY total_spend
        ) AS monetary_score

    FROM customer_rfm
),
rfm_segments AS (
    SELECT
        *,
        recency_score + frequency_score + monetary_score
            AS rfm_total_score,

        CASE
            WHEN recency_score >= 4
                 AND frequency_score >= 4
                 AND monetary_score >= 4
                THEN 'Champions'

            WHEN recency_score >= 3
                 AND frequency_score >= 4
                THEN 'Loyal Customers'

            WHEN recency_score >= 4
                 AND frequency_score <= 2
                THEN 'Recent Customers'

            WHEN recency_score <= 2
                 AND frequency_score >= 3
                THEN 'At Risk'

            WHEN recency_score <= 2
                 AND frequency_score <= 2
                THEN 'Lost Customers'

            ELSE 'Potential Loyalists'
        END AS customer_rfm_segment

    FROM rfm_scores
)
SELECT
    customer_rfm_segment,
    COUNT(customer_id) AS total_customers,
    ROUND(AVG(total_spend), 2) AS average_spend,
    ROUND(AVG(total_orders), 2) AS average_orders,
    ROUND(AVG(recency_days), 2) AS average_recency_days,
    ROUND(AVG(rfm_total_score), 2) AS average_rfm_score
FROM rfm_segments
GROUP BY customer_rfm_segment
ORDER BY total_customers DESC;

-- CUSTOMER CHURN RISK ANALYSIS..
-- Identify customers who may be at risk of becoming inactive..

SELECT
    CASE
        WHEN last_order_date IS NULL THEN 'Never Purchased'

        WHEN DATEDIFF(
            (SELECT MAX(order_date) FROM orders),
            last_order_date
        ) > 365 THEN 'High Churn Risk'

        WHEN DATEDIFF(
            (SELECT MAX(order_date) FROM orders),
            last_order_date
        ) BETWEEN 181 AND 365 THEN 'Medium Churn Risk'

        WHEN DATEDIFF(
            (SELECT MAX(order_date) FROM orders),
            last_order_date
        ) BETWEEN 91 AND 180 THEN 'Low Churn Risk'

        ELSE 'Active Customers'
    END AS churn_risk_group,

    COUNT(customer_id) AS total_customers,

    ROUND(AVG(total_spend), 2) AS average_customer_spend,

    ROUND(AVG(total_orders), 2) AS average_orders

FROM customers
GROUP BY churn_risk_group
ORDER BY total_customers DESC;

-- CHURN RISK BY CUSTOMER SEGMENT..
-- Identify which customer segments contain the most high risk customers..

SELECT
    customer_segment,

    CASE
        WHEN last_order_date IS NULL THEN 'Never Purchased'

        WHEN DATEDIFF(
            (SELECT MAX(order_date) FROM orders),
            last_order_date
        ) > 365 THEN 'High Churn Risk'

        WHEN DATEDIFF(
            (SELECT MAX(order_date) FROM orders),
            last_order_date
        ) BETWEEN 181 AND 365 THEN 'Medium Churn Risk'

        WHEN DATEDIFF(
            (SELECT MAX(order_date) FROM orders),
            last_order_date
        ) BETWEEN 91 AND 180 THEN 'Low Churn Risk'

        ELSE 'Active Customers'
    END AS churn_risk_group,

    COUNT(customer_id) AS total_customers,

    ROUND(AVG(total_spend), 2) AS average_customer_spend

FROM customers

GROUP BY
    customer_segment,
    churn_risk_group

ORDER BY
    customer_segment,
    total_customers DESC;
    
-- CHURN RISK BY ACQUISTION CHANNEL..
-- Identify which customer acquisition channels bring customers who are more likely to become inactive.

SELECT
    acquisition_channel,

    COUNT(customer_id) AS total_customers,

    SUM(CASE
        WHEN DATEDIFF(
            (SELECT MAX(order_date) FROM orders),
            last_order_date
        ) > 365 THEN 1
        ELSE 0
    END) AS high_churn_risk_customers,

    ROUND(
        SUM(CASE
            WHEN DATEDIFF(
                (SELECT MAX(order_date) FROM orders),
                last_order_date
            ) > 365 THEN 1
            ELSE 0
        END) * 100.0 / COUNT(customer_id),
        2
    ) AS high_churn_risk_percentage,

    ROUND(AVG(total_spend), 2) AS average_customer_spend

FROM customers
GROUP BY acquisition_channel
ORDER BY high_churn_risk_percentage DESC;

-- MONTHLY CUSTOMER ACQUISITION ANALYSIS..
-- Identify how many new customers the business acquired each month and which months had the highest customer acquisition.

SHOW COLUMNS FROM customers;

-- MONTHLY CUSTOMER ACQUISTION ANALYSIS..
-- Calculate how many new customers registered each month.

SELECT
    DATE_FORMAT(customer_signup_date, '%Y-%m') AS signup_month,
    COUNT(customer_id) AS new_customers,
    COUNT(DISTINCT acquisition_channel) AS acquisition_channels,
    COUNT(DISTINCT state) AS states_reached
FROM customers
WHERE customer_signup_date IS NOT NULL
GROUP BY DATE_FORMAT(customer_signup_date, '%Y-%m')
ORDER BY signup_month;

-- CUSTOMER COHORT RETENTION ANALYSIS..
-- Find out whether customers continue purchasing after the month they first registered.

WITH customer_cohorts AS (
    SELECT
        customer_id,
        DATE_FORMAT(customer_signup_date, '%Y-%m-01')
            AS cohort_month
    FROM customers
    WHERE customer_signup_date IS NOT NULL
),

cohort_sizes AS (
    SELECT
        cohort_month,
        COUNT(DISTINCT customer_id) AS cohort_size
    FROM customer_cohorts
    GROUP BY cohort_month
),

customer_activity AS (
    SELECT DISTINCT
        c.customer_id,
        c.cohort_month,
        TIMESTAMPDIFF(
            MONTH,
            STR_TO_DATE(c.cohort_month, '%Y-%m-%d'),
            DATE_FORMAT(o.order_date, '%Y-%m-01')
        ) AS month_number
    FROM customer_cohorts c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_date >= STR_TO_DATE(
        c.cohort_month,
        '%Y-%m-%d'
    )
)
SELECT
    a.cohort_month,
    a.month_number,
    s.cohort_size,
    COUNT(DISTINCT a.customer_id) AS active_customers,
 ROUND(
        COUNT(DISTINCT a.customer_id) * 100.0 /
        s.cohort_size,
        2
    ) AS retention_percentage
FROM customer_activity a
JOIN cohort_sizes s
    ON a.cohort_month = s.cohort_month
GROUP BY
    a.cohort_month,
    a.month_number,
    s.cohort_size
ORDER BY
    a.cohort_month,
    a.month_number;
    
-- ORDER DISCOUNT ANALYSIS..
-- Analyse how discounts affect order revenue and customer purchases.

SHOW COLUMNS FROM orders;

-- Analyse how different discount levels affect order volume, revenue, and average order value.

SELECT
    CASE
        WHEN discount_percentage = 0 THEN 'No Discount'
        WHEN discount_percentage <= 10 THEN '1-10%'
        WHEN discount_percentage <= 20 THEN '11-20%'
        WHEN discount_percentage <= 30 THEN '21-30%'
        WHEN discount_percentage <= 40 THEN '31-40%'
        ELSE 'Above 40%'
    END AS discount_group,

    COUNT(order_id) AS total_orders,

    ROUND(AVG(discount_percentage), 2) AS average_discount,

    ROUND(SUM(subtotal), 2) AS total_subtotal,

    ROUND(SUM(final_amount), 2) AS total_revenue,

    ROUND(AVG(final_amount), 2) AS average_order_value

FROM orders

GROUP BY discount_group

ORDER BY
    CASE discount_group
        WHEN 'No Discount' THEN 1
        WHEN '1-10%' THEN 2
        WHEN '11-20%' THEN 3
        WHEN '21-30%' THEN 4
        WHEN '31-40%' THEN 5
        ELSE 6
    END;

-- SHIPPING PERFORMANCE BY STATE..
-- Identify which states have the highest delivery delays. This will help us identify regional shipping problems.

SHOW COLUMNS FROM shipments;

-- Connect the SHIPMENTS table with the ORDERS table to identify which states experience the most delivery delays..

SHOW COLUMNS FROM customers;

SELECT
    c.state,

    COUNT(s.shipment_id) AS total_shipments,

    SUM(CASE
        WHEN s.delayed_flag = 1 THEN 1
        ELSE 0
    END) AS delayed_shipments,

    ROUND(
        SUM(CASE
            WHEN s.delayed_flag = 1 THEN 1
            ELSE 0
        END) * 100.0 / COUNT(s.shipment_id),
        2
    ) AS delay_percentage,
    ROUND(AVG(s.delivery_days), 2) AS average_delivery_days
FROM shipments s
JOIN orders o
    ON s.order_id = o.order_id
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE s.delivery_days IS NOT NULL
GROUP BY c.state
ORDER BY delay_percentage DESC;

-- Data Reconciliation and Validation..
-- Compare the four financial totals..

SHOW COLUMNS FROM payments;

SELECT
    'Orders' AS data_source,
    COUNT(order_id) AS total_records,
    ROUND(SUM(final_amount), 2) AS total_amount
FROM orders

UNION ALL

SELECT
    'Order Items',
    COUNT(order_item_id),
    ROUND(SUM(item_revenue), 2)
FROM order_items

UNION ALL

SELECT
    'Payments',
    COUNT(payment_id),
    ROUND(SUM(amount_paid), 2)
FROM payments

UNION ALL

SELECT
    'Customers',
    COUNT(customer_id),
    ROUND(SUM(total_spend), 2)
FROM customers;

--  We need to know how much was successfully paid, refunded, failed, or left pending.
-- PAYMENT AMOUNT BY PAYMENT STATUS..

SELECT
    payment_status,
    COUNT(payment_id) AS total_transactions,
    ROUND(SUM(amount_paid), 2) AS total_amount_paid,
    ROUND(AVG(amount_paid), 2) AS average_payment_amount
FROM payments
GROUP BY payment_status
ORDER BY total_transactions DESC;

-- MATCH PAYMENTS WITH ORDERS..
-- Investigate whether payment records match their corresponding order amounts.

SELECT
    o.order_id,
    o.final_amount AS order_amount,
    p.amount_paid AS payment_amount,
    p.payment_status,

    ROUND(
        o.final_amount - p.amount_paid,
        2
    ) AS amount_difference

FROM orders o

JOIN payments p
    ON o.order_id = p.order_id

WHERE p.payment_status = 'Success'
  AND ABS(o.final_amount - p.amount_paid) > 0.01

ORDER BY ABS(o.final_amount - p.amount_paid) DESC
LIMIT 100;

-- Check every order has a corresponding payment record and any order has multiple payment records..

SELECT
    COUNT(*) AS total_orders,

    SUM(CASE
        WHEN payment_count = 0 THEN 1
        ELSE 0
    END) AS orders_without_payment,

    SUM(CASE
        WHEN payment_count = 1 THEN 1
        ELSE 0
    END) AS orders_with_one_payment,

    SUM(CASE
        WHEN payment_count > 1 THEN 1
        ELSE 0
    END) AS orders_with_multiple_payments

FROM (
    SELECT
        o.order_id,
        COUNT(p.payment_id) AS payment_count
    FROM orders o
    LEFT JOIN payments p
        ON o.order_id = p.order_id
    GROUP BY o.order_id
) AS payment_check;

SELECT
    COUNT(*) AS total_payment_records,
    COUNT(DISTINCT order_id) AS unique_order_ids
FROM payments;

SELECT
    COUNT(*) AS total_shipments,
    COUNT(DISTINCT order_id) AS unique_order_ids
FROM shipments;

SELECT
    COUNT(*) AS total_returns,
    COUNT(DISTINCT order_id) AS unique_order_ids
FROM returns;

SELECT
    COUNT(*) AS total_reviews,
    COUNT(DISTINCT order_id) AS unique_order_ids
FROM customer_reviews;

SELECT
    COUNT(*) AS total_campaigns,
    COUNT(DISTINCT campaign_id) AS unique_campaign_ids
FROM marketing_campaigns;

SELECT
    COUNT(*) AS total_returns,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM returns;

SELECT COUNT(*) AS invalid_customer_references
FROM returns r
LEFT JOIN customers c
    ON r.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


SELECT
    COUNT(*) AS invalid_customer_references
FROM customer_reviews cr
LEFT JOIN customers c
    ON cr.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT COUNT(*) AS invalid_order_references
FROM customer_reviews cr
LEFT JOIN orders o
    ON cr.order_id = o.order_id
WHERE o.order_id IS NULL;


SELECT
    COUNT(*) AS invalid_product_references
FROM customer_reviews cr
LEFT JOIN products p
    ON cr.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'indian_ecommerce'
  AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME;