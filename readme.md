# Online Retail UCI · Retención de Clientes y Segmentación RFM

## ¿De qué se trata?

Este es uno de mis proyectos de portfolio. Lo armé para practicar análisis end-to-end sobre datos reales de e-commerce, no sobre datasets sintéticos armados para que todo cierre bien. 

La diferencia en esta versión es que migré toda la lógica pesada a la nube: usé **Google BigQuery** como Data Warehouse para procesar los datos con **SQL** antes de llevarlos a **Power BI**. Esto me permitió manejar el volumen de datos sin que el reporte se arrastre.

La pregunta que guió todo el análisis fue una sola: **¿por qué los clientes no vuelven a comprar, quiénes son los que más revenue generan y cómo impactan las cancelaciones?**

---

## Dataset

Descargado desde [UCI Machine Learning Repository](https://archive.ics.uitedu/ml/datasets/online+retail). Transacciones históricas de un minorista online del Reino Unido entre 2009 y 2011.

| Tabla | Qué tiene |
|---|---|
| Transacciones | ~500.000 registros con fecha, producto, cliente, cantidad y precio |
| Clientes | CustomerID con datos geográficos |
| Productos | StockCode y descripción |

---

## Qué hice con los datos antes de analizar

El dataset original era una tabla plana con varios problemas que había que resolver en BigQuery antes de tocar cualquier métrica:

* **Valores nulos:** Una parte de las transacciones no tenía `CustomerID`. Las excluí del análisis de retención y RFM porque sin identificador de cliente no hay forma de rastrear comportamiento.
* **Transacciones canceladas:** Creé una bandera booleana (`is_cancelled`) para los pedidos que venían con el prefijo 'C'. Separar este flujo fue clave para analizar las pérdidas de forma independiente sin inflar el revenue general.
* **Modelo de datos:** Transformé ese archivo plano en un esquema estrella dentro del Data Warehouse. Creé una tabla de hechos (`fact_sales`) conectada a dimensiones de clientes, productos y fechas.
* **Cálculo de cohortes en SQL:** Para no saturar a Power BI, armé una vista calculada (`annual_cohort_retention`) directamente en BigQuery que procesa los meses de actividad de cada usuario (`period 0` al `n`) y genera las tasas de retención.

---

## Lo que encontré

### 4 de cada 5 clientes no vuelven a comprar
La retención cae drásticamente del 100% a aproximadamente un 20% entre la primera y la segunda compra, sin importar la cohorte ni el período del año. El primer mes es la ventana crítica: si el cliente no vuelve en ese lapso, lo perdiste.

| Período | Retención promedio |
|---|---|
| Mes 0 (primera compra) | 100% |
| Mes 1 | ~20% |
| Mes 3 | ~10% |
| Mes 6+ | <8% |

### Dependencia absoluta de los clientes recurrentes (97%)
A pesar de la fuga del primer mes, el negocio se sostiene gracias a la recompra: el **97% de los ingresos totales** proviene de usuarios recurrentes. Además, el cliente que logra superar la barrera del tercer mes se vuelve ultra fiel, alcanzando una **frecuencia promedio de 7.49 pedidos**.

### Las cancelaciones son muchas pero no destruyen el margen
Aproximadamente 1 de cada 6 pedidos se cancela (**17%**), pero el impacto real en los ingresos netos es de solo el **2%**. Las cancelaciones se concentran casi en su totalidad en pedidos de muy bajo valor unitario. El problema no es un riesgo financiero, sino una fricción puramente operativa o logística.

### Los Campeones tienen comportamiento estacional
Los clientes del segmento Champion superan consistentemente a los Loyal en revenue mensual, con una brecha que se amplía fuerte en octubre-noviembre. Hay una ventana de oportunidad gigante antes del Q4 para activar estrategias diferenciadas.

---

## Qué haría con esta información

1.  **Campaña de reactivación agresiva en el primer mes post-compra:** Es el punto exacto donde se pierde el 80% de los clientes. Cualquier mejora en esa ventana va a mover la aguja del LTV mucho más que optimizar cualquier otra cosa.
2.  **Blindar al Top 10 y al segmento Champion:** Son los que concentran el revenue. Perder a diez de ellos impacta más que perder a cien clientes promedio. Diseñaría un programa de beneficios exclusivos antes de que arranque octubre para aprovechar su estacionalidad.
3.  **Auditar el proceso de checkout/bajos montos:** Como el 17% de las cancelaciones son de tickets bajos, investigaría si hay problemas con los métodos de pago en compras chicas o si se están cayendo carritos por costos de envío inesperados.

---

## El dashboard

Diseñado en dos páginas para que cualquiera entienda la salud del negocio en 30 segundos:

* **Página 1 — Segmentación RFM y Performance de Ventas:** KPIs principales ($32.77M en Ganancia), curva de Pareto de concentración y tendencias por segmento.
* **Página 2 — Retención y Cancelaciones:** Heatmap dinámico de cohortes, análisis de pérdidas vs ingresos netos y métricas de recompra.

*Herramientas: Google BigQuery · SQL · Power BI · Analytics Engineering*
