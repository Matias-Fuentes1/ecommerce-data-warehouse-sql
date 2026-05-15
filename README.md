# Online Retail UCI · Retención de Clientes y Segmentación RFM

## ¿De qué se trata?

Este es uno de mis proyectos de portfolio. Lo armé para practicar análisis end-to-end con SQL y Power BI sobre datos reales de e-commerce, no sobre datasets sintéticos armados para que todo cierre bien.

La pregunta que guió todo el análisis fue una sola: **¿por qué los clientes no vuelven a comprar, y quiénes son los que más revenue generan?**

Me llevó aproximadamente 4 semanas. Lo más difícil no fue técnico: fue decidir qué nivel de limpieza era suficiente para no distorsionar el análisis, y qué métricas realmente respondían la pregunta central. Descarté varias visualizaciones que se veían bien pero no aportaban nada concreto a las decisiones de negocio.

---

## Dataset

Descargado desde [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/online+retail). Transacciones históricas de un minorista online del Reino Unido entre 2009 y 2011.

| Tabla | Qué tiene |
|---|---|
| Transacciones | ~500.000 registros con fecha, producto, cliente, cantidad y precio |
| Clientes | CustomerID con datos geográficos |
| Productos | StockCode y descripción |

Período cubierto: 2009–2011. El análisis se centra en retención por cohortes y segmentación RFM.

---

## Qué hice con los datos antes de analizar

El dataset tenía varios problemas que había que resolver antes de tocar cualquier métrica:

**Valores nulos:** Una parte de las transacciones no tenía `CustomerID`. Las excluí del análisis de retención y RFM porque sin identificador de cliente no hay forma de rastrear comportamiento. Las mantuve para el análisis de revenue total.

**Transacciones canceladas:** Los pedidos cancelados tienen el prefijo `'C'` en el `InvoiceNo`. Los separé del flujo principal para analizarlos de forma independiente — incluirlos en el revenue hubiera inflado los números sin sentido.

**Precios y cantidades negativos:** Aparecen en devoluciones y ajustes contables. Los filtré antes de calcular cualquier KPI de rentabilidad.

**Modelo de datos:** Transformé el dataset plano en un esquema estrella con una tabla de hechos (`fact_sales`) y dimensiones de clientes, productos y fechas. Eso fue lo que permitió que Power BI funcionara sin explotar con medio millón de filas.

**Un error que encontré en el camino:** Al calcular el revenue por segmento RFM, los totales no cerraban con el revenue general. El problema era que algunos `CustomerID` aparecían duplicados con transacciones en distintas monedas. Lo resolví filtrando solo transacciones en GBP antes de construir el modelo.

---

## Lo que encontré

### 4 de cada 5 clientes no vuelven a comprar

Ese es el problema central. La retención cae de 100% a aproximadamente 20% entre la primera y segunda compra, sin importar la cohorte ni el período del año. El primer mes es la ventana crítica: si el cliente no vuelve en ese lapso, probablemente no vuelve nunca.

| Período | Retención promedio |
|---|---|
| Mes 0 (primera compra) | 100% |
| Mes 1 | ~20% |
| Mes 3 | ~10% |
| Mes 6+ | <8% |

### El revenue depende de un grupo muy pequeño de clientes

La curva de Pareto es pronunciada. El cliente de mayor valor generó $1.13M en el período, y los 10 principales concentran una porción desproporcionada del revenue total. Alta dependencia en un grupo reducido — eso es riesgo de concentración.

### Las cancelaciones son muchas pero no destruyen el margen

Aproximadamente 1 de cada 5 pedidos se cancela (~17%), pero el impacto en ingresos netos es de solo ~2%. Las cancelaciones se concentran en pedidos de bajo valor. El problema no es económico — es operativo.

### Los Campeones tienen comportamiento estacional

Los clientes del segmento Champion superan consistentemente a los Loyal en revenue mensual, con una brecha que se amplía en octubre-noviembre. Eso sugiere que hay una ventana de oportunidad antes del Q4 para activar retención diferenciada.

---

## Qué haría con esta información

Antes de cualquier otra cosa, activaría una campaña de reactivación en el primer mes post-compra. Es el punto donde se pierde el 80% de los clientes — cualquier intervención ahí tiene más impacto que optimizar cualquier otra etapa del funnel.

Después de eso, el movimiento más directo para proteger el revenue sería armar un programa de fidelización específico para los Campeones. Son 1.112 clientes que generan una fracción desproporcionada del total — perder diez de ellos duele más que perder cien clientes promedio.

---

## El dashboard

Dos páginas. Diseñado para que alguien que no estuvo en el análisis entienda el problema en 30 segundos.

**Página 1 — Segmentación RFM y Performance de Ventas:** matriz RFM interactiva, KPIs de revenue y clientes activos, curva de Pareto, tendencia mensual por segmento.

**Página 2 — Retención y Cancelaciones:** heatmap de cohortes con retención mensual, impacto de cancelaciones sobre revenue neto, tasa de recompra por segmento.

**Paleta:** rojo para retención crítica y pérdidas, verde para segmentos de alto valor, azul para revenue neutro — la misma lógica en todos los gráficos.

---

*Herramientas: PostgreSQL · SQL · Power BI · Dataset: UCI Machine Learning Repository (Online Retail) · Proyecto de portfolio*
