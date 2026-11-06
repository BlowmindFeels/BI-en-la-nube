# Dashboard web TechSolutions S.A.S. – cómo publicarlo

Archivos:
- `index.html`: el dashboard completo (HTML + CSS + JavaScript). No necesita instalar nada.
- `ventas.csv`: los 10 registros, para subirlos a Google Sheets (la fuente de datos en la nube).

Para probarlo en tu computador: haz doble clic en `index.html` (necesita internet para cargar la librería de gráficos).

---

## 1. Publicarlo con GitHub Pages (gratis, enlace público)

1. Crea una cuenta en github.com (o inicia sesión).
2. Arriba a la derecha: **+ → New repository**. Nombre: `techsolutions-dashboard`. Marca **Public**. Pulsa **Create repository**.
3. Pulsa **uploading an existing file**, arrastra `index.html` y pulsa **Commit changes**.
4. Ve a **Settings → Pages**. En *Build and deployment → Source* elige **Deploy from a branch**; en *Branch* elige **main** y la carpeta **/(root)**; pulsa **Save**.
5. Espera 1 o 2 minutos y recarga la página. Aparece el enlace:
   `https://TU_USUARIO.github.io/techsolutions-dashboard/`
6. Ábrelo y comprueba que carga. Ese es el enlace del dashboard para el docente. **Captura 4.**

### Alternativa: Netlify
1. Entra a app.netlify.com y crea una cuenta gratuita.
2. Ve a **Add new site → Deploy manually** y arrastra la carpeta que contiene `index.html`.
3. Copia el enlace que te da. Sin cuenta, el sitio se borra a la hora.

---

## 2. Conectar los datos en la nube con Google Sheets (Fase 2)

1. Entra a Google Drive → **Nuevo → Subir archivo** → sube `ventas.csv` → ábrelo con **Hojas de cálculo de Google**.
2. Renombra la hoja a `Ventas`. (Opcional: agrega la columna `Total de ventas` con `=F2*G2`.) **Captura 1.**
3. Deja `Unidades` y `Precio` como números simples, sin formato de moneda.
4. **Archivo → Compartir → Publicar en la Web** → elige la hoja `Ventas` y el formato **Valores separados por comas (.csv)** → **Publicar** → copia el enlace.
5. Abre `index.html` (en GitHub: clic en el archivo → icono del lápiz) y pega el enlace en esta línea:

   `const FUENTE_CSV = "AQUI_EL_ENLACE";`

6. Guarda (**Commit changes**). En 1 o 2 minutos, el pie de página del dashboard dirá **Fuente: Google Sheets (nube)**.

Desde ahora, si cambias un dato en la hoja de Google, el dashboard lo refleja al recargar la página (Google puede tardar unos minutos en publicar el cambio). **Captura 2:** la hoja de Google y el enlace de publicación.

Si el enlace falla, el dashboard usa los datos incluidos en la página y lo indica en el pie.

---

## 3. Capturas y entrega

1. Hoja de datos con `Total de ventas`.
2. Publicación de la hoja en la nube (paso 4 de la sección 2).
3. Código del dashboard en GitHub (repositorio con `index.html`).
4. Dashboard publicado, con el enlace visible en la barra del navegador.
5. Dashboard con un filtro aplicado (por ejemplo, Bogotá).

Enlaces para el documento: dashboard (GitHub Pages), hoja de Google Sheets (**Compartir → Cualquier persona con el enlace → Lector**) y repositorio de GitHub.

## 4. Qué debe mostrar con todos los filtros vacíos

Ingresos $ 36.320.000 · 114 unidades · 6 productos · promedio por producto $ 6.053.333.
Producto top: Portátil · Categoría: Hardware · Ciudad: Bogotá · Vendedor: Carlos.
