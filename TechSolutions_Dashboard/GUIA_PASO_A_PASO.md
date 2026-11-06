# Guía paso a paso – Dashboard TechSolutions S.A.S.

Contenido del paquete:

| Archivo | Para qué sirve |
|---|---|
| `TechSolutions_Ventas.xlsx` | Datos ya organizados (tabla `tblVentas` + columna *Total de ventas* + hoja *Verificación*) |
| `01_PowerQuery.m` | Código de conexión y limpieza (Power Query) |
| `02_Medidas_DAX.dax` | Todas las medidas del dashboard |
| `tema_TechSolutions.json` | Tema de colores opcional para Power BI |

Arquitectura: **Excel en OneDrive → Power Query → modelo (tabla Ventas + medidas DAX) → informe en Power BI Service**.

---

## PARTE 1 – Excel Online (≈ 20 min)

1. Entra a **onedrive.live.com** (o al OneDrive de tu universidad) e inicia sesión.
2. Pulsa **Cargar → Archivos** y sube `TechSolutions_Ventas.xlsx`.
3. Ábrelo (se abre en Excel Online) y revisa:
   - Hoja **Ventas**: 10 registros, columnas `ID … Precio` y `Total de ventas`.
   - Hoja **Verificación**: las cuatro filas deben decir **OK** (Total 36.320.000, 114 unidades, 6 productos, 10 registros).
4. Comprueba que `Total de ventas` = `Unidades × Precio` (fórmula `=F2*G2`).
5. **Captura 1:** hoja Ventas con la columna Total de ventas.
6. Compartir (permisos para el docente): botón **Compartir → Cualquier persona con el vínculo puede ver** (o agrega el correo del docente). Elige **Solo ver**, copia el enlace y guárdalo.

> Si prefieres crear el Excel a mano: pega los datos en A1:G11, selecciona todo, **Insertar → Tabla**, ponle el nombre `tblVentas` en *Diseño de tabla*, y en H1 escribe `Total de ventas` con la fórmula `=F2*G2`. Formatea `ID` como Texto.

---

## PARTE 2 – Power BI Desktop: conexión (≈ 25 min)

Descarga Power BI Desktop gratis (Microsoft Store o powerbi.microsoft.com).

1. Descarga también el Excel a tu computador (o usa la carpeta sincronizada de OneDrive).
2. Abre Power BI Desktop → **Inicio → Obtener datos → Libro de Excel** → selecciona el archivo → marca la tabla **tblVentas** → **Transformar datos**.
3. En Power Query: **Inicio → Editor avanzado**. Borra el contenido y pega la **Opción A** de `01_PowerQuery.m` (cambia la ruta por la tuya). Pulsa **Listo**.
4. Cambia el nombre de la consulta (panel derecho) a **`Ventas`**.
5. Verifica los tipos: `ID`, `Producto`, `Categoría`, `Ciudad`, `Vendedor` = Texto; `Unidades`, `Precio`, `Total de ventas` = Número entero.
6. **Cerrar y aplicar**.
7. En la **Vista de datos** (icono de tabla a la izquierda) comprueba los 10 registros. En el panel *Datos* haz clic en cada campo y ajusta **Herramientas de columna → Resumen**:
   - `Unidades`, `Total de ventas` → **Suma** (métricas)
   - `Precio` → **No resumir**
   - `ID`, `Producto`, `Categoría`, `Ciudad`, `Vendedor` → **No resumir** (dimensiones)
8. **Captura 2:** Power Query / Vista de datos con los campos reconocidos.

### Para usar el archivo directamente desde la nube (opcional)
- **OneDrive empresarial / SharePoint:** copia el enlace de compartir, agrega `?download=1` al final y usa la **Opción B** del archivo `.m`.
- **OneDrive personal:** convierte el enlace de compartir así: codifica el enlace en Base64, cambia `+` por `-`, `/` por `_`, quita los `=` finales y antepón `u!`. El enlace final es `https://api.onedrive.com/v1.0/shares/u!CODIGO/root/content`. Úsalo en la Opción B en lugar de la URL.

Esto responde la pregunta de la Fase 2: una fuente en la nube es única para todos, se actualiza sin reenviar archivos, tiene control de acceso, historial de versiones y copia de respaldo; un archivo local genera versiones duplicadas y depende de un solo equipo.

---

## PARTE 3 – Medidas DAX (≈ 15 min)

1. **Vista de informe → Inicio → Nueva medida**.
2. Abre `02_Medidas_DAX.dax` y copia **una medida a la vez** (desde `Nombre =` hasta antes de la siguiente). Pégala en la barra de fórmulas y pulsa Enter.
3. Crea las 11 medidas: `Total Ingresos`, `Unidades Totales`, `Productos Distintos`, `Promedio por Producto`, `Promedio por Transacción`, `% Participación`, `Ranking Vendedor`, `Producto Top`, `Categoría Top`, `Ciudad Top`, `Vendedor Top`.
4. Formato (pestaña **Herramientas de medida**): moneda `$ #,##0` en ingresos y promedios; porcentaje en `% Participación`.
5. **Captura 3:** panel de campos con las medidas y una de ellas en la barra de fórmulas.

---

## PARTE 4 – Construir el dashboard (≈ 60 min)

**Preparación**
- (Opcional) **Vista → Temas → Examinar temas** → selecciona `tema_TechSolutions.json`.
- **Vista → Tamaño de página → 16:9**.

**Encabezado**
1. **Insertar → Cuadro de texto**: `DASHBOARD DE VENTAS` y debajo `TechSolutions S.A.S.` (título + nombre de la empresa).

**Segmentadores (filtros)** – arriba a la derecha
2. Visual **Segmentación de datos** → campo `Ciudad`. En *Formato → Configuración de segmentación → Opciones → Estilo*: **Desplegable**.
3. Otro segmentador → campo `Categoría`, mismo estilo.

**Cuatro tarjetas (KPI)** – una fila debajo del título
4. Visual **Tarjeta** × 4, cada una con: `Total Ingresos`, `Unidades Totales`, `Productos Distintos`, `Promedio por Producto`. Renombra los títulos: *Ingresos por ventas*, *Unidades vendidas*, *Productos diferentes*, *Promedio de ventas por producto*.

**Tres gráficos** – fila central
5. **Gráfico de barras agrupadas**: Eje `Categoría`, Valores `Total Ingresos`. Título: *Ventas por categoría*.
6. **Gráfico circular**: Leyenda `Producto`, Valores `Total Ingresos`. Título: *Participación de ventas por producto*. En *Etiquetas de detalle* elige **Categoría, porcentaje del total**.
7. **Gráfico de barras agrupadas**: Eje `Ciudad`, Valores `Total Ingresos`. Título: *Ventas por ciudad*.
8. Activa **Etiquetas de datos** en los tres (Formato → Etiquetas de datos).

**Tabla de vendedores** – fila inferior
9. Visual **Tabla** con: `Vendedor`, `Unidades Totales`, `Total Ingresos`, `% Participación`, `Ranking Vendedor`. Título: *Desempeño de los vendedores*.

**(Opcional) Tarjetas de respuesta rápida:** `Producto Top`, `Categoría Top`, `Ciudad Top`, `Vendedor Top`, que cambian al usar los filtros.

**Prueba de interactividad:** elige *Bogotá* en el filtro de ciudad y verifica que todos los visuales cambien. Con el filtro vacío, los KPI deben dar 36.320.000 / 114 / 6 / 6.053.333.

10. **Captura 4:** dashboard completo.

Distribución sugerida:

```
┌─────────────────────────────────────────────────────────────┐
│ DASHBOARD DE VENTAS – TechSolutions S.A.S.  [Ciudad][Categ.] │
├───────────┬───────────┬───────────┬─────────────────────────┤
│ Ingresos  │ Unidades  │ Productos │ Promedio x producto     │
├───────────┴──┬────────┴───────────┴──┬──────────────────────┤
│ Barras:      │ Circular:             │ Barras:              │
│ Categoría    │ Producto              │ Ciudad               │
├──────────────┴───────────────────────┴──────────────────────┤
│ Tabla: desempeño de vendedores                              │
└─────────────────────────────────────────────────────────────┘
```

---

## PARTE 5 – Publicar y compartir (≈ 15 min)

1. **Inicio → Publicar** → inicia sesión con tu cuenta institucional (los correos personales como Gmail/Outlook.com **no** funcionan en Power BI Service) → elige **Mi área de trabajo**.
2. Abre el enlace que te da Power BI Desktop (*Abrir 'TechSolutions' en Power BI*).
3. En Power BI Service: **Archivo → Insertar informe / Compartir** → **Compartir**. Agrega el correo del docente (o *Personas de tu organización con el vínculo*) y copia el enlace.
4. Para convertirlo en **dashboard**: en el informe, **Editar → … → Anclar a un panel** (*Anclar página activa*) → crea un panel nuevo llamado *TechSolutions Dashboard*.
5. **Captura 5:** el dashboard publicado con el botón Compartir/permisos visible.

**Si Power BI Service no te deja publicar o compartir** (cuenta no institucional, o el docente no tiene licencia):
- Guarda el `.pbix` y súbelo a OneDrive con enlace de solo lectura.
- Exporta a PDF (**Archivo → Exportar → PDF**) y adjúntalo.
- Como alternativa, Looker Studio acepta una hoja de Google Sheets y se comparte con un enlace sin licencia.

---

## PARTE 6 – Respuestas de análisis (con los datos reales)

| Pregunta | Respuesta |
|---|---|
| Producto con mayores ingresos | **Portátil**: $22.400.000 (61,7 %) |
| Mejor categoría | **Hardware**: $26.900.000 (74,1 %) |
| Ciudad con mayores ingresos | **Bogotá**: $20.900.000 (57,5 %) |
| Mejor vendedor | **Carlos**: $17.435.000 (48,0 %) |

Totales: ingresos $36.320.000 · 114 unidades · 6 productos · promedio por producto $6.053.333.

Decisiones sugeridas: venta cruzada de licencias y soporte con los portátiles; capacitar a Andrés (43 unidades pero solo $3.885.000, vende productos de bajo valor); campaña en Medellín (8,4 %); reducir la dependencia de los portátiles.

Riesgos en la nube: acceso no autorizado, fuga de datos, permisos excesivos, falta de cifrado y cumplimiento de la Ley 1581 de 2012 (Habeas Data). Mitigación: autenticación multifactor, permisos por rol, enlaces solo lectura, cifrado, copias de respaldo y no publicar datos personales.

---

## Lista de verificación de entrega

- [ ] Enlace al Excel en la nube (solo lectura)
- [ ] Enlace al dashboard publicado
- [ ] Enlace al tablero de actividades por integrante
- [ ] 5 capturas de pantalla
- [ ] Documento con respuestas del análisis y propuesta (Fase 5)
- [ ] Todos los enlaces con permisos para el docente, sin datos personales
