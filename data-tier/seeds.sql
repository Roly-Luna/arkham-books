-- ARKHAM BOOKS - DATOS DE PRUEBA
USE ArkhamBooks;

-- Editoriales
INSERT INTO Editorial (nombre_edit) VALUES
('penguin random house'),
('editorial norma'),
('minotauro'),
('anagrama'),
('salamandra'),
('planeta'),
('alianza editorial'),
('debolsillo'),
('acantilado'),
('ediciones sm'),
('alfaguara'),
('siruela'),
('tusquets'),
('lumen'),
('seix barral'),
('national geographic partners'),
('time usa'),
('conde nast'),
('hearst magazines'),
('scientific american');

-- Autores
INSERT INTO Autor (nombre_autor) VALUES
('frank herbert'),
('stephen king'),
('isaac asimov'),
('jrr tolkien'),
('jk rowling'),
('george rr martin'),
('agatha christie'),
('gabriel garcia marquez'),
('hp lovecraft'),
('arthur conan doyle'),
('edgar allan poe'),
('julio verne'),
('hg wells'),
('ray bradbury'),
('philip k dick'),
('neil gaiman'),
('terry pratchett'),
('brandon sanderson'),
('ursula k le guin'),
('mario vargas llosa');

-- Categorías
INSERT INTO Categoria (nombre_cat) VALUES
('ciencia ficcion'),
('terror'),
('suspenso'),
('fantasia'),
('misterio'),
('romance'),
('historia'),
('biografia'),
('aventura'),
('poesia'),
('drama'),
('ensayo'),
('comic'),
('manga'),
('infantil'),
('ciencia'),
('tecnologia'),
('actualidad');

-- Usuarios
INSERT INTO Usuario (nombre, email, password) VALUES
('ryan zavaleta', 'ryan@arkhambooks.com', 'hash1'),
('roly luna', 'roly@arkhambooks.com', 'hash2'),
('brenda ochoa', 'brenda@arkhambooks.com', 'hash3'),
('juan perez', 'juan@correo.com', 'hash4'),
('maria gomez', 'maria@correo.com', 'hash5'),
('carlos ruiz', 'carlos@correo.com', 'hash6'),
('ana silva', 'ana@correo.com', 'hash7'),
('luis torres', 'luis@correo.com', 'hash8'),
('carmen vega', 'carmen@correo.com', 'hash9'),
('jorge castro', 'jorge@correo.com', 'hash10'),
('diana rojas', 'diana@correo.com', 'hash11'),
('miguel paz', 'miguel@correo.com', 'hash12'),
('lucia vargas', 'lucia@correo.com', 'hash13'),
('hugo mendoza', 'hugo@correo.com', 'hash14'),
('rosa flor', 'rosa@correo.com', 'hash15'),
('pedro lecca', 'pedro@correo.com', 'hash16'),
('sofia rios', 'sofia@correo.com', 'hash17'),
('diego luna', 'diego@correo.com', 'hash18'),
('valeria soto', 'valeria@correo.com', 'hash19'),
('andres cruz', 'andres@correo.com', 'hash20'),
('camila tapia', 'camila@correo.com', 'hash21'),
('fernando gil', 'fernando@correo.com', 'hash22'),
('paola reyes', 'paola@correo.com', 'hash23'),
('martin pena', 'martin@correo.com', 'hash24'),
('daniela mora', 'daniela@correo.com', 'hash25'),
('oscar ruiz', 'oscar@correo.com', 'hash26'),
('elena rios', 'elena@correo.com', 'hash27'),
('renzo vera', 'renzo@correo.com', 'hash28'),
('silvia pino', 'silvia@correo.com', 'hash29'),
('victor soto', 'victor@correo.com', 'hash30');

-- =========================================================
-- PRODUCTOS: LIBROS
-- IDs esperados: 1 al 30
-- =========================================================

INSERT INTO Producto (titulo, precio, stock, rating, id_editorial) VALUES
('dune', 85.50, 50, 5, 3),
('el resplandor', 65.00, 30, 4, 1),
('fundacion', 75.00, 40, 5, 2),
('el senor de los anillos', 120.00, 20, 5, 3),
('harry potter 1', 55.00, 100, 4, 5),
('juego de tronos', 95.00, 60, 5, 6),
('asesinato en el orient express', 45.00, 25, 4, 6),
('cien anos de soledad', 70.00, 80, 5, 1),
('la llamada de cthulhu', 40.00, 15, 4, 7),
('estudio en escarlata', 35.00, 50, 4, 8),
('el cuervo', 25.00, 10, 4, 9),
('viaje al centro de la tierra', 45.00, 35, 4, 10),
('la maquina del tiempo', 50.00, 40, 4, 11),
('fahrenheit 451', 60.00, 55, 5, 12),
('suenan los androides con ovejas electricas', 65.00, 25, 5, 13),
('american gods', 80.00, 30, 4, 14),
('el color de la magia', 55.00, 45, 4, 15),
('el imperio final', 90.00, 60, 5, 3),
('los desposeidos', 70.00, 20, 5, 4),
('la ciudad y los perros', 65.00, 40, 5, 11),
('el mesias de dune', 85.00, 30, 4, 3),
('it', 95.00, 50, 5, 1),
('el hobbit', 75.00, 80, 5, 3),
('choque de reyes', 95.00, 45, 5, 6),
('diez negritos', 45.00, 60, 4, 6),
('el amor en los tiempos del colera', 75.00, 50, 5, 1),
('las montanas de la locura', 50.00, 20, 4, 7),
('el sabueso de los baskerville', 40.00, 30, 4, 8),
('veinte mil leguas de viaje submarino', 45.00, 40, 4, 10),
('cronicas marcianas', 65.00, 35, 5, 12);

INSERT INTO Libro (id_producto, isbn, edicion, anio_publicacion) VALUES
(1,  '9780000000001', '1ra edicion', 1965),
(2,  '9780000000002', '1ra edicion', 1977),
(3,  '9780000000003', '1ra edicion', 1951),
(4,  '9780000000004', 'edicion unica', 1954),
(5,  '9780000000005', '1ra edicion', 1997),
(6,  '9780000000006', '1ra edicion', 1996),
(7,  '9780000000007', '1ra edicion', 1934),
(8,  '9780000000008', '1ra edicion', 1967),
(9,  '9780000000009', 'edicion recopilatoria', 1928),
(10, '9780000000010', '1ra edicion', 1887),
(11, '9780000000011', 'edicion recopilatoria', 1845),
(12, '9780000000012', '1ra edicion', 1864),
(13, '9780000000013', '1ra edicion', 1895),
(14, '9780000000014', '1ra edicion', 1953),
(15, '9780000000015', '1ra edicion', 1968),
(16, '9780000000016', '1ra edicion', 2001),
(17, '9780000000017', '1ra edicion', 1983),
(18, '9780000000018', '1ra edicion', 2006),
(19, '9780000000019', '1ra edicion', 1974),
(20, '9780000000020', '1ra edicion', 1963),
(21, '9780000000021', '1ra edicion', 1969),
(22, '9780000000022', '1ra edicion', 1986),
(23, '9780000000023', '1ra edicion', 1937),
(24, '9780000000024', '1ra edicion', 1998),
(25, '9780000000025', '1ra edicion', 1939),
(26, '9780000000026', '1ra edicion', 1985),
(27, '9780000000027', '1ra edicion', 1936),
(28, '9780000000028', '1ra edicion', 1902),
(29, '9780000000029', '1ra edicion', 1870),
(30, '9780000000030', '1ra edicion', 1950);

-- =========================================================
-- PRODUCTOS: REVISTAS
-- IDs esperados: 31 al 35
-- =========================================================

INSERT INTO Producto (titulo, precio, stock, rating, id_editorial) VALUES
('national geographic - septiembre 2026', 29.90, 40, 5, 16),
('time - tecnologia 2026', 25.00, 35, 4, 17),
('wired - inteligencia artificial 2026', 28.50, 30, 5, 18),
('popular mechanics - innovacion 2026', 24.90, 25, 4, 19),
('scientific american - espacio 2026', 32.00, 20, 5, 20);

INSERT INTO Revista (id_producto, numero_edicion, issn, fecha_publicacion) VALUES
(31, 9,  '0027-9358', '2026-09-01'),
(32, 37, '0040-781X', '2026-09-01'),
(33, 9,  '1059-1028', '2026-09-01'),
(34, 9,  '0032-4558', '2026-09-01'),
(35, 9,  '0036-8733', '2026-09-01');

-- Relaciones Producto - Autor
INSERT INTO Producto_Autor (id_producto, id_autor) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8),
(9, 9), (10, 10), (11, 11), (12, 12), (13, 13), (14, 14), (15, 15),
(16, 16), (17, 17), (18, 18), (19, 19), (20, 20), (21, 1), (22, 2),
(23, 4), (24, 6), (25, 7), (26, 8), (27, 9), (28, 10), (29, 12), (30, 14);

-- Relaciones Producto - Categoria
INSERT INTO Producto_Categoria (id_producto, id_categoria) VALUES
(1, 1), (2, 2), (2, 3), (3, 1), (4, 4), (4, 9), (5, 4), (6, 4),
(7, 5), (8, 6), (9, 2), (10, 5), (11, 2), (12, 9), (13, 1), (14, 1),
(15, 1), (16, 4), (17, 4), (18, 4), (19, 1), (20, 11), (21, 1), (22, 2),
(23, 4), (24, 4), (25, 5), (26, 6), (27, 2), (28, 5), (29, 9), (30, 1),
(31, 16), (32, 18), (33, 17), (34, 17), (35, 16);

-- Pedidos
INSERT INTO Pedido (id_usuario, estado) VALUES
(1, 'completado'), (2, 'pendiente'), (3, 'enviado'), (4, 'completado'),
(5, 'cancelado'), (6, 'pendiente'), (7, 'completado'), (8, 'enviado'),
(9, 'pendiente'), (10, 'completado'), (11, 'enviado'), (12, 'completado'),
(13, 'pendiente'), (14, 'cancelado'), (15, 'completado'), (16, 'enviado'),
(17, 'pendiente'), (18, 'completado'), (19, 'pendiente'), (20, 'completado'),
(1, 'pendiente'), (2, 'completado'), (3, 'pendiente'), (4, 'enviado'),
(5, 'completado'), (6, 'completado'), (7, 'pendiente'), (8, 'cancelado'),
(9, 'completado'), (10, 'enviado');

-- Detalles de pedido
INSERT INTO Detalle_Pedido (id_pedido, id_producto, cantidad, precio_unit) VALUES
(1, 1, 2, 85.50), (1, 31, 1, 29.90),
(2, 2, 1, 65.00), (2, 3, 1, 75.00),
(3, 4, 1, 120.00), (3, 32, 1, 25.00),
(4, 5, 3, 55.00), (5, 6, 1, 95.00),
(6, 7, 2, 45.00), (7, 8, 1, 70.00),
(8, 9, 1, 40.00), (9, 10, 2, 35.00),
(10, 11, 1, 25.00), (10, 12, 1, 45.00),
(11, 13, 1, 50.00), (12, 14, 2, 60.00),
(13, 15, 1, 65.00), (14, 16, 1, 80.00),
(15, 17, 3, 55.00), (16, 18, 1, 90.00),
(17, 19, 1, 70.00), (18, 20, 2, 65.00),
(19, 21, 1, 85.00), (20, 22, 1, 95.00),
(21, 23, 2, 75.00), (22, 24, 1, 95.00),
(23, 25, 1, 45.00), (24, 26, 1, 75.00),
(25, 27, 2, 50.00), (26, 28, 1, 40.00),
(27, 29, 1, 45.00), (28, 30, 2, 65.00),
(29, 33, 1, 28.50), (30, 35, 1, 32.00);
