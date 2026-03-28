# Online Retail Analytics Project (SQL + Power BI)

Este repositorio contiene un proyecto de análisis de datos de extremo a extremo que transforma datos transaccionales crudos en un sistema de inteligencia de negocios funcional. El proyecto abarca desde la limpieza de datos y modelado relacional hasta la creación de un dashboard interactivo para la toma de decisiones estratégicas.

## Objetivo del Proyecto
Analizar el comportamiento de compra y el rendimiento operativo de un minorista online para identificar oportunidades de crecimiento, segmentos de clientes clave y patrones de retención.

## Dataset
Fuente: https://archive.ics.uci.edu/ml/datasets/online+retail
* Alcance: Transacciones históricas (Reino Unido) entre 2009 y 2011.
* Desafíos de datos resueltos: Gestión de valores nulos en CustomerID, tratamiento de transacciones canceladas (identificadas con 'C') y filtrado de registros inconsistentes (precios o cantidades menores o iguales a cero).

## Tecnologías Utilizadas
* PostgreSQL: Motor de base de datos para el almacenamiento, limpieza (ETL) y consultas analíticas complejas.
* Power BI: Modelado de datos (DAX) y visualización interactiva.
* SQL: Creación de vistas, análisis de cohortes y segmentación RFM.

## Modelo de Datos (Star Schema)
Para optimizar el rendimiento de las consultas y la flexibilidad en Power BI, se transformó el dataset original en un Esquema Estrella:

* Fact Table: fact_sales (Transacciones, ingresos, cantidades).
* Dimensiones:
    * dim_customers: Datos geográficos e identificadores.
    * dim_products: Catálogo de productos y descripciones.
    * dim_date: Jerarquías temporales (Año, Mes, Trimestre, Día).

## Análisis Realizados

### KPIs Principales
* Total Revenue: Ingresos totales netos.
* Average Order Value (AOV): Gasto promedio por pedido.
* Total Customers: Volumen de base de clientes activos.

### Segmentación y Comportamiento
* Análisis RFM: Clasificación de clientes basada en Recencia, Frecuencia y Valor Monetario para identificar clientes clave.
* Cohort Analysis: Medición de la tasa de retención mensual para entender la lealtad de los clientes tras su primera compra.
* Basket Analysis: Cálculo del tamaño promedio de la cesta (unidades distintas por pedido).

### Rendimiento de Productos
* Identificación de productos estrella y análisis de concentración de ventas (Pareto).

## Hallazgos Obtenidos
* Concentración de Ingresos: Una pequeña proporción de clientes genera la mayor parte del revenue total, lo que sugiere una alta dependencia de clientes de alto valor.
* Correlación Frecuencia/Monto: Los clientes recurrentes presentan una tendencia clara a realizar transacciones de mayor valor monetario.
* Punto Crítico de Retención: Se observa una caída significativa en la retención tras los primeros dos meses, identificando una ventana crítica para estrategias de fidelización.
* Revenue Perdido: El análisis detallado de cancelaciones permitió cuantificar el impacto real de las devoluciones sobre el margen neto.

## Estructura del Repositorio
* /sql: Scripts de creación de tablas, vistas y análisis de cohortes.
* /data: Documentación sobre el origen de los datos.
* /dashboard: Archivo .pbix con las visualizaciones finales.

## Cómo Utilizar este Repositorio
1. Datos: Descarga el dataset de la fuente UCI y cárgalo en tu instancia de PostgreSQL.
2. Scripts SQL: Ejecuta los scripts para crear el esquema, limpiar los datos y generar las vistas analíticas.
3. Power BI: Abre el archivo .pbix y actualiza la conexión a tu base de datos para visualizar el dashboard.
