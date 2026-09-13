-- CONSULTAS Y PRUEBAS

\connect "ArkhamBooks"


-- 1. VERIFICAR BASE DE DATOS Y TABLAS
SELECT datname AS base_de_datos
FROM pg_database
WHERE datistemplate = false
ORDER BY datname;

SELECT tablename AS tabla
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY tablename;


-- 2. VERIFICAR CONTEOS
SELECT COUNT(*) AS total_productos FROM Producto;
SELECT COUNT(*) AS total_libros FROM Libro;
SELECT COUNT(*) AS total_revistas FROM Revista;


-- 3. MOSTRAR EL CATALOGO COMPLETO
SELECT
    p.id_producto,
    p.titulo,
    CASE
        WHEN l.id_producto IS NOT NULL THEN 'libro'
        WHEN r.id_producto IS NOT NULL THEN 'revista'
        ELSE 'sin tipo'
    END AS tipo_producto,
    p.precio,
    p.stock,
    p.rating,
    e.nombre_edit AS editorial
FROM Producto p
JOIN Editorial e
    ON p.id_editorial = e.id_editorial
LEFT JOIN Libro l
    ON p.id_producto = l.id_producto
LEFT JOIN Revista r
    ON p.id_producto = r.id_producto
ORDER BY p.id_producto;


-- 4. MOSTRAR SOLO LIBROS
SELECT
    p.id_producto,
    p.titulo,
    l.isbn,
    l.edicion,
    l.anio_publicacion,
    p.precio,
    p.stock
FROM Producto p
JOIN Libro l
    ON p.id_producto = l.id_producto
ORDER BY p.id_producto;


-- 5. MOSTRAR SOLO REVISTAS
SELECT
    p.id_producto,
    p.titulo,
    r.issn,
    r.numero_edicion,
    r.fecha_publicacion,
    p.precio,
    p.stock
FROM Producto p
JOIN Revista r
    ON p.id_producto = r.id_producto
ORDER BY p.id_producto;


-- 6. INSERT DE PRUEBA
WITH nuevo_producto AS (
    INSERT INTO Producto (titulo, precio, stock, rating, id_editorial)
    VALUES ('libro de prueba pc1', 49.90, 10, 4, 1)
    RETURNING id_producto
)
INSERT INTO Libro (id_producto, isbn, edicion, anio_publicacion)
SELECT id_producto, '9789999999999', '1ra edicion', 2026
FROM nuevo_producto
RETURNING id_producto, isbn, edicion, anio_publicacion;

SELECT
    p.id_producto,
    p.titulo,
    l.isbn,
    l.edicion,
    l.anio_publicacion
FROM Producto p
JOIN Libro l
    ON p.id_producto = l.id_producto
WHERE l.isbn = '9789999999999';


-- 7. UPDATE DE PRODUCTO
-- Antes
SELECT id_producto, titulo, precio, stock
FROM Producto
WHERE id_producto = 1;

-- Modificación
UPDATE Producto
SET precio = 89.90,
    stock = stock - 1
WHERE id_producto = 1
RETURNING id_producto, titulo, precio, stock;

-- Despues
SELECT id_producto, titulo, precio, stock
FROM Producto
WHERE id_producto = 1;


-- 8. UPDATE DE PEDIDO
-- Antes
SELECT id_pedido, id_usuario, fecha_compra, estado
FROM Pedido
WHERE id_pedido = 2;

-- Modificación
UPDATE Pedido
SET estado = 'enviado'
WHERE id_pedido = 2
RETURNING id_pedido, id_usuario, fecha_compra, estado;

-- Despues
SELECT id_pedido, id_usuario, fecha_compra, estado
FROM Pedido
WHERE id_pedido = 2;


-- 9. DELETE DE DETALLE
-- Antes: debe existir una fila
SELECT *
FROM Detalle_Pedido
WHERE id_pedido = 2
  AND id_producto = 3;

-- Eliminación
DELETE FROM Detalle_Pedido
WHERE id_pedido = 2
  AND id_producto = 3
RETURNING *;

-- Despues: debe devolver 0 filas
SELECT *
FROM Detalle_Pedido
WHERE id_pedido = 2
  AND id_producto = 3;


-- 10. RELACION PRODUCTO - AUTOR - EDITORIAL
SELECT
    p.titulo,
    a.nombre_autor,
    e.nombre_edit
FROM Producto p
JOIN Producto_Autor pa
    ON p.id_producto = pa.id_producto
JOIN Autor a
    ON pa.id_autor = a.id_autor
JOIN Editorial e
    ON p.id_editorial = e.id_editorial
ORDER BY p.id_producto;


-- 11. RELACION PRODUCTO - CATEGORIA
SELECT
    p.titulo,
    c.nombre_cat AS categoria
FROM Producto p
JOIN Producto_Categoria pc
    ON p.id_producto = pc.id_producto
JOIN Categoria c
    ON pc.id_categoria = c.id_categoria
ORDER BY p.id_producto, c.nombre_cat;


-- 12. PRODUCTOS COMPRADOS POR PEDIDO
SELECT
    pe.id_pedido,
    u.nombre AS usuario,
    p.titulo,
    dp.cantidad,
    dp.precio_unit,
    (dp.cantidad * dp.precio_unit) AS subtotal,
    pe.estado
FROM Detalle_Pedido dp
JOIN Pedido pe
    ON dp.id_pedido = pe.id_pedido
JOIN Usuario u
    ON pe.id_usuario = u.id_usuario
JOIN Producto p
    ON dp.id_producto = p.id_producto
ORDER BY pe.id_pedido, p.titulo;