-- Název: Databázový sytém (databázová aplikace pro správu databáze)
-- Jméno a příjmení: Michal Siviček
-- Datum vypracování: 3.2.2023
-- Škola: Střední průmyslová škola elektrotechnická, Praha 2, Ječná 30
-- Třída: C4c
-- Jedná se o školní projekt 

CREATE DATABASE  IF NOT EXISTS `eshop` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `eshop`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: eshop
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.24-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `kategorie`
--

DROP TABLE IF EXISTS `kategorie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kategorie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nazev` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategorie`
--

LOCK TABLES `kategorie` WRITE;
/*!40000 ALTER TABLE `kategorie` DISABLE KEYS */;
INSERT INTO `kategorie` VALUES (1,'Elektronika'),(2,'Oblečení'),(3,'Sport');
/*!40000 ALTER TABLE `kategorie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objednavky`
--

DROP TABLE IF EXISTS `objednavky`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objednavky` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mnozstvi` int(11) NOT NULL,
  `zakaznik_id` int(11) NOT NULL,
  `zamestnanec_id` int(11) NOT NULL,
  `produkty_id` int(11) NOT NULL,
  `datum_objednavky` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `produkty_id` (`produkty_id`),
  KEY `zakaznik_id` (`zakaznik_id`),
  KEY `zamestnanec_id` (`zamestnanec_id`),
  CONSTRAINT `objednavky_ibfk_1` FOREIGN KEY (`produkty_id`) REFERENCES `produkty` (`id`),
  CONSTRAINT `objednavky_ibfk_2` FOREIGN KEY (`zakaznik_id`) REFERENCES `zakaznici` (`id`),
  CONSTRAINT `objednavky_ibfk_3` FOREIGN KEY (`zamestnanec_id`) REFERENCES `zamestnavatele` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objednavky`
--

LOCK TABLES `objednavky` WRITE;
/*!40000 ALTER TABLE `objednavky` DISABLE KEYS */;
INSERT INTO `objednavky` VALUES (1,2,2,2,4,'2022-01-01 10:00:00'),(2,1,2,2,2,'2021-01-01 10:00:00'),(3,3,3,3,3,'2022-02-03 10:00:00');
/*!40000 ALTER TABLE `objednavky` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `objednavky_s_detaily`
--

DROP TABLE IF EXISTS `objednavky_s_detaily`;
/*!50001 DROP VIEW IF EXISTS `objednavky_s_detaily`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `objednavky_s_detaily` AS SELECT 
 1 AS `objednavka_id`,
 1 AS `zakaznik`,
 1 AS `zamestnanec`,
 1 AS `produkt`,
 1 AS `mnozstvi`,
 1 AS `datum_objednavky`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `objednavky_s_jmeny`
--

DROP TABLE IF EXISTS `objednavky_s_jmeny`;
/*!50001 DROP VIEW IF EXISTS `objednavky_s_jmeny`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `objednavky_s_jmeny` AS SELECT 
 1 AS `id`,
 1 AS `jmeno_zakaznika`,
 1 AS `jmeno_zamestnance`,
 1 AS `nazev_produktu`,
 1 AS `mnozstvi`,
 1 AS `datum_objednavky`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `produkty`
--

DROP TABLE IF EXISTS `produkty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produkty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nazev` varchar(255) NOT NULL,
  `popis` text NOT NULL,
  `cena` float NOT NULL,
  `skladem` tinyint(1) NOT NULL,
  `kategorie_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `kategorie_id` (`kategorie_id`),
  CONSTRAINT `produkty_ibfk_1` FOREIGN KEY (`kategorie_id`) REFERENCES `kategorie` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkty`
--

LOCK TABLES `produkty` WRITE;
/*!40000 ALTER TABLE `produkty` DISABLE KEYS */;
INSERT INTO `produkty` VALUES (1,'iPhone X','Smartphone od Applu',7999,1,1),(2,'Nike Air Max','Obuv pro sportovce',3999,1,3),(3,'Adidas T-shirt','Sportovní tričko',799,1,3),(4,'Samsung Galaxy S21','Smartphone od Samsungu',8999,1,1);
/*!40000 ALTER TABLE `produkty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `soucet_podle_adresy`
--

DROP TABLE IF EXISTS `soucet_podle_adresy`;
/*!50001 DROP VIEW IF EXISTS `soucet_podle_adresy`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `soucet_podle_adresy` AS SELECT 
 1 AS `adresa`,
 1 AS `soucet_nakupu`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `zakaznici`
--

DROP TABLE IF EXISTS `zakaznici`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zakaznici` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jmeno` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefon` varchar(255) NOT NULL,
  `adresa` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zakaznici`
--

LOCK TABLES `zakaznici` WRITE;
/*!40000 ALTER TABLE `zakaznici` DISABLE KEYS */;
INSERT INTO `zakaznici` VALUES (1,'Michal Novotný','mnovotny@email.com','+420777888999','Praha 1, Nové Město'),(2,'Lucie Novotná','lnovotna@email.com','+420333222333','Brno 2, Židenice'),(3,'Adam Nový','anovy@email.com','+420511332211','Ostrava 3, Poruba');
/*!40000 ALTER TABLE `zakaznici` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zamestnavatele`
--

DROP TABLE IF EXISTS `zamestnavatele`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zamestnavatele` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jmeno` varchar(255) NOT NULL,
  `adresa` varchar(255) NOT NULL,
  `datum_zalozeni` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zamestnavatele`
--

LOCK TABLES `zamestnavatele` WRITE;
/*!40000 ALTER TABLE `zamestnavatele` DISABLE KEYS */;
INSERT INTO `zamestnavatele` VALUES (1,'Jan Novák','Hlavní 1, Praha','2021-01-01 00:00:00'),(2,'Petra Nováková','Vedlejší 2, Brno','2020-02-01 00:00:00'),(3,'Tomáš Nový','Druhá 3, Ostrava','2019-03-01 00:00:00');
/*!40000 ALTER TABLE `zamestnavatele` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `objednavky_s_detaily`
--

/*!50001 DROP VIEW IF EXISTS `objednavky_s_detaily`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `objednavky_s_detaily` AS select `objednavky`.`id` AS `objednavka_id`,`zakaznici`.`jmeno` AS `zakaznik`,`zamestnavatele`.`jmeno` AS `zamestnanec`,`produkty`.`nazev` AS `produkt`,`objednavky`.`mnozstvi` AS `mnozstvi`,`objednavky`.`datum_objednavky` AS `datum_objednavky` from (((`objednavky` join `zakaznici` on(`objednavky`.`zakaznik_id` = `zakaznici`.`id`)) join `zamestnavatele` on(`objednavky`.`zamestnanec_id` = `zamestnavatele`.`id`)) join `produkty` on(`objednavky`.`produkty_id` = `produkty`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `objednavky_s_jmeny`
--

/*!50001 DROP VIEW IF EXISTS `objednavky_s_jmeny`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `objednavky_s_jmeny` AS select `objednavky`.`id` AS `id`,`zakaznici`.`jmeno` AS `jmeno_zakaznika`,`zamestnavatele`.`jmeno` AS `jmeno_zamestnance`,`produkty`.`nazev` AS `nazev_produktu`,`objednavky`.`mnozstvi` AS `mnozstvi`,`objednavky`.`datum_objednavky` AS `datum_objednavky` from (((`objednavky` join `zakaznici` on(`objednavky`.`zakaznik_id` = `zakaznici`.`id`)) join `zamestnavatele` on(`objednavky`.`zamestnanec_id` = `zamestnavatele`.`id`)) join `produkty` on(`objednavky`.`produkty_id` = `produkty`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `soucet_podle_adresy`
--

/*!50001 DROP VIEW IF EXISTS `soucet_podle_adresy`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `soucet_podle_adresy` AS select `zakaznici`.`adresa` AS `adresa`,sum(`produkty`.`cena` * `objednavky`.`mnozstvi`) AS `soucet_nakupu` from ((`objednavky` join `zakaznici` on(`objednavky`.`zakaznik_id` = `zakaznici`.`id`)) join `produkty` on(`objednavky`.`produkty_id` = `produkty`.`id`)) group by `zakaznici`.`adresa` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-03 18:40:28
