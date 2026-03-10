-- Eliminar tablas si existen previamente para evitar conflictos al recrearlas
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_products;
DROP TABLE IF EXISTS dim_customers;
DROP TABLE IF EXISTS retail_raw;

-- Crear tabla staging con los datos crudos del dataset
CREATE TABLE retail_raw (
    invoice        VARCHAR(20),
    stock_code     VARCHAR(20),
    description    TEXT,
    quantity       INTEGER,
    invoice_date   TIMESTAMP,
    price          NUMERIC(10,2),
    customer_id    NUMERIC,
    country        VARCHAR(100)
);

-- Crear dimensión de clientes
CREATE TABLE dim_customers (
    customer_id INTEGER PRIMARY KEY,
    country VARCHAR(100)
);

-- Crear dimensión de productos
CREATE TABLE dim_products (
    stock_code VARCHAR(20) PRIMARY KEY,
    description TEXT
);

-- Crear dimensión de fechas para análisis temporal
CREATE TABLE dim_date (
    date_id DATE PRIMARY KEY,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    quarter INTEGER
);

-- Crear tabla de hechos que almacena las transacciones de venta
CREATE TABLE fact_sales (
    sale_id SERIAL PRIMARY KEY,
    invoice VARCHAR(20),
    customer_id INTEGER,
    stock_code VARCHAR(20),
    invoice_date DATE,
    quantity INTEGER,
    price NUMERIC(10,2),
    total_amount NUMERIC(12,2),
    FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_id),
    FOREIGN KEY (stock_code) REFERENCES dim_products(stock_code)
);

-- Verificar cantidad de registros cargados en la tabla raw
SELECT COUNT(*) 
FROM retail_raw;

-- Visualizar los datos cargados en la tabla de hechos
SELECT *
FROM fact_sales;
