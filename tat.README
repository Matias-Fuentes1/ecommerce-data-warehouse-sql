# Online Retail Analytics · Retención por Cohortes y Segmentación RFM

## ¿De qué se trata?

Este proyecto de portfolio implementa un análisis de datos transaccionales *end-to-end* escalable en la nube. Recrea un entorno real de Analytics Engineering utilizando **Google BigQuery** como Data Warehouse, **VSCode** para el desarrollo de la lógica de modelado en SQL, y **Power BI** para la capa de visualización e inteligencia de negocio.

La pregunta central que guió el desarrollo fue: **¿Por qué los clientes dejan de comprar y cómo impactan las cancelaciones en la salud financiera del negocio?**

---

## Arquitectura del Proyecto y Stack Tecnológico

* **Data Warehouse:** Google BigQuery (Almacenamiento y procesamiento elástico).
* **Modelado de Datos:** VSCode + SQL (Construcción de vistas optimizadas, segmentación RFM y matrices de cohorte).
* **BI & Visualización:** Power BI (Conexión nativa a BigQuery mediante DirectQuery/Import para dashboards interactivos).

---

## Dataset

Origen de datos: [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/online+retail). Contiene ~500,000 registros transaccionales históricos de un retail e-commerce del Reino Unido entre 2009 y 2011.

---

## Ingeniería y Transformación de Datos (ELT)

El procesamiento pesado se migró directamente al Data Warehouse mediante consultas optimizadas escritas en VSCode para garantizar la performance de los reportes:

1.  **Tratamiento de Nulos y Calidad de Datos:** Identificación y aislamiento de registros sin `CustomerID` para no sesgar las métricas de comportamiento individual.
2.  **Lógica de Cancelaciones:** Creación de una bandera booleana (`is_cancelled`) basada en prefijos de factura para segmentar el revenue real de las pérdidas operativas.
3.  **Modelado Multidimensional:** Transformación del set plano en un modelo de esquema estrella compuesto por una tabla de hechos (`fact_sales`) y dimensiones optimizadas (`dim_date`, `dim_customers`, `dim_products`).
4.  **Cálculo de Cohortes en la Nube:** Creación de la vista avanzada `annual_cohort_retention` en BigQuery, calculando dinámicamente los periodos de actividad de los clientes (`period 0` a `n`) y sus tasas de retención correspondientes.

---

## Principales Hallazgos de Negocio

### 📊 Fuga Estructural en el Mes 1
La retención de clientes sufre un quiebre crítico del 100% al ~20% inmediatamente después de la primera compra, estabilizándose por debajo del 10% en los meses siguientes. Esto demuestra que las estrategias de adquisición pierden efectividad si no se acompaña al cliente en sus primeros 30 días.

### 📉 Impacto Financiero vs. Operativo de las Cancelaciones
Aunque la tasa de cancelación de pedidos es del **17%** (1 de cada 6 pedidos no prospera), el impacto económico en los ingresos netos totales es de apenas el **2%**. Esto confirma que las cancelaciones se concentran en pedidos de bajo valor unitario, señalando un problema de fricción operativa en la plataforma más que un riesgo financiero.

### 🏆 Concentración de Ingresos Recurrentes (97%)
La operación está fuertemente consolidada en la recurrencia: el **97% del revenue** proviene de clientes de compras repetidas, quienes promedian **7.49 pedidos** por ciclo de vida. Perder un cliente fidelizado del top 10 afecta más al margen que cientos de usuarios esporádicos.

---

## Estructura del Dashboard (Power BI)

El reporte consta de dos vistas analíticas integradas con una paleta de colores corporativa y limpia:

* **Página 1 — Segmentación RFM y Performance de Ventas:** Análisis macro de ingresos ($32.77M en Ganancia), análisis de concentración mediante curva de Pareto, y evolución temporal por segmento de cliente (Champions vs. Loyal).
* **Página 2 — Retención y Cancelaciones:** Heatmap dinámico de cohortes anuales/mensuales, monitoreo de pérdidas de ingresos contra ingresos netos, y distribución del volumen de cancelaciones por clúster de cliente.

---
*Herramientas: Google BigQuery · VSCode · SQL · Power BI · Analytics Engineering*
