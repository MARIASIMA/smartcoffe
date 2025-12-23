#!/usr/bin/env python3
"""
smartcoffee_db.py

Conecta a la base de datos SQLite del proyecto, crea la base de datos si no existe
(ejecutando create_tables.sql e insert_data.sql) y ejecuta varias consultas de ejemplo
mostrando resultados por consola.

No requiere interacción del usuario.
"""

import os
import sqlite3
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent
DB_PATH = BASE_DIR / 'smartcoffee.db'
SQL_DIR = BASE_DIR / 'database'

def ejecutar_sql_file(conn, sql_file_path):
    with open(sql_file_path, 'r', encoding='utf-8') as f:
        sql_script = f.read()
    conn.executescript(sql_script)


def asegurar_base_datos():
    """Crea y pobla la base de datos si no existe."""
    created = False
    if not DB_PATH.exists():
        print('Base de datos no encontrada. Creando y poblando:', DB_PATH)
        conn = sqlite3.connect(DB_PATH)
        try:
            ejecutar_sql_file(conn, SQL_DIR / 'create_tables.sql')
            ejecutar_sql_file(conn, SQL_DIR / 'insert_data.sql')
            created = True
            print('Base de datos creada y poblada.')
        finally:
            conn.close()
    return created


def ejecutar_consultas():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    try:
        c = conn.cursor()

        queries = [
            ("Pedidos por cliente (cliente_id=1)", "SELECT p.pedido_id, p.fecha, p.estado, p.total FROM pedidos p WHERE p.cliente_id = 1 ORDER BY p.fecha DESC;"),
            ("Total gastado por cliente", "SELECT c.cliente_id, c.nombre, IFNULL(SUM(p.total),0) AS total_gastado FROM clientes c LEFT JOIN pedidos p ON c.cliente_id = p.cliente_id GROUP BY c.cliente_id ORDER BY total_gastado DESC;"),
            ("Productos más vendidos", "SELECT pr.producto_id, pr.nombre, SUM(d.cantidad) AS total_vendido FROM productos pr JOIN detalle_pedido d ON pr.producto_id = d.producto_id GROUP BY pr.producto_id ORDER BY total_vendido DESC;"),
            ("Ventas totales", "SELECT IFNULL(SUM(total),0) AS ventas_totales FROM pedidos;"),
            ("Empleado con más pedidos", "SELECT e.empleado_id, e.nombre, COUNT(p.pedido_id) AS pedidos_gestionados FROM empleados e JOIN pedidos p ON e.empleado_id = p.empleado_id GROUP BY e.empleado_id ORDER BY pedidos_gestionados DESC LIMIT 1;"),
            ("Ticket medio", "SELECT IFNULL(AVG(total),0) AS ticket_medio FROM pedidos;"),
            ("Clientes con más puntos", "SELECT cliente_id, nombre, puntos_fidelidad FROM clientes ORDER BY puntos_fidelidad DESC LIMIT 5;"),
            ("Producto con mayor facturación", "SELECT pr.producto_id, pr.nombre, SUM(d.cantidad * d.precio_unitario) AS facturacion FROM productos pr JOIN detalle_pedido d ON pr.producto_id = d.producto_id GROUP BY pr.producto_id ORDER BY facturacion DESC LIMIT 1;"),
            ("Historial completo (JOINs)", "SELECT p.pedido_id, p.fecha, p.estado, c.nombre AS cliente, e.nombre AS empleado, p.total FROM pedidos p JOIN clientes c ON p.cliente_id = c.cliente_id LEFT JOIN empleados e ON p.empleado_id = e.empleado_id ORDER BY p.fecha DESC;"),
            ("Pedidos con más productos (por líneas)", "SELECT p.pedido_id, c.nombre AS cliente, COUNT(d.detalle_id) AS lineas FROM pedidos p JOIN detalle_pedido d ON p.pedido_id = d.pedido_id JOIN clientes c ON p.cliente_id = c.cliente_id GROUP BY p.pedido_id ORDER BY lineas DESC;"),
        ]

        for titulo, sql in queries:
            print('\n---', titulo, '---')
            c.execute(sql)
            rows = c.fetchall()
            if not rows:
                print('(sin resultados)')
                continue
            # Imprimir cabecera
            columnas = rows[0].keys()
            print('\t'.join(columnas))
            for r in rows:
                print('\t'.join(str(r[col]) for col in columnas))

    finally:
        conn.close()


if __name__ == '__main__':
    # Asegurar base de datos y ejecutar consultas
    asegurar_base_datos()
    ejecutar_consultas()
