-- consultas
-- mostrar el catalogo actual
SELECT id_producto, titulo, stock, precio FROM Producto;

-- actualizar precio y reducir stock de un libro vendido
UPDATE Producto 
SET precio = 89.90, stock = stock - 1 
WHERE id_producto = 1;

-- cambiar el estado de un pedido a enviado
UPDATE Pedido 
SET estado = 'enviado' 
WHERE id_pedido = 2;

-- eliminar un detalle de pedido respetando la llave foranea
DELETE FROM Detalle_Pedido 
WHERE id_pedido = 2 AND id_producto = 3;

-- verificar la 5fn cruzando tablas
SELECT p.titulo, a.nombre_autor, e.nombre_edit 
FROM Producto p
JOIN Producto_Autor pa ON p.id_producto = pa.id_producto
JOIN Autor a ON pa.id_autor = a.id_autor
JOIN Editorial e ON p.id_editorial = e.id_editorial;