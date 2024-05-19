-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: bdFacu2
-- ------------------------------------------------------
-- Server version	8.0.36-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `articulo`
--

DROP TABLE IF EXISTS `articulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articulo` (
  `cod_art` int NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `precio` float DEFAULT NULL,
  `tipo` char(1) DEFAULT NULL,
  PRIMARY KEY (`cod_art`),
  CONSTRAINT `articulo_chk_1` CHECK ((`tipo` in (_utf8mb4'A',_utf8mb4'B',_utf8mb4'C')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articulo`
--

LOCK TABLES `articulo` WRITE;
/*!40000 ALTER TABLE `articulo` DISABLE KEYS */;
INSERT INTO `articulo` VALUES (1,'RS500Camiseta',15.99,'A'),(2,'Pantalón',29.99,'B'),(3,'Zapatos',49.99,'C'),(4,'Gorra',9.99,'A'),(5,'Bufanda',12.99,'B'),(6,'Reloj S500',99.99,'C'),(7,'Bolsa',19.99,'A'),(8,'Calcetines',7.99,'B'),(9,'Guantes',14.99,'C'),(10,'Vestido',39.99,'A'),(11,'Corbata',17.99,'B'),(12,'Chaquetón',79.99,'C'),(13,'Falda',24.99,'A'),(14,'Sombrero',11.99,'B'),(15,'Bufanda',8.99,'C'),(16,'Chaqueta',34.99,'A'),(17,'Pantalón corto',21.99,'B'),(18,'Botas',59.99,'C'),(19,'Jersey',27.99,'A'),(20,'Gafas de sol',39.99,'B'),(21,'Bañador',29.99,'C'),(22,'Chaleco',22.99,'A'),(23,'Zapatillas deportivas',44.99,'B'),(24,'Pulsera',6.99,'C'),(25,'Gorro de lana',10.99,'A'),(26,'T-shirt S500',7.99,'A'),(54,'Pantalón de jean',39.99,'A'),(121,'Zapatillas deportivas',49.99,'A');
/*!40000 ALTER TABLE `articulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articuloDeposito`
--

DROP TABLE IF EXISTS `articuloDeposito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articuloDeposito` (
  `cod_articulo` int NOT NULL,
  `cod_deposito` int NOT NULL,
  `stockActual` int DEFAULT NULL,
  `puntoReorden` int DEFAULT NULL,
  PRIMARY KEY (`cod_articulo`,`cod_deposito`),
  KEY `cod_deposito` (`cod_deposito`),
  CONSTRAINT `articuloDeposito_ibfk_1` FOREIGN KEY (`cod_articulo`) REFERENCES `articulo` (`cod_art`),
  CONSTRAINT `articuloDeposito_ibfk_2` FOREIGN KEY (`cod_deposito`) REFERENCES `deposito` (`cod_deposito`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articuloDeposito`
--

LOCK TABLES `articuloDeposito` WRITE;
/*!40000 ALTER TABLE `articuloDeposito` DISABLE KEYS */;
/*!40000 ALTER TABLE `articuloDeposito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `cod_cliente` int NOT NULL,
  `razonSocial` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cod_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Empresa A','Av. Corrientes 1234, Buenos Aires'),(2,'Compañía B','Calle Florida 567, Buenos Aires'),(3,'Corporación C','Av. Rivadavia 890, Buenos Aires'),(4,'Negocio D','Calle Reconquista 432, Buenos Aires'),(5,'Tienda E','Av. Santa Fe 678, Buenos Aires'),(6,'Comercio F','Av. Cabildo 987, Buenos Aires'),(7,'Establecimiento G','Calle Lavalle 345, Buenos Aires'),(8,'Fábrica H','Av. Corrientes 567, Buenos Aires'),(9,'Proveedor I','Calle Maipú 123, Buenos Aires'),(10,'Distribuidor J','Av. Santa Fe 432, Buenos Aires'),(11,'Empresa K','Av. Libertador 789, Buenos Aires'),(12,'Compañía L','Calle Alsina 456, Buenos Aires'),(13,'Corporación M','Av. Córdoba 210, Buenos Aires'),(14,'Negocio N','Av. Callao 543, Buenos Aires'),(15,'Tienda O','Calle Esmeralda 876, Buenos Aires'),(16,'Comercio P','Av. Pueyrredón 654, Buenos Aires'),(17,'Establecimiento Q','Calle Uruguay 321, Buenos Aires'),(18,'Fábrica R','Av. Belgrano 432, Buenos Aires'),(19,'Proveedor S','Calle San Martín 987, Buenos Aires'),(20,'Distribuidor T','Av. 9 de Julio 654, Buenos Aires'),(21,'Empresa U','Calle Paraguay 432, Buenos Aires'),(22,'Compañía V','Av. Scalabrini Ortiz 789, Buenos Aires'),(23,'Corporación W','Calle Junín 876, Buenos Aires'),(24,'Negocio X','Av. Las Heras 321, Buenos Aires'),(25,'Tienda Y','Calle Sarmiento 543, Buenos Aires'),(26,'Miguel Sánchez e hijos SRL','Av. Corrientes 123, Buenos Aires'),(27,'Mega Electrodomésticos','Av. Corrientes 123, Buenos Aires'),(28,'Mueblería Martínez','Av. Callao 456, Buenos Aires'),(29,'Mercado Marquez','Av. Santa Fe 789, Buenos Aires');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `depa`
--

DROP TABLE IF EXISTS `depa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `depa` (
  `cod_depa` int NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `gerente` int DEFAULT NULL,
  `cod_dep_padre` int DEFAULT NULL,
  PRIMARY KEY (`cod_depa`),
  KEY `cod_dep_padre` (`cod_dep_padre`),
  KEY `gerente` (`gerente`),
  CONSTRAINT `depa_ibfk_1` FOREIGN KEY (`cod_dep_padre`) REFERENCES `depa` (`cod_depa`),
  CONSTRAINT `depa_ibfk_2` FOREIGN KEY (`gerente`) REFERENCES `emp` (`cod_empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `depa`
--

LOCK TABLES `depa` WRITE;
/*!40000 ALTER TABLE `depa` DISABLE KEYS */;
INSERT INTO `depa` VALUES (1,'Ventas',NULL,NULL),(2,'Marketing',NULL,NULL),(3,'Recursos Humanos',NULL,NULL),(4,'Contabilidad',NULL,NULL),(5,'Producción',NULL,NULL),(6,'Logística',NULL,NULL),(7,'Tecnología de la Información',NULL,NULL),(8,'Desarrollo de Producto',NULL,NULL),(9,'Investigación y Desarrollo',NULL,NULL),(10,'Calidad',NULL,NULL);
/*!40000 ALTER TABLE `depa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deposito`
--

DROP TABLE IF EXISTS `deposito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deposito` (
  `cod_deposito` int NOT NULL,
  `ubicacion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cod_deposito`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deposito`
--

LOCK TABLES `deposito` WRITE;
/*!40000 ALTER TABLE `deposito` DISABLE KEYS */;
INSERT INTO `deposito` VALUES (1,'Av. Corrientes 1234, Buenos Aires'),(2,'Calle Florida 567, Buenos Aires'),(3,'Av. Rivadavia 890, Buenos Aires'),(4,'Calle Reconquista 432, Buenos Aires'),(5,'Av. Santa Fe 678, Buenos Aires');
/*!40000 ALTER TABLE `deposito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detallePedido`
--

DROP TABLE IF EXISTS `detallePedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detallePedido` (
  `cod_pedido` int NOT NULL,
  `cod_articulo` int NOT NULL,
  `cantidad` int DEFAULT NULL,
  PRIMARY KEY (`cod_pedido`,`cod_articulo`),
  KEY `cod_articulo` (`cod_articulo`),
  CONSTRAINT `detallePedido_ibfk_1` FOREIGN KEY (`cod_pedido`) REFERENCES `pedido` (`cod_pedido`),
  CONSTRAINT `detallePedido_ibfk_2` FOREIGN KEY (`cod_articulo`) REFERENCES `articulo` (`cod_art`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detallePedido`
--

LOCK TABLES `detallePedido` WRITE;
/*!40000 ALTER TABLE `detallePedido` DISABLE KEYS */;
INSERT INTO `detallePedido` VALUES (1,15,2),(1,23,3),(2,23,2),(2,25,4),(3,12,3),(3,23,1),(4,17,2),(4,23,5),(5,16,3),(5,54,2),(6,9,1),(6,54,4),(7,12,2),(7,54,3),(8,5,4),(8,54,1),(9,23,2),(9,54,3),(10,23,3),(10,54,2),(11,23,4),(11,54,4),(12,23,2),(12,54,1),(13,23,3),(13,54,3),(14,23,5),(14,54,2),(15,23,2),(15,54,4);
/*!40000 ALTER TABLE `detallePedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp`
--

DROP TABLE IF EXISTS `emp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emp` (
  `cod_empleado` int NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `codigoPostal` varchar(45) DEFAULT NULL,
  `codDepto` int DEFAULT NULL,
  `sueldBasico` float DEFAULT NULL,
  `fechaIngreso` date DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `telefono` int DEFAULT NULL,
  `jefe` int DEFAULT NULL,
  PRIMARY KEY (`cod_empleado`),
  KEY `jefe` (`jefe`),
  KEY `codDepto` (`codDepto`),
  CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`jefe`) REFERENCES `emp` (`cod_empleado`),
  CONSTRAINT `emp_ibfk_2` FOREIGN KEY (`codDepto`) REFERENCES `depa` (`cod_depa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp`
--

LOCK TABLES `emp` WRITE;
/*!40000 ALTER TABLE `emp` DISABLE KEYS */;
INSERT INTO `emp` VALUES (1,'Juan','Perez','Av. Corrientes 123','C1234ABC',1,30000,'1990-05-15','1980-01-10',1122334455,NULL),(2,'María','López','Av. Santa Fe 456','C5678DEF',2,32000,'1992-08-20','1985-06-22',1122334466,NULL),(3,'Pedro','Garcia','Av. Callao 789','C9012GHI',1,28000,'1995-02-10','1987-11-30',1122334477,1),(4,'Ana','Rodriguez','Av. Rivadavia 1011','C3456JKL',3,35000,'1993-04-05','1983-03-25',1122334488,2),(5,'Lucas','Martinez','Av. Cabildo 1213','C7890MNO',1,31000,'1991-07-12','1982-09-15',1122334499,2),(6,'Florencia','Sanchez','Av. Belgrano 1415','C1213PQR',2,33000,'1994-10-18','1986-12-20',1122334500,2),(7,'Diego','Perez','Av. Pueyrredón 1617','C1415STU',3,29000,'1996-03-22','1988-04-28',1122334511,1),(8,'Carolina','Fernandez','Av. Scalabrini Ortiz 1819','C1617VWX',1,34000,'1990-09-28','1981-07-05',1122334522,2),(9,'Martin','Perez','Av. Corrientes 2021','C1819YZA',2,30000,'1993-12-10','1984-05-18',1122334533,1),(10,'Laura','Alvarez','Av. Santa Fe 2223','C2021BCD',3,32000,'1997-01-15','1989-08-14',1122334544,1);
/*!40000 ALTER TABLE `emp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `cod_pedido` int NOT NULL,
  `cliente` int DEFAULT NULL,
  `empleado` int DEFAULT NULL,
  `fechaEntrega` date DEFAULT NULL,
  `fechaReal` date DEFAULT NULL,
  `depositoEntrega` int DEFAULT NULL,
  PRIMARY KEY (`cod_pedido`),
  KEY `cliente` (`cliente`),
  KEY `empleado` (`empleado`),
  KEY `depositoEntrega` (`depositoEntrega`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`cliente`) REFERENCES `cliente` (`cod_cliente`),
  CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`empleado`) REFERENCES `emp` (`cod_empleado`),
  CONSTRAINT `pedido_ibfk_3` FOREIGN KEY (`depositoEntrega`) REFERENCES `deposito` (`cod_deposito`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,1,1,'2024-04-20','2024-04-21',1),(2,2,2,'2024-04-21','2024-04-22',2),(3,3,3,'2024-04-22','2024-04-23',3),(4,4,4,'2024-04-23','2024-04-24',4),(5,5,5,'2024-04-24','2024-04-25',5),(6,1,2,'2024-04-25','2024-04-26',1),(7,2,3,'2024-04-26','2024-04-27',2),(8,3,4,'2024-04-27','2024-04-28',3),(9,4,5,'2024-04-28','2024-04-29',4),(10,5,1,'2024-04-29','2024-04-30',5),(11,1,3,'2024-04-30','2024-05-01',1),(12,2,4,'2024-05-01','2024-05-02',2),(13,3,5,'2024-05-02','2024-05-03',3),(14,4,1,'2024-05-03','2024-05-04',4),(15,5,2,'2024-05-04','2024-05-05',5);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-19 19:20:34
