// =====================================================================
// TechSolutions S.A.S. - Consulta Power Query (lenguaje M)
// Power BI Desktop > Transformar datos > Nueva consulta > Consulta en blanco
// > Editor avanzado > borra todo y pega UNA de las dos opciones.
// Nombra la consulta:  Ventas
// =====================================================================

// ---------------------------------------------------------------------
// OPCIÓN A - Archivo Excel guardado en tu computador / OneDrive sincronizado
// Cambia la ruta por la de tu archivo.
// ---------------------------------------------------------------------
let
    Origen = Excel.Workbook(
        File.Contents("C:\Users\TU_USUARIO\OneDrive\TechSolutions_Ventas.xlsx"),
        null, true),
    Tabla = Origen{[Item = "tblVentas", Kind = "Table"]}[Data],
    Tipos = Table.TransformColumnTypes(Tabla, {
        {"ID", type text},
        {"Producto", type text},
        {"Categoría", type text},
        {"Ciudad", type text},
        {"Vendedor", type text},
        {"Unidades", Int64.Type},
        {"Precio", Int64.Type}
    }),
    // Se vuelve a calcular aquí para no depender de la fórmula de Excel
    SinTotalExcel = Table.RemoveColumns(Tipos, {"Total de ventas"}, MissingField.Ignore),
    TotalVentas = Table.AddColumn(SinTotalExcel, "Total de ventas",
        each [Unidades] * [Precio], Int64.Type)
in
    TotalVentas


// ---------------------------------------------------------------------
// OPCIÓN B - Archivo en la NUBE (OneDrive / SharePoint) por enlace web
// Sirve para actualizar el informe desde Power BI Service.
//
//  * OneDrive empresarial / SharePoint: copia el enlace de compartir y
//    añade al final  ?download=1
//  * OneDrive personal: usa el enlace  https://api.onedrive.com/v1.0/shares/u!XXXX/root/content
//    (XXXX = enlace de compartir codificado en Base64 URL-safe; ver la guía)
//
// Para usarla, reemplaza el bloque de arriba por este:
// ---------------------------------------------------------------------
/*
let
    Origen = Excel.Workbook(
        Web.Contents("https://TU_ENLACE_ONEDRIVE/TechSolutions_Ventas.xlsx?download=1"),
        null, true),
    Tabla = Origen{[Item = "tblVentas", Kind = "Table"]}[Data],
    Tipos = Table.TransformColumnTypes(Tabla, {
        {"ID", type text},
        {"Producto", type text},
        {"Categoría", type text},
        {"Ciudad", type text},
        {"Vendedor", type text},
        {"Unidades", Int64.Type},
        {"Precio", Int64.Type}
    }),
    SinTotalExcel = Table.RemoveColumns(Tipos, {"Total de ventas"}, MissingField.Ignore),
    TotalVentas = Table.AddColumn(SinTotalExcel, "Total de ventas",
        each [Unidades] * [Precio], Int64.Type)
in
    TotalVentas
*/
