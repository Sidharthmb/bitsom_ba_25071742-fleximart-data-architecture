-- Query 1: Monthly Sales Drill-Down Analysis
-- Demonstrates: Year → Quarter → Month drill-down

SELECT
    d.year,
    d.quarter,
    d.month,
    d.month_name,
    SUM(f.total_amount) AS total_sales,
    SUM(f.quantity_sold) AS total_quantity
FROM fact_sales f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.quarter,
    d.month,
    d.month_name
ORDER BY
    d.year,
    d.month;


-- Query 2: Top Products by Revenue
SELECT
    p.product_name,
    p.category,
    SUM(f.quantity_sold) AS units_sold,
    SUM(f.total_amount) AS revenue,
    ROUND(
        SUM(f.total_amount) * 100.0 /
        SUM(SUM(f.total_amount)) OVER (), 2
    ) AS revenue_percentage
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.product_name, p.category
ORDER BY revenue DESC
LIMIT 10;

-- Query 3: Customer Segmentation
SELECT
    c.customer_segment,
    COUNT(DISTINCT c.customer_key) AS customer_count,
    SUM(f.total_amount) AS total_revenue,
    AVG(f.total_amount) AS avg_revenue_per_customer
FROM fact_sales f
JOIN dim_customer c ON f.customer_key = c.customer_key
GROUP BY c.customer_segment;