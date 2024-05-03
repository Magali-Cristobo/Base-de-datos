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
select sum(precio*cantidad)*1.21 precioConIva from detallePedido join articulo on cod_articulo = cod_art group by cod_pedido;
-- 4
