#!/usr/bin/env python3
"""
smartcoffee_rutas.py

Ejercicio de grafos: representamos 1 cafetería y 4 clientes como nodos en un grafo
ponderado. Calculamos rutas más cortas (Dijkstra) desde la cafetería y determinamos
el cliente más lejano. Opcionalmente se guarda una imagen del grafo con la ruta
resaltada (requiere matplotlib).

No interactivo: al ejecutarlo imprimirá resultados y guardará `rutas.png` si es posible.
"""

import sys
from pathlib import Path

try:
    import networkx as nx
except Exception as e:
    print('Error: networkx no está instalado. Instale con "pip install networkx"')
    sys.exit(1)

HAS_MPL = True
try:
    import matplotlib.pyplot as plt
except Exception:
    HAS_MPL = False

# Definición de nodos: 'Cafeteria' + 4 clientes
NODOS = ['Cafeteria', 'Cliente A', 'Cliente B', 'Cliente C', 'Cliente D']

# Aristas con pesos (distancias en km o unidades arbitrarias)
ARISTAS = [
    ('Cafeteria', 'Cliente A', 1.2),
    ('Cafeteria', 'Cliente B', 3.5),
    ('Cafeteria', 'Cliente C', 2.0),
    ('Cliente A', 'Cliente B', 2.0),
    ('Cliente A', 'Cliente C', 1.5),
    ('Cliente B', 'Cliente D', 2.5),
    ('Cliente C', 'Cliente D', 3.0),
]

G = nx.Graph()
G.add_nodes_from(NODOS)
for u, v, w in ARISTAS:
    G.add_edge(u, v, weight=w)

# Calcular rutas desde 'Cafeteria' usando Dijkstra
origen = 'Cafeteria'
longitudes = nx.single_source_dijkstra_path_length(G, origen, weight='weight')
rutas = nx.single_source_dijkstra_path(G, origen, weight='weight')

# Identificar cliente más lejano (excluimos la propia cafetería)
clientes = [n for n in NODOS if n != origen]
cliente_mas_lejano = max(clientes, key=lambda c: longitudes.get(c, float('inf')))

print('Distancias desde', origen)
for c in clientes:
    dist = longitudes.get(c, None)
    ruta = rutas.get(c, None)
    print(f'- {c}: distancia = {dist}, ruta = {ruta}')

print('\nCliente más lejano:', cliente_mas_lejano, 'distancia =', longitudes.get(cliente_mas_lejano))

# Visualización (bonus): guardar imagen con la ruta resaltada
out_path = Path(__file__).resolve().parent / 'rutas.png'
if HAS_MPL:
    pos = nx.spring_layout(G, seed=42)
    plt.figure(figsize=(8,6))
    # Dibujar nodos y etiquetas
    nx.draw_networkx_nodes(G, pos, node_color='lightblue', node_size=800)
    nx.draw_networkx_labels(G, pos)
    # Dibujar todas las aristas normales
    nx.draw_networkx_edges(G, pos, edgelist=G.edges(), width=1)
    # Resaltar la ruta hacia el cliente más lejano
    ruta_resaltada = rutas[cliente_mas_lejano]
    aristas_ruta = list(zip(ruta_resaltada[:-1], ruta_resaltada[1:]))
    nx.draw_networkx_edges(G, pos, edgelist=aristas_ruta, width=3, edge_color='red')
    # Dibujar pesos
    edge_labels = {(u, v): f"{d['weight']}" for u, v, d in G.edges(data=True)}
    nx.draw_networkx_edge_labels(G, pos, edge_labels=edge_labels)
    plt.title(f'Rutas desde {origen} — cliente más lejano: {cliente_mas_lejano} ({longitudes[cliente_mas_lejano]})')
    plt.axis('off')
    plt.tight_layout()
    plt.savefig(out_path)
    print('\nSe ha guardado la visualización en:', out_path)
else:
    print('\nmatplotlib no disponible — la visualización se omite. Para ver la gráfica, instale matplotlib.')
