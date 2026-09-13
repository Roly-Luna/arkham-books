DROP DATABASE IF EXISTS ArkhamBooks;
CREATE DATABASE ArkhamBooks;
USE ArkhamBooks;

CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE Editorial (
    id_editorial INT AUTO_INCREMENT PRIMARY KEY,
    nombre_edit VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Autor (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_autor VARCHAR(100) NOT NULL
);

CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cat VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    precio DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    stock INT NOT NULL DEFAULT 0,
    rating INT NULL,
    id_editorial INT NOT NULL,
    CONSTRAINT CK_Producto_precio CHECK (precio >= 0),
    CONSTRAINT CK_Producto_stock CHECK (stock >= 0),
    CONSTRAINT CK_Producto_rating CHECK (rating IS NULL OR rating BETWEEN 1 AND 5),
    CONSTRAINT FK_Editorial_Producto
        FOREIGN KEY (id_editorial)
        REFERENCES Editorial(id_editorial)
);

CREATE TABLE Libro (
    id_producto INT PRIMARY KEY,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    edicion VARCHAR(50) NULL,
    anio_publicacion INT NULL,
    CONSTRAINT FK_Producto_Libro
        FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto)
);

CREATE TABLE Revista (
    id_producto INT PRIMARY KEY,
    numero_edicion INT NOT NULL,
    issn VARCHAR(20) NOT NULL,
    fecha_publicacion DATE NULL,
    CONSTRAINT UQ_Revista_ISSN_Numero UNIQUE (issn, numero_edicion),
    CONSTRAINT FK_Producto_Revista
        FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto)
);

CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_compra DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) NOT NULL DEFAULT 'pendiente',
    CONSTRAINT CK_Pedido_estado
        CHECK (estado IN ('pendiente', 'enviado', 'completado', 'cancelado')),
    CONSTRAINT FK_Usuario_Pedido
        FOREIGN KEY (id_usuario)
        REFERENCES Usuario(id_usuario)
);

CREATE TABLE Detalle_Pedido (
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    precio_unit DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_producto),
    CONSTRAINT CK_Detalle_cantidad CHECK (cantidad > 0),
    CONSTRAINT CK_Detalle_precio CHECK (precio_unit >= 0),
    CONSTRAINT FK_Pedido_Detalle
        FOREIGN KEY (id_pedido)
        REFERENCES Pedido(id_pedido),
    CONSTRAINT FK_Producto_Detalle
        FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto)
);

CREATE TABLE Producto_Autor (
    id_producto INT NOT NULL,
    id_autor INT NOT NULL,
    PRIMARY KEY (id_producto, id_autor),
    CONSTRAINT FK_Producto_ProductoAutor
        FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto),
    CONSTRAINT FK_Autor_ProductoAutor
        FOREIGN KEY (id_autor)
        REFERENCES Autor(id_autor)
);

CREATE TABLE Producto_Categoria (
    id_producto INT NOT NULL,
    id_categoria INT NOT NULL,
    PRIMARY KEY (id_producto, id_categoria),
    CONSTRAINT FK_Producto_ProductoCategoria
        FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto),
    CONSTRAINT FK_Categoria_ProductoCategoria
        FOREIGN KEY (id_categoria)
        REFERENCES Categoria(id_categoria)
);
