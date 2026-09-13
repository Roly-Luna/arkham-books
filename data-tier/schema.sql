-- ESQUEMA RELACIONAL

\connect postgres

-- Cerrar conexiones activas antes de recrear la base
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'ArkhamBooks'
  AND pid <> pg_backend_pid();

DROP DATABASE IF EXISTS "ArkhamBooks";
CREATE DATABASE "ArkhamBooks";

\connect "ArkhamBooks"


-- TABLAS PRINCIPALES
CREATE TABLE Usuario (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE Editorial (
    id_editorial SERIAL PRIMARY KEY,
    nombre_edit VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Autor (
    id_autor SERIAL PRIMARY KEY,
    nombre_autor VARCHAR(100) NOT NULL
);

CREATE TABLE Categoria (
    id_categoria SERIAL PRIMARY KEY,
    nombre_cat VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Producto (
    id_producto SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    precio DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    stock INT NOT NULL DEFAULT 0,
    rating INT NULL,
    id_editorial INT NOT NULL,

    CONSTRAINT ck_producto_precio CHECK (precio >= 0),
    CONSTRAINT ck_producto_stock CHECK (stock >= 0),
    CONSTRAINT ck_producto_rating CHECK (rating IS NULL OR rating BETWEEN 1 AND 5),

    CONSTRAINT fk_editorial_producto
        FOREIGN KEY (id_editorial)
        REFERENCES Editorial(id_editorial)
);

-- SUBTIPOS DE PRODUCTO

CREATE TABLE Libro (
    id_producto INT PRIMARY KEY,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    edicion VARCHAR(50) NULL,
    anio_publicacion INT NULL,

    CONSTRAINT fk_producto_libro
        FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto)
        ON DELETE CASCADE
);

CREATE TABLE Revista (
    id_producto INT PRIMARY KEY,
    numero_edicion INT NOT NULL,
    issn VARCHAR(20) NOT NULL,
    fecha_publicacion DATE NULL,

    CONSTRAINT uq_revista_issn_numero
        UNIQUE (issn, numero_edicion),

    CONSTRAINT fk_producto_revista
        FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto)
        ON DELETE CASCADE
);

-- PEDIDOS

CREATE TABLE Pedido (
    id_pedido SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_compra TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) NOT NULL DEFAULT 'pendiente',

    CONSTRAINT ck_pedido_estado
        CHECK (estado IN ('pendiente', 'enviado', 'completado', 'cancelado')),

    CONSTRAINT fk_usuario_pedido
        FOREIGN KEY (id_usuario)
        REFERENCES Usuario(id_usuario)
);

CREATE TABLE Detalle_Pedido (
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    precio_unit DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (id_pedido, id_producto),

    CONSTRAINT ck_detalle_cantidad CHECK (cantidad > 0),
    CONSTRAINT ck_detalle_precio CHECK (precio_unit >= 0),

    CONSTRAINT fk_pedido_detalle
        FOREIGN KEY (id_pedido)
        REFERENCES Pedido(id_pedido)
        ON DELETE CASCADE,

    CONSTRAINT fk_producto_detalle
        FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto)
);

-- TABLAS PUENTE

CREATE TABLE Producto_Autor (
    id_producto INT NOT NULL,
    id_autor INT NOT NULL,

    PRIMARY KEY (id_producto, id_autor),

    CONSTRAINT fk_producto_productoautor
        FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto)
        ON DELETE CASCADE,

    CONSTRAINT fk_autor_productoautor
        FOREIGN KEY (id_autor)
        REFERENCES Autor(id_autor)
);

CREATE TABLE Producto_Categoria (
    id_producto INT NOT NULL,
    id_categoria INT NOT NULL,

    PRIMARY KEY (id_producto, id_categoria),

    CONSTRAINT fk_producto_productocategoria
        FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto)
        ON DELETE CASCADE,

    CONSTRAINT fk_categoria_productocategoria
        FOREIGN KEY (id_categoria)
        REFERENCES Categoria(id_categoria)
);

-- Verificación rápida
SELECT tablename
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY tablename;
