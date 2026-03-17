# Online Retail Analytics Project (SQL + Power BI)
Este repositorio contiene un proyecto completo de análisis de datos de extremo a extremo utilizando el dataset Online Retail.
El objetivo del proyecto es transformar datos transaccionales en información accionable, aplicando modelado de datos, consultas analíticas y visualización para comprender el comportamiento de los clientes y el rendimiento del negocio.

# Dataset
### Fuente: UCI Machine Learning Repository
Dataset: Online Retail
Contiene transacciones de un minorista online con sede en Reino Unido entre 2009 y 2011.
### Columnas principales:
- Invoice → número de factura
- StockCode → código del producto
- Description → descripción del producto
- Quantity → cantidad vendida
- InvoiceDate → fecha de la compra
- Price → precio unitario
- CustomerID → identificador del cliente
- Country → país del cliente

## El flujo del proyecto incluye:
- Exploración inicial del dataset
- Limpieza y transformación de datos
- Modelado de datos (Esquema estrella)
- Análisis con SQL
- Segmentación de clientes (RFM: Recencia, Frecuencia, Monetaria)
- Análisis de cohortes (Retencion de los clientes a lo largo del tiempo 
- Visualización de KPIs en Power BI

# Modelo de datos 
Se utilizó un modelo tipo estrella para organizar las transacciones.
### Fact table
fact_sales: Contiene las ventas realizadas.
### Dimensiones
- dim_customers
- dim_products
- dim_date

# Análisis realizados
## KPIs
- Total Revenue
- Average Order Value (AOV)
- Total Customers
- Revenue mensual
## Clientes
- Top clientes por revenue
- Segmentación RFM
- Productos
- Top productos por ventas
- Unidades vendidas
## Retención
- Cohort analysis de clientes
- Cohort analysis de revenue

# Hallazgos obtenidos 
Algunos hallazgos obtenidos del análisis:
- * Una pequeña proporción de clientes genera una gran parte del revenue total.
- * Los clientes con mayor frecuencia de compra también presentan el mayor valor monetario.
- * La retención de clientes disminuye significativamente después de los primeros meses.
- * Algunos productos concentran gran parte de las ventas, indicando una posible estrategia de productos estrella.

# Tecnologias utilizadas 
PostgreSQL → transformación y análisis de datos
Power BI → visualización



“Los KPIs finales se calculan en Power BI para permitir análisis dinámico según filtros”
