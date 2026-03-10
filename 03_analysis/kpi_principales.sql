-- Top productos mas vendidos 
SELECT d.stock_code, d.description,
    SUM(f.total_amount) AS product_revenue
FROM fact_sales f
JOIN dim_products d 
    ON f.stock_code = d.stock_code
GROUP BY d.stock_code, d.description
ORDER BY product_revenue DESC
LIMIT 10;

-- Top clientes por revenue
SELECT customer_id, 
    SUM(f.total_amount) AS customer_revenue
FROM fact_sales
GROUP BY customer_id
ORDER BY customer_revenue DESC
LIMIT 10;

-- Basket size (cantidad de productos distintos por orden)
SELECT AVG(product_distinct) AS avg_basket_size
FROM (SELECT invoice,
    COUNT(DISTINCT stock_code) AS product_distinct
    FROM fact_sales
    GROUP BY invoice) sub;

-- Ganancia por mes y año 
CREATE OR REPLACE VIEW vw_monthly_revenue AS
SELECT 
    d.year,
    d.month,
    SUM(f.total_amount) AS ganancia
FROM fact_sales f
JOIN dim_date d 
    ON f.invoice_date = d.date_id
GROUP BY d.year, d.month;
-- 
SELECT * FROM vw_monthly_revenue
--

-- Ganancia por cliente 
CREATE OR REPLACE VIEW vw_customer_revenue AS
SELECT 
    customer_id,
    ROUND(SUM(total_amount), 0) AS customer_revenue
FROM fact_sales
GROUP BY customer_id;
-- 
SELECT * FROM vw_customer_revenue
--

-- KPIs principales (Revenue, AOV y Clientes)
CREATE OR REPLACE VIEW vw_monthly_revenue AS
SELECT 
    d.year,
    d.month,
    ROUND(SUM(f.total_amount), 0) AS ganancia,
    COUNT(DISTINCT f.customer_id) AS clientes_activos,
    COUNT(DISTINCT f.invoice) AS total_orders
FROM fact_sales f
JOIN dim_date d 
    ON f.invoice_date = d.date_id
GROUP BY d.year, d.month
ORDER BY d.year, d.month;
-- 
SELECT * FROM vw_monthly_revenue
