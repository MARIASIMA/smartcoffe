-- Datos de ejemplo para SmartCoffee (SQLite)

PRAGMA foreign_keys = ON;

-- Clientes (al menos 5, con puntos de fidelidad)
INSERT INTO clientes (cliente_id, nombre, email, telefono, direccion, puntos_fidelidad) VALUES
(1, 'Ana López', 'ana.lopez@example.com', '+34 600111222', 'C/ Mayor 1, Ciudad', 120),
(2, 'Carlos Martín', 'c.martin@example.com', '+34 611222333', 'Av. Sol 45, Ciudad', 45),
(3, 'María García', 'm.garcia@example.com', '+34 622333444', 'C/ Luna 7, Ciudad', 300),
(4, 'Lucía Fernández', 'lucia.f@example.com', '+34 633444555', 'Plaza Vieja 3, Ciudad', 10),
(5, 'Pablo Ruiz', 'pablo.ruiz@example.com', '+34 644555666', 'Paseo Verde 10, Ciudad', 75);

-- Empleados (3 con roles y turnos)
INSERT INTO empleados (empleado_id, nombre, role, turno, email) VALUES
(1, 'Miguel Sánchez', 'Barista', 'Mañana', 'miguel.s@example.com'),
(2, 'Sara Torres', 'Repartidor', 'Tarde', 'sara.t@example.com'),
(3, 'Raúl Ortega', 'Encargado', 'Mañana', 'raul.o@example.com');

-- Productos (8 con tipo y precio)
INSERT INTO productos (producto_id, nombre, tipo, precio, disponible) VALUES
(1, 'Café Americano', 'Bebida', 1.50, 1),
(2, 'Cappuccino', 'Bebida', 2.20, 1),
(3, 'Latte', 'Bebida', 2.50, 1),
(4, 'Té Verde', 'Bebida', 1.80, 1),
(5, 'Croissant', 'Comida', 1.20, 1),
(6, 'Sandwich Vegetal', 'Comida', 3.50, 1),
(7, 'Galletas', 'Comida', 0.90, 1),
(8, 'Vaso Reutilizable', 'Accesorio', 5.00, 1);

-- Pedidos (6 pedidos con distintos clientes y empleados)
-- Nota: fecha en ISO 8601, total calculado manualmente para consistencia
INSERT INTO pedidos (pedido_id, cliente_id, empleado_id, fecha, estado, total) VALUES
(1, 1, 1, '2025-11-10T09:12:00', 'entregado', 3.70),
(2, 2, 1, '2025-11-11T10:05:00', 'entregado', 4.70),
(3, 3, 2, '2025-11-12T12:30:00', 'enviado', 8.00),
(4, 1, 3, '2025-11-13T08:00:00', 'entregado', 6.20),
(5, 4, NULL, '2025-11-14T16:45:00', 'pendiente', 5.40),
(6, 5, 2, '2025-11-15T14:20:00', 'entregado', 9.40);

-- Detalles de pedido (cantidades y precios_unitarios)
INSERT INTO detalle_pedido (detalle_id, pedido_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 1, 1, 1.50),  -- Ana: Café Americano
(2, 1, 5, 1, 1.20),  -- Ana: Croissant
(3, 2, 3, 1, 2.50),  -- Carlos: Latte
(4, 2, 7, 2, 0.60),  -- Carlos: 2 Galletas (precio unitario 0.60 usado en este pedido)
(5, 3, 6, 2, 3.50),  -- María: 2 Sandwich Vegetal
(6, 3, 8, 1, 5.00),  -- María: Vaso Reutilizable
(7, 4, 2, 2, 2.20),  -- Ana: 2 Cappuccino
(8, 4, 7, 1, 0.90),  -- Ana: 1 Galleta
(9, 5, 4, 2, 1.80),  -- Lucía: 2 Té Verde
(10, 5, 5, 1, 1.20), -- Lucía: Croissant
(11, 6, 3, 3, 2.50), -- Pablo: 3 Latte
(12, 6, 6, 1, 3.50); -- Pablo: Sandwich Vegetal

-- Observación: los totales en la tabla pedidos deben coincidir con la suma de detalle_pedido (se ha calculado manualmente para este dataset)
