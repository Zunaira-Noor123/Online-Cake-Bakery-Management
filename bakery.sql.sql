-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: sweettreatsdb
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `adminusers`
--

DROP TABLE IF EXISTS `adminusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminusers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminusers`
--

LOCK TABLES `adminusers` WRITE;
/*!40000 ALTER TABLE `adminusers` DISABLE KEYS */;
INSERT INTO `adminusers` VALUES (1,'admin','240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9','admin@sweettreats.com','2025-12-27 20:52:42');
/*!40000 ALTER TABLE `adminusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cakes`
--

DROP TABLE IF EXISTS `cakes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cakes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` double NOT NULL,
  `imageUrl` varchar(255) DEFAULT NULL,
  `ingredients` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cakes`
--

LOCK TABLES `cakes` WRITE;
/*!40000 ALTER TABLE `cakes` DISABLE KEYS */;
INSERT INTO `cakes` VALUES (1,'Chocolate Delight','Rich chocolate cake topped with dark chocolate ganache.',3000,'images/chocolate.jpg','Flour, Cocoa, Sugar, Eggs, Vinegar'),(2,'Strawberry Heaven','Soft sponge cake layered with fresh strawberries and cream.',1800,'images/strawberry.jpg','Strawberries, Cream, Sponge, Sugar'),(3,'Vanilla Dream','Classic vanilla sponge with creamy buttercream frosting.',1200,'images/vanilla.jpg','Vanilla Extract, Buttercream, Flour, Sugar'),(4,'Red Velvet','Delicious red velvet sponge, cream cheese frosting.',2000,'images/red_velvet.jpg','Flour, Cocoa, Cream Cheese, Sugar'),(5,'Black Forest','German chocolate cake layered with cherries.',2200,'images/black_forest.jpg','Chocolate, Cherries, Cream, Flour'),(6,'Lemon Tart','Tangy lemon cake with a lemon curd center.',1600,'images/lemon_tart.jpg','Lemon, Cream, Sugar, Butter, Flour'),(7,'Carrot Cake','Moist and spiced cake with cream cheese frosting.',2000,'images/carrot.jpg','Carrots, Flour, Cinnamon, Sugar, Cream Cheese'),(8,'Pineapple Upside Down','Caramelized pineapple with soft cake.',1800,'images/pineapple.jpg','Pineapple, Caramel, Egg, Flour, Sugar'),(9,'Chocolate Fudge','Rich chocolate cake with layers of smooth fudge frosting.',2500,'images/chocolate_fudge.jpg','Fudge, Chocolate, Cocoa Powder, Cream, Eggs'),(10,'Coconut Bliss','Tropical coconut cake topped with creamy coconut frosting.',2100,'images/coconut_bliss.jpg','Coconut Milk, Flour, Butter, Eggs, Sugar'),(11,'Matcha Green Tea Cake','Light and airy cake infused with premium matcha flavor.',2300,'images/matcha_cake.jpg','Matcha Powder, Flour, Sugar, Eggs, Cream'),(12,'Raspberry Almond Cake','Delicate almond sponge layered with sweet raspberry filling.',2450,'images/raspberry_almond.jpg','Almonds, Raspberry Jam, Cream, Sugar, Flour'),(13,'Tiramisu Cake','A decadent cake with coffee and mascarpone layers.',2600,'images/tiramisu.jpg','Coffee, Mascarpone, Sponge, Cocoa Powder, Sugar'),(14,'Funfetti Cake','A colorful vanilla sponge with rainbow sprinkles and buttercream frosting.',1900,'images/funfetti.jpg','Vanilla, Rainbow Sprinkles, Butter, Flour, Sugar');
/*!40000 ALTER TABLE `cakes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deliveries`
--

DROP TABLE IF EXISTS `deliveries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deliveries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `delivery_person_id` int DEFAULT NULL,
  `status` enum('pending','in_progress','delivered') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliveries`
--

LOCK TABLES `deliveries` WRITE;
/*!40000 ALTER TABLE `deliveries` DISABLE KEYS */;
INSERT INTO `deliveries` VALUES (1,1,1,'pending','2025-12-28 15:53:36','2025-12-30 10:16:24'),(2,2,1,'pending','2025-12-28 15:53:36','2026-01-30 08:56:33'),(3,3,1,'in_progress','2025-12-28 15:53:36','2026-01-30 07:11:33'),(4,101,12,'pending','2025-12-28 16:01:38','2025-12-28 22:54:45'),(5,102,14,'delivered','2025-12-28 16:01:38','2025-12-28 22:54:54'),(6,103,1,'pending','2025-12-28 16:01:38','2026-01-21 16:04:31'),(7,104,2,'pending','2025-12-28 16:27:59','2026-01-21 16:09:43'),(8,105,NULL,'pending','2025-12-28 16:27:59','2025-12-28 16:27:59'),(9,106,12,'delivered','2025-12-28 16:27:59','2025-12-28 20:21:36'),(10,201,NULL,'pending','2025-12-29 19:58:23','2025-12-29 19:58:23'),(11,202,NULL,'pending','2025-12-29 20:09:17','2025-12-29 20:09:17');
/*!40000 ALTER TABLE `deliveries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_persons`
--

DROP TABLE IF EXISTS `delivery_persons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_persons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_persons`
--

LOCK TABLES `delivery_persons` WRITE;
/*!40000 ALTER TABLE `delivery_persons` DISABLE KEYS */;
INSERT INTO `delivery_persons` VALUES (1,'deliveryperson1','deliveryperson@example.com','deliver123','2025-12-29 18:38:13'),(2,'deliveryperson2','delivery2@example.com','deliver234','2025-12-29 18:38:13');
/*!40000 ALTER TABLE `delivery_persons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderitems`
--

DROP TABLE IF EXISTS `orderitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderitems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `cake_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cake_id` (`cake_id`),
  KEY `orderitems_ibfk_1` (`order_id`),
  CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`cake_id`) REFERENCES `cakes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitems`
--

LOCK TABLES `orderitems` WRITE;
/*!40000 ALTER TABLE `orderitems` DISABLE KEYS */;
INSERT INTO `orderitems` VALUES (1,1,1,1,15),(11,10,1,1,1500),(13,12,7,1,2000),(14,12,2,1,1800),(17,14,2,1,1800),(18,15,1,1,1500),(21,17,1,1,2000),(26,21,2,1,1800),(27,22,2,1,1800);
/*!40000 ALTER TABLE `orderitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `total_price` double NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,4,15,'2025-12-27 19:32:59'),(10,4,1500,'2025-12-29 16:31:49'),(12,4,3800,'2025-12-29 17:08:34'),(14,4,1800,'2025-12-29 19:21:03'),(15,4,1500,'2025-12-29 19:25:00'),(17,4,2000,'2025-12-30 10:46:26'),(21,4,1800,'2026-01-23 07:30:46'),(22,4,1800,'2026-01-30 07:12:16');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `role` enum('admin','customer','delivery') NOT NULL DEFAULT 'customer',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (4,'testuser34','password123','testuser@example.com','2025-12-27 18:51:00','customer'),(8,'testuser','password1232','23-22411-075@se.fjwu.edu.pk','2025-12-27 20:38:35','customer'),(17,'zunaira123','zunaira','23-22411-075@se.fjwu.edu.pk','2026-01-21 16:05:38','customer'),(18,'zuna1','123','23-22411-075@se.fjwu.edu.pk','2026-01-21 16:06:45','customer');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-05  1:24:52
