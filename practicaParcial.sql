create table ESCUELAS (
id int primary key,
nombre varchar(45)
);
create table ENFERMERAS (
 id int primary key, 
 apellido varchar(45),
 nombre varchar(45),
 turno varchar(45),
 sueldo float,
 EscuelaId int,
 foreign key (EscuelaId) references ESCUELAS(id)
);

create table MEDICAMENTOS(
id int primary key, 
descripcion varchar (100),
codigo varchar(2)
);

create table PREPAGAS(
id int primary key, 
nombre varchar(45)
);

create table PACIENTES (
	id int primary key,
    nombre varchar(45),
    apellido varchar(45),
	prepagaId int,
    foreign key (prepagaId) references PREPAGAS (id)
);

create table MEDICOS (
 id int primary key, 
 apellido varchar(45),
 nombre varchar(45),
 nroMatricula int
);

create table HABITACIONES (
id int primary key, 
numero int,
tipo varchar(45),
estado varchar(45)
);
create table INTERNACIONES (
id int primary key,
numero int,
fechaIngreso date,
horaIngreso time,
pacienteId int,
habitacionId int,
medicoId int,
foreign key (pacienteId) references PACIENTES (id),
foreign key (habitacionId) references HABITACIONES (id),
foreign key (medicoId) references MEDICOS (id)
);

create table MEDICAMENTOINTERNACION (
medicamentoId int,
internacionId int,
fecha date,
dosis float,
primary key (medicamentoId, internacionId),
foreign key (medicamentoId) references MEDICAMENTOS(id),
foreign key (internacionId) references INTERNACIONES(id)
);

CREATE TABLE ENFERMERAINTERNACION (
enfermeraId int,
internacionId int,
foreign key (internacionId) references INTERNACIONES(id),
foreign key (enfermeraId) references ENFERMERAS (id)
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------
# 1 Recupere los números de las internaciones y los nombres de los pacientes que ingresaron ayer.
select INTERNACIONES.id, nombre from INTERNACIONES JOIN PACIENTES ON pacienteId = PACIENTES.id where date_sub(now(), interval 1 day) = fechaIngreso;
# 2 Recupere los números de las internaciones que usaron los medicamentos con alguno de los siguientes códigos A2, S4, D6, F3
select distinct(internacionId) from MEDICAMENTOINTERNACION join MEDICAMENTOS on MEDICAMENTOS.id = MEDICAMENTOINTERNACION.medicamentoId where MEDICAMENTOS.codigo
in ("A2", "S4", "D6", "F3"); 
# 3 Recupere las enfermeras que nunca atendieron internaciones en la habitación número 145
select * from ENFERMERAS where not exists (select * from ENFERMERAINTERNACION join INTERNACIONES ON internacionId = INTERNACIONES.id join HABITACIONES 
ON HABITACIONES.id = habitacionId where enfermeraId = ENFERMERAS.id and HABITACIONES.numero = 145);
# 4. Recupere el total de la dosis administrada al paciente con Id = 100 del medicamento con Id = 435
SELECT SUM(dosis) from MEDICAMENTOINTERNACION JOIN INTERNACIONES on internacionId = id where pacienteId = 100 and medicamentoId = 435;
# 5 Obtenga el sueldo promedio por escuela de las enfermeras. Se requiere obtener el Id y el nombre de la escuela junto al sueldo promedio
select avg(sueldo), ESCUELAS.nombre from ENFERMERAS join ESCUELAS on EscuelaId = ESCUELAS.id group by ESCUELAS.nombre;
# 6 Obtenga el nombre de las enfermeras con mayor sueldo que atendieron internaciones en el mes de mayo
select nombre from ENFERMERAS where sueldo = (select max(sueldo) from ENFERMERAS join ENFERMERAINTERNACION ON enfermeraId = ENFERMERAS.id join INTERNACIONES
on internacionId = INTERNACIONES.id where fechaIngreso like "2024-05-%");
# 7 Actualizar el estado de la habitación 115 a 'DISPONIBLE'
update HABITACIONES SET estado = "DISPONIBLE" WHERE numero = 115;


