# Online Retail Analytics Project (SQL + Power BI)

Este repositorio contiene un proyecto de **análisis de datos end-to-end** utilizando el dataset **Online Retail**.  
El objetivo es transformar datos transaccionales en insights de negocio mediante **modelado de datos, SQL analítico y visualización en Power BI**.

El proyecto se enfoca especialmente en:

- **Segmentación de clientes mediante RFM**
- **Análisis de cohortes para estudiar la retención**
- **KPIs de ventas y comportamiento del cliente**

---

# Dataset

**Fuente:** UCI Machine Learning Repository  
**Dataset:** Online Retail

Contiene más de **500.000 transacciones** realizadas por un minorista online con sede en **Reino Unido entre 2009 y 2011**.

## Variables principales

- **Invoice** → número de factura  
- **StockCode** → código del producto  
- **Description** → descripción del producto  
- **Quantity** → cantidad vendida  
- **InvoiceDate** → fecha de la compra  
- **Price** → precio unitario  
- **CustomerID** → identificador del cliente  
- **Country** → país del cliente  

---

# Flujo del proyecto

El proyecto sigue un flujo típico de análisis de datos:

1. Exploración del dataset  
2. Limpieza y transformación de datos  
3. Modelado dimensional (**Star Schema**)  
4. Análisis con SQL  
5. Segmentación de clientes (**RFM**)  
6. Análisis de cohortes  
7. Visualización en Power BI  

---

# Modelo de datos

Se implementó un **modelo estrella (Star Schema)** para optimizar consultas analíticas.

## Fact table

**fact_sales**

Granularidad: **transacción por producto**

Contiene:

- invoice
- customer_id
- stock_code
- invoice_date
- quantity
- price
- total_amount

## Dimensiones

**dim_customers**

- customer_id  
- country  

**dim_products**

- stock_code  
- description  

**dim_date**

- date_id  
- year  
- month  
- day  
- quarter  

Este modelo permite **consultas analíticas más eficientes y dashboards más simples de construir**.

---

# Análisis realizados

## KPIs principales

- Total Revenue  
- Average Order Value (AOV)  
- Total Customers  
- Revenue mensual  

## Análisis de clientes

- Top clientes por revenue  
- Segmentación **RFM**

## Análisis de productos

- Top productos por ventas  
- Unidades vendidas por producto  

## Retención de clientes

- **Cohort analysis de clientes**
- **Cohort analysis de revenue**

---

# Key Insights

Algunos hallazgos obtenidos del análisis:

- Un pequeño grupo de clientes genera una gran parte del revenue total.
- Los clientes con mayor frecuencia de compra presentan también mayor valor monetario.
- La retención de clientes disminuye significativamente después de los primeros meses.
- Un número reducido de productos concentra gran parte de las ventas.

---

# Dashboard

El dashboard en **Power BI** permite explorar:

- evolución del revenue
- KPIs principales
- segmentación de clientes
- análisis de cohortes
- top productos

*(Aquí puedes agregar una captura del dashboard)*

---

# SQL Skills Demonstrated

Durante el proyecto se aplicaron varias técnicas de SQL:

- Window Functions (`NTILE`, `FIRST_VALUE`)
- Common Table Expressions (CTE)
- Aggregate Functions
- Cohort Analysis
- Customer Segmentation (RFM)
- Date Functions
- Data Modeling (Star Schema)

---

# Tecnologías utilizadas

- **PostgreSQL** → limpieza, modelado y análisis de datos  
- **Power BI** → visualización y dashboard  
- **Git / GitHub** → control de versiones del proyecto  
