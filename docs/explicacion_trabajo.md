# Explicación del trabajo — SmartCoffee

Este documento resume el propósito del proyecto, las tareas realizadas por sesión, las decisiones de diseño y su relación con los contenidos del curso.

Resumen del proyecto

SmartCoffee es una aplicación de ejemplo para gestionar una cadena de cafeterías: clientes, empleados, productos, pedidos y rutas de entrega. El objetivo académico es aplicar conceptos de bases de datos relacionales, diseño E/R, UML, SQL y algoritmos de grafos (rutas). El repositorio contiene artefactos que muestran progresión por sesiones y facilitan la evaluación.

Registro por sesiones (ejemplo de progresión)

Sesión 1 — Análisis y modelo conceptual
- Reunión de requisitos básicos (clientes, empleados, productos, pedidos).
- Definición de entidades y atributos clave.
- Documento: `database/modelo_ER.md` con el modelo Entidad-Relación.

Sesión 2 — UML y normalización
- Traducción del modelo E/R a clases UML (ver `database/uml.md`).
- Discusión sobre normalización: separado `Pedido` y `DetallePedido` para evitar duplicar líneas y capturar precio histórico.

Sesión 3 — Implementación de la BD en SQLite
- Creación de `database/create_tables.sql` con constraints, claves y checks.
- Inserción de datos de ejemplo en `database/insert_data.sql` para permitir consultas y pruebas.

Sesión 4 — Consultas y análisis
- Redacción de consultas útiles en `database/queries.sql` para obtener KPI básicos: ventas, clientes más fieles, productos más vendidos, etc.
- Ajuste de índices y consideraciones de rendimiento (en SQLite, índices se añadirían si la BD crece; en este entregable se prioriza claridad).

Sesión 5 — Scripts Python y práctica de grafos
- `python/smartcoffee_db.py`: script para crear/poblar la BD y ejecutar consultas de ejemplo, pensado para demostraciones en clase.
- `python/smartcoffee_rutas.py`: ejercicio de grafos que modela la cafetería y clientes, calcula rutas cortas y guarda una visualización.

Decisiones de diseño y justificación

- Guardar `precio_unitario` en `detalle_pedido` permite mantener historial de precios y coherencia en facturación.
- Mantener `total` en `pedidos` acelera consultas para métricas agregadas; si se desea consistencia absoluta, `total` puede recalcularse a partir de `detalle_pedido`.
- Las restricciones `CHECK` y `UNIQUE` mejoran la integridad y facilitan la corrección temprana de errores.
- Se usan tipos simples y compatibles con SQLite para maximizar portabilidad.

Relación con lo visto en clase

- Modelado E/R y normalización: diseño de tablas y separación de entidades.
- SQL: creación de tablas, integridad referencial, consultas agregadas y JOINs.
- Programación: uso de Python para automatizar creación de BD y ejecutar consultas.
- Grafos: uso de Dijkstra para rutas óptimas (aplicación a reparto/última milla).

Siguientes pasos y mejoras propuestas

- Añadir autenticación y gestión de permisos para empleados.
- Implementar API REST y una interfaz web para uso real.
- Añadir pruebas unitarias y scripts de despliegue.
- Expandir el modelo con sucursales, vehículos y planificación de rutas con VRP (Vehicle Routing Problem).


Fecha de la versión inicial: 2025-12-23
