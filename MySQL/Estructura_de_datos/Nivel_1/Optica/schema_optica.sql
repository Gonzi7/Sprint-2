DROP DATABASE IF EXISTS optica;
CREATE DATABASE optica CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE optica;

CREATE TABLE proveedores(
	id_proveedor INT UNSIGNED NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(150) NOT NULL,
	direccion VARCHAR(150) NOT NULL,
	ciudad VARCHAR(100) NOT NULL,
	codigo_postal VARCHAR(20) NOT NULL,
	pais VARCHAR(100) NOT NULL,
	telefono VARCHAR(20),
	fax VARCHAR(20),
	nif VARCHAR(20) NOT NULL,
	PRIMARY KEY(id_proveedor)
);

CREATE TABLE gafas(
	id_gafas INT UNSIGNED NOT NULL AUTO_INCREMENT,
	id_proveedor INT UNSIGNED NOT NULL,
	marca VARCHAR(100) NOT NULL,
	graduacion_izquierda FLOAT,
	graduacion_derecha FLOAT,
	tipo_de_montura ENUM('flotante','pasta','metal','titanio','madera') NOT NULL,
	color_montura VARCHAR(20) NULL,
	color_vidrio_izquierdo VARCHAR(20),
	color_vidrio_derecho VARCHAR(20),
	precio DOUBLE NOT NULL,
	PRIMARY KEY(id_gafas),
	FOREIGN KEY(id_proveedor) REFERENCES proveedores(id_proveedor)
);

CREATE TABLE clientes(
	id_clientes INT UNSIGNED NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(150) NOT NULL,
	direccion VARCHAR(150) NOT NULL,
	telefono VARCHAR(20),
	email VARCHAR(50),
	fecha_registro DATE NOT NULL,
	id_cliente_referencia INT UNSIGNED NOT NULL,
	PRIMARY KEY(id_clientes),
	FOREIGN KEY(id_cliente_referencia) REFERENCES clientes(id_clientes)
);

ALTER TABLE clientes MODIFY id_cliente_referencia INT UNSIGNED NULL;

CREATE TABLE empleados(
	id_empleados INT UNSIGNED NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(150) NOT NULL,
	PRIMARY KEY(id_empleados)
);

ALTER TABLE empleados MODIFY nombre VARCHAR(20) NOT NULL;
ALTER TABLE empleados ADD apellido VARCHAR(50) NOT NULL;



CREATE TABLE ventas(
	id_venta INT UNSIGNED NOT NULL AUTO_INCREMENT,
	id_clientes INT UNSIGNED NOT NULL,
	id_empleados INT UNSIGNED NOT NULL,
	id_gafas INT UNSIGNED NOT NULL,
	fecha_venta DATE NOT NULL,
	PRIMARY KEY(id_venta),
	FOREIGN KEY(id_clientes) REFERENCES clientes(id_clientes),
	FOREIGN KEY(id_empleados) REFERENCES empleados(id_empleados),
	FOREIGN KEY(id_gafas) REFERENCES gafas(id_gafas)
);

-- Insertar datos a las tablas --
/* Proveedores */
INSERT INTO proveedores(nombre, direccion, ciudad, codigo_postal, pais, telefono, fax, nif) VALUES
('OptiProvee', 'Calle Vista, 123', 'Barcelona', '08015', 'España', '930123456', '930654321', 'B12345678'),
('VistaLens', 'Avenida Mirada, 45', 'Madrid', '28080', 'España', '910987654', '910654987', 'B87654321'),
('LentesPlus', 'Calle Óptica, 55', 'Valencia', '46001', 'España', '960123456', '960654321', 'B23456789'),
('GafasWorld', 'Plaza Visión, 22', 'Sevilla', '41001', 'España', '950123456', '950654321', 'B34567890'),
('VisionDirect', 'Calle Claridad, 80', 'Zaragoza', '50001', 'España', '976123456', '976654321', 'B45678901'),
('OpticasVision', 'Avenida Luminosa, 9', 'Málaga', '29001', 'España', '951234567', '951654321', 'B56789012'),
('EyeMarket', 'Paseo Mirador, 33', 'Bilbao', '48001', 'España', '944123456', '944654321', 'B67890123'),
('OptiGafas', 'Carrera del Darro, 19', 'Granada', '18001', 'España', '958123456', '958654321', 'B78901234'),
('LentesRapid', 'Camino de Ronda, 47', 'A Coruña', '15001', 'España', '981123456', '981654321', 'B89012345'),
('SuperLentes', 'Calle Mayor, 15', 'Las Palmas', '35001', 'España', '928123456', '928654321', 'B90123456');


/* Gafas */
INSERT INTO gafas(id_proveedor, marca,graduacion_izquierda,graduacion_derecha,tipo_de_montura,color_montura,color_vidrio_izquierdo,color_vidrio_derecho,precio) VALUES
(1, 'Ray-Ban', -1.25, -1.50, 'metal', 'negro', 'transparente', 'transparente', 120.00),
(2, 'Oakley', -0.75, -0.75, 'pasta', 'azul', 'transparente', 'transparente', 150.00),
(3, 'Versace', -2.00, -2.25, 'metal', 'dorado', 'transparente', 'transparente', 200.00),
(4, 'Prada', -1.00, -0.50, 'pasta', 'rojo', 'transparente', 'transparente', 180.00),
(5, 'Gucci', 0.00, 0.00, 'flotante', 'negro', 'transparente', 'transparente', 250.00),
(6, 'Tom Ford', -0.25, -0.75, 'pasta', 'marrón', 'transparente', 'transparente', 220.00),
(7, 'Burberry', -3.00, -3.50, 'madera', 'plata', 'transparente', 'transparente', 210.00),
(8, 'Dolce & Gabbana', -0.50, -0.50, 'metal', 'azul', 'transparente', 'transparente', 190.00),
(9, 'Polaroid', 1.00, 1.25, 'madera', 'verde', 'transparente', 'transparente', 160.00),
(10, 'Hugo Boss', 1.50, 1.75, 'titanio', 'negro', 'transparente', 'transparente', 170.00);


/* Clientes */
INSERT INTO clientes(nombre, direccion, telefono, email, fecha_registro) VALUES
('Ana López', 'Calle Falsa, 123', '600123456', 'ana.lopez@gmail.com', '2023-01-10'),
('Carlos Pérez', 'Avenida Siempre Viva, 456', '600654321', 'carlos.perez@mail.com', '2023-02-15'),
('Marta Ruiz', 'Calle Sol, 67', '601234567', 'marta.ruiz@protonmail.com', '2023-03-05'),
('Jorge Navarro', 'Avenida Luna, 89', '602345678', 'jorge.navarro@yahoo.com', '2023-03-20'),
('Sofía Martín', 'Paseo Estrellas, 12', '603456789', 'sofia.martin@hotmail.com', '2023-04-01'),
('Luis Fernández', 'Calle Júpiter, 34', '604567890', 'luis.fernandez@zoho.com', '2023-04-15'),
('Elena Núñez', 'Calle Joaquin Costa, 47', '667526880' ,'elena.nunez@outlook.com', '2023-09-12'),
('Joan Laporta', 'Avenida Diagonal, 469', '605788701', 'joanlaporta@fcbarcelona.cat', '2023-12-24');


-- Ahora actualizamos los datos para el clientes que hayan sido recomendados por otro cliente 
-- por ejemplo para Carlos para que haya sido recomendado por Ana y asi para las otros clientes
UPDATE clientes SET id_cliente_referencia  = 1 WHERE id_clientes = 2;
UPDATE clientes SET id_cliente_referencia = 2 WHERE id_clientes  IN (3,4);
UPDATE clientes SET id_cliente_referencia = 4 WHERE id_clientes = 5;
UPDATE clientes SET id_cliente_referencia  = 5 WHERE id_clientes = 6;
UPDATE clientes SET id_cliente_referencia = 6 WHERE id_clientes IN (7,8);

/* Empleados */
INSERT INTO empleados(nombre,apellido) VALUES
('Laura', 'Martínez'),
('David', 'Gómez'),
('Sergio', 'Ramos'),
('Lucía', 'Gómez'),
('Beatriz', 'Conde'),
('Marcos', 'Pérez'),
('Jordi', 'Evole'),
('Daniel', 'Jiménez'),
('Alba', 'Ruiz'),
('Roberto', 'López'),
('María', 'García'),
('Antonio', 'Sánchez');

SELECT *FROM clientes;

/* Ventas */
INSERT INTO ventas(id_clientes,id_empleados,id_gafas,fecha_venta) VALUES
(1, 1, 1, '2023-03-10'),
(2, 2, 2, '2023-04-05'),
(3, 3, 3, '2023-05-01'),
(4, 4, 4, '2023-05-02'),
(5, 5, 5, '2023-05-03'),
(6, 6, 6, '2023-05-04'),
(7, 7, 7, '2023-05-05'),
(8, 8, 8, '2023-05-06'),
(2, 9, 9, '2023-05-07'),
(3, 10, 10, '2023-05-08'),
(5, 1, 1, '2023-05-09'),
(8, 2, 2, '2023-05-10');


/* Para verificar que tu diseño es correcto, efectúa las siguientes consultas y comprueba que devuelven resultados correctos: */


-- Óptica: --

-- 1. Lista el total de compras de un cliente/a. --

SELECT clientes.id_clientes, clientes.nombre, SUM(gafas.precio) AS total_compras
FROM ventas 
INNER JOIN clientes ON ventas.id_clientes = clientes.id_clientes
INNER JOIN gafas ON ventas.id_gafas = gafas.id_gafas 
WHERE clientes.id_clientes = 8
GROUP BY clientes.id_clientes, clientes.nombre;


-- 2. Lista las distintas gafas que ha vendido un empleado durante un año. --

SELECT empleados.id_empleados, empleados.nombre, empleados.apellido, gafas.marca, COUNT(*) AS cantidad_vendida
FROM ventas 
INNER JOIN empleados ON ventas.id_empleados = empleados.id_empleados 
INNER JOIN gafas ON ventas.id_gafas = gafas.id_gafas 
WHERE empleados.id_empleados = 2 AND YEAR(ventas.fecha_venta) = 2023
GROUP BY empleados.id_empleados, empleados.nombre, empleados.apellido, gafas.marca;


-- 3. Lista a los diferentes proveedores que han suministrado gafas vendidas con éxito por la óptica. -- 
SELECT proveedores.nombre, proveedores.ciudad, proveedores.telefono 
FROM ventas 
INNER JOIN gafas ON ventas.id_gafas = gafas.id_gafas 
INNER JOIN proveedores ON gafas.id_proveedor = proveedores.id_proveedor;


SELECT p.id_proveedor, p.nombre, COUNT(*) AS numero_de_gafas_vendidas
FROM ventas v
INNER JOIN gafas g ON v.id_gafas = g.id_gafas 
INNER JOIN proveedores p ON g.id_proveedor = p.id_proveedor 
GROUP BY p.id_proveedor, p.nombre;