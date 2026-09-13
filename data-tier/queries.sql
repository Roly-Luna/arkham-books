-- CONSULTAS Y PRUEBAS
USE ArkhamBooks;

-- 1. Mostrar el catálogo indicando si es libro o revista
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
JOIN Editorial e ON p.id_editorial = e.id_editorial
LEFT JOIN Libro l ON p.id_producto = l.id_producto
LEFT JOIN Revista r ON p.id_producto = r.id_producto
ORDER BY p.id_producto;

-- 2. Mostrar solo libros
SELECT
    p.id_producto,
    p.titulo,
    l.isbn,
    l.edicion,
    l.anio_publicacion,
    p.precio,
    p.stock
FROM Producto p
JOIN Libro l ON p.id_producto = l.id_producto
ORDER BY p.id_producto;

-- 3. Mostrar solo revistas
SELECT
    p.id_producto,
    p.titulo,
    r.issn,
    r.numero_edicion,
    r.fecha_publicacion,
    p.precio,
    p.stock
FROM Producto p
JOIN Revista r ON p.id_producto = r.id_producto
ORDER BY p.id_producto;

-- 4. INSERT DE PRUEBA
-- Ejecutar una sola vez para obtener evidencia del INSERT
INSERT INTO Producto (titulo, precio, stock, rating, id_editorial)
VALUES ('libro de prueba pc1', 49.90, 10, 4, 1);

SET @nuevo_producto = LAST_INSERT_ID();

INSERT INTO Libro (id_producto, isbn, edicion, anio_publicacion)
VALUES (@nuevo_producto, '9789999999999', '1ra edicion', 2026);

SELECT
    p.id_producto,
    p.titulo,
    l.isbn,
    l.edicion,
    l.anio_publicacion
FROM Producto p
JOIN Libro l ON p.id_producto = l.id_producto
WHERE p.id_producto = @nuevo_producto;

-- 5. UPDATE DE PRODUCTO
-- Antes
SELECT id_producto, titulo, precio, stock
FROM Producto
WHERE id_producto = 1;

-- Modificación
UPDATE Producto
SET precio = 89.90,
    stock = stock - 1
WHERE id_producto = 1;

-- Después
SELECT id_producto, titulo, precio, stock
FROM Producto
WHERE id_producto = 1;

-- 6. UPDATE DE PEDIDO
-- Antes
SELECT id_pedido, id_usuario, fecha_compra, estado
FROM Pedido
WHERE id_pedido = 2;

-- Modificación
UPDATE Pedido
SET estado = 'enviado'
WHERE id_pedido = 2;

-- Después
SELECT id_pedido, id_usuario, fecha_compra, estado
FROM Pedido
WHERE id_pedido = 2;

-- 7. DELETE DE DETALLE
-- Antes: debe existir una fila
SELECT *
FROM Detalle_Pedido
WHERE id_pedido = 2 AND id_producto = 3;

-- Eliminación
DELETE FROM Detalle_Pedido
WHERE id_pedido = 2 AND id_producto = 3;

-- Después: debe devolver 0 filas
SELECT *
FROM Detalle_Pedido
WHERE id_pedido = 2 AND id_producto = 3;

-- 8. Relación Producto - Autor - Editorial
SELECT
    p.titulo,
    a.nombre_autor,
    e.nombre_edit
FROM Producto p
JOIN Producto_Autor pa ON p.id_producto = pa.id_producto
JOIN Autor a ON pa.id_autor = a.id_autor
JOIN Editorial e ON p.id_editorial = e.id_editorial
ORDER BY p.id_producto;

-- 9. Relación Producto - Categoria
SELECT
    p.titulo,
    c.nombre_cat AS categoria
FROM Producto p
JOIN Producto_Categoria pc ON p.id_producto = pc.id_producto
JOIN Categoria c ON pc.id_categoria = c.id_categoria
ORDER BY p.id_producto, c.nombre_cat;

-- 10. Productos comprados por pedido
SELECT
    pe.id_pedido,
    u.nombre AS usuario,
    p.titulo,
    dp.cantidad,
    dp.precio_unit,
    (dp.cantidad * dp.precio_unit) AS subtotal,
    pe.estado
FROM Detalle_Pedido dp
JOIN Pedido pe ON dp.id_pedido = pe.id_pedido
JOIN Usuario u ON pe.id_usuario = u.id_usuario
JOIN Producto p ON dp.id_producto = p.id_producto
ORDER BY pe.id_pedido, p.titulo;
