-- PostgreSQL schema for a fresh Arkham Books database
-- Connect to the target database before running this file
-- This file never drops a database or deletes existing records

CREATE TABLE IF NOT EXISTS usuario (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    biografia TEXT,
    avatar_url TEXT,
    fecha_registro TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    perfil_publico BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS editorial (
    id_editorial SERIAL PRIMARY KEY,
    nombre_edit VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS autor (
    id_autor SERIAL PRIMARY KEY,
    nombre_autor VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS categoria (
    id_categoria SERIAL PRIMARY KEY,
    nombre_cat VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS producto (
    id_producto SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    precio DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    stock INT NOT NULL DEFAULT 0,
    rating INT,
    id_editorial INT NOT NULL,
    CONSTRAINT ck_producto_precio CHECK (precio >= 0),
    CONSTRAINT ck_producto_stock CHECK (stock >= 0),
    CONSTRAINT ck_producto_rating CHECK (rating IS NULL OR rating BETWEEN 1 AND 5),
    CONSTRAINT fk_editorial_producto FOREIGN KEY (id_editorial) REFERENCES editorial(id_editorial)
);

CREATE TABLE IF NOT EXISTS libro (
    id_producto INT PRIMARY KEY,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    edicion VARCHAR(50),
    anio_publicacion INT,
    CONSTRAINT fk_producto_libro FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS revista (
    id_producto INT PRIMARY KEY,
    numero_edicion INT NOT NULL,
    issn VARCHAR(20) NOT NULL,
    fecha_publicacion DATE,
    CONSTRAINT uq_revista_issn_numero UNIQUE (issn, numero_edicion),
    CONSTRAINT fk_producto_revista FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS pedido (
    id_pedido SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_compra TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) NOT NULL DEFAULT 'pendiente',
    CONSTRAINT ck_pedido_estado CHECK (estado IN ('pendiente', 'enviado', 'completado', 'cancelado')),
    CONSTRAINT fk_usuario_pedido FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE IF NOT EXISTS detalle_pedido (
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    precio_unit DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_producto),
    CONSTRAINT ck_detalle_cantidad CHECK (cantidad > 0),
    CONSTRAINT ck_detalle_precio CHECK (precio_unit >= 0),
    CONSTRAINT fk_pedido_detalle FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido) ON DELETE CASCADE,
    CONSTRAINT fk_producto_detalle FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE IF NOT EXISTS producto_autor (
    id_producto INT NOT NULL,
    id_autor INT NOT NULL,
    PRIMARY KEY (id_producto, id_autor),
    CONSTRAINT fk_producto_productoautor FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE,
    CONSTRAINT fk_autor_productoautor FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
);

CREATE TABLE IF NOT EXISTS producto_categoria (
    id_producto INT NOT NULL,
    id_categoria INT NOT NULL,
    PRIMARY KEY (id_producto, id_categoria),
    CONSTRAINT fk_producto_productocategoria FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE,
    CONSTRAINT fk_categoria_productocategoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE INDEX IF NOT EXISTS idx_producto_titulo ON producto(titulo);
CREATE INDEX IF NOT EXISTS idx_pedido_usuario_fecha ON pedido(id_usuario, fecha_compra DESC);
CREATE INDEX IF NOT EXISTS idx_detalle_producto ON detalle_pedido(id_producto);

SELECT tablename
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY tablename;
