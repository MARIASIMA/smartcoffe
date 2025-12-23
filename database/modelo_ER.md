# Modelo Entidad-Relación (SmartCoffee)

Este documento describe el modelo Entidad-Relación para SmartCoffee: entidades, atributos, claves y relaciones con sus cardinalidades. Está pensado para evaluación académica y como referencia para la implementación en la base de datos.

Entidades principales

1. Cliente
- Atributos:
  - cliente_id (PK, INTEGER): Identificador único de cliente.
  - nombre (TEXT, NOT NULL)
  - email (TEXT, UNIQUE, NOT NULL)
  - telefono (TEXT)
  - direccion (TEXT)
  - puntos_fidelidad (INTEGER, DEFAULT 0, CHECK >=0)

2. Empleado
- Atributos:
  - empleado_id (PK, INTEGER): Identificador único de empleado.
  - nombre (TEXT, NOT NULL)
  - role (TEXT, NOT NULL) -- ej. 'Barista', 'Repartidor', 'Encargado'
  - turno (TEXT) -- ej. 'Mañana', 'Tarde', 'Noche'
  - email (TEXT, UNIQUE)

3. Producto
- Atributos:
  - producto_id (PK, INTEGER)
  - nombre (TEXT, NOT NULL)
  - tipo (TEXT) -- ej. 'Bebida', 'Comida', 'Accesorio'
  - precio (REAL, NOT NULL, CHECK >= 0)
  - disponible (INTEGER, DEFAULT 1) -- 1 disponible, 0 no disponible

4. Pedido
- Atributos:
  - pedido_id (PK, INTEGER)
  - cliente_id (FK -> Cliente.cliente_id, NOT NULL)
  - empleado_id (FK -> Empleado.empleado_id) -- empleado que atendió/gestionó
  - fecha (TEXT, NOT NULL) -- ISO 8601 (ej. '2025-12-23T10:15:00')
  - estado (TEXT, NOT NULL) -- ej. 'pendiente', 'enviado', 'entregado'
  - total (REAL, NOT NULL, CHECK >= 0)

5. DetallePedido
- Atributos:
  - detalle_id (PK, INTEGER)
  - pedido_id (FK -> Pedido.pedido_id, NOT NULL)
  - producto_id (FK -> Producto.producto_id, NOT NULL)
  - cantidad (INTEGER, NOT NULL, CHECK (cantidad > 0))
  - precio_unitario (REAL, NOT NULL, CHECK >= 0) -- copia del precio en el momento del pedido

Relaciones y cardinalidades

- Cliente 1 — N Pedido
  - Un cliente puede hacer muchos pedidos, cada pedido pertenece a un único cliente.

- Empleado 1 — N Pedido
  - Un empleado (p. ej. barista o repartidor) puede gestionar/atender varios pedidos. Un pedido puede ser atendido por cero o uno empleado (NULL si pendiente de asignación).

- Pedido 1 — N DetallePedido
  - Un pedido contiene uno o más detalles (líneas), cada detalle corresponde a un único pedido.

- Producto 1 — N DetallePedido
  - Un producto puede aparecer en muchos detalles de pedido (en distintos pedidos). Cada detalle referencia a un único producto.

Integridad y consideraciones

- Las claves primarias son enteras autoincrementales (INTEGER PRIMARY KEY en SQLite).
- Las claves foráneas garantizan la consistencia: si se elimina un cliente/empleado/producto, la política preferible es usar `ON DELETE RESTRICT` o `ON DELETE SET NULL` según la regla de negocio. En este proyecto usamos `ON DELETE RESTRICT` para no perder historial de pedidos accidentalmente.
- Se usan `CHECK` para evitar valores negativos en cantidades y precios, y `UNIQUE` en campos como `email`.

Justificación académica

El modelo prioriza trazabilidad de pedidos y detalle de facturación (precio unitario guardado en el detalle). Mantener `total` en `Pedido` facilita consultas de rendimiento (se puede recalcular desde `DetallePedido` si se quiere normalizar más). Las cardinalidades reflejan un negocio típico de cafetería con clientes recurrentes y empleados que atienden pedidos.
