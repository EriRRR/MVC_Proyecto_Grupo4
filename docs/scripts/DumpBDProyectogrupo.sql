CREATE DATABASE  IF NOT EXISTS `ecommerce` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ecommerce`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `bitacora`
--

DROP TABLE IF EXISTS `bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bitacora` (
  `bitacoracod` int NOT NULL AUTO_INCREMENT,
  `bitacorafch` datetime DEFAULT NULL,
  `bitprograma` varchar(255) DEFAULT NULL,
  `bitdescripcion` varchar(255) DEFAULT NULL,
  `bitobservacion` mediumtext,
  `bitTipo` char(3) DEFAULT NULL,
  `bitusuario` bigint DEFAULT NULL,
  PRIMARY KEY (`bitacoracod`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora`
--

LOCK TABLES `bitacora` WRITE;
/*!40000 ALTER TABLE `bitacora` DISABLE KEYS */;
/*!40000 ALTER TABLE `bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carretilla`
--

DROP TABLE IF EXISTS `carretilla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carretilla` (
  `usercod` bigint NOT NULL,
  `productId` int NOT NULL,
  `crrctd` int NOT NULL,
  `crrprc` decimal(12,2) NOT NULL,
  `crrfching` datetime NOT NULL,
  PRIMARY KEY (`usercod`,`productId`),
  KEY `productId_idx` (`productId`),
  CONSTRAINT `carretilla_prd_key` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`),
  CONSTRAINT `carretilla_user_key` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carretilla`
--

LOCK TABLES `carretilla` WRITE;
/*!40000 ALTER TABLE `carretilla` DISABLE KEYS */;
/*!40000 ALTER TABLE `carretilla` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carretillaanon`
--

DROP TABLE IF EXISTS `carretillaanon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carretillaanon` (
  `anoncod` varchar(128) NOT NULL,
  `productId` int NOT NULL,
  `crrctd` int NOT NULL,
  `crrprc` decimal(12,2) NOT NULL,
  `crrfching` datetime NOT NULL,
  PRIMARY KEY (`anoncod`,`productId`),
  KEY `productId_idx` (`productId`),
  CONSTRAINT `carretillaanon_prd_key` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carretillaanon`
--

LOCK TABLES `carretillaanon` WRITE;
/*!40000 ALTER TABLE `carretillaanon` DISABLE KEYS */;
INSERT INTO `carretillaanon` VALUES ('e3c9aa70b78bbdb3ca995e4282bb4106',3,1,15.00,'2025-07-27 13:37:15'),('e3c9aa70b78bbdb3ca995e4282bb4106',4,1,75.00,'2025-07-27 13:37:06');
/*!40000 ALTER TABLE `carretillaanon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `estado` enum('activo','inactivo') DEFAULT 'activo',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Lacteos','Lacteos de todo tipo san marqueños','activo','2025-07-14 18:23:27'),(2,'Pan','Panes de todo tipo','activo','2025-07-15 01:50:34'),(3,'Enlatados','Enlatados','activo','2025-07-15 02:25:44');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funciones`
--

DROP TABLE IF EXISTS `funciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funciones` (
  `fncod` varchar(255) NOT NULL,
  `fndsc` varchar(255) DEFAULT NULL,
  `fnest` char(3) DEFAULT NULL,
  `fntyp` char(3) DEFAULT NULL,
  PRIMARY KEY (`fncod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funciones`
--

LOCK TABLES `funciones` WRITE;
/*!40000 ALTER TABLE `funciones` DISABLE KEYS */;
INSERT INTO `funciones` VALUES ('Controllers\\Categorias\\Categorias','Controllers\\Categorias\\Categorias','ACT','CTR'),('Controllers\\Categorias\\Categorias\\delete','Controllers\\Categorias\\Categorias\\delete','ACT','FNC'),('Controllers\\Categorias\\Categorias\\new','Controllers\\Categorias\\Categorias\\new','ACT','FNC'),('Controllers\\Categorias\\Categorias\\update','Controllers\\Categorias\\Categorias\\update','ACT','FNC'),('Controllers\\Checkout\\Checkout','Controllers\\Checkout\\Checkout','ACT','CTR'),('Controllers\\Mnt\\Usuarios','Controllers\\Mnt\\Usuarios','ACT','CTR'),('Controllers\\Orders\\AdminOrders','Controllers\\Orders\\AdminOrders','ACT','CTR'),('Controllers\\Orders\\MyOrders','Controllers\\Orders\\MyOrders','ACT','CTR'),('Controllers\\Productos\\Catalogo','Controllers\\Productos\\Catalogo','ACT','CTR'),('Controllers\\Productos\\ProductoDetalle','Controllers\\Productos\\ProductoDetalle','ACT','CTR'),('Controllers\\Productos\\Productos','Controllers\\Productos\\Productos','ACT','CTR'),('Controllers\\Productos\\Productos\\delete','Controllers\\Productos\\Productos\\delete','ACT','FNC'),('Controllers\\Productos\\Productos\\new','Controllers\\Productos\\Productos\\new','ACT','FNC'),('Controllers\\Productos\\Productos\\update','Controllers\\Productos\\Productos\\update','ACT','FNC'),('Controllers\\Proveedores\\Proveedores','Controllers\\Proveedores\\Proveedores','ACT','CTR'),('Controllers\\Proveedores\\Proveedores\\delete','Controllers\\Proveedores\\Proveedores\\delete','ACT','FNC'),('Controllers\\Proveedores\\Proveedores\\new','Controllers\\Proveedores\\Proveedores\\new','ACT','FNC'),('Controllers\\Proveedores\\Proveedores\\update','Controllers\\Proveedores\\Proveedores\\update','ACT','FNC'),('Controllers\\Usuarios\\Usuarios','Controllers\\Usuarios\\Usuarios','ACT','CTR'),('Menu_Catalogo','Menu_Catalogo','ACT','MNU'),('Menu_Categorias','Menu_Categorias','ACT','MNU'),('Menu_HistorialGeneral','Menu_HistorialGeneral','ACT','MNU'),('Menu_MisCompras','Menu_MisCompras','ACT','MNU'),('Menu_PaymentCheckout','Menu_PaymentCheckout','ACT','MNU'),('Menu_Products','Menu_Products','ACT','MNU'),('Menu_Proveedores','Menu_Proveedores','ACT','MNU'),('Menu_SignIn','Menu_SignIn','ACT','MNU'),('Menu_SignUp','Menu_SignUp','ACT','MNU'),('Menu_Usuarios','Menu_Usuarios','ACT','MNU');
/*!40000 ALTER TABLE `funciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funciones_roles`
--

DROP TABLE IF EXISTS `funciones_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funciones_roles` (
  `rolescod` varchar(128) NOT NULL,
  `fncod` varchar(255) NOT NULL,
  `fnrolest` char(3) DEFAULT NULL,
  `fnexp` datetime DEFAULT NULL,
  PRIMARY KEY (`rolescod`,`fncod`),
  KEY `rol_funcion_key_idx` (`fncod`),
  CONSTRAINT `funcion_rol_key` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`),
  CONSTRAINT `rol_funcion_key` FOREIGN KEY (`fncod`) REFERENCES `funciones` (`fncod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funciones_roles`
--

LOCK TABLES `funciones_roles` WRITE;
/*!40000 ALTER TABLE `funciones_roles` DISABLE KEYS */;
INSERT INTO `funciones_roles` VALUES ('Admin','Controllers\\Categorias\\Categorias','ACT','2026-12-31 00:00:00'),('Admin','Controllers\\Categorias\\Categorias\\delete','ACT','2026-12-31 00:00:00'),('Admin','Controllers\\Categorias\\Categorias\\new','ACT','2026-12-31 00:00:00'),('Admin','Controllers\\Categorias\\Categorias\\update','ACT','2026-12-31 00:00:00'),('Admin','Controllers\\Productos\\Productos','ACT','2026-12-31 00:00:00'),('Admin','Controllers\\Productos\\Productos\\delete','ACT','2026-12-31 00:00:00'),('Admin','Controllers\\Productos\\Productos\\new','ACT','2026-12-31 00:00:00'),('Admin','Controllers\\Productos\\Productos\\update','ACT','2026-12-31 00:00:00'),('Admin','Controllers\\Proveedores\\Proveedores','ACT','2026-12-31 00:00:00'),('Admin','Controllers\\Proveedores\\Proveedores\\delete','ACT','2026-12-31 00:00:00'),('Admin','Controllers\\Proveedores\\Proveedores\\new','ACT','2026-12-31 00:00:00'),('Admin','Controllers\\Proveedores\\Proveedores\\update','ACT','2026-12-31 00:00:00'),('Admin','Menu_Categorias','ACT','2026-12-31 00:00:00'),('Admin','Menu_HistorialGeneral','ACT','2026-12-31 00:00:00'),('Admin','Menu_MisCompras','ACT','2026-12-31 00:00:00'),('Admin','Menu_Products','ACT','2026-12-31 00:00:00'),('Admin','Menu_Proveedores','ACT','2026-12-31 00:00:00'),('Auditor','Controllers\\Categorias\\Categorias','ACT','2026-12-31 00:00:00'),('Auditor','Controllers\\Orders\\AdminOrders','ACT','2026-12-31 00:00:00'),('Auditor','Controllers\\Productos\\Productos','ACT','2026-12-31 00:00:00'),('Auditor','Controllers\\Proveedores\\Proveedores','ACT','2026-12-31 00:00:00'),('Auditor','Controllers\\Usuarios\\Usuarios','ACT','2026-12-31 00:00:00'),('Auditor','Menu_HistorialGeneral','ACT','2026-12-31 00:00:00'),('Auditor','Menu_Products','ACT','2026-12-31 00:00:00'),('Auditor','Menu_Proveedores','ACT','2026-12-31 00:00:00'),('Auditor','Menu_Usuarios','ACT','2026-12-31 00:00:00'),('Publico','Controllers\\Checkout\\Checkout','ACT','2026-12-31 00:00:00'),('Publico','Controllers\\Orders\\MyOrders','ACT','2026-12-31 00:00:00'),('Publico','Menu_MisCompras','ACT','2026-12-31 00:00:00'),('Publico','Menu_PaymentCheckout','ACT','2026-12-31 00:00:00');
/*!40000 ALTER TABLE `funciones_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `highlights`
--

DROP TABLE IF EXISTS `highlights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `highlights` (
  `highlightId` int NOT NULL AUTO_INCREMENT,
  `productId` int NOT NULL,
  `highlightStart` datetime NOT NULL,
  `highlightEnd` datetime NOT NULL,
  PRIMARY KEY (`highlightId`),
  KEY `productId` (`productId`),
  CONSTRAINT `highlights_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `highlights`
--

LOCK TABLES `highlights` WRITE;
/*!40000 ALTER TABLE `highlights` DISABLE KEYS */;
INSERT INTO `highlights` VALUES (2,4,'2025-06-01 00:00:00','2025-06-30 23:59:59');
/*!40000 ALTER TABLE `highlights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `orderId` varchar(255) NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `payerName` varchar(255) DEFAULT NULL,
  `payerEmail` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_userId` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (3,3,'3N006918B21690616','COMPLETED',15.00,'USD','John Doe','sb-qedp844878326@personal.example.com','2025-07-28 10:26:09','2025-07-28 16:26:11'),(4,3,'9E936183U7127781F','COMPLETED',595.00,'USD','John Doe','sb-qedp844878326@personal.example.com','2025-07-28 14:52:24','2025-07-28 20:52:26'),(5,8,'6RA913185K4026521','COMPLETED',70.00,'USD','John Doe','sb-qedp844878326@personal.example.com','2025-07-28 15:03:28','2025-07-28 21:03:30');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `productId` int NOT NULL AUTO_INCREMENT,
  `productName` varchar(255) NOT NULL,
  `productDescription` text NOT NULL,
  `productPrice` decimal(10,2) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `productStock` int NOT NULL DEFAULT '0',
  `productStatus` enum('ACT','INA','DSC') NOT NULL DEFAULT 'ACT',
  `categoryId` int DEFAULT NULL,
  `providerId` int DEFAULT NULL,
  `productCreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`productId`),
  KEY `categoryId` (`categoryId`),
  KEY `providerId` (`providerId`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `categorias` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`providerId`) REFERENCES `proveedores` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (3,'Leche','Leche',15.00,'prod_6887a7a8bafbf3.98778468.jpg',145,'ACT',1,1,'2025-07-23 15:18:30'),(4,'queso','queso semiseco',75.00,'prod_688104c56ed2c8.89304019.jpg',162,'ACT',1,1,'2025-07-23 15:50:29'),(5,'Cuajada','Cuajada',180.00,'prod_6882ea79c2b406.93782105.jpg',88,'ACT',1,1,'2025-07-25 02:22:49'),(6,'Quesillo','Quesilllo ',70.00,'prod_68879a5e8401e3.34191394.jpg',23,'ACT',1,1,'2025-07-28 15:42:22'),(7,'Requeson','Requeson fresco',40.00,'prod_68879ab8f18742.02766154.jpg',25,'ACT',1,1,'2025-07-28 15:43:52'),(8,'Lata de maiz','Lata de maiz 20g',65.00,'prod_68879b7c4d2048.19014097.jpg',37,'ACT',3,2,'2025-07-28 15:46:42');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `contacto` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(150) DEFAULT NULL,
  `direccion` text,
  `estado` enum('activo','inactivo') DEFAULT 'activo',
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (1,'leche sula','sula','98078908','sula@gmail.com','barrio la peña','activo','2025-07-15 16:09:27'),(2,'proveedor enlatados','enatados del valle','994513218','latasdelvaelle@gmail.com','smc','activo','2025-07-28 15:45:51');
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `rolescod` varchar(128) NOT NULL,
  `rolesdsc` varchar(45) DEFAULT NULL,
  `rolesest` char(3) DEFAULT NULL,
  PRIMARY KEY (`rolescod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES ('Admin','Administrador','ACT'),('Auditor','Auditor','ACT'),('Publico','Publico','ACT');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_usuarios`
--

DROP TABLE IF EXISTS `roles_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles_usuarios` (
  `usercod` bigint NOT NULL,
  `rolescod` varchar(128) NOT NULL,
  `roleuserest` char(3) DEFAULT NULL,
  `roleuserfch` datetime DEFAULT NULL,
  `roleuserexp` datetime DEFAULT NULL,
  PRIMARY KEY (`usercod`,`rolescod`),
  KEY `rol_usuario_key_idx` (`rolescod`),
  CONSTRAINT `rol_usuario_key` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`),
  CONSTRAINT `usuario_rol_key` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_usuarios`
--

LOCK TABLES `roles_usuarios` WRITE;
/*!40000 ALTER TABLE `roles_usuarios` DISABLE KEYS */;
INSERT INTO `roles_usuarios` VALUES (1,'Admin','ACT','2025-07-25 00:00:00','2026-07-25 00:00:00'),(2,'Auditor','ACT','2025-07-25 00:00:00','2026-07-25 00:00:00'),(3,'Publico','ACT','2025-07-25 00:00:00','2026-07-25 00:00:00'),(8,'Publico','ACT','2025-07-25 00:00:00','2026-07-25 00:00:00');
/*!40000 ALTER TABLE `roles_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `saleId` int NOT NULL AUTO_INCREMENT,
  `productId` int NOT NULL,
  `salePrice` decimal(10,2) NOT NULL,
  `saleStart` datetime NOT NULL,
  `saleEnd` datetime NOT NULL,
  PRIMARY KEY (`saleId`),
  KEY `productId` (`productId`),
  CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (1,3,500.00,'2025-06-01 00:00:00','2025-06-30 23:59:59'),(2,5,750.00,'2025-06-01 00:00:00','2025-06-30 23:59:59'),(3,7,1500.00,'2025-06-01 00:00:00','2025-06-30 23:59:59');
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `usercod` bigint NOT NULL AUTO_INCREMENT,
  `useremail` varchar(80) DEFAULT NULL,
  `username` varchar(80) DEFAULT NULL,
  `userpswd` varchar(128) DEFAULT NULL,
  `userfching` datetime DEFAULT NULL,
  `userpswdest` char(3) DEFAULT NULL,
  `userpswdexp` datetime DEFAULT NULL,
  `userest` char(3) DEFAULT NULL,
  `useractcod` varchar(128) DEFAULT NULL,
  `userpswdchg` varchar(128) DEFAULT NULL,
  `usertipo` char(3) DEFAULT NULL COMMENT 'Tipo de Usuario, Normal, Consultor o Cliente',
  PRIMARY KEY (`usercod`),
  UNIQUE KEY `useremail_UNIQUE` (`useremail`),
  KEY `usertipo` (`usertipo`,`useremail`,`usercod`,`userest`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'manuelynat14@gmail.com','ManuelADM','$2y$10$Y1K3hs.PsZYh98of/qLDD.FBgBOF2/TEHbv452kqjmp0b2ACUrxCC','2025-07-24 15:40:44','ACT','2025-10-22 00:00:00','ACT','32b84f87838fec473fddcc59b3b390d73f6dbe289e64393fdfc7191072be5ec8','2025-07-24 15:40:44','ADM'),(2,'kennet@gmail.com','KennetAUD','$2y$10$rK.J1eZqbU.pU/bKibrOG.kRTBAuYgovf6JbOcG4oH8W/Q0Bgnuta','2025-07-24 20:38:39','ACT','2025-10-22 00:00:00','ACT','c24010d16e4041bc9c2292aabe3c342bc3ddc131b7e73ffb575a893751eb29fc','2025-07-24 20:38:39','AUD'),(3,'cristian@gmail.com','CristianPBL','$2y$10$UFrAb8kMbnfeuWaOBCkn/euFUUIp7jVYIu6SPRLbkepOCIWLhuI4i','2025-07-26 11:02:49','ACT','2025-10-24 00:00:00','ACT','0eae627b4f2ebf5061d171c9b33ac6f32c09871022d1c9c7f199d1812aa9329e','2025-07-26 11:02:49','PBL'),(8,'erick@gmail.com','John Doe','$2y$10$rkRGNePyimhL9.JoRE9kFuCsgWecA56EYd0wE55RAVvwdj2IhCWG6','2025-07-28 14:59:06','ACT','2025-10-26 00:00:00','ACT','01c5d7a67480d09938dc7608cefca5076b7e3e6851e3208e903c0b281d3da205','2025-07-28 14:59:06','PBL');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ecommerce'
--

--
-- Dumping routines for database 'ecommerce'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-29 17:52:26
