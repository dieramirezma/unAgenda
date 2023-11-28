-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: bk9yaw96cgi2zyhqfvda-mysql.services.clever-cloud.com:3306
-- Generation Time: Nov 28, 2023 at 01:25 AM
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
(19, 8, 'Ingesoft apuntes', '<p>Aloooooo</p>\n<p>&nbsp;</p>\n<p><strong>PROBANDOOOO</strong></p>\n<p>&nbsp;</p>\n<p>funciona? :D?</p>', 0),
(40, 16, 'Prueba', '<p>Tus Nuevos Apuntes...</p>', 0),
(41, 12, 'Prueba1', '<p>Tus Nuevos Apuntes...</p>', 0),
(42, 12, 'prueba2', 'Tus Nuevos Apuntes...', 0),
(43, 12, 'prueba2', 'Tus Nuevos Apuntes...', 0),
(72, 17, 'Ingeniería de software', '<p>El equipo Scrum se compone de:</p>\n<ul>\n<li>- Equipo de desarrollo.</li>\n<li>- Scrum Master.</li>\n<li>- Product Owner.</li>\n</ul>', 0),
(73, 17, 'Sistemas Operativos', '<p>Los hilos son una unidad de CPU.</p>\n<p>Hola esto es una prueba</p>', 0),
(105, 11, 'Ingeniería de software', '<p><strong>Hola bla bla bla</strong></p>', 0),
(122, 11, 'Sistemas Operativos', '<p>Tus Nuevos Apuntes...</p>', 0);

-- --------------------------------------------------------

--
-- Table structure for table `flashcards`
--

CREATE TABLE `flashcards` (
  `idFlashcard` int NOT NULL,
  `id_Usuario` int NOT NULL,
  `nombreMazo` varchar(255) NOT NULL,
  `pista` varchar(255) NOT NULL,
  `respuesta` varchar(255) NOT NULL,
  `dia` int NOT NULL,
  `mes` int NOT NULL,
  `año` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `flashcards`
--

INSERT INTO `flashcards` (`idFlashcard`, `id_Usuario`, `nombreMazo`, `pista`, `respuesta`, `dia`, `mes`, `año`) VALUES
(14, 8, 'Kanji', '地球', 'ちきゅう (Tierra)', 26, 11, 2023),
(32, 8, 'Kanji', '友達', 'ともだち (Amiguinho)', 26, 11, 2023),
(34, 8, 'PRUEBA 2', '2', '3', 21, 11, 2023),
(37, 15, 'Ingesoft', '¿Cuál es el primer artefacto de SCRUM?', 'Product Backlog', 0, 0, 0),
(39, 15, 'Ingesoft', '¿Cuál es el segundo artefacto de SCRUM?', 'Sprint Backlog', 0, 0, 0),
(40, 15, 'Sistemas Operativos', '¿Cómo se llama la librería para hilos en C?', 'pthread', 0, 0, 0),
(44, 15, 'Sistemas Operativos', '¿Qué es SSH?', 'Secure Shell', 0, 0, 0),
(45, 15, 'Prueba1', 'Prueba1.1', 'Prueba1.2', 0, 0, 0),
(46, 15, 'Prueba1', 'Prueba2', 'Prueba2.1', 0, 0, 0),
(47, 15, 'Sistemas Operativos', '¿Cuál es el comando para ejecutar una instrucción con permisos de administrador?', 'sudo', 0, 0, 0),
(48, 16, 'Ingesoft', 'Que es python', 'Un lenguaje de programacion', 0, 0, 0),
(49, 11, 'Prueba 1', 'Pregunta Prueba 1', 'Respuesta Prueba 1', 26, 11, 2023),
(51, 11, 'Prueba Estudio', '¿Cuáles?', 'Estos', 26, 11, 2023),
(52, 11, 'Prueba Estudio', '¿Quién?', 'Yo', 26, 11, 2023),
(53, 11, 'Prueba Estudio', '¿Por qué?', 'No sé', 26, 11, 2023),
(54, 11, 'Prueba Estudio', '¿Cuándo?', 'Mañana', 26, 11, 2023),
(55, 11, 'Prueba Estudio', '¿Dónde?', 'En la casa', 26, 11, 2023),
(56, 11, 'Prueba Estudio', '¿Cómo?', 'Así', 26, 11, 2023),
(57, 11, 'Prueba 1', 'Plat?', 'ton', 26, 11, 2023),
(58, 8, 'Kanji', '質問', 'しつもん (Pregunta)', 26, 11, 2023),
(59, 8, 'Kanji', '理由', 'りゆう　(Motivo)', 26, 11, 2023),
(60, 8, 'Kanji', '楽', 'たの', 26, 11, 2023),
(61, 8, 'Kanji', '薬', 'くすり (Medicina)', 26, 11, 2023),
(62, 8, 'Kanji', '理解', 'りかい (Comprensión)', 26, 11, 2023),
(63, 8, 'Kanji', '説明', 'せつめい (Explicación)', 26, 11, 2023),
(67, 11, ' teoría de la computación', '¿Qué estudia la teoría de la computación?', ' las propiedades generales del cómputo, ya sea natural, artificial, o imaginario.', 0, 0, 0),
(73, 11, 'MATEMÁTICAS', 'que es', 'como ', 0, 0, 0),
(74, 11, 'MATEMÁTICAS', 'que es', 'como ', 0, 0, 0),
(83, 11, 'Ingeniería de Software I', '¿Qué es el software?', '“Conjunto de los programas de cómputo, procedimientos, reglas, documentación y datos asociados que forman parte de las operaciones de un sistema de computación”', 26, 11, 2023),
(85, 11, 'Ingeniería de Software I', '¿Qué es la Gestión de proyectos?', 'La gestión de proyectos según PMI (2013), es la aplicación de conocimientos, habilidades, herramientas y técnicas a las actividades del proyecto con el fin de satisfacer sus necesidades', 26, 11, 2023);

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
(2, 15, 0, 70, 4.5),
(3, 15, 0, 70, 4.3),
(4, 15, 1, 30, 3),
(5, 15, 1, 30, 2),
(10, 8, 0, 50, 5),
(11, 8, 1, 50, 3),
(15, 16, 0, 50, 3),
(16, 16, 1, 50, 3),
(18, 11, 0, 50, 4.5),
(19, 11, 1, 50, 3.4),
(20, 11, 1, 50, 3.4);

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
(16, 15, 'Clase de Ingesoft', 7, 8, '1'),
(22, 11, 'Sistemas operativos', 7, 9, '3'),
(27, 16, 'Arquitectura de computadores', 11, 13, '1'),
(28, 16, 'Arquitectura de computadores', 11, 13, '3'),
(29, 16, 'Arquitectura de computadores', 11, 13, '3'),
(30, 16, 'Gerencia y Gestion', 7, 9, '2'),
(31, 16, 'Pensamiento Sistemico', 18, 20, '1'),
(32, 16, 'Pensamiento Sistemico', 18, 20, '3'),
(33, 16, 'Gerencia y Gestion', 7, 9, '4'),
(36, 11, 'Gerencia y gestión de Proyectos', 7, 9, '1'),
(38, 11, 'Clase de SO', 18, 20, '4'),
(39, 11, 'Ingeniería de Software I', 8, 9, '2');

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
(2, 'usuario1@example.com', 'AU3VLgrY6gClLX4RSu0AMlOMNM1bZEKz', '2023-10-26 20:50:41', '2023-10-27 20:50:41'),
(3, 'andersondavid000.admc@gmail.com', '6WtGVKCZXvLjEfVLvpRBvRHzyStYgSTy', '2023-11-07 19:53:26', '2023-11-08 19:53:26'),
(4, 'andersondavid000.admc@gmail.com', 'Tqabipz3zRoB0dBhKF0Do9gmQ6EyBMqY', '2023-11-07 19:53:59', '2023-11-08 19:53:59'),
(5, 'dieramirezma@unal.edu.co', 'UgLiU6sVDfUzGqvvbKdiLNIXbv6FrMQA', '2023-11-07 20:37:39', '2023-11-08 20:37:39'),
(6, 'jruac@unal.edu.co', 'jjJIP4nVUB0cp9QqJFIxGsrD9sr7JYQw', '2023-11-27 19:22:33', '2023-11-28 19:22:33');

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
(13, 8, 'Recordatorio 5', 2023, 11, 5, 18, 0),
(17, 11, 'TESTT', 2023, 11, 18, 19, 34),
(20, 11, 'Trabajo', 2023, 11, 19, 17, 42),
(23, 11, 'Prueba v1', 2023, 11, 20, 16, 37),
(25, 11, 'Testing', 2023, 11, 21, 22, 36),
(33, 11, 'Prueba v1', 2023, 11, 21, 22, 11),
(35, 11, 'Daily', 2023, 11, 22, 20, 30),
(36, 11, 'REVIEW', 2023, 11, 23, 8, 46),
(37, 16, 'Estudiar mañana', 2023, 11, 29, 15, 17),
(39, 11, 'Prueba', 2023, 11, 26, 19, 54),
(40, 11, 'Prueba 2', 2023, 11, 27, 18, 9);

-- --------------------------------------------------------

--
-- Table structure for table `Registro`
--

CREATE TABLE `Registro` (
  `action` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Traza`
--

CREATE TABLE `Traza` (
  `idTraza` int NOT NULL,
  `id_Usuario` int DEFAULT NULL,
  `Nombre` varchar(255) DEFAULT NULL,
  `Descripcion` varchar(255) DEFAULT NULL,
  `Hora` varchar(45) DEFAULT NULL,
  `Servicio` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Traza`
--

INSERT INTO `Traza` (`idTraza`, `id_Usuario`, `Nombre`, `Descripcion`, `Hora`, `Servicio`) VALUES
(1, 11, NULL, 'El usuario ha iniciado sesión', '2023-11-16 21:59:07', NULL),
(2, 11, 'Usuario1', 'El usuario ha iniciado sesión', '2023-11-16 22:03:35', NULL),
(3, 16, 'John', 'El usuario ha iniciado sesión', '2023-11-16 22:10:21', NULL),
(4, 12, 'Usuario2', 'El usuario ha iniciado sesión', '2023-11-16 22:12:20', NULL),
(5, 16, 'John', 'Ha iniciado sesión', '2023-11-16 22:17:34', NULL),
(6, 11, 'Usuario1', 'El usuario ha iniciado sesión', '2023-11-17 17:06:41', NULL),
(7, 11, 'Usuario1', 'El usuario ha iniciado sesión', '2023-11-17 18:13:18', NULL),
(8, 11, 'Usuario1', 'El usuario ha iniciado sesión', '2023-11-17 20:23:50', NULL),
(9, 11, 'Usuario1', 'El usuario ha iniciado sesión', '2023-11-17 20:35:08', NULL),
(10, 11, 'Usuario1', 'El usuario ha iniciado sesión', '2023-11-17 20:36:03', NULL),
(11, 11, 'Usuario1', 'El usuario ha iniciado sesión', '2023-11-17 20:36:58', NULL),
(12, 15, 'Diego Ramirez', 'El usuario ha iniciado sesión', '2023-11-17 21:14:20', NULL),
(13, 11, 'Usuario1', 'El usuario ha iniciado sesión', '2023-11-17 21:17:49', NULL),
(14, 11, 'Usuario1', 'El usuario ha iniciado sesión', '2023-11-17 21:17:51', NULL),
(15, 11, 'Usuario1', 'El usuario ha iniciado sesión', '2023-11-17 21:33:52', NULL),
(16, 11, 'Usuario1', 'El usuario ha iniciado sesión', '2023-11-18 07:52:02', NULL),
(17, 11, 'Usuario1', 'El usuario ha iniciado sesión', '2023-11-18 08:40:32', NULL),
(18, 11, 'Usuario1', 'El usuario ha iniciado sesión', '2023-11-18 08:42:52', NULL),
(19, 11, 'Usuario1', 'El usuario ha iniciado sesión', '2023-11-18 08:44:15', NULL),
(20, 11, 'Usuario1', 'El usuario ha iniciado sesión', '2023-11-18 08:45:19', NULL),
(21, 11, 'Usuario1', 'El usuario ha iniciado sesión', '2023-11-18 08:45:26', NULL),
(22, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 09:16:06', NULL),
(23, 12, 'Usuario2', 'Ha iniciado sesión', '2023-11-18 11:20:36', NULL),
(24, 13, 'Usuario3', 'Ha iniciado sesión', '2023-11-18 11:20:55', NULL),
(25, 12, 'Usuario2', 'Ha iniciado sesión', '2023-11-18 11:21:09', NULL),
(26, 12, 'Usuario2', 'Ha iniciado sesión', '2023-11-18 11:21:10', NULL),
(27, 12, 'Usuario2', 'Ha iniciado sesión', '2023-11-18 11:21:12', NULL),
(28, 12, 'Usuario2', 'Ha iniciado sesión', '2023-11-18 11:21:12', NULL),
(29, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 11:21:14', NULL),
(30, 13, 'Usuario3', 'Ha iniciado sesión', '2023-11-18 11:21:22', NULL),
(31, 16, 'John', 'Ha iniciado sesión', '2023-11-18 11:21:23', NULL),
(32, 12, 'Usuario2', 'Ha iniciado sesión', '2023-11-18 11:21:32', NULL),
(33, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:29:35', NULL),
(34, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:40:01', NULL),
(35, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:40:04', NULL),
(36, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:40:52', NULL),
(37, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:41:10', NULL),
(38, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:43:32', NULL),
(39, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:43:38', NULL),
(40, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:46:46', NULL),
(41, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:47:25', NULL),
(42, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:47:30', NULL),
(43, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:47:40', NULL),
(44, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:50:21', NULL),
(45, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:50:40', NULL),
(46, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:51:09', NULL),
(47, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:51:43', NULL),
(48, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:52:04', NULL),
(49, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:53:16', NULL),
(50, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:54:20', NULL),
(51, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:54:29', NULL),
(52, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:55:32', NULL),
(53, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:55:54', NULL),
(54, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:57:47', NULL),
(55, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 12:58:05', NULL),
(56, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 13:09:23', NULL),
(57, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 13:12:14', NULL),
(58, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 13:13:31', NULL),
(59, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 13:14:27', NULL),
(60, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 13:17:10', NULL),
(61, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 13:19:31', NULL),
(62, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 13:21:07', NULL),
(63, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 13:22:05', NULL),
(64, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 13:24:01', NULL),
(65, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 16:10:09', NULL),
(66, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-18 16:28:40', NULL),
(67, 11, 'Usuario1', 'Ha creado el evento Sistemas operativos', '2023-11-18 16:58:44', NULL),
(68, 11, 'Usuario1', 'Ha creado el evento Sistemas operativos', '2023-11-18 16:59:14', NULL),
(69, 11, 'Usuario1', 'Ha creado el evento Pensamiento Sistémico', '2023-11-18 17:00:33', NULL),
(70, 11, 'Usuario1', 'Ha creado el evento Pensamiento Sistémico', '2023-11-18 18:00:41', 'Horario'),
(72, 11, 'Usuario1', 'Ha eliminado el evento Pensamiento Sistémico', '2023-11-18 18:03:26', 'Horario'),
(73, 11, 'Usuario1', 'Ha creado el evento Ingeniería de Software I', '2023-11-18 18:03:40', 'Horario'),
(74, 11, 'Usuario1', 'Ha eliminado el evento Ingeniería de Software I', '2023-11-18 18:04:15', 'Horario'),
(75, 11, 'Usuario1', 'Ha creado el evento Clase de SO', '2023-11-18 18:05:44', 'Horario'),
(76, 11, 'Usuario1', 'El usuario ha iniciado sesión', '2023-11-18 19:26:32', NULL),
(77, 15, 'Diego Ramirez', 'El usuario ha iniciado sesión', '2023-11-18 20:07:25', NULL),
(78, 16, 'John', 'Ha iniciado sesión', '2023-11-18 21:49:41', 'Login'),
(79, 16, 'John', 'Se ha Registrado', '2023-11-18 21:59:54', 'Login'),
(80, 19, 'ejemplotraza', 'Se ha Registrado', '2023-11-18 22:01:38', 'Login'),
(81, 16, 'John', 'Ha iniciado sesión', '2023-11-18 22:19:02', 'Login'),
(82, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-19 08:09:35', 'Login'),
(83, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-19 08:18:04', 'Login'),
(84, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-19 08:19:29', 'Login'),
(85, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-19 14:54:52', 'Login'),
(86, 11, 'Usuario1', 'Ha creado el evento Gerencia y gestión de Proyectos', '2023-11-19 15:01:15', 'Horario'),
(87, 11, 'Usuario1', 'Ha eliminado el evento Gerencia y gestión de Proyectos', '2023-11-19 15:01:30', 'Horario'),
(88, 11, 'Usuario1', 'Ha creado el evento Gerencia y gestión de Proyectos', '2023-11-19 15:01:43', 'Horario'),
(89, 11, 'Usuario1', 'Ha creado el evento Clase de SO', '2023-11-19 15:02:12', 'Horario'),
(90, 11, 'Usuario1', 'Ha editado el evento Clase de SO', '2023-11-19 15:04:49', 'Horario'),
(91, 11, 'Usuario1', 'Ha creado el evento Ingeniería de Software I', '2023-11-19 15:05:39', 'Horario'),
(92, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-19 15:27:55', 'Login'),
(93, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-19 15:34:34', 'Cuaderno'),
(94, 11, 'Usuario1', 'Ha editado el cuaderno Sistemas Operativos', '2023-11-19 15:35:38', 'Cuaderno'),
(95, 11, 'Usuario1', 'Ha editado el cuaderno Sistemas Operativos', '2023-11-19 15:36:37', 'Cuaderno'),
(96, 11, 'Usuario1', 'Ha creado el cuaderno Gerencia y gestión de proyectos', '2023-11-19 15:37:22', 'Cuaderno'),
(97, 11, 'Usuario1', 'Ha editado el cuaderno Gerencia y gestión de proyectos', '2023-11-19 15:37:33', 'Cuaderno'),
(98, 11, 'Usuario1', 'Ha editado el cuaderno Gerencia y gestión de proyectos', '2023-11-19 15:38:25', 'Cuaderno'),
(99, 11, 'Usuario1', 'Ha cambiado de cuaderno', '2023-11-19 15:38:43', 'Cuaderno'),
(100, 11, 'Usuario1', 'Ha eliminado el cuaderno Gerencia y gestión de proyectos', '2023-11-19 15:38:48', 'Cuaderno'),
(101, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-19 15:39:50', 'Cuaderno'),
(102, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-19 19:20:05', 'Login'),
(103, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-20 07:36:10', 'Login'),
(104, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-20 07:59:42', 'Login'),
(105, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-20 10:05:40', 'Login'),
(106, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-20 10:19:13', 'Login'),
(107, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-20 10:21:34', 'Login'),
(108, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-20 12:32:19', 'Login'),
(109, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-20 19:13:42', 'Login'),
(110, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-20 19:21:15', 'Login'),
(111, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-20 20:32:51', 'Login'),
(112, 8, 'Tili', 'Ha iniciado sesión', '2023-11-20 20:37:10', 'Login'),
(113, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-21 10:26:42', 'Login'),
(114, 8, 'Tili', 'Ha iniciado sesión', '2023-11-21 12:39:45', 'Login'),
(115, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-21 18:49:34', 'Login'),
(116, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-21 21:10:42', 'Login'),
(117, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-22 07:56:03', 'Login'),
(118, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-22 07:57:11', 'Login'),
(119, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-22 07:58:42', 'Login'),
(120, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-22 08:22:09', 'Login'),
(121, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-22 08:23:10', 'Login'),
(122, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-22 08:27:00', 'Login'),
(123, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-22 08:35:36', 'Login'),
(124, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-22 09:45:59', 'Login'),
(125, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-22 09:46:54', 'Login'),
(126, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-22 09:51:32', 'Login'),
(127, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-22 09:52:19', 'Login'),
(128, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-22 09:52:59', 'Login'),
(129, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-22 09:57:11', 'Login'),
(130, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-22 09:57:30', 'Login'),
(131, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-22 10:11:17', 'Login'),
(132, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-22 15:04:58', 'Login'),
(133, 8, 'Tili', 'Ha iniciado sesión', '2023-11-22 17:54:23', 'Login'),
(134, 8, 'Tili', 'Ha iniciado sesión', '2023-11-22 17:54:39', 'Login'),
(135, 8, 'Tili', 'Ha creado el mazo Prueba', '2023-11-22 18:42:54', 'Tarjetas Didácticas'),
(136, 8, 'Tili', 'Ha editado una tarjeta del mazo Prueba', '2023-11-22 18:43:44', 'Tarjetas Didácticas'),
(137, 8, 'Tili', 'Ha borrado una tarjeta del mazo Prueba', '2023-11-22 18:44:04', 'Tarjetas Didácticas'),
(138, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-22 21:41:34', 'Login'),
(139, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-23 07:55:58', 'Login'),
(140, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-23 09:13:14', 'Login'),
(141, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-23 09:18:49', 'Cuaderno'),
(142, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-23 09:19:48', 'Cuaderno'),
(143, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-23 09:20:48', 'Cuaderno'),
(144, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-23 09:21:48', 'Cuaderno'),
(145, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-23 09:22:58', 'Cuaderno'),
(146, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-23 09:23:59', 'Cuaderno'),
(147, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-23 09:24:58', 'Cuaderno'),
(148, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-23 09:25:58', 'Cuaderno'),
(149, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-23 09:26:58', 'Cuaderno'),
(150, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-23 09:27:59', 'Cuaderno'),
(151, 8, 'Tili', 'Ha iniciado sesión', '2023-11-23 14:45:55', 'Login'),
(152, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-23 17:15:59', 'Login'),
(153, 11, 'Usuario1', 'Ha creado el mazo Introducción a la teoría de la computación', '2023-11-23 17:49:43', 'Tarjetas Didácticas'),
(154, 11, 'Usuario1', 'Ha creado una tarjeta para el mazo Introducción a la teoría de la computación', '2023-11-23 17:51:18', 'Tarjetas Didácticas'),
(155, 11, 'Usuario1', 'Ha editado una tarjeta del mazo Introducción a la teoría de la computación', '2023-11-23 17:51:56', 'Tarjetas Didácticas'),
(156, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-23 18:53:49', 'Login'),
(157, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-23 18:59:36', 'Login'),
(158, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-23 19:00:42', 'Login'),
(159, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-23 19:09:45', 'Login'),
(160, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-23 19:44:32', 'Login'),
(161, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-23 19:45:48', 'Login'),
(162, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-23 20:53:59', 'Login'),
(163, 11, 'Usuario1', 'Ha borrado una tarjeta del mazo Introducción a la teoría de la computación', '2023-11-23 21:05:03', 'Tarjetas Didácticas'),
(164, 11, 'Usuario1', 'Ha borrado una tarjeta del mazo Mazo de prueba 1', '2023-11-23 21:05:15', 'Tarjetas Didácticas'),
(165, 11, 'Usuario1', 'Ha borrado una tarjeta del mazo Introducción a la teoría de la computación', '2023-11-23 21:05:29', 'Tarjetas Didácticas'),
(166, 11, 'Usuario1', 'Ha creado el mazo  teoría de la computación', '2023-11-23 23:42:58', 'Tarjetas Didácticas'),
(167, 11, 'Usuario1', 'Ha creado una tarjeta para el mazo teoría de la computación', '2023-11-23 23:44:17', 'Tarjetas Didácticas'),
(168, 11, 'Usuario1', 'Ha borrado una tarjeta del mazo teoría de la computación', '2023-11-23 23:45:01', 'Tarjetas Didácticas'),
(169, 11, 'Usuario1', 'Ha creado el mazo Computación paralela', '2023-11-23 23:46:16', 'Tarjetas Didácticas'),
(170, 11, 'Usuario1', 'Ha creado una tarjeta para el mazo Computación paralela', '2023-11-23 23:47:01', 'Tarjetas Didácticas'),
(171, 11, 'Usuario1', 'Ha borrado una tarjeta del mazo Computación paralela', '2023-11-23 23:47:46', 'Tarjetas Didácticas'),
(172, 11, 'Usuario1', 'Ha borrado una tarjeta del mazo Computación paralela', '2023-11-23 23:48:00', 'Tarjetas Didácticas'),
(173, 11, 'Usuario1', 'Ha creado el mazo Redes', '2023-11-23 23:51:08', 'Tarjetas Didácticas'),
(174, 11, 'Usuario1', 'Ha borrado una tarjeta del mazo Redes', '2023-11-23 23:51:24', 'Tarjetas Didácticas'),
(175, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 00:34:53', 'Login'),
(176, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-24 00:50:16', 'Cuaderno'),
(177, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-24 00:51:15', 'Cuaderno'),
(178, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-24 00:52:14', 'Cuaderno'),
(179, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-24 00:53:14', 'Cuaderno'),
(180, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-24 00:54:21', 'Cuaderno'),
(181, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-24 01:17:07', 'Cuaderno'),
(182, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-24 01:18:06', 'Cuaderno'),
(183, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-24 01:19:07', 'Cuaderno'),
(184, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-24 01:20:06', 'Cuaderno'),
(185, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-24 01:22:00', 'Cuaderno'),
(186, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-24 01:22:53', 'Cuaderno'),
(187, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-24 01:23:07', 'Cuaderno'),
(188, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-24 01:24:42', 'Cuaderno'),
(189, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-24 01:25:06', 'Cuaderno'),
(190, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 16:58:36', 'Login'),
(191, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 16:58:39', 'Login'),
(192, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 16:58:40', 'Login'),
(193, 11, 'Usuario1', 'Ha creado el mazo jiji', '2023-11-24 17:01:48', 'Tarjetas Didácticas'),
(194, 11, 'Usuario1', 'Ha borrado una tarjeta del mazo jiji', '2023-11-24 17:03:53', 'Tarjetas Didácticas'),
(195, 11, 'Usuario1', 'Ha creado el mazo MATEMÁTICAS', '2023-11-24 17:23:39', 'Tarjetas Didácticas'),
(196, 11, 'Usuario1', 'Ha creado el mazo MATEMÁTICAS', '2023-11-24 17:23:40', 'Tarjetas Didácticas'),
(197, 11, 'Usuario1', 'Ha creado el mazo : Ingeniería de Software I', '2023-11-24 17:30:43', 'Tarjetas Didácticas'),
(198, 11, 'Usuario1', 'Ha creado el mazo Gerencia y Gestión', '2023-11-24 17:33:19', 'Tarjetas Didácticas'),
(199, 11, 'Usuario1', 'Ha borrado una tarjeta del mazo Gerencia y Gestión', '2023-11-24 17:33:28', 'Tarjetas Didácticas'),
(200, 11, 'Usuario1', 'Ha borrado una tarjeta del mazo : Ingeniería de Software I', '2023-11-24 17:35:24', 'Tarjetas Didácticas'),
(201, 11, 'Usuario1', 'Ha creado el mazo Ingeniería de Software I', '2023-11-24 17:37:32', 'Tarjetas Didácticas'),
(202, 11, 'Usuario1', 'Ha borrado una tarjeta del mazo Ingeniería de Software I', '2023-11-24 17:44:49', 'Tarjetas Didácticas'),
(203, 11, 'Usuario1', 'Ha creado el mazo Ingeniería de Software I', '2023-11-24 18:10:32', 'Tarjetas Didácticas'),
(204, 11, 'Usuario1', 'Ha borrado una tarjeta del mazo Ingeniería de Software I', '2023-11-24 18:11:11', 'Tarjetas Didácticas'),
(205, 11, 'Usuario1', 'Ha creado el mazo Ingeniería de Software I', '2023-11-24 18:19:18', 'Tarjetas Didácticas'),
(206, 11, 'Usuario1', 'Ha borrado una tarjeta del mazo Ingeniería de Software I', '2023-11-24 18:21:16', 'Tarjetas Didácticas'),
(207, 11, 'Usuario1', 'Ha creado el mazo Ingeniería de Software I', '2023-11-24 18:23:16', 'Tarjetas Didácticas'),
(208, 11, 'Usuario1', 'Ha borrado una tarjeta del mazo Ingeniería de Software I', '2023-11-24 18:23:58', 'Tarjetas Didácticas'),
(209, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 18:24:07', 'Login'),
(210, 11, 'Usuario1', 'Ha creado el mazo Ingeniería de Software I', '2023-11-24 18:25:53', 'Tarjetas Didácticas'),
(211, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 18:31:14', 'Login'),
(212, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 18:33:18', 'Login'),
(213, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 18:34:29', 'Login'),
(214, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 18:35:42', 'Login'),
(215, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 18:36:55', 'Login'),
(216, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 18:38:05', 'Login'),
(217, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 18:39:30', 'Login'),
(218, 11, 'Usuario1', 'Ha borrado una tarjeta del mazo Ingeniería de Software I', '2023-11-24 18:40:59', 'Tarjetas Didácticas'),
(219, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 18:41:38', 'Login'),
(220, 11, 'Usuario1', 'Ha creado el mazo Ingeniería de Software I', '2023-11-24 18:42:55', 'Tarjetas Didácticas'),
(221, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 18:42:28', 'Login'),
(222, 11, 'Usuario1', 'Ha borrado una tarjeta del mazo Ingeniería de Software I', '2023-11-24 18:44:08', 'Tarjetas Didácticas'),
(223, 11, 'Usuario1', 'Ha creado el mazo Ingeniería de Software I', '2023-11-24 18:45:27', 'Tarjetas Didácticas'),
(224, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 18:44:54', 'Login'),
(225, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 18:46:08', 'Login'),
(226, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 19:08:44', 'Login'),
(227, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 19:12:33', 'Login'),
(228, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 19:14:52', 'Login'),
(229, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 19:31:23', 'Login'),
(230, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 19:41:40', 'Login'),
(231, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 19:47:12', 'Login'),
(232, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 19:47:54', 'Login'),
(233, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 19:50:45', 'Login'),
(234, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 19:51:13', 'Login'),
(235, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 19:51:50', 'Login'),
(236, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 19:52:22', 'Login'),
(237, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 21:34:11', 'Login'),
(238, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-24 23:36:48', 'Login'),
(239, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-24 23:54:26', 'Cuaderno'),
(240, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-25 00:25:44', 'Cuaderno'),
(241, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-25 00:35:29', 'Cuaderno'),
(242, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-25 00:37:41', 'Cuaderno'),
(243, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-25 00:38:40', 'Cuaderno'),
(244, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-25 00:39:40', 'Cuaderno'),
(245, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-25 00:40:40', 'Cuaderno'),
(246, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-25 00:41:40', 'Cuaderno'),
(247, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-25 00:42:40', 'Cuaderno'),
(248, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-25 11:30:35', 'Login'),
(249, 11, 'Usuario1', 'Ha creado una tarjeta para el mazo Ingeniería de Software I', '2023-11-25 11:52:36', 'Tarjetas Didácticas'),
(250, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-25 19:14:46', 'Login'),
(251, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-25 19:15:04', 'Login'),
(252, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-25 19:31:32', 'Login'),
(253, 11, 'Usuario1', 'Ha editado una tarjeta del mazo Ingeniería de Software I', '2023-11-25 19:35:40', 'Tarjetas Didácticas'),
(254, 11, 'Usuario1', 'Ha editado una tarjeta del mazo Ingeniería de Software I', '2023-11-25 19:48:03', 'Tarjetas Didácticas'),
(255, 8, 'Tili', 'Ha iniciado sesión', '2023-11-25 20:33:37', 'Login'),
(256, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 07:49:26', 'Login'),
(257, 11, 'Usuario1', 'Ha editado una tarjeta del mazo Ingeniería de Software I', '2023-11-26 07:54:05', 'Tarjetas Didácticas'),
(258, 11, 'Usuario1', 'Ha editado una tarjeta del mazo Ingeniería de Software I', '2023-11-26 07:57:11', 'Tarjetas Didácticas'),
(259, 11, 'Usuario1', 'Ha editado una tarjeta del mazo Ingeniería de Software I', '2023-11-26 08:00:13', 'Tarjetas Didácticas'),
(260, 11, 'Usuario1', 'Ha borrado una tarjeta del mazo Ingeniería de Software I', '2023-11-26 08:01:03', 'Tarjetas Didácticas'),
(261, 11, 'Usuario1', 'Ha creado una tarjeta para el mazo Ingeniería de Software I', '2023-11-26 09:27:38', 'Tarjetas Didácticas'),
(262, 16, 'John', 'Ha iniciado sesión', '2023-11-26 11:40:40', 'Login'),
(263, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 11:42:27', 'Login'),
(264, 16, 'John', 'Ha iniciado sesión', '2023-11-26 11:50:31', 'Login'),
(265, 16, 'John', 'Ha iniciado sesión', '2023-11-26 11:52:21', 'Login'),
(266, 16, 'John', 'Ha iniciado sesión', '2023-11-26 11:52:29', 'Login'),
(267, 16, 'John', 'Ha iniciado sesión', '2023-11-26 11:53:35', 'Login'),
(268, 16, 'John', 'Ha iniciado sesión', '2023-11-26 11:53:58', 'Login'),
(269, 16, 'John', 'Ha iniciado sesión', '2023-11-26 11:54:12', 'Login'),
(270, 16, 'John', 'Ha iniciado sesión', '2023-11-26 11:55:35', 'Login'),
(271, 16, 'John', 'Ha iniciado sesión', '2023-11-26 11:55:41', 'Login'),
(272, 16, 'John', 'Ha iniciado sesión', '2023-11-26 11:59:00', 'Login'),
(273, 16, 'John', 'Ha iniciado sesión', '2023-11-26 12:01:45', 'Login'),
(274, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 12:02:53', 'Login'),
(275, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 12:03:24', 'Login'),
(276, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 12:04:52', 'Login'),
(277, 16, 'John', 'Ha iniciado sesión', '2023-11-26 12:10:06', 'Login'),
(278, 16, 'John', 'Ha iniciado sesión', '2023-11-26 12:10:49', 'Login'),
(279, 16, 'John', 'Ha iniciado sesión', '2023-11-26 12:11:23', 'Login'),
(280, 16, 'John', 'Ha iniciado sesión', '2023-11-26 12:16:44', 'Login'),
(281, 16, 'John', 'Ha iniciado sesión', '2023-11-26 12:18:51', 'Login'),
(282, 16, 'John', 'Ha editado un recordatorio', '2023-11-26 12:19:01', 'Login'),
(283, 16, 'John', 'Ha iniciado sesión', '2023-11-26 12:22:59', 'Login'),
(284, 16, 'John', 'Ha añadido un recordatorio', '2023-11-26 12:23:13', 'Recordatorio'),
(285, 16, 'John', 'Ha editado un recordatorio', '2023-11-26 12:23:43', 'Recordatorio'),
(286, 16, 'John', 'Ha Eliminado un recordatorio', '2023-11-26 12:23:59', 'Recordatorio'),
(287, 16, 'John', 'Ha iniciado sesión', '2023-11-26 12:29:54', 'Login'),
(288, 16, 'John', 'Ha iniciado sesión', '2023-11-26 12:32:03', 'Login'),
(289, 16, 'John', 'Ha actualizado notas', '2023-11-26 12:32:32', 'Calculadora'),
(290, 16, 'John', 'Ha iniciado sesión', '2023-11-26 12:37:37', 'Login'),
(291, 16, 'John', 'Ha actualizado notas', '2023-11-26 12:38:40', 'Calculadora'),
(292, 16, 'John', 'Ha actualizado notas', '2023-11-26 12:38:59', 'Calculadora'),
(293, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 17:07:53', 'Login'),
(294, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 17:09:20', 'Login'),
(295, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 17:10:44', 'Login'),
(296, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 17:39:09', 'Login'),
(297, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-26 17:40:19', 'Cuaderno'),
(298, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-26 17:41:19', 'Cuaderno'),
(299, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-26 17:42:19', 'Cuaderno'),
(300, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-26 17:43:19', 'Cuaderno'),
(301, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-26 17:44:18', 'Cuaderno'),
(302, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-26 17:45:19', 'Cuaderno'),
(303, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-26 17:46:43', 'Cuaderno'),
(304, 11, 'Usuario1', 'Ha editado el cuaderno Ingeniería de software', '2023-11-26 17:47:43', 'Cuaderno'),
(305, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 22:34:42', 'Login'),
(306, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 22:35:51', 'Login'),
(307, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 22:39:34', 'Login'),
(308, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 22:40:09', 'Login'),
(309, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 22:40:41', 'Login'),
(310, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 22:42:48', 'Login'),
(311, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 22:43:09', 'Login'),
(312, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 22:43:59', 'Login'),
(313, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 22:44:41', 'Login'),
(314, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 22:45:20', 'Login'),
(315, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 22:46:16', 'Login'),
(316, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 22:46:30', 'Login'),
(317, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 22:47:34', 'Login'),
(318, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 22:49:07', 'Login'),
(319, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-26 22:49:48', 'Login'),
(320, 8, 'Tili', 'Ha iniciado sesión', '2023-11-26 23:28:55', 'Login'),
(321, 16, 'John', 'Ha iniciado sesión', '2023-11-27 19:15:27', 'Login'),
(322, 16, 'John', 'Ha cambiado de cuaderno', '2023-11-27 19:16:13', 'Cuaderno'),
(323, 16, 'John', 'Ha iniciado sesión', '2023-11-27 19:23:29', 'Login'),
(324, 11, 'Usuario1', 'Ha iniciado sesión', '2023-11-27 19:25:19', 'Login'),
(325, 23, 'uribe2', 'Ha iniciado sesión', '2023-11-27 19:40:33', 'Login'),
(326, 24, 'user', 'Se ha Registrado Exitosamente', '2023-11-27 19:43:00', 'Login'),
(327, 24, 'user', 'Ha iniciado sesión', '2023-11-27 19:43:20', 'Login');

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
(15, 'Diego Ramirez', 'dieramirezma@unal.edu.co', 'scrypt:32768:8:1$HEz8jTyk4zfdcWE4$a3c7fdc71562a0ee8867c2aa09edd8aa244d16670f999b493739d64feca16aecd3950819c1a864fb01791729a2dc1d69338e5dad7b1717309e518a3f01f89ad0', NULL),
(16, 'John', 'jruac@unal.edu.co', 'scrypt:32768:8:1$VjNPRtM86vlkkbax$0667132b6c570937efdf31765d79e0d15528839ce8e0f2a903071f5f7f7acd5d585cc13a15ba46b5c5209da931a71336c346cc4c91161545331e79bb834d7519', NULL),
(17, 'Anderson David Morales Chila', 'amoralesch@unal.edu.co', 'scrypt:32768:8:1$4C1fGh9mrSPL7Sb2$7117c1cc456ee472a6cc544786785b916763633c3b658a2db4e6b0c4d34730d8e90664fcfe463d7b7628e2462c4bde5872adeb25176257ad4a9f75674b8977e8', NULL),
(18, 'Anderson Morales', 'a@example.com', 'scrypt:32768:8:1$q06xk85BCLkdF1sj$f24819211d64ea444fce049db4f87153813224a1853b8575f785ea4d244674653d89eb33788430155f0249e18bd73c0345475068722080298c050694c60947da', NULL),
(19, 'Ejemplo Traza', 'usuario5@example.com', 'scrypt:32768:8:1$4xTDnqxaxWt4v6l5$745e1735c60830a96018f11560bbfd15c34d930385acc490724415be985ab685ba7a53ed27aadcb44d1bfdf259fffd825f8ae9523a31661e6ea4a369d5016a4e', NULL),
(20, 'ejemplotraza', 'usuario6@example.com', 'scrypt:32768:8:1$dzptthQo1r2TDvy3$1e4866af71dd13d1e2b65e923da83d3263bcd8f1c468928a8f3e948064ad4c7fb1ced2d07f6ef73085c5cd9cad9d2d9f6a1efa9e5e984dcb2011c3172947ef5d', NULL),
(21, 'Uribe', 'uribe@xn--miseor-zwa.com', 'scrypt:32768:8:1$LBfCVkl3gBXZJIkX$53ebcc301b8194bf25b1a36a1b6d374b53783b453ecbf18a78d41d1730bd374b416bf648e48a8c268421833af5a264aff436fff9e7b3b53df432ecb0475f4bf3', NULL),
(22, 'Uribe', 'uribe@example.com', 'scrypt:32768:8:1$EG3pqlT5izI6jX8k$e8507d2d41a31d87c6e3f078020e739a3ec38648471711ae5bca6dd87f7f7d45977da1ed7d0b0c95e8ae40500c80b886cf66908c9efd4f490ff7ac0799804696', NULL),
(23, 'uribe2', 'uribe@example1.com', 'scrypt:32768:8:1$YorU59TlPhO7OqoR$c0f6dd5c4542cbdc23c324032c3547313ebcbafc1055f7b566790526980786784792c29fabf9b4681097d2a308d226a7d7875db2a4d439e82460b286a78f7a03', NULL),
(24, 'user', 'ejemplo@gmail.com', 'scrypt:32768:8:1$9ysRMqnvn0CML1Ha$5498036f75d466cde9888162fd0c775bf03299d399d7c6d5c1183c755a74f8d1d10adfdb7d41c0b0b92974e91e558d2e08ff578471f37fa0710d389d5967aec6', NULL);

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
-- Indexes for table `flashcards`
--
ALTER TABLE `flashcards`
  ADD PRIMARY KEY (`idFlashcard`),
  ADD KEY `idUsuario_idx` (`id_Usuario`);

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
-- Indexes for table `Traza`
--
ALTER TABLE `Traza`
  ADD PRIMARY KEY (`idTraza`),
  ADD KEY `id_Usuario_idx` (`id_Usuario`);

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
  MODIFY `id_cuaderno` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- AUTO_INCREMENT for table `flashcards`
--
ALTER TABLE `flashcards`
  MODIFY `idFlashcard` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `grupoNotas`
--
ALTER TABLE `grupoNotas`
  MODIFY `idNota` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `horario`
--
ALTER TABLE `horario`
  MODIFY `idHorario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `recordatorios`
--
ALTER TABLE `recordatorios`
  MODIFY `idRecordatorio` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `Traza`
--
ALTER TABLE `Traza`
  MODIFY `idTraza` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=328;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cuaderno`
--
ALTER TABLE `cuaderno`
  ADD CONSTRAINT `idUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `flashcards`
--
ALTER TABLE `flashcards`
  ADD CONSTRAINT `id_Usuario` FOREIGN KEY (`id_Usuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

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

--
-- Constraints for table `Traza`
--
ALTER TABLE `Traza`
  ADD CONSTRAINT `idUsuariotraza` FOREIGN KEY (`id_Usuario`) REFERENCES `usuario` (`idUsuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
