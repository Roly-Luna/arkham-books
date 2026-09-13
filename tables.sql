
CREATE TABLE Autor
(
  id_autor     INT          NOT NULL,
  nombre_autor VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_autor)
);

ALTER TABLE Autor
  ADD CONSTRAINT UQ_Autor_id_autor UNIQUE (id_autor);

CREATE TABLE Categoria
(
  id_categoria INT         NOT NULL,
  nombre_cat   VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_categoria)
);

ALTER TABLE Categoria
  ADD CONSTRAINT UQ_Categoria_id_categoria UNIQUE (id_categoria);

ALTER TABLE Categoria
  ADD CONSTRAINT UQ_Categoria_nombre_cat UNIQUE (nombre_cat);

CREATE TABLE Detalle_Pedido
(
  id_pedido   INT           NOT NULL,
  id_producto INT           NOT NULL,
  cantidad    INT           NOT NULL,
  precio_unit DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_pedido, id_producto)
) COMMENT 'Items_comprados_por_pedido';

CREATE TABLE Editorial
(
  id_editorial INT          NOT NULL,
  nombre_edit  VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_editorial)
);

ALTER TABLE Editorial
  ADD CONSTRAINT UQ_Editorial_id_editorial UNIQUE (id_editorial);

ALTER TABLE Editorial
  ADD CONSTRAINT UQ_Editorial_nombre_edit UNIQUE (nombre_edit);

CREATE TABLE Libro
(
  id_producto      INT         NOT NULL,
  isbn             VARCHAR(20) NOT NULL,
  edicion          VARCHAR(50) NULL    ,
  anio_publicacion INT         NULL    ,
  PRIMARY KEY (id_producto)
);

ALTER TABLE Libro
  ADD CONSTRAINT UQ_Libro_isbn UNIQUE (isbn);

CREATE TABLE Pedido
(
  id_pedido    INT         NOT NULL,
  id_usuario   INT         NOT NULL,
  fecha_compra DATETIME    NOT NULL,
  estado       VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_pedido)
);

ALTER TABLE Pedido
  ADD CONSTRAINT UQ_Pedido_id_pedido UNIQUE (id_pedido);

CREATE TABLE Producto
(
  id_producto  INT           NOT NULL,
  titulo       VARCHAR(200)  NOT NULL,
  precio       DECIMAL(10,2) NOT NULL,
  stock        INT           NOT NULL,
  rating       INT           NULL    ,
  id_editorial INT           NOT NULL,
  id_producto  INT           NOT NULL,
  id_producto                NOT NULL,
  PRIMARY KEY (id_producto)
);

ALTER TABLE Producto
  ADD CONSTRAINT UQ_Producto_id_producto UNIQUE (id_producto);

CREATE TABLE Producto_Autor
(
  id_producto INT NOT NULL,
  id_autor    INT NOT NULL,
  PRIMARY KEY (id_producto, id_autor)
) COMMENT 'Tabla_puente_Muchos_a_Muchos';

CREATE TABLE Producto_Categoria
(
  id_producto  INT NOT NULL,
  id_categoria INT NOT NULL,
  PRIMARY KEY (id_producto, id_categoria)
) COMMENT 'Tabla_puente_Muchos_a_Muchos';

CREATE TABLE Revista
(
  id_producto       INT         NOT NULL,
  numero_edicion    INT         NOT NULL,
  issn              VARCHAR(20) NOT NULL,
  fecha_publicacion DATE        NULL    ,
  PRIMARY KEY (id_producto)
);

ALTER TABLE Revista
  ADD CONSTRAINT UQ_Revista_numero_edicion UNIQUE (numero_edicion);

ALTER TABLE Revista
  ADD CONSTRAINT UQ_Revista_issn UNIQUE (issn);

CREATE TABLE Usuario
(
  id_usuario INT          NOT NULL,
  nombre     VARCHAR(100) NOT NULL,
  email      VARCHAR(100) NOT NULL,
  password   VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_usuario)
);

ALTER TABLE Usuario
  ADD CONSTRAINT UQ_Usuario_id_usuario UNIQUE (id_usuario);

ALTER TABLE Usuario
  ADD CONSTRAINT UQ_Usuario_email UNIQUE (email);

ALTER TABLE Producto
  ADD CONSTRAINT FK_Editorial_TO_Producto
    FOREIGN KEY (id_editorial)
    REFERENCES Editorial (id_editorial);

ALTER TABLE Pedido
  ADD CONSTRAINT FK_Usuario_TO_Pedido
    FOREIGN KEY (id_usuario)
    REFERENCES Usuario (id_usuario);

ALTER TABLE Detalle_Pedido
  ADD CONSTRAINT FK_Pedido_TO_Detalle_Pedido
    FOREIGN KEY (id_pedido)
    REFERENCES Pedido (id_pedido);

ALTER TABLE Detalle_Pedido
  ADD CONSTRAINT FK_Producto_TO_Detalle_Pedido
    FOREIGN KEY (id_producto)
    REFERENCES Producto (id_producto);

ALTER TABLE Producto_Autor
  ADD CONSTRAINT FK_Producto_TO_Producto_Autor
    FOREIGN KEY (id_producto)
    REFERENCES Producto (id_producto);

ALTER TABLE Producto_Autor
  ADD CONSTRAINT FK_Autor_TO_Producto_Autor
    FOREIGN KEY (id_autor)
    REFERENCES Autor (id_autor);

ALTER TABLE Producto_Categoria
  ADD CONSTRAINT FK_Producto_TO_Producto_Categoria
    FOREIGN KEY (id_producto)
    REFERENCES Producto (id_producto);

ALTER TABLE Producto_Categoria
  ADD CONSTRAINT FK_Categoria_TO_Producto_Categoria
    FOREIGN KEY (id_categoria)
    REFERENCES Categoria (id_categoria);

ALTER TABLE Libro
  ADD CONSTRAINT FK_Producto_TO_Libro
    FOREIGN KEY (id_producto)
    REFERENCES Producto (id_producto);

ALTER TABLE Revista
  ADD CONSTRAINT FK_Producto_TO_Revista
    FOREIGN KEY (id_producto)
    REFERENCES Producto (id_producto);
