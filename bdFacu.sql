-- Practica 2
create table emp(
	codemp int primary key,
    nombre varchar(45),
    coddep int, 
    sueldo float,
    foreign key (coddep) references dep (coddep)
);

create table dep(
	coddep int primary key,
    descripcion varchar(45)
);

drop table emp;
-- 2
insert into emp value (01, "Jose", 2, 800); -- no va a funcionar nunca poruqe no creamos ese depto
-- 3
insert into dep value( 2, "Marketing"); 
-- 4
insert into emp value (01, "Jose", 2, 800); -- anda
-- 5
delete from dep; -- en mi caso funciona porque puse restriccion cascade de entrada, pero no deberia
-- 6 lo mismo que el 5
update dep set coddep = 4 where coddep = 2;
-- 7 dos formas:
ALTER TABLE emp ADD CONSTRAINT chequearSueldo CHECK (
    sueldo > 0
);
ALTER TABLE emp ADD CHECK (
    sueldo > 0
);
-- 8
insert into emp value (2, "Martin",4, 0); -- no cumple con la condicion asi que no lo agrega
-- 9
alter table emp drop constraint emp_ibfk_1; -- borro la constraint anterior
ALTER TABLE emp
ADD CONSTRAINT fk_emp_dep
FOREIGN KEY (coddep)
REFERENCES dep(coddep)
ON UPDATE CASCADE
on delete cascade;

-- Practica 3

create table depa ( -- la creo sin la foranea gerente y la agrego despues
	cod_depa int primary key, 
    descripcion varchar(45),
    gerente int,
    cod_dep_padre int,
    foreign key (cod_dep_padre) references depa(cod_depa)
);
create table emp(
	cod_empleado int primary key,
    nombre varchar(45),
    apellido varchar(45),
    direccion varchar(45),
    codigoPostal int,
    codDepto int, 
    sueldBasico float,
    fechaIngreso date,
    fechaNacimiento date,
    telefono int,
    jefe int,
    foreign key (jefe) references emp(cod_empleado),
    foreign key (codDepto) references depa(cod_depa)
);
alter table depa add foreign key (gerente) references emp(cod_empleado);
create table deposito(
	cod_deposito int primary key, 
    ubicacion varchar(45)
);
create table cliente(
	cod_cliente int primary key,
    razonSocial varchar(45),
    direccion varchar(45)
);
create table articulo(
	cod_art int primary key, 
    descripcion varchar(45),
    precio float,
    tipo char,
	check (tipo in ("A", "B","C"))
);
create table articuloDeposito(
	cod_articulo int, 
    cod_deposito int,
    stockActual int, 
    puntoReorden int,
    primary key(cod_articulo, cod_deposito),
    foreign key (cod_articulo) references articulo(cod_art),
    foreign key (cod_deposito) references deposito(cod_deposito)
);
create table pedido (
	cod_pedido int primary key, 
    cliente int, 
    empleado int,
    fechaEntrega date,
    fechaReal date, 
    depositoEntrega int,
    foreign key (cliente) references cliente(cod_cliente),
    foreign key (empleado) references emp(cod_empleado),
    foreign key (depositoEntrega) references deposito(cod_deposito)
);
create table detallePedido(
	cod_pedido int,
    cod_articulo int,
    cantidad int,
    primary key(cod_pedido, cod_articulo),
    foreign key (cod_pedido) references pedido(cod_pedido),
    foreign key (cod_articulo) references articulo(cod_art)
);
-- 1
select cod_pedido, razonSocial from pedido join cliente on cliente = cod_cliente where fechaEntrega = adddate(now(), interval 1 day);
-- 2
select pedido.*, descripcion from pedido join detallePedido on detallePedido.cod_pedido = pedido.cod_pedido join articulo on cod_articulo = cod_art;
-- 3
select cod_pedido, sum(precio*cantidad)*1.21 precioConIva from detallePedido join articulo on cod_articulo = cod_art group by cod_pedido;
-- 4 Listar los datos de los artículos que se encuentren a menos de un 10% de su punto de reorden.
select distinct(cod_art), articulo.* from articulo join articuloDeposito on cod_articulo = cod_art where stockActual < puntoReorden*1.1;
-- 5
select distinct (apellido) from emp;
-- 6 
select cod_cliente from cliente where razonSocial like "M%";
-- 7
select * from emp where apellido = "Perez";
-- 8 Recuperar los números de los pedidos que compraron el artículo, 2, 4, 6,8 ó 10 ( AR)
select cod_pedido from detallePedido where cod_articulo in (2,4, 6, 8, 10);
-- 9
select * from articulo where precio between 20000 and 50000;
-- 10
select * from pedido where fechaEntrega = adddate(now(), interval 1 week);
-- 11
select * from pedido where cliente is null;
-- 12 Recuperar los artículos cuya primera letra sea una R o una T y que luego continúan con S500. anda pero no con mysql
select * from articulo where descripcion like '[RT]S500' ;
-- 13 Recuperar los nombres de los diferentes artículos que tienen pedidos. ( AR)
select descripcion from articulo where cod_art in  (select distinct(cod_articulo) from detallePedido);
-- 14 Recuperar los artículos que nunca fueron pedidos. ( AR)
select descripcion from articulo where cod_art not in  (select distinct(cod_articulo) from detallePedido);
-- 15 Recuperar el nombre de los empleados que no efectuaron ningún pedido esta semana. (AR)
select nombre from emp where cod_empleado not in (select empleado from pedido where fechaEntrega >= current_date() and fechaEntrega<= adddate(now(), interval 1 week));
-- 16 Crear una tabla con nuevos pedidos. Listar los pedidos “viejos” y los nuevos
create table pedidosNuevos (
	cod_pedido int primary key,
    cliente int, 
    empleado int, 
    fechaEntrega date,
    fechaReal date,
    depositoEntrega int,
    foreign key (cod_pedido) references cliente(cod_cliente),
    foreign key (empleado) references emp(cod_empleado),
    foreign key (depositoEntrega) references deposito(cod_deposito)
);
(select * from pedido) union (select * from pedidosNuevos);
-- 17 Listar todos los pedidos de la tabla anterior ordenados por fecha de entrega decreciente
select * from pedido order by fechaEntrega desc;
-- 18 Recuperar el total de sueldos y el promedio de sueldos para cada departamento.
select sum(sueldBasico), avg(sueldBasico),codDepto from emp group by codDepto;
-- 19 Recuperar el costo total de cada pedido.
select sum(precio*cantidad) from detallePedido join articulo on cod_art = cod_articulo group by cod_pedido;
-- 20 Recuperar el total de unidades de cada artículo que hay que entregar la próxima semana.
select cod_articulo, sum(cantidad) from detallePedido join pedido on pedido.cod_pedido = detallePedido.cod_pedido where fechaEntrega = adddate(now(), interval 1 week) 
group by cod_articulo;
-- 21 Recuperar los datos de los empleados que tienen más de 3 pedidos pendientes de entrega
select * from emp where exists (select count(*) from pedido where fechaReal is null and empleado = emp.cod_empleado group by empleado having count(*) >= 3);
-- 22 Recuperar la cantidad de pedidos para cada empleado indicando el código y el nombre del mismo.
select count(*), empleado, nombre from pedido join emp on emp.cod_empleado = pedido.empleado group by empleado, nombre;
-- 23 Recuperar la cantidad pedida pendiente de entrega para cada artículo.
select cod_articulo, sum(cantidad) from detallePedido join pedido on pedido.cod_pedido = detallePedido.cod_pedido where fechaReal is null 
group by cod_articulo;
-- 24 Recuperar los departamentos para los cuales el promedio de sueldo de sus empleados sea superior a 3000.
select depa.* from depa join emp on depa.cod_depa = codDepto group by codDepto having avg(sueldBasico)>3000;
-- 25 Recuperar los artículos para los cuales la cantidad pendiente de entrega supere el stock. Los pedidos pendientes de entrega son los que no tienen informado el campo
-- fecha_real_entrega. no esta probado.
select distinct(articuloDeposito.cod_articulo), sum(cantidad) from articuloDeposito join detallePedido on detallePedido.cod_articulo = articuloDeposito.cod_articulo 
join pedido on detallePedido.cod_pedido = pedido.cod_pedido where fechaReal is null group by articuloDeposito.cod_articulo;
-- 28
update emp set direccion = "Congreso 1111" where cod_empleado = 1;
-- 30
delete from emp where codigoPostal = "9999";
-- 31 Dar de alta 3 artículos del tipo C con todos sus datos y uno del tipo B, indicando para este último un stock de 2126 unidades
insert into articulo values (55, "Pantuflas", 123, "C"), (56, "Pantuflas Cars", 123, "C"), (57, "Pantuflas Cars", 1243, "C"), (58, "Cuchara", 1243, "B");
-- 32 Todos los artículos del tipo C pasaron a formar parte del tipo A. Actualizar la tabla con 1 instrucción.
update articulo set tipo = "C" where tipo = "A";
-- 33 Restar 268 unidades al stock de los artículos de tipo B
update articuloDeposito join articulo on articuloDeposito.cod_articulo = articulo.cod_art set stockActual = stockActual - 268 where tipo = "B"; 
-- 34 Aumentar en un 5,5% el precio de los artículos del grupo A
update articulo set precio = precio*6.5 where tipo="A";
-- 35 Disminuir en un 10% el precio de los artículos con el mayor stock.
update articulo set precio = precio - precio*0.1 where cod_art = (select cod_articulo from articuloDeposito order by stockActual desc limit 1);
-- 36 Aumentar un 20% el sueldo básico de los empleados con el menor sueldo básico.
update emp set sueldBasico = sueldBasico + sueldBasico*0.2 order by sueldBasico asc limit 1;
-- 37 Aumentar un 15% a los empleados con más de 20 años en la empresa.
update emp set sueldBasico = sueldBasico + sueldBasico*0.15 where timestampdiff(year, fechaIngreso,now()) > 15;
-- 38 Aumentar en $500,00 el sueldo de los jefes de departamento que tengan el menor sueldo básico
update emp set sueldBasico = sueldBasico + 500 where jefe is null order by sueldBasico limit 1;
-- 39 Actualizar el precio de todos los artículos que no tienen pedidos reduciéndolo en un 10%
update articulo set precio = precio - precio*0.1 where cod_art not in (select distinct(cod_articulo) from detallePedido);
-- 40 Borrar todos los artículos cuyo stock es 0 y nunca han tenido pedidos.
delete from articulo where cod_art not in (select cod_articulo from detallePedido) and (select stockActual from articuloDeposito where cod_articulo = cod_art);
-- 41 Recuperar los artículos cuya descripción tiene al comienzo la sílaba MA y luego continúa con S550 ó S750.
select * from articulo where descripcion like 'MAS550%' or descripcion like 'MAS570%';
-- 42 Listar el sotck de los artículos cuya primera sílaba es ME o TE y luego continúan con R200 o R980
select stockActual from articulo join articuloDeposito on cod_art = cod_articulo where descripcion like 'ME_R200%' or descripcion like 'ME_R980%' 
or descripcion like 'TER200%' or descripcion like 'TE_R980%';
-- 43 Recuperar toda la estructura del departamento A ( con todos sus subniveles ). Anda
WITH RECURSIVE jerarquia AS (
    -- Caso base: el empleado específico
    SELECT cod_depa, descripcion, cod_dep_padre FROM depa WHERE cod_depa = 2 
    UNION ALL
    -- Parte recursiva: seleccionar el jefe del empleado anterior en la jerarquía
    SELECT e.cod_depa, e.descripcion, e.cod_dep_padre  FROM depa e INNER JOIN jerarquia j ON e.cod_dep_padre = j.cod_depa
)
-- Seleccionar toda la jerarquía
-- select * from jerarquia;
SELECT GROUP_CONCAT(distinct(descripcion) order by cod_dep_padre SEPARATOR ' - ') AS linea_jerarquica
FROM jerarquia;

-- 44 Recuperar toda la línea jerárquica que se encuentra sobre el empleado 28. Anda
WITH RECURSIVE jerarquia AS (
    -- Caso base: el empleado específico
    SELECT cod_empleado, nombre, apellido, jefe FROM emp WHERE cod_empleado = 6 
    UNION ALL
    -- Parte recursiva: seleccionar el jefe del empleado anterior en la jerarquía
    SELECT e.cod_empleado, e.nombre, e.apellido, e.jefe FROM emp e INNER JOIN jerarquia j ON e.cod_empleado = j.jefe
)
-- Seleccionar toda la jerarquía
SELECT GROUP_CONCAT(distinct(nombre) order by jefe SEPARATOR ' - ') AS linea_jerarquica -- lo ordeno para que me muestre ultimo el empleado 28
FROM jerarquia;
/*
WITH RECURSIVE employee_hierarchy AS (
	SELECT cod_empleado, nombre, apellido, jefe, 'Owner' AS path FROM emp WHERE cod_empleado = 6
	UNION ALL
	SELECT e.cod_empleado, e.nombre, e.apellido, e.jefe, concat(employee_hierarchy.path,'->' ,e.apellido) FROM emp e, employee_hierarchy WHERE e.cod_empleado = employee_hierarchy.jefe
)
SELECT *
FROM employee_hierarchy;
SELECT cod_empleado, nombre, apellido, jefe, 'Owner' AS aa FROM emp WHERE cod_empleado = 6;
select emp.cod_empleado hijo from emp join emp a on emp.jefe = a.cod_empleado where emp.jefe = 2;

WITH RECURSIVE employee_hierarchy (cod_empleado, nombre, apellido, jefe, Level) AS (
  -- Anchor member
  SELECT cod_empleado, nombre, apellido, jefe, 1 as Level
  FROM emp
  WHERE cod_empleado = 1
  UNION ALL
  -- Recursive member
  SELECT e.cod_empleado, e.nombre, e.apellido, e.jefe, eh.Level +1 
  FROM emp e
  INNER JOIN employee_hierarchy eh ON e.jefe = eh.cod_empleado
)
SELECT * FROM employee_hierarchy;*/

-- 45 Recuperar el nombre de todos los empleados que dependen de XXXX ( en todos los niveles). Anda
WITH RECURSIVE jerarquia AS (
    -- Caso base: el empleado específico
    SELECT cod_empleado, nombre, apellido, jefe
    FROM emp
    WHERE cod_empleado = 1  -- si pongo jefe = 1 no me muestra el nombre de xxxx
    UNION ALL

    -- Parte recursiva: seleccionar el jefe del empleado anterior en la jerarquía
    SELECT e.cod_empleado, e.nombre, e.apellido, e.jefe
    FROM emp e
    INNER JOIN jerarquia j ON e.jefe = j.cod_empleado
)

-- Seleccionar toda la jerarquía
SELECT GROUP_CONCAT(distinct(nombre) ORDER BY jefe SEPARATOR ', ') AS linea_jerarquica
FROM jerarquia;
-- 46 Recuperar el árbol que corresponde a la estructura de departamentos de la organización
WITH RECURSIVE Recursivo AS (
    SELECT
        cod_depa, descripcion, cod_dep_padre, descripcion AS ruta FROM depa WHERE cod_dep_padre IS NULL
    UNION ALL
    SELECT
        d.cod_depa, d.descripcion, d.cod_dep_padre, CONCAT(r.ruta, ' - ', d.descripcion) FROM depa d INNER JOIN Recursivo r ON d.cod_dep_padre = r.cod_depa
)
-- SELECT descripcion, if(ruta = descripcion, "-", ruta) FROM Recursivo;
SELECT  if(ruta = descripcion, descripcion, concat(descripcion, " -> " ,ruta)) FROM Recursivo;
-- 47 Recuperar el árbol que corresponde a la estructura de personal de la organización. Anda pero se puede emprolijar un poco
WITH RECURSIVE Recursivo AS (
    SELECT
        cod_empleado, jefe, nombre, if(jefe is null, "", nombre) AS ruta FROM emp WHERE jefe IS NULL
    UNION ALL
    SELECT
        d.cod_empleado, d.jefe, d.nombre, if(d.jefe is null, "", CONCAT(r.ruta," --- ",  r.nombre)) FROM emp d INNER JOIN Recursivo r ON d.jefe = r.cod_empleado
)
select concat(nombre, " -> " ,ruta) from Recursivo;
-- SELECT descripcion, if(ruta = descripcion, "-", ruta) FROM Recursivo;
-- SELECT  if(ruta = nombre, nombre, concat(nombre, " -> " ,ruta)) FROM Recursivo;
-- 48 Recuperar el nombre y el departamento de los empleados de mayor sueldo.
select cod_depa, descripcion from emp join depa on depa.cod_depa = codDepto group by cod_depa having sum(sueldBasico) = (select max(sueldoDepto) from (select sum(sueldBasico) as sueldoDepto from emp group by codDepto) as a);
-- verificacion
select sum(sueldBasico), codDepto from emp group by codDepto;
-- 49 Recuperar el nombre y el departamento de los empleados de mayor sueldo y de los de menor sueldo indicando en una columna la condición de mayor o de menor según corresponda.
select cod_depa, descripcion, "Mayor" as condicion from emp join depa on depa.cod_depa = codDepto group by cod_depa having sum(sueldBasico) = (select max(sueldoDepto) from 
(select sum(sueldBasico) as sueldoDepto from emp group by codDepto) as a) union (select cod_depa, descripcion,"Menor" from emp join depa on depa.cod_depa = codDepto 
group by cod_depa having sum(sueldBasico) = (select min(sueldoDepto) from 
(select sum(sueldBasico) as sueldoDepto from emp group by codDepto) as a) );
-- otra forma buscando los empleados con mayor y menor sueldo
select codDepto,descripcion, "Mayor" as condicion from emp join depa on cod_depa = codDepto where sueldBasico = (select max(sueldBasico) from emp) union 
(select codDepto, descripcion, "Menor" as condicion from emp join depa on cod_depa = codDepto where sueldBasico = (select min(sueldBasico) from emp));
-- 50 Obtener el departamento de los empleados que cobran, al menos, el doble que el sueldo promedio de los empleados.
select distinct(codDepto) from emp where sueldBasico >= 2*(select avg(sueldBasico) from emp);
-- 51 Listar los empleados que no son jefes de departamento y tienen sueldo mayor que el sueldo más alto de los jefes
select * from emp where jefe is not null and sueldBasico > (select max(sueldBasico) from emp where jefe is null);
-- 52
insert into pedido (cod_pedido, cliente, empleado, fechaEntrega, fechaReal, depositoEntrega) select 24, cliente, empleado, fechaEntrega, fechaReal, 
depositoEntrega  from pedido where cod_pedido = 13;
-- 53 Listar los números de pedido que vendieron el artículo 23 y el 54. Resolver este ejercicio de 3 formas diferentes. ( AR)
select cod_pedido from detallePedido where cod_articulo = 23 or cod_articulo = 54 group by cod_pedido having count(*)=2;
-- con exists y in
select cod_pedido from detallePedido where cod_articulo = 23 or cod_articulo = 54 group by cod_pedido having count(*)=2;

select cod_articulo from detallePedido order by;