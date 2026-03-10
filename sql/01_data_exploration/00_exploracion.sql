-- Crear tabla base para almacenar los datos crudos del dataset de retail
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

-- Contar la cantidad total de registros cargados en la tabla
SELECT COUNT(*) AS total_registros
FROM retail_raw;

-- Visualizar una muestra inicial de los datos
SELECT *
FROM retail_raw
LIMIT 1000;

-- Verificar cantidad de valores no nulos por columna
SELECT 
    COUNT(*) AS total_filas,
    COUNT(invoice) AS invoice_no_nulos,
    COUNT(stock_code) AS stockcode_no_nulos,
    COUNT(description) AS description_no_nulos,
    COUNT(quantity) AS quantity_no_nulos,
    COUNT(invoice_date) AS invoice_date_no_nulos,
    COUNT(price) AS price_no_nulos,
    COUNT(customer_id) AS customer_id_no_nulos,
    COUNT(country) AS country_no_nulos
FROM retail_raw;

-- Calcular la cantidad y porcentaje de valores nulos en customer_id
SELECT
    COUNT(*) AS total_filas,
    COUNT(customer_id) AS customerid_no_nulos,
    COUNT(*) - COUNT(customer_id) AS customerid_nulos,
    ROUND(100.0 * (COUNT(*) - COUNT(customer_id)) / COUNT(*), 2) AS pct_customerid_nulos
FROM retail_raw;

-- Identificar registros con cantidades negativas (posibles devoluciones)
SELECT COUNT(*) AS registros_con_devoluciones
FROM retail_raw
WHERE quantity < 0;

-- Detectar registros con precio cero o negativo
SELECT COUNT(*) AS registros_con_precio_cero
FROM retail_raw
WHERE price <= 0;

-- Contar facturas canceladas (prefijo 'C' en el número de factura)
SELECT COUNT(*) AS facturas_canceladas
FROM retail_raw
WHERE invoice LIKE 'C%';

-- Contar la cantidad de países distintos presentes en el dataset
SELECT COUNT(DISTINCT country) AS cantidad_paises
FROM retail_raw;

-- Obtener el rango temporal del dataset
SELECT MIN(invoice_date) AS fecha_minima,
       MAX(invoice_date) AS fecha_maxima
FROM retail_raw;

-- Contar la cantidad de productos únicos
SELECT COUNT(DISTINCT stock_code) AS productos_distintos
FROM retail_raw;

-- Contar la cantidad de clientes únicos (excluyendo nulos)
SELECT COUNT(DISTINCT customer_id) AS clientes_distintos
FROM retail_raw
WHERE customer_id IS NOT NULL;
