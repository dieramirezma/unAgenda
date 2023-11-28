-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: prflask
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `gruponotas`
--
DROP TABLE IF EXISTS `Traza`;
CREATE TABLE `bk9yaw96cgi2zyhqfvda`.`Traza` (
  `idTraza` INT NOT NULL AUTO_INCREMENT,
  `id_Usuario` INT NULL,
  `Nombre` VARCHAR(255) NULL,
  `Descripcion` VARCHAR(255) NULL,
  `Hora` VARCHAR(45) NULL,
  PRIMARY KEY (`idTraza`),
  INDEX `id_Usuario_idx` (`id_Usuario` ASC) VISIBLE,
  CONSTRAINT `idUsuariotraza`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `bk9yaw96cgi2zyhqfvda`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


DROP TABLE IF EXISTS `recordatorios`;
 SET character_set_client = utf8mb4 ;

 CREATE TABLE `recordatorios` (
  `idRecordatorio` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) DEFAULT NULL,
  `nombreRecordatorio` varchar(255) NOT NULL,
  `y` int(11) NOT NULL,
  `mm` int(11) NOT NULL,
  `d` int(11) NOT NULL,
  `h` int(11) NOT NULL,
  `m` int(11) NOT NULL,
  PRIMARY KEY (`idRecordatorio`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `recordatorios_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idusuario`)
 )ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `recordatorios`;
 SET character_set_client = utf8mb4 ;

 CREATE TABLE `recordatorios` (
  `idRecordatorio` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) DEFAULT NULL,
  `nombreRecordatorio` varchar(255) NOT NULL,
  `y` int(11) NOT NULL,
  `mm` int(11) NOT NULL,
  `d` int(11) NOT NULL,
  `h` int(11) NOT NULL,
  `m` int(11) NOT NULL,
  PRIMARY KEY (`idRecordatorio`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `recordatorios_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idusuario`)
 )ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `grupoNotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `gruponotas` (
  `idNota` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) DEFAULT NULL,
  `numGrupo` int(11) DEFAULT NULL,
  `porcentaje` float DEFAULT NULL,
  `nota` float DEFAULT NULL,
  PRIMARY KEY (`idNota`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `gruponotas_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gruponotas`
--

LOCK TABLES `gruponotas` WRITE;
/*!40000 ALTER TABLE `gruponotas` DISABLE KEYS */;
/*!40000 ALTER TABLE `gruponotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horario`
--

DROP TABLE IF EXISTS `horario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `horario` (
  `idHorario` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `evento` varchar(255) NOT NULL,
  `horaInicio` int(5) NOT NULL,
  `horaFin` int(5) NOT NULL,
  `diaSemana` varchar(15) NOT NULL,
  PRIMARY KEY (`idHorario`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `horario_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horario`
--

LOCK TABLES `horario` WRITE;
/*!40000 ALTER TABLE `horario` DISABLE KEYS */;
/*!40000 ALTER TABLE `horario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `password_reset_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `expiration` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `correo` varchar(50) NOT NULL,
  `contrasena` varchar(200) NOT NULL,
  `codigo_verificacion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;

/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-15 12:56:12
