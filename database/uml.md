# Diagrama UML (descripción textual)

Este archivo describe las clases UML equivalentes al modelo E/R, pensado para documentar la estructura del software y su correspondencia con la base de datos.

Clases

1. Cliente
- Atributos:
  - cliente_id: int
  - nombre: str
  - email: str
  - telefono: str
  - direccion: str
  - puntos_fidelidad: int

2. Empleado
- Atributos:
  - empleado_id: int
  - nombre: str
  - role: str
  - turno: str
  - email: str

3. Producto
- Atributos:
  - producto_id: int
  - nombre: str
  - tipo: str
  - precio: float
  - disponible: bool

4. Pedido
- Atributos:
  - pedido_id: int
  - cliente_id: int
  - empleado_id: int (opcional)
  - fecha: str (ISO 8601)
  - estado: str
  - total: float

5. DetallePedido
- Atributos:
  - detalle_id: int
  - pedido_id: int
  - producto_id: int
  - cantidad: int
  - precio_unitario: float

Relaciones (UML)

- Cliente 1..1 <-> 0..* Pedido
  - Un `Cliente` tiene 0..* `Pedido`.

- Empleado 0..1 <-> 0..* Pedido
  - Un `Empleado` puede estar asociado a 0..* `Pedido`. Un `Pedido` puede no tener empleado asignado.

- Pedido 1..1 <-> 1..* DetallePedido
  - Un `Pedido` contiene 1..* `DetallePedido`.

- Producto 1..1 <-> 0..* DetallePedido
  - Un `Producto` puede aparecer en 0..* `DetallePedido`.

Correspondencia con el modelo E/R

- Cada clase corresponde a una tabla del modelo E/R: `Cliente` -> `clientes`, `Empleado` -> `empleados`, `Producto` -> `productos`, `Pedido` -> `pedidos`, `DetallePedido` -> `detalle_pedido`.
- Los atributos simples se mapean a columnas y las relaciones a claves foráneas.

Notas de diseño

- Se mantiene la separación de `Pedido` y `DetallePedido` para conservar normalización y trazabilidad por línea de pedido.
- `precio_unitario` en `DetallePedido` captura el precio histórico del producto en el momento del pedido.
- En el diseño orientado a objetos, se podrían añadir métodos auxiliares como `Pedido.calcular_total()` o `Cliente.obtener_historial()` para encapsular lógica; en este repositorio documental se mencionan como posibilidad para implementaciones futuras.
