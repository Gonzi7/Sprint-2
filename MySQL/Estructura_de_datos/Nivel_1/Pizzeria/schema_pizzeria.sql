DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE pizzeria;

CREATE TABLE clientes(
		id_cliente INT NOT NULL AUTO_INCREMENT,
		nombre VARCHAR(20) NOT NULL,
		apellido1 VARCHAR(50) NOT NULL,
		apellido2 VARCHAR(50) NOT NULL,
		direccion VARCHAR(100),
		codigo_postal MEDIUMINT(5),
		localidad VARCHAR(50),
		provincia VARCHAR(50),
		telefono VARCHAR(20),
		PRIMARY KEY(id_cliente)
);

CREATE TABLE tiendas(
		id_tienda INT NOT NULL AUTO_INCREMENT,
		direccion VARCHAR(100),
		codigo_postal MEDIUMINT(5),
		localidad VARCHAR(50), 
		provincia VARCHAR(50),
		PRIMARY KEY(id_tienda)
);

CREATE TABLE empleados( 
		id_empleado INT NOT NULL AUTO_INCREMENT,
		nombre VARCHAR(20) NOT NULL,
		apellido1 VARCHAR(50) NOT NULL,
		apellido2 VARCHAR(50) NOT NULL,
		telefono VARCHAR(20) NOT NULL,
		funcion ENUM('Cocinero','Repartidor') NOT NULL,
		id_tienda INT NOT NULL,
		PRIMARY KEY(id_empleado),
		FOREIGN KEY(id_tienda) REFERENCES tiendas(id_tienda) 
);

ALTER TABLE empleados ADD nif VARCHAR(20) NOT NULL AFTER apellido2;

CREATE TABLE pedidos(
		id_pedido INT NOT NULL AUTO_INCREMENT,
		fecha DATETIME NOT NULL,
		tipo_de_pedido ENUM('Envio a Domicilio','Recoger en Tienda') NOT NULL,
		precio_total DOUBLE NOT NULL,
		id_cliente INT NOT NULL,
		id_tienda INT NOT NULL,
		id_repartidor INT,
		fecha_hora_entrega DATETIME,
		PRIMARY KEY(id_pedido),
		FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente),
		FOREIGN KEY(id_tienda) REFERENCES tiendas(id_tienda),
		FOREIGN KEY(id_repartidor) REFERENCES empleados(id_empleado)
);

DESCRIBE pedidos;
DESCRIBE empleados;
-- ALTER TABLE pedidos MODIFY id_repartidor INT;
-- ALTER TABLE pedidos MODIFY fecha_hora_entrega DATETIME; 
SELECT TABLE_NAME, COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE REFERENCED_TABLE_SCHEMA = 'pizzeria' AND REFERENCED_TABLE_NAME = 'empleados';

CREATE TABLE categorias(
		id_categoria INT NOT NULL AUTO_INCREMENT,
		nombre VARCHAR(25),
		PRIMARY KEY(id_categoria)
);

CREATE TABLE productos(
		id_producto INT NOT NULL AUTO_INCREMENT,
		nombre_producto VARCHAR(50) NOT NULL,
		descripcion TEXT,
		imagen VARCHAR(200),
		precio_producto DOUBLE NOT NULL,
		PRIMARY KEY(id_producto)
);

CREATE TABLE categoriaproducto(
		id_producto INT NOT NULL,
		id_categoria INT NOT NULL,
		FOREIGN KEY(id_producto) REFERENCES productos(id_producto),
		FOREIGN KEY(id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE detallespedidos(
		id_detalle INT NOT NULL AUTO_INCREMENT,
		id_pedido INT,
		id_producto INT,
		cantidad INT,
		PRIMARY KEY(id_detalle),
		FOREIGN KEY(id_pedido) REFERENCES pedidos(id_pedido),
		FOREIGN KEY(id_producto) REFERENCES productos(id_producto)
);

-- Insertar datos a las tablas --
/* Clientes */
INSERT INTO clientes(nombre,apellido1,apellido2,direccion,codigo_postal,localidad,provincia,telefono)VALUES
('Juan', 'Toledo', 'Zurita', 'Calle Falsa 123', '28080', 'Madrid', 'Madrid', '600123456'),
('Andrea', 'García', 'Torrez', 'Av. Principal 45', '08020', 'Barcelona', 'Barcelona', '610234567'),
('Ana', 'de Armas', 'Caso', 'Plaza Central 10', '50001', 'Zaragoza', 'Zaragoza', '620345678'),
('Dani', 'Carvajal', 'Ramos', 'Calle Secundaria 5', '41010', 'Sevilla', 'Sevilla', '630456789'),
('Jaime', 'Paz', 'Zamora', 'Ronda Norte 22', '15004', 'A Coruña', 'A Coruña', '640567890'),
('Begoña', 'Vargas', 'López','Paseo del Río 3', '29016', 'Málaga', 'Málaga', '650678901'),
('Pedro', 'González', 'Alonso','Calle Nueva 12', '46010', 'Valencia', 'Valencia', '660789012'),
('Esther', 'Expósito', 'Gayoso', 'Av. de la Industria 6', '37004', 'Salamanca', 'Salamanca', '670890123'),
('Florentino', 'Pérez','Rodríguez', 'Plaza Mayor 1', '33011', 'Oviedo', 'Asturias', '680901234'),
('Penélope', 'Cruz', 'Sanchez', 'Calle Vieja 8', '41011', 'Sevilla', 'Sevilla', '690012345');

/* Tiendas */
INSERT INTO tiendas(direccion, codigo_postal, localidad, provincia) VALUES
('Calle Principal 100', '28080', 'Madrid', 'Madrid'),
('Av. Secundaria 200', '08020', 'Barcelona', 'Barcelona'),
('Plaza del Mercado 300', '50001', 'Zaragoza', 'Zaragoza'),
('Calle del Parque 400', '41010', 'Sevilla', 'Sevilla'),
('Ronda Sur 500', '15004', 'A Coruña', 'A Coruña'),
('Paseo Marítimo 600', '29016', 'Málaga', 'Málaga'),
('Calle del Puerto 700', '46010', 'Valencia', 'Valencia'),
('Av. de los Reyes 800', '37004', 'Salamanca', 'Salamanca'),
('Plaza de la Universidad 900', '33011', 'Oviedo', 'Asturias'),
('Calle Larga 101', '41011', 'Sevilla', 'Sevilla');

/* Empleados */
INSERT INTO empleados(nombre, apellido1, apellido2, nif, telefono, funcion, id_tienda) VALUES
('Pedro', 'Núñez', 'López', '12345678A', '691234567', 'Cocinero', 1),
('Isabel', 'Díaz', 'Martín', '23456789B', '692345678', 'Repartidor', 1),
('Jorge', 'Molina', 'Rodríguez', '34567890C', '693456789', 'Cocinero', 2),
('Carmen', 'Santos', 'Fernández', '45678901D', '694567890', 'Repartidor', 2),
('Antonio', 'Ortiz', 'Gutiérrez', '56789012E', '695678901', 'Cocinero', 3),
('Susana', 'Ramírez', 'Sánchez', '67890123F', '696789012', 'Repartidor', 3),
('Ricardo', 'Castro', 'Gil', '78901234G', '697890123', 'Cocinero', 4),
('Beatriz', 'Navarro', 'Ruiz', '89012345H', '698901234', 'Repartidor', 4),
('Alberto', 'Giménez', 'Alonso', '90123456I', '699012345', 'Cocinero', 5),
('Sofía', 'Vázquez', 'Pereira', '01234567J', '600123456', 'Repartidor', 5),
('Manuel', 'Hernández', 'Garrido', '11234567K', '601234567', 'Cocinero', 6),
('Lucía', 'González', 'Álvarez', '22345678L', '602345678', 'Repartidor', 6),
('Francisco', 'López', 'Moreno', '33456789M', '603456789', 'Cocinero', 7),
('Laura', 'Martínez', 'Domínguez', '44567890N', '604567890', 'Repartidor', 7),
('Sergio', 'Álvarez', 'Jiménez', '55678901O', '605678901', 'Cocinero', 8),
('Patricia', 'Pérez', 'Pascual', '66789012P', '606789012', 'Repartidor', 8),
('Raquel', 'Jiménez', 'García', '77890123Q', '607890123', 'Cocinero', 9),
('Pablo', 'Ruiz', 'López', '88901234R', '608901234', 'Repartidor', 9),
('Marta', 'Moreno', 'Fernández', '99012345S', '609012345', 'Cocinero', 10),
('Carlos', 'Gómez', 'Sánchez', '10123456T', '610123456', 'Repartidor', 10);

/* Pedidos */
INSERT INTO pedidos(fecha, tipo_de_pedido, precio_total, id_cliente, id_tienda, id_repartidor, fecha_hora_entrega) VALUES
('2024-01-10 18:00:00', 'Envio a Domicilio', 20.50, 1, 1, 2, '2024-01-10 18:45:00'),
('2024-01-11 19:00:00', 'Recoger en Tienda', 15.75, 2, 2, NULL, NULL),
('2024-01-12 20:00:00', 'Envio a Domicilio', 22.30, 3, 3, 4, '2024-01-12 20:30:00'),
('2024-01-13 18:30:00', 'Envio a Domicilio', 18.90, 4, 4, 6, '2024-01-13 19:10:00'),
('2024-01-14 19:45:00', 'Recoger en Tienda', 12.00, 5, 5, NULL, NULL),
('2024-01-15 17:50:00', 'Envio a Domicilio', 16.50, 6, 6, 8, '2024-01-15 18:20:00'),
('2024-01-16 19:30:00', 'Recoger en Tienda', 14.25, 7, 7, NULL, NULL),
('2024-01-17 20:15:00', 'Envio a Domicilio', 21.00, 8, 8, 10, '2024-01-17 20:50:00'),
('2024-01-18 18:05:00', 'Recoger en Tienda', 17.50, 9, 9, NULL, NULL),
('2024-01-19 20:30:00', 'Envio a Domicilio', 19.75, 10, 10, 12, '2024-01-19 21:00:00');

/* Categorias */
INSERT INTO categorias(nombre) VALUES
('Clásicas'),
('Especiales'),
('Vegetarianas'),
('Con Carne'),
('Bebidas');

/* Productos */
INSERT INTO productos(nombre_producto, descripcion, imagen, precio_producto) VALUES
('Pizza Margarita', 'Pizza clásica con tomate y mozzarella', 'img_margarita.jpg', 8.99),
('Pizza Pepperoni', 'Pizza con pepperoni y queso extra', 'img_pepperoni.jpg', 9.99),
('Hamburguesa Clásica', 'Hamburguesa con carne, queso y salsa', 'img_hamburguesa.jpg', 7.99),
('Hamburguesa Doble', 'Doble carne y doble queso', 'img_hamburguesa_doble.jpg', 9.99),
('Coca Cola', 'Lata de 330 ml', 'img_cocacola.jpg', 1.50),
('Fanta', 'Lata de 330 ml', 'img_fanta.jpg', 1.50),
('Agua Mineral', 'Botella de 500 ml', 'img_agua.jpg', 1.00),
('Pizza Vegetariana', 'Pizza con verduras variadas', 'img_vegetariana.jpg', 10.99),
('Pizza Barbacoa', 'Pizza con salsa barbacoa y carne', 'img_barbacoa.jpg', 11.99),
('Hamburguesa Vegetariana', 'Hamburguesa con hamburguesa de soja y vegetales', 'img_hamburguesa_vegetariana.jpg', 8.99);

/* Categoria de Productos */
INSERT INTO categoriaproducto(id_producto, id_categoria) VALUES
(1, 1), -- Ejemplo de la categoria de acuerdo al id_producto y id_categoria: Pizza Margarita en Clásicas
(2, 1), 
(8, 3), 
(9, 2), 
(5, 5), 
(6, 5), 
(7, 5); 

-- ALTER TABLE pedidos AUTO_INCREMENT = 1;
/* Detalles de Pedidos */
INSERT INTO detallespedidos(id_pedido, id_producto, cantidad) VALUES
(1, 1, 2), -- Ejemplo del detalle de acuerdo al id_pedido en este caso el pedido numero 1 el cual incluye 2 unidades del Producto 1 --
(1, 3, 1), 
(2, 2, 1), 
(2, 4, 2), 
(3, 1, 3), 
(4, 5, 1), 
(4, 6, 1), 
(5, 3, 2), 
(6, 4, 1), 
(7, 2, 1), 
(7, 5, 1), 
(8, 1, 2), 
(9, 3, 3), 
(10, 4, 1), 
(10, 6, 2); 

/* Para verificar que tu diseño es correcto, efectúa las siguientes consultas y comprueba que devuelven resultados correctos: */


-- Pizzeria: --

-- 1.Lista cuántos productos de tipo “Bebidas” se han vendido en una determinada localidad.

SELECT cli.localidad, SUM(dp.cantidad) as Total_Bebidas_Vendidas
FROM detallespedidos dp
JOIN pedidos ped ON dp.id_pedido = ped.id_pedido
JOIN clientes cli ON ped.id_cliente = cli.id_cliente
JOIN categoriaproducto catp ON dp.id_producto = catp.id_producto 
JOIN categorias cat ON catp.id_categoria = cat.id_categoria 
WHERE cat.nombre = 'Bebidas'
AND cli.localidad = 'Sevilla';



-- 2.Lista cuántos pedidos ha efectuado un determinado empleado/a.
SELECT id_repartidor, COUNT(*) AS Numero_de_Pedidos
FROM pedidos
WHERE id_repartidor = 2;




