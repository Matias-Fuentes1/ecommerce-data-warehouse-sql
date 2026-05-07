-- Cohort analysis: cálculo de retención mensual de clientes basado en su primera compra.
DROP VIEW IF EXISTS annual_cohort_retention;

CREATE VIEW annual_cohort_retention AS

WITH cohort_base AS (
SELECT
    customer_id,
    DATE_TRUNC('month', invoice_date) AS mes_de_compra,
    DATE_TRUNC('month',
        MIN(invoice_date) OVER (PARTITION BY customer_id)
    ) AS cohort_month
FROM fact_sales
WHERE is_cancelled = FALSE
    AND customer_id IS NOT NULL
),
cohort_period AS (
SELECT
    customer_id,
    cohort_month,
    (
        EXTRACT(YEAR FROM AGE(mes_de_compra, cohort_month)) * 12 +
        EXTRACT(MONTH FROM AGE(mes_de_compra, cohort_month))
    ) AS period
FROM cohort_base
)
SELECT
    cohort_month,
    period,
    COUNT(DISTINCT customer_id) AS clientes_activos,
    FIRST_VALUE(COUNT(DISTINCT customer_id)) OVER (
        PARTITION BY cohort_month
        ORDER BY period
    ) AS cohort_size,
    ROUND(
        COUNT(DISTINCT customer_id)::numeric /
        FIRST_VALUE(COUNT(DISTINCT customer_id)) OVER (
            PARTITION BY cohort_month
            ORDER BY period
        ), 2
    ) AS retention_rate
FROM cohort_period
WHERE period BETWEEN 0 AND 12
GROUP BY cohort_month, period
ORDER BY cohort_month, period;
--
SELECT *
FROM annual_cohort_retention;

-- Cohort analysis: cálculo de retención de ingresos (revenue retention) por cohorte y periodo.
DROP VIEW IF EXISTS annual_cohort_revenue;

CREATE VIEW annual_cohort_revenue AS

WITH base AS (
SELECT 
    customer_id,
    DATE_TRUNC('month', invoice_date) AS purchase_month,
    DATE_TRUNC('month',
        MIN(invoice_date) OVER (PARTITION BY customer_id)
    ) AS cohort_month,
    ROUND(total_amount::numeric, 0) AS revenue
FROM fact_sales
WHERE is_cancelled = FALSE
AND customer_id IS NOT NULL 
),
cohort_period AS (
SELECT
    customer_id,
    cohort_month,
    (
        DATE_PART('year', AGE(purchase_month, cohort_month)) * 12 +
        DATE_PART('month', AGE(purchase_month, cohort_month))
    ) AS period,
    revenue
FROM base
)
SELECT
    cohort_month,
    period,
    SUM(revenue) AS revenue
FROM cohort_period
GROUP BY cohort_month, period
ORDER BY cohort_month, period;
-- 
SELECT *
FROM annual_cohort_revenue
