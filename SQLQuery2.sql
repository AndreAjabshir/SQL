
select * from [dbo].[retail_sales];

--Total sales by date

SELECT date, SUM(total_amount) AS total_sales
FROM retail_sales
GROUP BY date
ORDER BY date;

--Total sales by product category

SELECT product_category, SUM(total_amount) AS total_sales
FROM retail_sales
GROUP BY product_category
ORDER BY total_sales DESC;

--Average transaction amount by gender

SELECT gender, AVG(total_amount) AS avg_transaction_amount
FROM retail_sales
GROUP BY gender;

--Top Selling Products

SELECT product_category, SUM(quantity) AS total_quantity_sold
FROM retail_sales
GROUP BY product_category
ORDER BY total_quantity_sold DESC;

--Customer Demographics

SELECT gender, AVG(age) AS avg_age, COUNT(customer_id) AS customer_count
FROM retail_sales
GROUP BY gender;

--Customer Lifetime Value (CLV).

SELECT customer_id, SUM(total_amount) AS clv
FROM retail_sales
GROUP BY customer_id
ORDER BY clv DESC;


--Customer Repeat Purchase Rate

SELECT
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT CASE WHEN transaction_count > 1 THEN customer_id END) AS repeat_customers,
    (COUNT(DISTINCT CASE WHEN transaction_count > 1 THEN customer_id END) / COUNT(DISTINCT customer_id)) * 100 AS repeat_purchase_rate
FROM (
    SELECT customer_id, COUNT(transaction_id) AS transaction_count
    FROM retail_sales
    GROUP BY customer_id
) subquery;

/*
Overall this data represents general business needs/queries. There were some oddities in the data. There was only one purchase per customer,
so CSV and customer repeat purchase rate did not see much use here. This practice was to showcase SQL query possibilites. 
*/
