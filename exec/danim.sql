-- MySQL dump 10.19  Distrib 10.3.38-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: Danim
-- ------------------------------------------------------
-- Server version	10.3.38-MariaDB-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Sequence structure for `hibernate_sequence`
--

DROP SEQUENCE IF EXISTS `hibernate_sequence`;
CREATE SEQUENCE `hibernate_sequence` start with 1 minvalue 1 maxvalue 9223372036854775806 increment by 1 cache 1000 nocycle ENGINE=InnoDB;
SELECT SETVAL(`hibernate_sequence`, 1001, 0);

--
-- Table structure for table `favorite`
--

DROP TABLE IF EXISTS `favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favorite` (
  `favorite_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`favorite_id`),
  KEY `FKh20v4bwlpu57uv12dl7i2qipe` (`post_id`),
  KEY `FKh3f2dg11ibnht4fvnmx60jcif` (`user_id`),
  CONSTRAINT `FKh20v4bwlpu57uv12dl7i2qipe` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE CASCADE,
  CONSTRAINT `FKh3f2dg11ibnht4fvnmx60jcif` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_uid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite`
--

LOCK TABLES `favorite` WRITE;
/*!40000 ALTER TABLE `favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nation`
--

DROP TABLE IF EXISTS `nation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nation` (
  `nation_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `nation_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`nation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nation`
--

LOCK TABLES `nation` WRITE;
/*!40000 ALTER TABLE `nation` DISABLE KEYS */;
INSERT INTO `nation` VALUES (1,'캐나다','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/18db075e-2bda-4e6f-a37c-6135d1143e99.png'),(2,'미국','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/a3cf7d74-7773-4ef3-924c-ee4ae2945d17.png'),(3,'대한민국','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/7c1e20b6-b8b3-432c-8c9c-031981abac80.%EB%8C%80%ED%95%9C%EB%AF%BC%EA%B5%AD'),(4,'대','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/a3dd3ac7-4667-403f-9932-ba833d280947.png');
/*!40000 ALTER TABLE `nation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo`
--

DROP TABLE IF EXISTS `photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photo` (
  `photo_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_live` bit(1) DEFAULT b'0',
  `photo_url` varchar(255) NOT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`photo_id`),
  UNIQUE KEY `UK_beoa8atls3i4o4s8dbsh6n182` (`photo_url`),
  KEY `FKt47fmi9mi5p9dkjyyuoyfc63f` (`post_id`),
  CONSTRAINT `FKt47fmi9mi5p9dkjyyuoyfc63f` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo`
--

LOCK TABLES `photo` WRITE;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` VALUES (1,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/8e0eedb0-9795-4a29-a340-b7ce8ed5bf14.jpg',1),(2,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/54355c17-47ab-45cc-bb57-392de1e794ba.jpg',2),(3,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/b8b9c9f3-19c6-4bbf-8333-3c742c996758.jpg',2),(4,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/ab9109c4-ee15-4180-991f-2795994ffcc6.jpg',2),(5,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/881fd13b-e3e1-47cc-b2ac-55f9c69b5a38.jpg',2),(6,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/f5a98a5f-3533-457e-8fc3-9099e372959b.jpg',2),(7,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/e9ed5836-b4bd-4e12-8040-12557f702603.jpg',3),(8,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/f40a2bec-3084-446c-9d06-4d9166a9fac0.jpg',3),(9,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/9f7018fc-87ec-423e-91a2-07e0258dd120.jpg',3),(10,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/520a8e4d-09bc-43d8-ad2b-824e5d70b2f6.jpg',3),(11,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/6f47ecb8-7d62-4655-93b4-084b9a5a3dfb.jpg',3),(12,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/5406a0d8-dcea-44f2-8344-c17a59034072.jpg',4),(13,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/8bbd2a68-88cb-4ca9-b786-6a180bccddff.jpg',4),(14,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/7c4e990c-0dc7-41e0-92b7-fd2f0aedf2a4.jpg',4),(15,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/88f1fb3d-59db-4839-a4d7-3a1b1ba01684.jpg',5),(16,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/041223c1-f531-44cf-a3ac-026e0c148760.jpg',5),(17,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/06356ae9-75c3-43bf-bedf-81dbccb5cb27.jpg',5),(18,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/48f0c0ac-d541-43c2-bfab-d95d66c74227.jpg',5),(19,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/a1406c39-7e5b-4784-8129-64a11872834f.jpg',6),(20,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/bec62236-3886-42bf-99af-7ffb81c11593.jpg',6),(21,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/d0ba92e8-2edc-4941-868b-8aa7b10a1010.jpg',7),(22,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/76fb2f87-30ee-4832-92d2-9005b5c98f53.jpg',7),(23,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/6bf41d10-6dd5-4e59-9686-da6de93b326c.jpg',7),(24,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/cef17bbb-8f83-460f-a83c-debc285eb663.jpg',7),(25,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/7174e1d0-eebd-4bad-bcc6-e0edbd1911c5.jpg',7),(26,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/05a38a72-d27f-434b-ba56-b2240d3c23ef.jpg',8),(27,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/fe242fd6-8a76-4626-9292-fad7db1b5508.jpg',8),(28,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/13163c27-ff27-4b8b-8811-c1dd6bcd5721.jpg',9),(29,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/8b9a3308-4e9b-4059-b5a0-61f904690cdd.jpg',9),(30,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/75307b22-06e5-4bf0-8568-70477cc7cb93.jpg',9),(31,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/ba764956-d055-4081-a660-3be5511deb18.jpg',9),(32,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/3367f095-df3d-4fef-b7fd-ee3ad44f780c.jpg',10),(33,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/0aaa7ce6-d758-4319-a486-022e1332a0f2.jpg',10),(34,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/22deafce-5ef1-4776-bdbc-d7b33708b3f6.jpg',10),(35,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/c645bf7b-5918-47ec-9b52-4c71ac7949e4.jpg',11),(36,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/e3ae66da-5a1f-44cd-8514-924c91a68ce0.jpg',12),(37,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/b53caa39-998d-43b2-b1cd-3d0b681af2f4.jpg',13),(38,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/4747c3da-d1d1-4542-8f9b-f9a87d5785a6.jpg',14),(39,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/e7b1d117-8fd6-4368-9a1a-58bad5806b3c.jpg',14),(40,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/dbd2eb6f-5506-4f87-96dc-b47b3f1dec37.jpg',14),(41,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/d380e0a8-d290-44c7-8ceb-084c531e8a09.jpg',14),(42,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/7779b7b6-2f74-4190-aec6-600c1769ef25.jpg',15),(43,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/edb1c2d2-f255-466f-a484-93306e05cd80.jpg',15),(44,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/a352fe55-7efc-4ab0-8708-daf01cb0d085.jpg',15),(45,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/b71a242a-a10e-4fea-ad03-eaa30693d9df.jpg',15),(46,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/92c7363c-4c14-483c-a8b3-0de403443f2f.jpg',16),(47,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/c1095684-3aa7-43e4-b33b-d05f6585e0c5.jpg',16),(48,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/4ef74214-abeb-48cd-9870-6d90953679ef.jpg',16),(49,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/11f5f088-32db-4a7b-ba46-7e20f9370375.jpg',16),(50,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/c61cbd44-b511-46c9-99d6-6bb85a46094a.jpg',16),(51,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/baade1c4-766e-490d-aa1b-46fca93de94b.png',17),(52,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/f6a2e520-7459-4b0a-a67b-5605cac304cd.jpg',17),(53,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/e2b1ab45-62a5-415e-9a80-75ceb7ab6b77.jpg',17),(54,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/e161a9da-dfe2-4b9f-990c-db1ad806a1f8.jpg',17),(55,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/95b2bf21-3698-4d36-8e06-1d610b0bb8df.jpg',18),(56,'\0','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/b8240ccb-36ba-4949-b5b8-b8cdbc442dde.jpg',18);
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `post_id` bigint(20) NOT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `modify_time` datetime(6) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `address3` varchar(255) DEFAULT NULL,
  `address4` varchar(255) DEFAULT NULL,
  `nation_url` varchar(255) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL,
  `voice_length` double DEFAULT NULL,
  `voice_url` varchar(255) DEFAULT NULL,
  `nation_id` bigint(20) DEFAULT NULL,
  `timeline_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  KEY `FKc8cj5j15kmp14xvp5r0hvo8fv` (`nation_id`),
  KEY `FK3snh9odcaoulqfvetlboupwoo` (`timeline_id`),
  CONSTRAINT `FK3snh9odcaoulqfvetlboupwoo` FOREIGN KEY (`timeline_id`) REFERENCES `time_line` (`timeline_id`) ON DELETE CASCADE,
  CONSTRAINT `FKc8cj5j15kmp14xvp5r0hvo8fv` FOREIGN KEY (`nation_id`) REFERENCES `nation` (`nation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,'2023-04-07 11:14:15.795052','2023-04-07 11:14:17.722209','캐나다','브리티시컬럼비아','노스벤쿠버','그라우스','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/18db075e-2bda-4e6f-a37c-6135d1143e99.png','여기 지금 그라우스 마운틴이 올라왔는데 지금 아직 5월인데도 불구하고 너무 아 고도 높은 곳에 처음. 와봤는데 진짜 춥네요.',12.58521556854248,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/a3395836-3904-498c-92da-fcb668f5f31b.wav',1,2),(2,'2023-04-07 11:15:02.527413','2023-04-07 11:15:05.016535','미국','로스앤젤레스','샌디에고','라호야','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/a3cf7d74-7773-4ef3-924c-ee4ae2945d17.png','라호야 비치라고 여기 야생 물개들이 와서 쉬는 서식지라고 합니다. 별로 냄새가 심할 줄 알았는데 냄새는 안 나고 귀엽긴 하네요. 근데',13.374693870544434,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/55efcf1a-cf45-499a-bdd0-83ce22c11c31.wav',2,3),(3,'2023-04-07 11:15:13.038558','2023-04-07 11:15:15.254888','캐나다','알버타','로키','로키산맥','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/18db075e-2bda-4e6f-a37c-6135d1143e99.png','여러분들 로키마운트입니다. 로키 마운트 이거 진짜 넓네 산이 어떻게 저렇게 높지 말이 안 된다 말',11.377778053283691,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/44658c23-86f8-40bd-a488-78315f2fd45c.wav',1,3),(4,'2023-04-07 11:15:45.875650','2023-04-07 11:15:47.982788','미국','로스앤젤레스','샌디에고','발보아','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/a3cf7d74-7773-4ef3-924c-ee4ae2945d17.png','여기 발보아 파크인데 여기 옛날에 상속자들에 나왔다고 하는 거기인데 저는 몰랐는데 여기가 그런 곳이라고 합니다. 샌디에이고 있는 건데 주변에 동물원도 있어요.',14.512471199035645,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/c2c5fbf9-95c4-414d-a98e-ef580a7cec72.wav',2,4),(5,'2023-04-07 11:15:56.615892','2023-04-07 11:15:58.473651','미국','오리건','포틀랜드','멀트노마','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/a3cf7d74-7773-4ef3-924c-ee4ae2945d17.png','미국 오리건주에 빅풋이 나왔다고 해서 와봤는데 빅풋은 없고 기념품만 팔고 근데 폭포는 멋지네요.',10.983038902282715,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/d8a23926-d20e-48c8-b7a8-1789aa03e091.wav',2,4),(6,'2023-04-07 11:16:02.803268','2023-04-07 11:16:04.510669','미국','오리건','시애플','스타벅스','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/a3cf7d74-7773-4ef3-924c-ee4ae2945d17.png','여기 지금 스타트 벅스 본점에 와 있는데 제가 이런 곳에 와볼 거라고는 생각도 못 해봤는데 텀블러 살까 말까 고민했는데 텀블러는 안 사겠습니다. 나중에 후회할지 모르겠는데',13.467574119567871,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/57974994-bd49-41f8-a771-6e6c00070bd8.wav',2,4),(7,'2023-04-07 11:16:41.068856','2023-04-07 11:16:43.746703','캐나다','알버타','로키','에메랄드레이크','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/18db075e-2bda-4e6f-a37c-6135d1143e99.png','여러분들 여기 에메랄드 레이크인데요. 어떻게 물 색깔이 저럴 수가 있죠. 저게 빙하에서 나온 물이라고 하는데 확실히 다르긴 하네요. 여기가 정말 멋집니다. 여러분',13.258594512939453,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/8d3a42b9-d8c7-4e5b-90f2-b31fe3b6aadc.wav',1,5),(8,'2023-04-07 11:16:45.372017','2023-04-07 11:16:46.840739','미국','유타','어딘','\"\"','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/a3cf7d74-7773-4ef3-924c-ee4ae2945d17.png','제가 요리하는 스테이크입니다. 안에 보세요. 미디엄 레어 야무지게 먹어야지',10.68117904663086,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/5019eb36-37ca-4637-90f8-997a4ba3c264.wav',2,5),(9,'2023-04-07 11:16:51.827656','2023-04-07 11:16:53.310431','캐나다','브리티시컬럼비아','벤쿠버','잉글리시베이','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/18db075e-2bda-4e6f-a37c-6135d1143e99.png','여기 잉글리시 베이인데 진짜 노리 멋지네요. 진짜 죽입니다. 죽여 너무 좋다.',8.614603042602539,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/34a72d4f-cd51-49fe-a5d9-742472357a5d.wav',1,5),(10,'2023-04-07 11:16:56.718446','2023-04-07 11:16:58.215975','캐나다','브리티시컬럼비아','벤쿠버','잉글리시베이','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/18db075e-2bda-4e6f-a37c-6135d1143e99.png','오늘 밴쿠버 파이어워크 페스티벌 왔는데 한국 팀 하는 건데 진짜 멋지네요. 어떻게 진짜 한국에서도 이런 거 있었으면 좋겠네요.',12.770975112915039,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/540a6415-6741-4f7a-8de6-56d015a40eda.wav',1,5),(11,'2023-04-07 11:17:09.657128','2023-04-07 11:17:11.155236','대한민국','서울','강남구','역삼동','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/7c1e20b6-b8b3-432c-8c9c-031981abac80.%EB%8C%80%ED%95%9C%EB%AF%BC%EA%B5%AD','녹음 중입니다. 하나 둘 셋 또 이제',4.027210712432861,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/b9b441a6-2cc2-420f-a5ac-b803ee2d403b.1116.58.wav',3,1),(12,'2023-04-07 11:17:28.382638','2023-04-07 11:17:29.820276','캐나다','알버타','로키','어딘가','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/18db075e-2bda-4e6f-a37c-6135d1143e99.png','이거 포르의 올드카입니다. 여기 아까 동호회 하던데 진짜 멋지네요. 저도 저런 차 하나 사고 싶습니다. 진짜 정말 멋지네요 소리 소리',12.44589614868164,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/a45c045e-2595-4f6c-b5a4-3d73b321f412.wav',1,6),(13,'2023-04-07 11:17:56.665220','2023-04-07 11:17:58.023892','미국','로스앤젤레스','샌디에고','포테이토칩스락','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/a3cf7d74-7773-4ef3-924c-ee4ae2945d17.png','이게 포테이토 칩스라인데 저 밑에 진짜 낭떨어집니다. 진짜 무서워요. 근데 저 바위가 안 부서지는지는 모르겠는데 진짜 아찔하긴 하네요.',12.538775444030762,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/2d5f986a-79f5-4d15-ab0f-49d2a5c93373.wav',2,6),(14,'2023-04-07 11:18:06.989008','2023-04-07 11:18:09.255282','대','가오','차진','류추 ','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/a3dd3ac7-4667-403f-9932-ba833d280947.png','이거 진짜 대만 가오슝인데 여러분들 여기 진짜 애플만 거 꼭 드셔보셔야 합니다. 이 망고 빙수가 장난이 아니에요. 장난이 정말 행복합니다.',13.631999969482422,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/bcbe9d13-5484-47f6-a5ce-1071f7922481.wav',4,6),(15,'2023-04-07 11:19:58.710181','2023-04-07 11:20:00.622221','미국','에리조','그랜드 캐니언 국립 공원 ','','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/a3cf7d74-7773-4ef3-924c-ee4ae2945d17.png','여기 지금 미국 그랜드 캐니언인데 여기 진짜 장난 아니에요. 자연이 진짜 멋져요. 세상에 어떻게 이런 곳이 다 있지',13.824000358581543,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/61bcce7b-87b8-453b-aa8c-06bc58ef2a84.wav',2,7),(16,'2023-04-07 11:20:07.218624','2023-04-07 11:20:09.592564','미국','로스앤젤레스','그리피스 천문대 ','','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/a3cf7d74-7773-4ef3-924c-ee4ae2945d17.png','지금 여기 la 한 세 번 오는데 이거 올 때마다 진짜 재밌네요. 여기는 전 la 여행 오는 게 정말 행복합니다. 너무 좋다.',13.994667053222656,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/5f6de734-00c6-47f8-810e-2635b0d19770.wav',2,7),(17,'2023-04-07 11:20:11.890820','2023-04-07 11:20:13.724166','미국','오리건 ','포틀랜드 ','올드타운 ','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/a3cf7d74-7773-4ef3-924c-ee4ae2945d17.png','여기 지금 부두 도넛에 왔는데 저는 진짜 도넛을 먹을 때마다 정말 행복합니다. 도넛 너무 좋아요.',10.837333679199219,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/93832718-1eb8-4131-b76a-0d5c560174c7.wav',2,7),(18,'2023-04-07 12:30:03.313337','2023-04-07 12:30:05.496233','대한민국','서울','강남구','역삼동','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/7c1e20b6-b8b3-432c-8c9c-031981abac80.%EB%8C%80%ED%95%9C%EB%AF%BC%EA%B5%AD','야옹아 여기 여기 이리 봐 이리 봐 안녕 야옹아',7.168435573577881,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/984eed65-35e0-4298-b890-1b6572e9d288.1229.49.wav',3,1);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_line`
--

DROP TABLE IF EXISTS `time_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_line` (
  `timeline_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) DEFAULT NULL,
  `modify_time` datetime(6) DEFAULT NULL,
  `complete` bit(1) DEFAULT b'0',
  `finish_time` datetime(6) DEFAULT NULL,
  `timeline_public` bit(1) DEFAULT b'1',
  `title` varchar(255) NOT NULL DEFAULT '여행중',
  `user_uid` bigint(20) NOT NULL,
  PRIMARY KEY (`timeline_id`),
  KEY `FKpaduoi408ie2ui5gg2ym018lu` (`user_uid`),
  CONSTRAINT `FKpaduoi408ie2ui5gg2ym018lu` FOREIGN KEY (`user_uid`) REFERENCES `user` (`user_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_line`
--

LOCK TABLES `time_line` WRITE;
/*!40000 ALTER TABLE `time_line` DISABLE KEYS */;
INSERT INTO `time_line` VALUES (1,'2023-04-07 10:57:50.668108','2023-04-07 13:23:39.209640','','2023-04-07 13:23:39.208737','','마지막',1),(2,'2023-04-07 11:13:27.107834','2023-04-07 11:14:37.560718','','2023-04-07 11:14:37.559759','','여행 끝~~',3),(3,'2023-04-07 11:14:46.923223','2023-04-07 11:15:29.411771','','2023-04-07 11:15:29.410753','','낭만 개발자 송지율',3),(4,'2023-04-07 11:15:33.744018','2023-04-07 11:16:23.275749','','2023-04-07 11:16:23.274647','','나혼자 떠나는 여행',3),(5,'2023-04-07 11:16:27.787594','2023-04-07 11:17:14.627816','','2023-04-07 11:17:14.626998','','자 이제 떠나요 공항으로',3),(6,'2023-04-07 11:17:17.268610','2023-04-07 11:19:03.047491','','2023-04-07 11:19:03.046305','','여행 떠나여🦕🦖',3),(7,'2023-04-07 11:19:28.317129','2023-04-07 11:20:37.240433','','2023-04-07 11:20:37.239397','','다음에도 여행가야지🐓🦃🦑🕊🐥',3);
/*!40000 ALTER TABLE `time_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_uid` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` varchar(255) NOT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `profile_image_url` varchar(255) DEFAULT NULL,
  `refresh_token` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_uid`),
  UNIQUE KEY `UK_rb7eox526ilbewv2wuv5bnsrt` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'2719848771','이영차','{bcrypt}$2a$10$soDBXCmsSrPXCoBJr4eThO5/ME5UHAUyJ3L5xvgqeKtFhzmyGr/VC','http://k.kakaocdn.net/dn/rkzVf/btrJlo4CzEH/nF4GlVkeOKaU7HSYw0k1aK/img_640x640.jpg','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNzE5ODQ4NzcxIiwicm9sZXMiOiJVU0VSIiwiaWF0IjoxNjgwODMyNTMxLCJleHAiOjE2ODM0MjQ1MzF9.8V9neW2VBhoitDlnOqAZx6SKpWh5kuAOPxCJHa7vKI8','USER'),(2,'2725410333','기남석','{bcrypt}$2a$10$dnWsZEdsTai4vQqxt8d9JuRZIw0T70k03.HXmch82K3/Wue3rdzju','http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNzI1NDEwMzMzIiwicm9sZXMiOiJVU0VSIiwiaWF0IjoxNjgwODMzMTQxLCJleHAiOjE2ODM0MjUxNDF9.czOiSy8T0QNjpJKyJouCF7ElKh2Zwor8c3uKx5An-I8','USER'),(3,'2725446611','송지율','{bcrypt}$2a$10$BewIiZTwNLsl4EdBU5ZF5./EDr107af1tVEbq0gvhDpOiVZ3OkKiq','http://k.kakaocdn.net/dn/dIUOxh/btrOfbMpO9p/JikTtvK5PtI5Wi6RMyPkDK/img_640x640.jpg','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyNzI1NDQ2NjExIiwicm9sZXMiOiJVU0VSIiwiaWF0IjoxNjgwODMzMjYzLCJleHAiOjE2ODM0MjUyNjN9.V1fhyCLhKpRduKZWy14ZbDEkFuoaYpTMtBYf95XqBTQ','USER');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-07  5:58:26
