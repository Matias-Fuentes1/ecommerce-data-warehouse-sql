#  Online Retail Analytics: End-to-End BI Solution

Este proyecto transforma datos transaccionales en bruto de un minorista del Reino Unido en un ecosistema de BI robusto. El enfoque principal fue la **segmentación avanzada de clientes (RFM)** y el **análisis de cohortes** para derivar estrategias de retención.

## Objetivos del Proyecto
* Diseñar e implementar un **Modelo en Estrella** optimizado para consultas analíticas.
* Segmentar la base de clientes mediante lógica **RFM (Recency, Frequency, Monetary)**.
* Analizar la retención y el ciclo de vida del cliente mediante **Cohortes**.
* Visualizar KPIs críticos para la toma de decisiones ejecutivas.

## Stack Tecnológico
* **Base de Datos:** PostgreSQL (Limpieza, CTEs, Window Functions).
* **BI & Dataviz:** Power BI (DAX avanzado, Modelado, Power Query).
* **Dataset:** UCI Machine Learning Repository (541k+ registros).

## Modelado de Datos (Schema)
Se implementó un esquema de estrella para garantizar el rendimiento de las medidas DAX y la simplicidad en el filtrado:

* **Fact Table:** `fact_sales` (Granularidad: Transacción por producto).
* **Dimensions:** * `dim_customers` (Geografía y Segmentación).
    * `dim_products` (Categorización y Precios).
    * `dim_date` (Calendario extendido para Time Intelligence).



## Análisis Técnico (SQL Highlights)
En este repositorio encontrarás scripts de PostgreSQL que abordan:
1.  **Data Cleaning:** Manejo de valores nulos en `CustomerID` y tratamiento de devoluciones (cantidades negativas).
2.  **Cálculo de RFM:** Uso de `NTILE()` y `PERCENT_RANK()` para asignar scores de 1 a 5 a cada cliente.
3.  **Análisis de Cohortes:** Determinación del mes de adquisición por cliente para calcular el % de retención mensual.

## Business Insights & Recomendaciones
* **Regla de Pareto:** Se identificó que el **Top 15% de los clientes** representan el **70% de la facturación**. *Acción: Priorizar campañas de marketing directo a este grupo.*
* **Curva de Retención:** La retención cae un **40% en el segundo mes**. *Acción: Implementar un flujo de correos 'Win-back' tras los primeros 30 días de inactividad.*
* **Productos Estrella:** El 5% del inventario genera el 50% de las ventas totales.

## Visualización en Power BI
El dashboard final incluye:
* **Executive Overview:** Ingresos, AOV y margen por país.
* **Customer Research:** Matriz de segmentación RFM interactiva.
* **Retention Lab:** Matriz de cohortes para medir el "Stickiness" del negocio.
