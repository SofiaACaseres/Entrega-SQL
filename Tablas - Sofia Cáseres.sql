-- Sofia Cáseres. Comisión: 45230

DROP SCHEMA IF EXISTS Libreria_Panteon; /*Drop = Eliminar */ 

CREATE schema IF NOT EXISTS Libreria_Panteon; 

USE Libreria_Panteon; /* USE: Voy a usar esta base de datos. Todo lo que crea a partir de ahora, va integrado a esa BD */

/* Creación de tablas*/
DROP TABLE IF EXISTS Editorial; 
CREATE TABLE IF NOT EXISTS Editorial (
id_editorial INT NOT NULL auto_increment,
Nombre varchar (30) NOT NULL,
direccion varchar (50) NOT NULL,
PRIMARY KEY (id_editorial)
); 

DROP TABLE IF EXISTS Proveedor;
Create table if not exists Proveedor (
id_proveedor INT NOT NULL auto_increment,
id_editorial INT NOT NULL, /*se puede cambiar con FK_id_editorial */
nombre varchar(15) NOT NULL,
apellido varchar (15) NOT NULL,
celular int NOT NULL,
correo varchar (60) NOT NULL, 
cbu int not null,
alias varchar (30) not null,
PRIMARY KEY (id_proveedor),
CONSTRAINT `Editorial` FOREIGN KEY (id_editorial) REFERENCES editorial (id_editorial) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Banco;
CREATE TABLE IF NOT EXISTS Banco(
id_banco INT NOT NULL auto_increment,
Nombre varchar (30) NOT NULL,
dirección varchar (40) NOT NULL,
primary key (id_banco)
);

DROP TABLE IF EXISTS formadepago;
create table if not exists formadepago (
id_pago int not null auto_increment,
tipo_de_pago enum ('CONTADO','CUOTAS'),
cantidad_Cuotas int,
primary key (id_pago)
);

DROP TABLE IF EXISTS Facturacion;
create table if not exists Facturacion (
id_facturacion INT NOT NULL auto_increment,
tipo enum ('COMPRA','VENTA'),
id_banco INT NOT NULL,
id_pago int not null,
total INT NOT NULL,
fecha datetime,
primary key (id_facturacion),
CONSTRAINT `Banco` FOREIGN KEY (id_banco) REFERENCES banco (id_banco) ON DELETE CASCADE,
CONSTRAINT `formadepago` FOREIGN KEY (id_pago) REFERENCES formadepago (id_pago) ON DELETE CASCADE
);

DROP TABLE IF EXISTS productos;
create table if not exists productos (
id_producto INT NOT NULL auto_increment,
nombre_libro varchar (30) NOT NULL,
genero varchar (30) NOT NULL,
autor varchar (50),
precio INT NOT NULL,
primary key (id_producto)
);

DROP TABLE IF EXISTS compras;
create table if not exists compras (
id_compra INT NOT NULL auto_increment,
id_producto INT NOT NULL,
id_facturacion INT NOT NULL,
id_proveedor INT NOT NULL,
PRIMARY key (id_compra),
CONSTRAINT `productos_C` FOREIGN KEY (id_producto) REFERENCES productos (id_producto) ON DELETE CASCADE,
CONSTRAINT `facturacion_compra` FOREIGN KEY (id_facturacion) REFERENCES facturacion (id_facturacion) ON DELETE CASCADE,
CONSTRAINT `proveedor` FOREIGN KEY (id_proveedor) REFERENCES proveedor (id_proveedor) ON DELETE CASCADE
);

DROP TABLE IF EXISTS direccion;
create table if not exists direccion(
id_direccion int not null auto_increment,
calle varchar (30) not null,
numero int not null,
localidad varchar (30) not null,
provincia varchar(20) not null,
primary key (id_direccion)
);

DROP TABLE IF EXISTS cliente;
create table if not exists cliente (
id_cliente INT NOT NULL auto_increment,
nombre varchar (15) not null,
apellido varchar (20) not null,
DNI INT not null,
fechadenacimiento date,
sexo enum ('femenino', 'masculino'),
id_direccion int not null,
primary key (id_cliente),
CONSTRAINT `direccion` FOREIGN KEY (id_direccion) REFERENCES direccion (id_direccion) ON DELETE CASCADE
);

DROP TABLE IF EXISTS ventas;
create table if not exists ventas (
id_venta int not null auto_increment primary key,
id_cliente INT NOT NULL,
id_producto INT NOT NULL,
id_facturacion INT NOT NULL,
CONSTRAINT `cliente` FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente) ON DELETE CASCADE,
CONSTRAINT `productos_V` FOREIGN KEY (id_producto) REFERENCES productos (id_producto) ON DELETE CASCADE,
CONSTRAINT `facturacion_venta` FOREIGN KEY (id_facturacion) REFERENCES facturacion (id_facturacion) ON DELETE CASCADE
);

DROP TABLE IF EXISTS stock;
create table if not exists stock (
id_stock int not null auto_increment,
cantidad int not null,
id_productos int not null,
id_compra int,
id_venta int,
primary key (id_stock),
CONSTRAINT `producto_stock` FOREIGN KEY (id_productos) REFERENCES productos (id_producto) ON DELETE CASCADE,
CONSTRAINT `producto_venta` FOREIGN KEY (id_venta) REFERENCES ventas (id_venta) ON DELETE CASCADE,
CONSTRAINT `producto_compra` FOREIGN KEY (id_compra) REFERENCES compras (id_compra) ON DELETE CASCADE
);



