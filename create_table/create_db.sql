-- imb_db 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `imb_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `imb_db`;

--nft 정보를 담을 테이블
-- 테이블 imb_db.imb_tb 구조 내보내기
CREATE TABLE IF NOT EXISTS `imb_tb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `destination` varchar(50) DEFAULT NULL,
  `image_url` varchar(50) DEFAULT NULL,
  `technology_exists` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

-- 내보낼 데이터가 선택되어 있지 않습니다.

--유저 정보를 담을 테이블
-- 테이블 imb_db.imb_user 구조 내보내기
CREATE TABLE IF NOT EXISTS `imb_user` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `wallet_address` varchar(255) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`no`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4;