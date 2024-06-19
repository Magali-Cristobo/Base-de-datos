
create database parcial;
CREATE TABLE CLIENTES(
    Id INT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    NroPasaporte VARCHAR(20) NOT NULL
);

-- Creación de la tabla Paises
CREATE TABLE PAISES (
    Id INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);

-- Creación de la tabla Ciudades
CREATE TABLE CIUDADES (
    Id INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    PaisId INT NOT NULL,
    FOREIGN KEY (PaisId) REFERENCES PAISES(Id)
);

-- Creación de la tabla Aerolineas
CREATE TABLE Aerolineas (
    id INT PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL
);

-- Creación de la tabla Estados_Reserva
CREATE TABLE Estados_Reserva (
    id INT PRIMARY KEY,
    estado NVARCHAR(50) NOT NULL
);

-- Creación de la tabla Reservas
CREATE TABLE RESERVAS (
    Id INT PRIMARY KEY,
    Numero VARCHAR(20) NOT NULL,
    FechaReserva DATETIME NOT NULL,
    FechaInicioViaje DATETIME NOT NULL,
    EstadoReservaId INT NOT NULL,
    ClienteId INT NOT NULL,
    FOREIGN KEY (EstadoReservaId) REFERENCES Estados_Reserva(id),
    FOREIGN KEY (ClienteId) REFERENCES CLIENTES(Id)
);

-- Creación de la tabla Servicios
CREATE TABLE SERVICIOS (
    Id INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Tipo VARCHAR(50) NOT NULL
);

-- Creación de la tabla Vuelos
CREATE TABLE VUELOS (
    IdServicio INT PRIMARY KEY,
    NroVuelo VARCHAR(20) NOT NULL,
    AerolineaId INT NOT NULL,
    CiudadOrigen INT NOT NULL,
    FechaHoraPartida DATETIME NOT NULL,
    CiudadDestino INT NOT NULL,
    FechaHoraLlegada DATETIME NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (IdServicio) REFERENCES SERVICIOS(Id),
    FOREIGN KEY (AerolineaId) REFERENCES Aerolineas(Id),
    FOREIGN KEY (CiudadOrigen) REFERENCES CIUDADES(Id),
    FOREIGN KEY (CiudadDestino) REFERENCES CIUDADES(Id)
);

-- Creación de la tabla Reservas_Servicios
CREATE TABLE RESERVASSERVICIOS (
    ReservaId INT NOT NULL,
    ServicioId INT NOT NULL,
    FechaInicio DATETIME NOT NULL,
    FechaFin DATETIME NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (ReservaId, ServicioId),
    FOREIGN KEY (ReservaId) REFERENCES RESERVAS(Id),
    FOREIGN KEY (ServicioId) REFERENCES SERVICIOS(Id)
);

-- Creación de la tabla Hoteles
CREATE TABLE HOTELES (
    IdServicio INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    Ciudad INT NOT NULL,
    calle VARCHAR(100) NOT NULL,
    nro VARCHAR(20) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    precioPorNoche DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (IdServicio) REFERENCES SERVICIOS(Id),
    FOREIGN KEY (Ciudad) REFERENCES CIUDADES(Id)
);


select RESERVAS.Id, Numero, Nombre from RESERVAS join CLIENTES on ClienteId = CLIENTES.Id;
select RESERVAS.* from RESERVAS join RESERVASSERVICIOS on RESERVAS.Id = ReservaId join SERVICIOS on ServicioId = SERVICIOS.Id where Tipo = 'H';
select HOTELES.* from HOTELES left join RESERVASSERVICIOS on IdServicio = ServicioId where ReservaId is null;
select sum(RESERVASSERVICIOS.Precio), Id, Numero, FechaReserva, FechaInicioViaje, EstadoReservaId, ClienteId  from RESERVAS join RESERVASSERVICIOS on Id = ReservaId 
where FechaInicioViaje = '2024-07-1' group by Id, Numero, FechaReserva, FechaInicioViaje, EstadoReservaId, ClienteId;
select avg(Precio) from VUELOS join CIUDADES as destino on destino.Id = CiudadDestino join CIUDADES as origen on origen.id = CiudadOrigen join PAISES on destino.PaisId = PAISES.Id
where PAISES.nombre = 'Francia' and origen.nombre = 'Buenos Aires' and FechaHoraLLegada between '2024-03-01' and '2024-03-31';
select RESERVAS.* from RESERVAS join RESERVASSERVICIOS on RESERVAS.Id = ReservaId join VUELOS on IdServicio = ServicioId 
where VUELOS.Precio = (select max(Precio) from VUELOS);
delete from CIUDADES where not exists (select * from HOTELES where Ciudad = CIUDADES.Id) and not exists 
(select * from VUELOS where CiudadOrigen = CIUDADES.Id or CiudadDestino = CIUDADES.Id);

INSERT INTO PAISES VALUE (4, 'Francia');

-- Insertar datos en la tabla Ciudades
INSERT INTO CIUDADES VALUES 
(15, 'Paris', 4);

-- Insertar datos en la tabla Clientes
INSERT INTO CLIENTES VALUES 
(1, 'Juan', 'Pérez', 'AR123456'),
(2, 'Maria', 'Gonzalez', 'BR654321'),
(3, 'Carlos', 'Silva', 'CL789012');

-- Insertar datos en la tabla Aerolineas
INSERT INTO Aerolineas (id, nombre) VALUES 
(1, 'Aerolíneas Argentinas'),
(2, 'LATAM'),
(3, 'Gol Linhas Aéreas');

-- Insertar datos en la tabla Estados_Reserva
INSERT INTO Estados_Reserva (id, estado) VALUES 
(1, 'Pendiente'),
(2, 'Confirmada'),
(3, 'Cancelada');

-- Insertar datos en la tabla Reservas
INSERT INTO RESERVAS VALUES 
(1, 'R0001', '2024-06-01', '2024-06-15', 1, 1),
(2, 'R0002', '2024-06-02', '2024-06-16', 2, 2),
(3, 'R0003', '2024-06-03', '2024-06-17', 3, 3);

-- Insertar datos en la tabla Servicios
INSERT INTO SERVICIOS VALUES 
(4, 'Vuelo a Buenos Aires', 'V');

-- Insertar datos en la tabla Vuelos
INSERT INTO VUELOS VALUES 
(4, 'AA101', 1, 1, '2024-06-15 08:00', 15, '2024-06-15 11:00', 300.00);

-- Insertar datos en la tabla Hoteles
INSERT INTO HOTELES VALUES 
(2, 'Hotel Santiago', '5 estrellas', 5, 'Av. Providencia', '1234', '555-6789', 150.00);

-- Insertar datos en la tabla Reservas_Servicios
INSERT INTO RESERVASSERVICIOS VALUES 
(1, 1, '2024-06-15', '2024-06-15', 300.00),
(2, 2, '2024-06-16', '2024-06-18', 300.00),
(3, 3, '2024-06-17', '2024-06-17', 350.00);
