DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

-- 1. Lista el nombre de todos los productos que hay en la tabla "producto". --
SELECT nombre FROM producto;

-- 2. Lista los nombres y precios de todos los productos de la tabla "producto". --
SELECT nombre, precio FROM producto;

-- 3. Lista todas las columnas de la tabla "producto". --
SELECT *FROM producto;

-- 4. Lista el nombre de los "productos", el precio en euros y el precio en dólares estadounidenses (USD). --
SELECT nombre, precio, (precio * 1.09) AS precio_USD FROM producto; 
-- Pasos extras para adicionar la columna de precios en dólares estadounidenses (USD) —
-- ALTER TABLE producto ADD precio_USD DECIMAL(10,2); --
ALTER TABLE producto ADD COLUMN precio_USD DOUBLE;

-- Conversion de euros a dólares en el campo precio_USD de la tabla producto --
UPDATE producto SET precio_USD = (precio * 1.09);

-- 5. Lista el nombre de los "productos", el precio en euros y el precio en dólares estadounidenses. Utiliza los siguientes sobrenombre para las columnas: nombre de "producto", euros, dólares estadounidenses. --
SELECT nombre AS productos, precio AS euros, precio_USD AS dolares_estadounidenses FROM producto;

-- 6. Lista los nombres y precios de todos los productos de la tabla "producto", convirtiendo los nombres a mayúscula. --
SELECT upper(nombre), precio, precio_USD FROM producto;

-- 7. Lista los nombres y precios de todos los productos de la tabla "producto", convirtiendo los nombres a minúscula. --
SELECT lower(nombre), precio, precio_USD FROM producto;

-- 8. Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante. --
SELECT nombre, UPPER(LEFT(nombre, 2)) AS primeros_dos_caracteres FROM fabricante;

-- 9. Lista los nombres y precios de todos los productos de la tabla "producto", redondeando el valor del precio. --
SELECT nombre, ROUND(precio, 2), ROUND(precio_USD, 2) FROM producto;

-- 10. Lista los nombres y precios de todos los productos de la tabla "producto", truncando el valor del precio para mostrarlo sin ninguna cifra decimal. --
SELECT nombre, ROUND(precio), ROUND(precio_USD) FROM producto;

-- 11. Lista el código de los fabricantes que tienen productos en la tabla "producto" --
SELECT fab.codigo, fab.nombre FROM fabricante fab INNER JOIN producto prod ON fab.codigo = prod.codigo_fabricante;

-- 12. Lista el código de los fabricantes que tienen productos en la tabla "producto", eliminando los códigos que aparecen repetidos. --
SELECT DISTINCT fab.codigo, fab.nombre FROM fabricante fab INNER JOIN producto prod ON fab.codigo = prod.codigo_fabricante;

-- 13. Lista el nombre del fabricante ordenando de manera ascendente. --
SELECT codigo, nombre FROM fabricante ORDER BY nombre ASC;

-- 14. Lista el nombre del fabricante ordenando de manera descendente. --
SELECT codigo, nombre FROM fabricante ORDER BY nombre DESC;

-- 15. Lista el nombre del producto ordenados en primer lugar, para el nombre de manera ascendente, y en segundo lugar, para el precio de manera descendente. --
SELECT * FROM producto ORDER BY nombre ASC;

SELECT * FROM producto ORDER BY precio DESC;

-- 16. Retorna una lista con las 5 primeras filas de la tabla fabricante --
SELECT * FROM fabricante LIMIT 5;

-- 17. Retorna una lista con 2 filas a partir de la cuarta fila de la tabla "fabricante". La cuarta fila también se ha de incluir en la respuesta. --
SELECT * FROM fabricante LIMIT 2 OFFSET 3;

-- 18. Lista el nombre y el precio del producto más barato. (Utiliza solo las cláusulas ORDER BY y LIMIT). Nota: Aquí no podrías usar MIN(precio), necesitarías GROUP BY --
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;

-- 19. Lista el nombre y precio del producto más caro (Utiliza solo las cláusulas ORDER BY y LIMIT). NOTA: Aquí no podrías usar MAX(precio), necesitarías GROUP BY. --
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

-- 20. Lista el nombre de todos los productos de fabricante cuyo codigo de fabricante es igual a 2. --
SELECT nombre FROM producto WHERE codigo_fabricante = 2;

-- 21. Devuelve una lista con el nombre del producto, precio y nombre del fabricante de todos los productos de la base de datos. --
SELECT fabricante.nombre, producto.nombre, producto.precio FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

-- 22. Devuelve una lista con el nombre de producto, precio y nombre del fabricante de todos los productos de la base de datos. Ordena el resultado por el nombre de fabricante, en orden alfabético. --
SELECT fab.nombre, prod.nombre, prod.precio FROM producto prod INNER JOIN fabricante fab ON prod.codigo_fabricante = fab.codigo ORDER BY  fab.nombre ASC;

-- 23. Devuelve una lista con el codigo del producto, nombre del producto, codigo del fabricante y nombre del fabricante, de todos los productos de la base de datos. --
SELECT prod.codigo, prod.nombre, prod.codigo_fabricante, fab.nombre FROM producto prod INNER JOIN fabricante fab ON prod.codigo_fabricante = fab.codigo;

-- 24. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto mas barato. --
SELECT fab.nombre AS nombre_fabricante, prod.nombre AS nombre_del_producto, prod.precio FROM producto prod INNER JOIN fabricante fab ON prod.codigo_fabricante = fab.codigo ORDER BY prod.precio ASC LIMIT 1;

-- 25. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto mas caro. --
SELECT fab.nombre AS nombre_fabricante, prod.nombre AS nombre_del_producto, prod.precio FROM producto prod  INNER JOIN fabricante fab ON prod.codigo_fabricante = fab.codigo ORDER BY prod.precio DESC LIMIT 1;

-- 26. Devuelve una lista con todos los productos del fabricante Lenovo --
SELECT fab.nombre, prod.nombre, prod.precio FROM producto prod INNER JOIN fabricante fab ON prod.codigo_fabricante = fab.codigo WHERE fab.nombre = "Lenovo";

-- 27. Devuelve una lista de todos los productos del fabricante Crucial que tenga un precio mayor que 200 € --
SELECT fab.nombre AS nombre_fabricante, prod.nombre AS nombre_del_producto, prod.precio FROM producto prod INNER JOIN fabricante fab ON prod.codigo_fabricante = fab.codigo WHERE fab.nombre = "Crucial" AND prod.precio > 200;

-- 28. Devuelve una lista con todos los productos del fabricante Asus, Hewlett-Packard y Seagate. Sin utilizar el operador IN. --
SELECT prod.nombre AS nombre_del_producto, fab.nombre AS nombre_fabricante FROM producto prod INNER JOIN fabricante fab ON prod.codigo_fabricante = fab.codigo WHERE fab.nombre = 'Asus' OR fab.nombre = 'Hewlett-Packard' OR fab.nombre = 'Seagate';

-- 29. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Usando el operador IN --
SELECT fab.nombre AS nombre_fabricante, prod.nombre AS nombre_del_producto FROM producto prod INNER JOIN fabricante fab ON prod.codigo_fabricante = fab.codigo WHERE fab.nombre IN ('Asus','Hewlett-Packard','Seagate');

-- 30. Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre acabe por la vocal e. --
SELECT fab.nombre AS nombre_fabricante, prod.nombre AS nombre_del_producto, prod.precio AS precio_fabricante FROM producto prod INNER JOIN fabricante fab ON prod.codigo_fabricante = fab.codigo WHERE fab.nombre LIKE ('%e');

-- 31. Devuelve un listado con el nombre y el precio de todos los productos de cuyos fabricantes contenga el carácter w en su nombre. --
SELECT fab.nombre AS nombre_fabricante, prod.nombre AS nombre_del_producto, prod.precio AS precio_fabricante FROM producto prod INNER JOIN fabricante fab ON prod.codigo_fabricante = fab.codigo WHERE fab.nombre LIKE ('%w%');

-- 32. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180 €. Ordena el resultado, en primer lugar, por el precio (en orden descendente) y, en segundo lugar, por el nombre (en orden ascendente). --
SELECT prod.nombre AS nombre_del_producto, prod.precio AS precio_del_producto, fab.nombre AS nombre_del_fabricante FROM producto prod INNER JOIN  fabricante fab ON prod.codigo_fabricante = fab.codigo WHERE prod.precio >= 180 ORDER BY prod.precio DESC;

SELECT prod.nombre AS nombre_del_producto, prod.precio AS precio_del_producto, fab.nombre AS nombre_del_fabricante FROM producto prod INNER JOIN  fabricante fab ON prod.codigo_fabricante = fab.codigo WHERE prod.precio >= 180 ORDER BY prod.nombre ASC;

SELECT prod.nombre AS nombre_del_producto, prod.precio AS precio_del_producto, fab.nombre AS nombre_del_fabricante FROM producto prod INNER JOIN  fabricante fab ON prod.codigo_fabricante = fab.codigo WHERE prod.precio >= 180 ORDER BY prod.precio, prod.nombre ASC;

-- 33. Devuelve un listado con el código y el nombre de fabricante, sólo de aquellos fabricantes que tienen productos asociados en la base de datos. --
SELECT DISTINCT prod.codigo_fabricante, fab.nombre FROM producto prod INNER JOIN  fabricante fab ON prod.codigo_fabricante = fab.codigo;

-- 34. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos fabricantes que carecen de productos asociados. --
SELECT fab.codigo, fab.nombre AS ’nombre_del_fabricante’, prod.nombre AS ’nombre_del_producto’ FROM fabricante fab LEFT JOIN producto prod ON fab.codigo = prod.codigo_fabricante;

-- 35. Devuelve un listado en el que sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado. --
SELECT fab.codigo, fab.nombre FROM fabricante fab LEFT JOIN producto prod ON fab.codigo = prod.codigo_fabricante WHERE prod.codigo_fabricante IS NULL;

-- 36. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN). --
SELECT nombre, precio, codigo_fabricante FROM producto WHERE codigo_fabricante = 2;

-- 37. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN) --
SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = 2);

-- 38. Lista el nombre del producto más caro del fabricante Lenovo. --
SELECT nombre 
FROM producto
WHERE codigo_fabricante = 2
AND precio = (
	SELECT  MAX(precio)
	FROM producto
	WHERE codigo_fabricante = 2
);
    
-- 39. Lista el nombre del producto más barato del fabricante Hewlett-Packard. --
SELECT nombre 
FROM producto
WHERE codigo_fabricante = 3
AND precio = (
	SELECT  MIN(precio)
	FROM producto
	WHERE codigo_fabricante = 3
);

-- 40. Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo. --
SELECT * FROM producto
WHERE precio >= (
	SELECT MAX(precio)
    FROM producto 
    WHERE codigo_fabricante = (
		SELECT codigo
        FROM fabricante
        WHERE nombre = 'Lenovo'
	)
);

-- 41. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos. --
SELECT *FROM producto 
WHERE codigo_fabricante = (
		SELECT codigo
        FROM fabricante 
        WHERE nombre = 'Asus'
)
AND precio > (
	SELECT AVG(precio)
    FROM producto 
    WHERE codigo_fabricante = (
		SELECT codigo
        FROM fabricante
        WHERE nombre = 'Asus'
	)
);















