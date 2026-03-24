DROP VIEW IF EXISTS rfm_segment;
CREATE VIEW rfm_segment AS 
WITH rfm_initial_calc AS (
    SELECT 
        customer_id, 
        ROUND(SUM(total_amount), 0) AS monetary_value,
        COUNT(DISTINCT invoice) AS frequency,
        DATE_PART(
            'day',
            (SELECT MAX(invoice_date)::timestamp FROM fact_sales) 
            - MAX(invoice_date)::timestamp
        ) AS recency
    FROM fact_sales
    WHERE invoice_date IS NOT NULL
    GROUP BY customer_id
),
rfm_score AS (
    SELECT 
        r.*,
        NTILE(4) OVER (ORDER BY monetary_value DESC) AS m_score,
        NTILE(4) OVER (ORDER BY frequency DESC) AS f_score,
        NTILE(4) OVER (ORDER BY recency ASC) AS r_score
    FROM rfm_initial_calc r
)
SELECT
    customer_id,
    monetary_value,
    frequency,
    recency,
    r_score,
    f_score,
    m_score,
    (r_score + f_score + m_score) AS total_rfm_score,
    CASE 
    WHEN r_score = 4 AND f_score >= 3 AND m_score >= 3 
        THEN 'Campeones'
    WHEN r_score >= 3 AND f_score >= 3 AND m_score >= 3 
        THEN 'Leales'
    WHEN r_score = 4 AND f_score <= 2 
        THEN 'Nuevos'
    WHEN r_score <= 2 AND f_score >= 3 AND m_score >= 3
        THEN 'En riesgo'
    WHEN r_score <= 2 AND f_score <= 2 AND m_score >= 3
        THEN 'No los puedo perder'
    WHEN r_score <= 2 AND f_score <= 2 AND m_score <= 2
        THEN 'Perdidos'
    ELSE 'Otros'
        END AS customers_segment
FROM rfm_score;
--
SELECT *
FROM rfm_segment;
