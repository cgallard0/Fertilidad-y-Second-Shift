# El costo invisible de la fertilidad: la segunda jornada en el hogar

Trabajo final de *Exploraciones sobre Pobreza, Desarrollo Humano y Políticas Sociales* (Universidad de San Andrés, 2025).

**Autoras:** Constanza Efkhanian, Catalina Gallardo e Inés Parra Cortijo
**Profesor:** Mariano Tommasi · **Tutoras:** Pilar Hüppi Lo Prete, María Victoria Rosino y María Florencia Ruiz

El trabajo analiza la relación entre la división del trabajo doméstico (el *second shift*) y la fertilidad en la Ciudad de Buenos Aires, a partir de la Encuesta Demográfica Retrospectiva (EDER-CABA 2019): cómo se relaciona la división de tareas del hogar con la cantidad de hijos, cómo cambia esa división después del primer hijo y cómo interactúa con la informalidad laboral de las madres.

📄 **Trabajo:** [`El costo invisible de la fertilidad.pdf`](El%20costo%20invisible%20de%20la%20fertilidad.pdf)

## Estructura

```
├── El costo invisible de la fertilidad.pdf     # el trabajo
├── programs/
│   ├── python/construccion_bases_y_figuras.ipynb  # arma las bases, estadísticas descriptivas y figuras
│   └── stata/regresiones.do                       # regresiones de los Apéndices B y C
├── output/
│   ├── data/      # bases de análisis generadas por el notebook (input del do-file)
│   ├── figures/   # figuras del trabajo (numeradas como en el PDF)
│   └── tables/    # tablas de regresión y estadísticas descriptivas
└── data/          # microdatos de la EDER (no incluidos en el repositorio)
```

## Datos

Se usan los microdatos de la **EDER 2019** de la Dirección General de Estadística y Censos del GCBA. Para replicar, descargar las bases y ubicar en `data/`:

- `eder2019_usuarios_retro.txt`
- `eder2019_usuarios_personas.txt`
- `eder2019_usuarios_retro_conyuge.txt`
- `eder2019_usuarios_retro_hijo.txt`

## Cómo replicar

1. **Python** (pandas, numpy, matplotlib, seaborn): correr `programs/python/construccion_bases_y_figuras.ipynb`. Genera `output/data/*.csv`, `output/figures/*.png` y `output/tables/estadisticas_descriptivas.txt`.
2. **Stata** (requiere `outreg2`: `ssc install outreg2`): cambiar el `global main` al comienzo de `programs/stata/regresiones.do` por la ruta de esta carpeta y correrlo. Genera `output/tables/tabla_B`, `tabla_C1`, `tabla_C2` y `tabla_C3`.

| Salida | Sección del trabajo |
|---|---|
| `figura_02` … `figura_14` | Figuras 2 a 14 |
| `tabla_B` | Tabla B1 (Apéndice B) |
| `tabla_C1`, `tabla_C2`, `tabla_C3` | Tablas C1 a C3 (Apéndice C) |
