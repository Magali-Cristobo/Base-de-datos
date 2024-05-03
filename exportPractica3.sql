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
  `codigoPostal` int DEFAULT NULL,
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

-- Dump completed on 2024-05-02 22:30:01
