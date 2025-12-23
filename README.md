# SmartCoffee — Proyecto de curso

Repositorio del proyecto de digitalización para la cadena de cafeterías "SmartCoffee".

**Resumen:**
SmartCoffee centraliza la gestión de clientes, empleados, productos, pedidos y rutas de entrega. Este repositorio recoge el avance por sesiones: modelo E/R, diagramas UML, scripts SQL (creación e inserción), consultas de ejemplo y scripts Python para interactuar con la base de datos y trabajar rutas (grafos).


Estructura del repositorio:

- database/
	- modelo_ER.md          Descripción del modelo Entidad-Relación
	- uml.md                Diagrama UML en formato textual
	- create_tables.sql     Script SQLite para crear tablas
	- insert_data.sql       Datos de ejemplo
	- queries.sql           Consultas útiles (ejemplos)
- python/
	- smartcoffee_db.py     Script para ejecutar consultas y poblar BD
	- smartcoffee_rutas.py  Ejercicio de grafos con networkx
- docs/
	- explicacion_trabajo.md  Registro de sesiones y justificaciones

Cómo ejecutar los scripts SQL y Python

1. Crear la base de datos SQLite y poblarla (opcional manual):

```bash
sqlite3 smartcoffee.db < database/create_tables.sql
sqlite3 smartcoffee.db < database/insert_data.sql
```

Recomendado: los scripts Python comprueban si la base de datos existe y, si no, intentan crearla y poblarla usando los scripts SQL anteriores.

2. Ejecutar script de consultas (muestra resultados por consola):

```bash
python3 python/smartcoffee_db.py
```

3. Ejecutar script de rutas (necesita `networkx`; para visualización también `matplotlib`):

```bash
python3 python/smartcoffee_rutas.py
```

Dependencias mínimas (instalar si no están presentes):

```bash
pip install networkx matplotlib
```

Nota sobre mantenimiento por sesiones

Este repositorio está pensado para ir actualizándose durante las sesiones prácticas: cada sesión añadiremos comentarios, nuevas consultas, mejoras del modelo y casos de uso. Los archivos reflejan versiones iniciales y ejemplos listos para evaluación académica.

Licencia: contenido para uso académico y evaluación (ajustar según el curso).