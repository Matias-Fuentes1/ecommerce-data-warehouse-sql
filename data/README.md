## Instrucciones de Uso y Protección del Reporte
1. Datos: Descarga el dataset de la fuente UCI Machine Learning Repository y cárgalo en tu instancia de PostgreSQL.
2. Scripts SQL: Ejecuta los scripts ubicados en la carpeta /sql para crear el esquema, limpiar los datos transaccionales y generar las vistas analíticas necesarias.
3. Power BI: Abre el archivo .pbix ubicado en la carpeta /dashboard y actualiza la conexión a tu base de datos PostgreSQL local para visualizar el dashboard interactivo.

**Atención para el uso del reporte:** Este archivo .pbix está configurado con permisos de solo lectura para los elementos visuales si se comparte a través del servicio de Power BI. Al abrirlo localmente, se recomienda no modificar las medidas DAX, títulos ni relaciones del modelo para preservar la integridad del análisis presentado.
