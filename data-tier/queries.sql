-- Read-only verification queries for Arkham Books
-- Connect to the target database before running this file

SELECT current_database() AS database_name;

SELECT tablename
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY tablename;

SELECT 'usuario' AS tabla, COUNT(*) AS total FROM usuario
UNION ALL SELECT 'editorial', COUNT(*) FROM editorial
UNION ALL SELECT 'autor', COUNT(*) FROM autor
UNION ALL SELECT 'categoria', COUNT(*) FROM categoria
UNION ALL SELECT 'producto', COUNT(*) FROM producto
UNION ALL SELECT 'libro', COUNT(*) FROM libro
UNION ALL SELECT 'revista', COUNT(*) FROM revista
UNION ALL SELECT 'pedido', COUNT(*) FROM pedido
UNION ALL SELECT 'detalle_pedido', COUNT(*) FROM detalle_pedido
UNION ALL SELECT 'producto_autor', COUNT(*) FROM producto_autor
UNION ALL SELECT 'producto_categoria', COUNT(*) FROM producto_categoria
ORDER BY tabla;

SELECT
    p.id_producto,
    p.titulo,
    CASE
        WHEN l.id_producto IS NOT NULL THEN 'libro'
        WHEN r.id_producto IS NOT NULL THEN 'revista'
        ELSE 'producto'
    END AS tipo_producto,
    p.precio,
    p.stock,
    p.rating,
    e.nombre_edit AS editorial
FROM producto p
JOIN editorial e ON e.id_editorial = p.id_editorial
LEFT JOIN libro l ON l.id_producto = p.id_producto
LEFT JOIN revista r ON r.id_producto = p.id_producto
ORDER BY p.id_producto;

SELECT
    id_usuario,
    nombre,
    biografia,
    avatar_url,
    fecha_registro,
    perfil_publico
FROM usuario
ORDER BY id_usuario
LIMIT 30;

SELECT
    pe.id_pedido,
    u.nombre AS usuario,
    p.titulo,
    dp.cantidad,
    dp.precio_unit,
    dp.cantidad * dp.precio_unit AS subtotal,
    pe.estado
FROM pedido pe
JOIN usuario u ON u.id_usuario = pe.id_usuario
JOIN detalle_pedido dp ON dp.id_pedido = pe.id_pedido
JOIN producto p ON p.id_producto = dp.id_producto
ORDER BY pe.id_pedido, p.titulo;
