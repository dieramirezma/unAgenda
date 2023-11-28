-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: bk9yaw96cgi2zyhqfvda-mysql.services.clever-cloud.com:3306
-- Generation Time: Nov 07, 2023 at 04:10 PM
-- Server version: 8.0.22-13
-- PHP Version: 8.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bk9yaw96cgi2zyhqfvda`
--

-- --------------------------------------------------------

--
-- Table structure for table `cuaderno`
--

CREATE TABLE `cuaderno` (
  `id_cuaderno` int NOT NULL,
  `id_usuario` int DEFAULT NULL,
  `nombreCuaderno` varchar(60) NOT NULL,
  `contenido` mediumtext NOT NULL,
  `modoOscuro` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cuaderno`
--

INSERT INTO `cuaderno` (`id_cuaderno`, `id_usuario`, `nombreCuaderno`, `contenido`, `modoOscuro`) VALUES
(17, 11, 'Ingeniería de software', '', 1),
(19, 8, 'Ingesoft apuntes', '<p>Aloooooo</p>\n<p>&nbsp;</p>\n<p><strong>PROBANDOOOO</strong></p>\n<p>&nbsp;</p>\n<p>funciona? :D?</p>', 0),
(25, 11, 'ff', 'Tus Nuevos Apuntes...', 1),
(30, 17, 'Ingeniería de software', '<p>Elquipo scrum se compone de:</p>', 0),
(31, 17, 'Sistemas Operativos', '<p>Los hilos son una unidad b&aacute;sica de CPU.</p>', 0),
(32, 11, 'hola', 'Tus Nuevos Apuntes...', 1),
(33, 11, 'e', 'Tus Nuevos Apuntes...', 1),
(34, 11, 'e', 'Tus Nuevos Apuntes...', 1),
(35, 11, 'e', 'Tus Nuevos Apuntes...', 1),
(36, 11, 'd', 'Tus Nuevos Apuntes...', 1),
(37, 11, 'd', 'Tus Nuevos Apuntes...', 1),
(38, 11, 'd', 'Tus Nuevos Apuntes...', 1),
(39, 11, 'd', 'Tus Nuevos Apuntes...', 1),
(40, 16, 'Prueba', '<p>Tus Nuevos Apuntes...</p>', 0),
(41, 12, 'Prueba1', '<p>Tus Nuevos Apuntes...</p>', 0),
(42, 12, 'prueba2', 'Tus Nuevos Apuntes...', 0),
(43, 12, 'prueba2', 'Tus Nuevos Apuntes...', 0),
(52, 11, '123', 'Tus Nuevos Apuntes...', 0),
(53, 11, 'Apuntes - arquitectura', '<p>Tus Nuevos Apuntes...</p>', 0),
(54, 11, 'PruebaEng', '<p>Tus Nuevos Apuntes...</p>', 0),
(55, 11, 'Test', '<p>Tus Nuevos Apuntes...</p>', 0),
(56, 11, 'Machine Learning', '<p>Tus Nuevos Apuntes...</p>', 0);

-- --------------------------------------------------------

--
-- Table structure for table `grupoNotas`
--

CREATE TABLE `grupoNotas` (
  `idNota` int NOT NULL,
  `idUsuario` int DEFAULT NULL,
  `numGrupo` int DEFAULT NULL,
  `porcentaje` float DEFAULT NULL,
  `nota` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `grupoNotas`
--

INSERT INTO `grupoNotas` (`idNota`, `idUsuario`, `numGrupo`, `porcentaje`, `nota`) VALUES
(1, 11, 0, 100, 4.5),
(2, 15, 0, 70, 4.5),
(3, 15, 0, 70, 4.3),
(4, 15, 1, 30, 3),
(5, 15, 1, 30, 2);

-- --------------------------------------------------------

--
-- Table structure for table `horario`
--

CREATE TABLE `horario` (
  `idHorario` int NOT NULL,
  `idUsuario` int NOT NULL,
  `evento` varchar(255) NOT NULL,
  `horaInicio` int NOT NULL,
  `horaFin` int NOT NULL,
  `diaSemana` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `horario`
--

INSERT INTO `horario` (`idHorario`, `idUsuario`, `evento`, `horaInicio`, `horaFin`, `diaSemana`) VALUES
(2, 11, 'Clase de SO', 7, 8, '1'),
(3, 8, 'Ingeniería de Software', 18, 20, '2'),
(4, 8, 'Ingeniería de Software', 18, 20, '4'),
(5, 8, 'Arquitectura de Computadores', 11, 13, '1'),
(6, 8, 'Arquitectura de Computadores', 11, 13, '3'),
(7, 8, 'Modelos y Simulación', 14, 16, '1'),
(8, 8, 'Modelos y Simulación', 14, 16, '3'),
(9, 8, 'Ingeniería Económica', 16, 18, '2'),
(10, 8, 'Ingeniería Económica', 16, 18, '4'),
(11, 8, 'Ingeniería Económica', 16, 18, '4'),
(12, 8, '日本語', 18, 20, '1'),
(13, 8, '日本語', 18, 20, '3'),
(14, 11, 'Clase de Ingesoft', 7, 8, '2'),
(16, 15, 'Clase de Ingesoft', 7, 8, '1');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `id` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `expiration` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`id`, `email`, `token`, `created_at`, `expiration`) VALUES
(1, 'dieramirezma@unal.edu.co', 'f5mV6gM4uuQkLs3kdpxyrgNFeCxp6s65', '2023-10-25 08:17:32', '2023-10-26 08:17:32'),
(2, 'usuario1@example.com', 'AU3VLgrY6gClLX4RSu0AMlOMNM1bZEKz', '2023-10-26 20:50:41', '2023-10-27 20:50:41');

-- --------------------------------------------------------

--
-- Table structure for table `recordatorios`
--

CREATE TABLE `recordatorios` (
  `idRecordatorio` int NOT NULL,
  `idUsuario` int DEFAULT NULL,
  `nombreRecordatorio` varchar(255) NOT NULL,
  `y` int NOT NULL,
  `mm` int NOT NULL,
  `d` int NOT NULL,
  `h` int NOT NULL,
  `m` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `recordatorios`
--

INSERT INTO `recordatorios` (`idRecordatorio`, `idUsuario`, `nombreRecordatorio`, `y`, `mm`, `d`, `h`, `m`) VALUES
(1, 8, 'Ingesoft Clase', 2023, 10, 31, 18, 0),
(3, 11, 'Recordatorio Prueba 2.1', 2023, 11, 6, 19, 30),
(4, 11, 'Recordatorio Prueba 3', 2023, 11, 4, 18, 30),
(5, 11, 'Recordatorio Prueba 4', 2023, 11, 2, 7, 30),
(6, 11, 'Recordatorio Prueba 5', 2023, 11, 1, 22, 30),
(7, 11, 'Recordatorio Prueba 6.1', 2023, 11, 14, 20, 30),
(8, 11, 'Recordatorio Prueba 7', 2023, 11, 2, 18, 30),
(9, 8, 'Recordatorio 1', 2023, 11, 1, 18, 0),
(10, 8, 'Recordatorio 2', 2023, 11, 2, 18, 0),
(11, 8, 'Recordatorio 3', 2023, 11, 3, 18, 0),
(12, 8, 'Recordatorio 4', 2023, 11, 4, 18, 0),
(22, 11, 'Daily', 2023, 11, 6, 20, 0),
(23, 8, 'Review Sprint 2', 2023, 11, 6, 18, 0),
(24, 15, 'Taller de SO', 2023, 11, 6, 23, 59),
(27, 15, 'REVIEW SPRINT 2', 2023, 11, 7, 18, 30),
(29, 8, 'aaa', 2023, 11, 8, 22, 0);

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` int NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `correo` varchar(50) NOT NULL,
  `contrasena` varchar(200) NOT NULL,
  `codigo_verificacion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `nombre`, `correo`, `contrasena`, `codigo_verificacion`) VALUES
(8, 'Tili', 'iayalar@unal.edu.co', 'scrypt:32768:8:1$RhIszEXc7wfhDWQV$cdd6b74f0562b9a5ee993e8862dec7073e3ada6eeef7eb4ed1f8f989a3e7f7459f6a3e7ae3fd6e5004bde2a19bcf35b477d192b4db07cfd95e5cac88814b18b6', NULL),
(11, 'Usuario1', 'usuario1@example.com', 'scrypt:32768:8:1$1TDf6GVwXLwTZcUE$7d98c0c4c1c4f1d477e82bc7b606f41f311ee6b8feed30463b48ddd4784b74143f4d3e1b84ed95c3aad3bdf2b36e6b01650b805b834d4f881a9a299df3ceb2ae', NULL),
(12, 'Usuario2', 'usuario2@example.com', 'scrypt:32768:8:1$7zIR5ncDYQhHoDpq$812ff44806d037514d41c86a8fbf3934707a24e9c295f5de59923c58d50bdee187bc4c962916ea7750cfdd249988063698966dd288dc14aa2cf5b669e14fb76e', NULL),
(13, 'Usuario3', 'usuario3@example.com', 'scrypt:32768:8:1$CTlxCq6xPNHebh8X$d84da508867b1ffcbde139cddaf7de04d9986810bc3c7d5797dca59abc0a53c76096a9f9e1864cded0970ef602f1b610c7c563318d9e15060917b3e4518409fe', NULL),
(14, 'Usuario4', 'usuario4@example.com', 'scrypt:32768:8:1$o85I8eKWMXUzFBIu$e5e368e9bc20e2f0058fc096e66d076995e126087d6d4175dfa6d03b55820ce23d01b00d9899fca594bd8c9a44fe0e1af6fb47a85290df3947f18d98c1d7533a', NULL),
(15, 'Diego Ramirez', 'dieramirezma@unal.edu.co', 'scrypt:32768:8:1$WaiaM7E1gWC50eq2$c891235e6f30f6e224b91dc87a481fa6c6369fd4f175f42304d43ce07ddf9ed9f9a4d55706dd463088cd3ae495930298d968c663dd467326a4291604396c739d', NULL),
(16, 'John', 'jruac@unal.edu.co', 'scrypt:32768:8:1$UNbogQ1hf9cv5mmF$746c17a74a0fa48f159115693414272f21ce63a9e4b7fed3b1552463b86de846b37f7afed51e46c8f24062016ea9aa3df43281868e70bca2dc5c425a594a0e5f', NULL),
(17, 'Anderson David Morales Chila', 'amoralesch@unal.edu.co', 'scrypt:32768:8:1$4C1fGh9mrSPL7Sb2$7117c1cc456ee472a6cc544786785b916763633c3b658a2db4e6b0c4d34730d8e90664fcfe463d7b7628e2462c4bde5872adeb25176257ad4a9f75674b8977e8', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cuaderno`
--
ALTER TABLE `cuaderno`
  ADD PRIMARY KEY (`id_cuaderno`),
  ADD KEY `idUsuario_idx` (`id_usuario`);

--
-- Indexes for table `grupoNotas`
--
ALTER TABLE `grupoNotas`
  ADD PRIMARY KEY (`idNota`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indexes for table `horario`
--
ALTER TABLE `horario`
  ADD PRIMARY KEY (`idHorario`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recordatorios`
--
ALTER TABLE `recordatorios`
  ADD PRIMARY KEY (`idRecordatorio`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cuaderno`
--
ALTER TABLE `cuaderno`
  MODIFY `id_cuaderno` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `grupoNotas`
--
ALTER TABLE `grupoNotas`
  MODIFY `idNota` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `horario`
--
ALTER TABLE `horario`
  MODIFY `idHorario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `recordatorios`
--
ALTER TABLE `recordatorios`
  MODIFY `idRecordatorio` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cuaderno`
--
ALTER TABLE `cuaderno`
  ADD CONSTRAINT `idUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `grupoNotas`
--
ALTER TABLE `grupoNotas`
  ADD CONSTRAINT `grupoNotas_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`);

--
-- Constraints for table `horario`
--
ALTER TABLE `horario`
  ADD CONSTRAINT `horario_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`);

--
-- Constraints for table `recordatorios`
--
ALTER TABLE `recordatorios`
  ADD CONSTRAINT `recordatorios_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
