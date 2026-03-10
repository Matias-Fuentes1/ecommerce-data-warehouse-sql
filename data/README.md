# Dataset
Fuente: UCI Machine Learning Repository
Dataset: Online Retail
Contiene transacciones de un minorista online con sede en Reino Unido entre 2009 y 2011.
## Columnas principales:
Invoice → número de factura
StockCode → código del producto
Description → descripción del producto
Quantity → cantidad vendida
InvoiceDate → fecha de la compra
Price → precio unitario
CustomerID → identificador del cliente
Country → país del cliente

# Modelo de datos
Se utilizó un modelo tipo Star Schema para organizar las transacciones.
### Fact table
fact_sales: Contiene las ventas realizadas.
### Dimensiones
dim_customers; 
dim_products; 
dim_date
Esto permite hacer consultas analíticas más claras y eficientes.
