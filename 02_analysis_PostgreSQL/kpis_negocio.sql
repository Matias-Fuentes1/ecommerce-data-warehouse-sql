-- Top productos mas vendidos 
SELECT d.stock_code, d.description,
    ROUND(SUM(f.total_amount::numeric), 0) AS product_revenue
FROM fact_sales f
JOIN dim_products d 
    ON f.stock_code = d.stock_code
GROUP BY d.stock_code, d.description
ORDER BY product_revenue DESC
LIMIT 10;


-- Top clientes por revenue
SELECT customer_id, 
    SUM(f.total_amount) AS customer_revenue
FROM fact_sales f 
GROUP BY customer_id
ORDER BY customer_revenue DESC
LIMIT 10;


-- Basket size (cantidad de productos distintos por orden)
CREATE OR REPLACE VIEW vw_basket_analysis AS
SELECT 
    ROUND(AVG(product_distinct), 2) AS avg_basket_size,
    ROUND(AVG(order_revenue), 2) AS avg_revenue_per_basket
FROM (
    SELECT 
        invoice,
        COUNT(DISTINCT stock_code) AS product_distinct,
        SUM(total_amount) AS order_revenue
    FROM fact_sales
    GROUP BY invoice
) sub;
-- 
SELECT * FROM vw_basket_analysis


-- Ganancia por mes y año 
DROP VIEW IF EXISTS vw_monthly_revenue;
CREATE VIEW vw_monthly_revenue AS
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


-- Ganancia por cliente 
DROP VIEW IF EXISTS vw_customer_revenue;
CREATE VIEW vw_customer_revenue AS
SELECT 
    customer_id,
    ROUND(SUM(total_amount), 0) AS customer_revenue
FROM fact_sales
GROUP BY customer_id;
-- 
SELECT * FROM vw_customer_revenue LIMIT 2O


-- KPIs principales (Revenue, AOV y Clientes)
DROP VIEW IF EXISTS vw_monthly_revenue;
CREATE VIEW vw_monthly_revenue AS
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


-- Revenue perdido (cancelaciones)
DROP VIEW IF EXISTS vw_revenue_perdido;
CREATE OR REPLACE VIEW vw_revenue_perdido AS
SELECT 
    ROUND(SUM(ABS(total_amount::numeric)), 0) AS revenue_perdido,
    ROUND(
        SUM(ABS(total_amount::numeric)) 
        / NULLIF(
            (SELECT SUM(total_amount::numeric) 
             FROM fact_sales 
             WHERE is_cancelled = FALSE), 
        0) * 100
    , 2) AS pct_revenue_perdido
FROM fact_sales
WHERE is_cancelled = TRUE;
--
SELECT * FROM vw_revenue_perdido

-- Frecuencia de compra (por cliente)
DROP VIEW IF EXISTS vw_frecuencia_clientes;
CREATE VIEW vw_frecuencia_clientes AS
SELECT 
    ROUND(AVG(order_count), 2) AS avg_pedidos_por_cliente
FROM (
    SELECT customer_id, COUNT(DISTINCT invoice) AS order_count
    FROM fact_sales
    GROUP BY customer_id
) sub;
-- 
SELECT * FROM vw_frecuencia_clientes
