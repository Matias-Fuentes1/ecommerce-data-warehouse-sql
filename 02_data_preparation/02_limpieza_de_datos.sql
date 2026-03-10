-- Vaciar tablas del Data Warehouse antes de recargar los datos
TRUNCATE TABLE fact_sales, dim_customers, dim_products, dim_date RESTART IDENTITY;

-- Poblar dimensión de clientes a partir de los datos raw
INSERT INTO dim_customers (customer_id, country)
SELECT 
    customer_id::INTEGER,
    MIN(country)
FROM retail_raw
WHERE customer_id IS NOT NULL
GROUP BY customer_id;

-- Poblar dimensión de productos
INSERT INTO dim_products (stock_code, description)
SELECT 
    stock_code,
    MIN(description)
FROM retail_raw
WHERE stock_code IS NOT NULL
GROUP BY stock_code;

-- Poblar dimensión de fechas para análisis temporal
INSERT INTO dim_date (date_id, year, month, day, quarter)
SELECT DISTINCT
    DATE(invoice_date),
    EXTRACT(YEAR FROM invoice_date)::INT,
    EXTRACT(MONTH FROM invoice_date)::INT,
    EXTRACT(DAY FROM invoice_date)::INT,
    EXTRACT(QUARTER FROM invoice_date)::INT
FROM retail_raw
WHERE invoice_date IS NOT NULL;

-- Poblar tabla de hechos con las transacciones válidas
INSERT INTO fact_sales (
    invoice,
    customer_id,
    stock_code,
    invoice_date,
    quantity,
    price,
    total_amount,
    is_cancelled
)
SELECT
    invoice,
    customer_id::INTEGER,
    stock_code,
    DATE(invoice_date),
    quantity,
    price,
    quantity * price AS total_amount,
    CASE 
        WHEN invoice LIKE 'C%' OR quantity < 0 THEN TRUE
        ELSE FALSE
    END AS is_cancelled
FROM retail_raw
WHERE customer_id IS NOT NULL
AND stock_code IS NOT NULL
AND invoice_date IS NOT NULL;
