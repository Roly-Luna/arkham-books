--Crear base de datos
CREATE DATABASE IF NOT EXISTS ArkhamBooks;
USE ArkhamBooks;

-- TABLAS PADRE (Sin dependencias)
-- Tabla de clientes
CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Tabla de editoriales
CREATE TABLE Editorial (
    id_editorial INT AUTO_INCREMENT PRIMARY KEY,
    nombre_edit VARCHAR(100) NOT NULL UNIQUE
);

-- Tabla de autores
CREATE TABLE Autor (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_autor VARCHAR(100) NOT NULL
);

-- Tabla de categorias literarias
CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cat VARCHAR(50) NOT NULL UNIQUE
);

-- TABLAS HIJAS (Dependen de las tablas padre)
-- Catalogo principal
CREATE TABLE Producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    precio DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    stock INT NOT NULL DEFAULT 0,
    rating INT NULL DEFAULT 5,
    id_editorial INT NOT NULL,
    FOREIGN KEY (id_editorial) REFERENCES Editorial(id_editorial)
);

-- Registro de compras
CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_compra DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- TABLAS PUENTE PARA 5FN (Rompen relaciones muchos a muchos)
-- Detalle de cada pedido
CREATE TABLE Detalle_Pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    precio_unit DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Relacion producto y autor
CREATE TABLE Producto_Autor (
    id_producto INT NOT NULL,
    id_autor INT NOT NULL,
    PRIMARY KEY (id_producto, id_autor),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_autor) REFERENCES Autor(id_autor)
);

-- Relacion producto y categoria
CREATE TABLE Producto_Categoria (
    id_producto INT NOT NULL,
    id_categoria INT NOT NULL,
    PRIMARY KEY (id_producto, id_categoria),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);