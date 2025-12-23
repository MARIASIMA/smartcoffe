-- Script SQLite: crear tablas para SmartCoffee

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS clientes (
    cliente_id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    telefono TEXT,
    direccion TEXT,
    puntos_fidelidad INTEGER NOT NULL DEFAULT 0 CHECK(puntos_fidelidad >= 0)
);

CREATE TABLE IF NOT EXISTS empleados (
    empleado_id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    role TEXT NOT NULL,
    turno TEXT,
    email TEXT UNIQUE
);

CREATE TABLE IF NOT EXISTS productos (
    producto_id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    tipo TEXT,
    precio REAL NOT NULL CHECK(precio >= 0),
    disponible INTEGER NOT NULL DEFAULT 1 CHECK(disponible IN (0,1))
);

CREATE TABLE IF NOT EXISTS pedidos (
    pedido_id INTEGER PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    empleado_id INTEGER,
    fecha TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'pendiente',
    total REAL NOT NULL CHECK(total >= 0),
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id) ON DELETE RESTRICT,
    FOREIGN KEY (empleado_id) REFERENCES empleados(empleado_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS detalle_pedido (
    detalle_id INTEGER PRIMARY KEY,
    pedido_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL CHECK(cantidad > 0),
    precio_unitario REAL NOT NULL CHECK(precio_unitario >= 0),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id) ON DELETE RESTRICT
);
