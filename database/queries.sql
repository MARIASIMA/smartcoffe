-- Consultas útiles para SmartCoffee (SQLite)

-- 1) Pedidos por cliente (listar pedidos de cada cliente)
-- Parámetro: cliente_id
SELECT p.pedido_id, p.fecha, p.estado, p.total
FROM pedidos p
WHERE p.cliente_id = 1
ORDER BY p.fecha DESC;

-- 2) Total gastado por cliente
SELECT c.cliente_id, c.nombre, SUM(p.total) AS total_gastado
FROM clientes c
LEFT JOIN pedidos p ON c.cliente_id = p.cliente_id
GROUP BY c.cliente_id
ORDER BY total_gastado DESC;

-- 3) Productos más vendidos (por cantidad)
SELECT pr.producto_id, pr.nombre, SUM(d.cantidad) AS total_vendido
FROM productos pr
JOIN detalle_pedido d ON pr.producto_id = d.producto_id
GROUP BY pr.producto_id
ORDER BY total_vendido DESC;

-- 4) Ventas totales (suma de todos los pedidos)
SELECT SUM(total) AS ventas_totales FROM pedidos;

-- 5) Empleado con más pedidos gestionados
SELECT e.empleado_id, e.nombre, COUNT(p.pedido_id) AS pedidos_gestionados
FROM empleados e
JOIN pedidos p ON e.empleado_id = p.empleado_id
GROUP BY e.empleado_id
ORDER BY pedidos_gestionados DESC
LIMIT 1;

-- 6) Ticket medio (promedio de total por pedido)
SELECT AVG(total) AS ticket_medio FROM pedidos;

-- 7) Clientes con más puntos de fidelidad
SELECT cliente_id, nombre, puntos_fidelidad
FROM clientes
ORDER BY puntos_fidelidad DESC
LIMIT 5;

-- 8) Producto con mayor facturación (cantidad * precio_unitario sumado)
SELECT pr.producto_id, pr.nombre, SUM(d.cantidad * d.precio_unitario) AS facturacion
FROM productos pr
JOIN detalle_pedido d ON pr.producto_id = d.producto_id
GROUP BY pr.producto_id
ORDER BY facturacion DESC
LIMIT 1;

-- 9) Historial completo de pedidos con JOINs (cliente, empleado, detalles)
SELECT p.pedido_id, p.fecha, p.estado, c.nombre AS cliente, e.nombre AS empleado, p.total
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.cliente_id
LEFT JOIN empleados e ON p.empleado_id = e.empleado_id
ORDER BY p.fecha DESC;

-- 10) Pedidos con más productos (por número de líneas o cantidad total)
-- Por número de líneas (detalle rows)
SELECT p.pedido_id, c.nombre AS cliente, COUNT(d.detalle_id) AS lineas
FROM pedidos p
JOIN detalle_pedido d ON p.pedido_id = d.pedido_id
JOIN clientes c ON p.cliente_id = c.cliente_id
GROUP BY p.pedido_id
ORDER BY lineas DESC;

-- 11) (Extra) Productos no vendidos
SELECT pr.producto_id, pr.nombre
FROM productos pr
LEFT JOIN detalle_pedido d ON pr.producto_id = d.producto_id
WHERE d.detalle_id IS NULL;

-- 12) (Extra) Ventas por día
SELECT DATE(fecha) AS dia, SUM(total) AS ventas_dia, COUNT(pedido_id) AS num_pedidos
FROM pedidos
GROUP BY dia
ORDER BY dia DESC;
