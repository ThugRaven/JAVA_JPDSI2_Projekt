-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema vehicle_marketplace_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `vehicle_marketplace_db` ;

-- -----------------------------------------------------
-- Schema vehicle_marketplace_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `vehicle_marketplace_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_polish_ci ;
USE `vehicle_marketplace_db` ;

-- -----------------------------------------------------
-- Table `vehicle_marketplace_db`.`user_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vehicle_marketplace_db`.`user_role` ;

CREATE TABLE IF NOT EXISTS `vehicle_marketplace_db`.`user_role` (
  `id_user_role` INT NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_user_role`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehicle_marketplace_db`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vehicle_marketplace_db`.`user` ;

CREATE TABLE IF NOT EXISTS `vehicle_marketplace_db`.`user` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(45) NOT NULL,
  `password` CHAR(73) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `id_user_role` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(15) NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `archived` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_user`),
  CONSTRAINT `fk_user_user_role`
    FOREIGN KEY (`id_user_role`)
    REFERENCES `vehicle_marketplace_db`.`user_role` (`id_user_role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_user_user_role_idx` ON `vehicle_marketplace_db`.`user` (`id_user_role` ASC);

CREATE UNIQUE INDEX `login_UNIQUE` ON `vehicle_marketplace_db`.`user` (`login` ASC);


-- -----------------------------------------------------
-- Table `vehicle_marketplace_db`.`brand`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vehicle_marketplace_db`.`brand` ;

CREATE TABLE IF NOT EXISTS `vehicle_marketplace_db`.`brand` (
  `id_brand` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_brand`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehicle_marketplace_db`.`model`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vehicle_marketplace_db`.`model` ;

CREATE TABLE IF NOT EXISTS `vehicle_marketplace_db`.`model` (
  `id_model` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `id_brand` INT NOT NULL,
  PRIMARY KEY (`id_model`),
  CONSTRAINT `fk_model_brand1`
    FOREIGN KEY (`id_brand`)
    REFERENCES `vehicle_marketplace_db`.`brand` (`id_brand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_model_brand1_idx` ON `vehicle_marketplace_db`.`model` (`id_brand` ASC);


-- -----------------------------------------------------
-- Table `vehicle_marketplace_db`.`generation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vehicle_marketplace_db`.`generation` ;

CREATE TABLE IF NOT EXISTS `vehicle_marketplace_db`.`generation` (
  `id_generation` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `production_start` SMALLINT NOT NULL,
  `production_end` SMALLINT NULL,
  `id_model` INT NOT NULL,
  PRIMARY KEY (`id_generation`),
  CONSTRAINT `fk_generation_model1`
    FOREIGN KEY (`id_model`)
    REFERENCES `vehicle_marketplace_db`.`model` (`id_model`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_generation_model1_idx` ON `vehicle_marketplace_db`.`generation` (`id_model` ASC);


-- -----------------------------------------------------
-- Table `vehicle_marketplace_db`.`body_style`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vehicle_marketplace_db`.`body_style` ;

CREATE TABLE IF NOT EXISTS `vehicle_marketplace_db`.`body_style` (
  `id_body_style` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_body_style`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehicle_marketplace_db`.`offer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vehicle_marketplace_db`.`offer` ;

CREATE TABLE IF NOT EXISTS `vehicle_marketplace_db`.`offer` (
  `id_offer` INT NOT NULL AUTO_INCREMENT,
  `id_brand` INT NOT NULL,
  `id_model` INT NOT NULL,
  `id_generation` INT NOT NULL,
  `id_user` INT NOT NULL,
  `title` VARCHAR(70) NULL,
  `image` VARCHAR(100) NULL,
  `price` INT NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `production_year` YEAR NOT NULL,
  `mileage` INT NOT NULL,
  `displacement` FLOAT NOT NULL,
  `power` SMALLINT NOT NULL,
  `fuel` VARCHAR(20) NOT NULL,
  `transmission` VARCHAR(15) NOT NULL,
  `drive` VARCHAR(3) NOT NULL,
  `id_body_style` INT NOT NULL,
  `doors` TINYINT NOT NULL,
  `seats` TINYINT NOT NULL,
  `color` VARCHAR(20) NOT NULL,
  `color_type` VARCHAR(20) NULL,
  `description` TEXT NULL,
  `license_plate` VARCHAR(15) NULL,
  `vin` CHAR(17) NOT NULL,
  `first_registration` DATE NULL,
  `is_new` TINYINT(1) NOT NULL,
  `is_damaged` TINYINT(1) NULL,
  `is_accident_free` TINYINT(1) NULL,
  `is_first_owner` TINYINT(1) NULL,
  `is_registered` TINYINT(1) NULL,
  `is_right_hand_drive` TINYINT(1) NULL,
  `archived` TINYINT(1) NOT NULL DEFAULT 0,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_offer`),
  CONSTRAINT `fk_offer_generation1`
    FOREIGN KEY (`id_generation`)
    REFERENCES `vehicle_marketplace_db`.`generation` (`id_generation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_offer_body_style1`
    FOREIGN KEY (`id_body_style`)
    REFERENCES `vehicle_marketplace_db`.`body_style` (`id_body_style`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_offer_user1`
    FOREIGN KEY (`id_user`)
    REFERENCES `vehicle_marketplace_db`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_offer_model1`
    FOREIGN KEY (`id_model`)
    REFERENCES `vehicle_marketplace_db`.`model` (`id_model`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_offer_brand1`
    FOREIGN KEY (`id_brand`)
    REFERENCES `vehicle_marketplace_db`.`brand` (`id_brand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_offer_generation1_idx` ON `vehicle_marketplace_db`.`offer` (`id_generation` ASC);

CREATE INDEX `fk_offer_body_style1_idx` ON `vehicle_marketplace_db`.`offer` (`id_body_style` ASC);

CREATE INDEX `fk_offer_user1_idx` ON `vehicle_marketplace_db`.`offer` (`id_user` ASC);

CREATE INDEX `fk_offer_model1_idx` ON `vehicle_marketplace_db`.`offer` (`id_model` ASC);

CREATE INDEX `fk_offer_brand1_idx` ON `vehicle_marketplace_db`.`offer` (`id_brand` ASC);


-- -----------------------------------------------------
-- Table `vehicle_marketplace_db`.`equipment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vehicle_marketplace_db`.`equipment` ;

CREATE TABLE IF NOT EXISTS `vehicle_marketplace_db`.`equipment` (
  `id_equipment` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_equipment`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehicle_marketplace_db`.`offer_equipment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vehicle_marketplace_db`.`offer_equipment` ;

CREATE TABLE IF NOT EXISTS `vehicle_marketplace_db`.`offer_equipment` (
  `id_offer` INT NOT NULL,
  `id_equipment` INT NOT NULL,
  CONSTRAINT `fk_offer_equipment_offer1`
    FOREIGN KEY (`id_offer`)
    REFERENCES `vehicle_marketplace_db`.`offer` (`id_offer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_offer_equipment_equipment1`
    FOREIGN KEY (`id_equipment`)
    REFERENCES `vehicle_marketplace_db`.`equipment` (`id_equipment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_offer_equipment_offer1_idx` ON `vehicle_marketplace_db`.`offer_equipment` (`id_offer` ASC);

CREATE INDEX `fk_offer_equipment_equipment1_idx` ON `vehicle_marketplace_db`.`offer_equipment` (`id_equipment` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `vehicle_marketplace_db`.`user_role`
-- -----------------------------------------------------
START TRANSACTION;
USE `vehicle_marketplace_db`;
INSERT INTO `vehicle_marketplace_db`.`user_role` (`id_user_role`, `role_name`) VALUES (1, 'user');
INSERT INTO `vehicle_marketplace_db`.`user_role` (`id_user_role`, `role_name`) VALUES (2, 'admin');

COMMIT;


-- -----------------------------------------------------
-- Data for table `vehicle_marketplace_db`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `vehicle_marketplace_db`;
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (1, 'admin', 'ef4cf0fd:4f230caf9dd674891e057a810500f5cc2ce550d45f36d62a6a72cbc8788d26e7', 'admin@gmail.com', 2, 'Kamil', 'Weso??owski', '48123456789', '2021-11-18 21:05:00', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (2, 'user', '7c0d04d7:a6593a7bd6ad399df60521d09f98f54f9cbc885210cc0160a728d552b2820b16', 'user@gmail.com', 1, 'Name', 'Surname', '48123123123', '2022-01-06 16:04:51', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (3, 'kamil', '9890a311:2cb3a8f9c9fe56eb6126718be21c87585da9568eb828f745e3b4bb5cd6fc3ac4', 'kamil@gmail.com', 2, 'Kamil', 'Weso??owski', '48987654321', '2022-01-06 16:11:10', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (4, 'amattsson0', '7612af6e:b0be8f3895221a3f521b23be3c0bd118da6f655c4e99434284c1ec0f23930920', 'amattsson0@discuz.net', 1, 'Abram', 'Mattsson', '48256319682', '2022-01-06 19:37:12', 1);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (5, 'yshanley1', '9a91f87c:9ec4b1aca8205b8c444ccc095cec37cb965da00925a25c34b6b2e95eb61ec613', 'yshanley1@qq.com', 1, 'Yolande', 'Shanley', '48715649550', '2022-01-06 19:42:36', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (6, 'ahargreave2', '7da95f05:757c3ba09281e7e4ff3314897f1ad65ddce7ac66118608e2c8d31ef28eb35d15', 'ahargreave2@theatlantic.com', 1, 'Amii', 'Hargreave', '48597251002', '2022-01-06 19:49:23', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (7, 'eworsnop3', 'f9f0ea52:6bdb2efd07b77d72b6aab2e79263147282b12fc38940bc3cec333ba25abb4ab7', 'eworsnop3@creativecommons.org', 1, 'Eben', 'Worsnop', '48685822818', '2022-01-06 19:54:50', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (8, 'gmaseres4', '70be99d3:f349c7a8e267da0f70e52ef856d1c30ef06675a09732a80b42a234185bff46c9', 'gmaseres4@pcworld.com', 1, 'Gayler', 'Maseres', '48676961782', '2022-01-06 19:59:33', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (9, 'fbirkinshaw5', '6e57c1df:0c24c691412e0e0accaa8f70285bce3e19bad80623647f3a5cbfe8df063bbf0f', 'fbirkinshaw5@google.co.jp', 1, 'Frannie', 'Birkinshaw', '48585168079', '2022-01-06 20:08:59', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (10, 'eraxworthy6', '4b941a3b:4d87bc445a22886602864e06c0bca1313398386565e3969b14786974610f8137', 'eraxworthy6@paginegialle.it', 1, 'Egor', 'Raxworthy', '48821983334', '2022-01-06 20:12:21', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (11, 'lboole7', '4a8e32c2:8edb5b6f0c300d65dda2257de4c10037a6562b125009e5a64e57d722a3668253', 'lboole7@t.co', 1, 'Lacey', 'Boole', '48281861298', '2022-01-06 20:15:54', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (12, 'lcheale8', '418f30a0:1a19b63620f556ff4a8d83a51c6b6cca5ad96dea135e30169c90681cb61ee32f', 'lcheale8@wikimedia.org', 1, 'Laney', 'Cheale', '48310144745', '2022-01-06 20:22:39', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (13, 'hhowgate9', '77f37a1c:cd436713f148b756ab14493465e76be20738faef77cb0c8b81fa2783b171eb3d', 'hhowgate9@dmoz.org', 1, 'Hewet', 'Howgate', '48104218861', '2022-01-06 20:28:32', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (14, 'tgluyasa', '52895148:dab62f4f20be8ee6717f3cd55baf4152bdfbeab330b821d3297b4e0e61537fc1', 'tgluyasa@ucla.edu', 1, 'Towney', 'Gluyas', '48243289873', '2022-01-06 20:32:59', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (15, 'xhinchamb', '417aa223:6fba07b68eee2119c538b56216094f9cff74531559c057356f7ef032c409d706', 'xhinchamb@google.de', 1, 'Xerxes', 'Hincham', '48237130428', '2022-01-06 20:38:23', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (16, 'cnovisc', '293cd971:ddb4de356eba19e14ce84316bb60f8d679147a230ac2704fa7f4176fa2c2687a', 'cnovisc@businesswire.com', 1, 'Cart', 'Novis', '48157162408', '2022-01-06 20:43:43', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (17, 'dmayelld', '43284d11:5aa4b20a3696c39d1d3d8ff11cdd1cc677c2be285c07f0bec5cc8c36f5a7bda8', 'dmayelld@timesonline.co.uk', 1, 'Deidre', 'Mayell', '48295376041', '2022-01-06 20:50:17', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (18, 'btansille', '642dae53:1871ce01cc57910355d66648ec627f9583bf4561390192562fb0504d64c71f33', 'btansille@psu.edu', 1, 'Benedikta', 'Tansill', '48563570561', '2022-01-06 20:55:35', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (19, 'gedgetti', 'd3ce0301:3a7ee2f0e8a71b9dd9a43189e2ed012eb4422ceab35b26a09eb8f7335b2f4fe2', 'gedgetti@hao123.com', 1, 'Garfield', 'Edgett', '48532249984', '2022-01-06 21:03:15', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (20, 'mwipperj', '5e03bed8:74a8da53f970a7400220ba3d9cd3601993fae342b5b4cb8a639d31175caff36b', 'mwipperj@dedecms.com', 1, 'Merola', 'Wipper', '48856226140', '2022-01-06 21:10:47', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (21, 'wstennardk', 'e60c4d2f:3ab6a60583c82e2d0ce82200a8a9584a99b0099bf2f9a63c5788596ccb519d3b', 'wstennardk@umn.edu', 1, 'Willetta', 'Stennard', '48349427267', '2022-01-06 21:14:47', 0);
INSERT INTO `vehicle_marketplace_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `create_time`, `archived`) VALUES (22, 'dandreazzin', 'c5244475:d98a908f9c63c0005e4df2ab6ebfdd06d6b4302be7f930c6c04230f7f0fb011f', 'dandreazzin@dagondesign.com', 1, 'Domenico', 'Andreazzi', '48993151153', '2022-01-06 21:36:19', 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `vehicle_marketplace_db`.`brand`
-- -----------------------------------------------------
START TRANSACTION;
USE `vehicle_marketplace_db`;
INSERT INTO `vehicle_marketplace_db`.`brand` (`id_brand`, `name`) VALUES (1, 'Seat');
INSERT INTO `vehicle_marketplace_db`.`brand` (`id_brand`, `name`) VALUES (2, 'Porsche');

COMMIT;


-- -----------------------------------------------------
-- Data for table `vehicle_marketplace_db`.`model`
-- -----------------------------------------------------
START TRANSACTION;
USE `vehicle_marketplace_db`;
INSERT INTO `vehicle_marketplace_db`.`model` (`id_model`, `name`, `id_brand`) VALUES (1, 'Ibiza', 1);
INSERT INTO `vehicle_marketplace_db`.`model` (`id_model`, `name`, `id_brand`) VALUES (2, 'Leon', 1);
INSERT INTO `vehicle_marketplace_db`.`model` (`id_model`, `name`, `id_brand`) VALUES (3, '911', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `vehicle_marketplace_db`.`generation`
-- -----------------------------------------------------
START TRANSACTION;
USE `vehicle_marketplace_db`;
INSERT INTO `vehicle_marketplace_db`.`generation` (`id_generation`, `name`, `production_start`, `production_end`, `id_model`) VALUES (1, 'I', 1985, 1993, 1);
INSERT INTO `vehicle_marketplace_db`.`generation` (`id_generation`, `name`, `production_start`, `production_end`, `id_model`) VALUES (2, 'II', 1993, 1999, 1);
INSERT INTO `vehicle_marketplace_db`.`generation` (`id_generation`, `name`, `production_start`, `production_end`, `id_model`) VALUES (3, 'II FL', 1999, 2002, 1);
INSERT INTO `vehicle_marketplace_db`.`generation` (`id_generation`, `name`, `production_start`, `production_end`, `id_model`) VALUES (4, 'III', 2002, 2008, 1);
INSERT INTO `vehicle_marketplace_db`.`generation` (`id_generation`, `name`, `production_start`, `production_end`, `id_model`) VALUES (5, 'IV', 2008, 2017, 1);
INSERT INTO `vehicle_marketplace_db`.`generation` (`id_generation`, `name`, `production_start`, `production_end`, `id_model`) VALUES (6, 'V', 2017, NULL, 1);
INSERT INTO `vehicle_marketplace_db`.`generation` (`id_generation`, `name`, `production_start`, `production_end`, `id_model`) VALUES (7, 'I', 1999, 2005, 2);
INSERT INTO `vehicle_marketplace_db`.`generation` (`id_generation`, `name`, `production_start`, `production_end`, `id_model`) VALUES (8, 'II', 2005, 2012, 2);
INSERT INTO `vehicle_marketplace_db`.`generation` (`id_generation`, `name`, `production_start`, `production_end`, `id_model`) VALUES (9, 'III', 2012, 2020, 2);
INSERT INTO `vehicle_marketplace_db`.`generation` (`id_generation`, `name`, `production_start`, `production_end`, `id_model`) VALUES (10, 'IV', 2020, NULL, 2);
INSERT INTO `vehicle_marketplace_db`.`generation` (`id_generation`, `name`, `production_start`, `production_end`, `id_model`) VALUES (11, '930', 1983, 1990, 3);
INSERT INTO `vehicle_marketplace_db`.`generation` (`id_generation`, `name`, `production_start`, `production_end`, `id_model`) VALUES (12, '964', 1989, 1994, 3);
INSERT INTO `vehicle_marketplace_db`.`generation` (`id_generation`, `name`, `production_start`, `production_end`, `id_model`) VALUES (13, '991', 2011, 2018, 3);
INSERT INTO `vehicle_marketplace_db`.`generation` (`id_generation`, `name`, `production_start`, `production_end`, `id_model`) VALUES (14, '992', 2019, NULL, 3);
INSERT INTO `vehicle_marketplace_db`.`generation` (`id_generation`, `name`, `production_start`, `production_end`, `id_model`) VALUES (15, '993', 1993, 1997, 3);
INSERT INTO `vehicle_marketplace_db`.`generation` (`id_generation`, `name`, `production_start`, `production_end`, `id_model`) VALUES (16, '996', 1997, 2004, 3);
INSERT INTO `vehicle_marketplace_db`.`generation` (`id_generation`, `name`, `production_start`, `production_end`, `id_model`) VALUES (17, '997', 2005, 2011, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `vehicle_marketplace_db`.`body_style`
-- -----------------------------------------------------
START TRANSACTION;
USE `vehicle_marketplace_db`;
INSERT INTO `vehicle_marketplace_db`.`body_style` (`id_body_style`, `name`) VALUES (1, 'Auta ma??e');
INSERT INTO `vehicle_marketplace_db`.`body_style` (`id_body_style`, `name`) VALUES (2, 'Auta miejskie');
INSERT INTO `vehicle_marketplace_db`.`body_style` (`id_body_style`, `name`) VALUES (3, 'Coupe');
INSERT INTO `vehicle_marketplace_db`.`body_style` (`id_body_style`, `name`) VALUES (4, 'Kabriolet');
INSERT INTO `vehicle_marketplace_db`.`body_style` (`id_body_style`, `name`) VALUES (5, 'Kombi');
INSERT INTO `vehicle_marketplace_db`.`body_style` (`id_body_style`, `name`) VALUES (6, 'Kompakt');
INSERT INTO `vehicle_marketplace_db`.`body_style` (`id_body_style`, `name`) VALUES (7, 'Minivan');
INSERT INTO `vehicle_marketplace_db`.`body_style` (`id_body_style`, `name`) VALUES (8, 'Sedan');
INSERT INTO `vehicle_marketplace_db`.`body_style` (`id_body_style`, `name`) VALUES (9, 'SUV');

COMMIT;


-- -----------------------------------------------------
-- Data for table `vehicle_marketplace_db`.`offer`
-- -----------------------------------------------------
START TRANSACTION;
USE `vehicle_marketplace_db`;
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (1, 1, 1, 4, 1, 'Seat Ibiza III 1.2 64KM', 'DSC_3777-8336529144170014815.jpg', 4500, 'Sosnowiec', 2002, 179000, 1198, 64, 'Benzyna', 'Manualna', 'FWD', 2, 3, 5, 'Srebrny', 'Metalik', 'Witam, do sprzedania mam Seat\'a Ibiz?? z 2002 roku. Wszystko dzia??a, serdecznie polecam!', 'SO1892S', 'VSSZZZ6LZ4R191497', '2002-01-01', 0, 0, 0, 0, 1, 0, 0, '2022-01-06 00:21:15', '2022-01-06 00:21:15');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (2, 1, 2, 9, 2, 'FR*Full LED Matrixy*Czujniki prz??d i ty??*Alu 18 cali*NAVI', 'image-134555137874361353.jpg', 44999, 'Olkusz', 2013, 169000, 1395, 140, 'Benzyna', 'Manualna', 'FWD', 6, 5, 5, 'Szary', 'Metalik', 'Opis\nSEAT LEON III\n1.4 TURBO BENZYNA 140 KM\nSamoch??d serwisowany do ko??ca w ASO\nBezwypadkowy\n\nBardzo bogate wyposa??enie:\n* Wersja FR\n* Reflektory Full LED - MATRIX\n* ??wiat??a do jazdy dziennej LED\n* Kolorowy wy??wietlacz z Navigacj?? i DVD\n* Przednie i tylne czujniki parkowania z wizualizacj??\n* Alufelgi 18 cali\n* Sk??rzana kierownica z multifunkcj??\n* System g??o??nom??wi??cy\n* Przyciemnione szyby tylne\n* Sportowe p????sk??rzane fotele podgrzewane\n* i wiele innych\n', NULL, 'SEATLE0NNNNNNNNNN', NULL, 0, 0, 1, 1, 1, 0, 0, '2022-01-06 16:31:31', '2022-01-06 22:32:14');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (3, 1, 2, 9, 4, 'zadbany ma??y przebieg oszcz??dny polecam', 'image-2456756653857336792.jpg', 37600, '??ask', 2013, 112000, 1197, 105, 'Benzyna', 'Manualna', 'FWD', 6, 5, 5, 'Czarny', 'Metalik', 'Auto zadbane zarejestrowane po obs??udze serwisowej olej filtry gotowe do jazdy bez wk??adu finansowego 1.2 tsi na pasku rozrz??du nowszy silnik sprzeda?? prywatna auta nie firma wi??cej informacji pod numerem telefonu', NULL, 'VSSZZZ5FZER067600', '2014-02-28', 0, 0, 0, 0, 0, 0, 0, '2022-01-06 19:42:00', '2022-01-06 22:32:47');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (4, 1, 2, 9, 5, 'Benzyna ZAREJESTROWANY,5drzwi,Klima z Niemiec, Ks serwis Nowy rozrz??d', 'image-13976170978417982951.jpg', 33900, 'Po??ajewo', 2014, 171900, 1197, 86, 'Benzyna', 'Manualna', 'FWD', 6, 5, 5, 'Czarny', 'Metalik', 'Auto zarejestrowane, sprowadzone z Niemiec .\nStan bardzo dobry , silnik 1.2 na pasku rozrz??du ( 4 cylindry)\nSilnik i pozosta??e podzespo??y pracuj?? perfekcyjnie.\nWn??trze czyste i zadbane.\nKlimatyzacja sprawna.\nPrzebieg oryginalny - udokumentowany,\nDwa kluczyki.\nKsi????ka serwisowa, pe??en serwis ostatni wpis 16-03-2021 rok\n??wie??o wymienione tarcze hamulcowe, klocki, rozrz??d, filtry, oleje\nAuto zarejestrowane i ubezpieczone w kraju.', 'PCT95002', 'VSSZZZ5FZERXXXXXX', '2014-08-26', 0, 0, 0, 0, 1, 0, 0, '2022-01-06 19:47:18', '2022-01-06 19:47:18');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (5, 1, 2, 8, 6, '1,9 TDI* 5L/100 km. Przebieg 167 ty??. km CAR PASS. 2008 r.', 'image-4586553784908421573.webp', 20500, 'Humniska', 2008, 167000, 1896, 105, 'Diesel', 'Manualna', 'FWD', 6, 5, 5, 'Czarny', 'Metalik', 'Samoch??d sprowadzony z Belgii auto utrzymane w bardzo dobrym stanie z przebiegiem 167 ty?? km potwierdzonym w serwisie.\nSilnik 1.9 TDI bez DPF niezawodny i bardzo ekonomiczny spalanie 5.5 L /100km , auto utrzymane w bardzo dobrym stanie wn??trze czyste, zadbane od strony technicznej wszystko dzia??a idealnie .\n\nSamoch??d w bogatej wersji wyposa??enia posiada:\n\n-Nawigacja\n-Radio multifunkcyjne z Mp3, DVD, USB,\n-ABS, ESP\n-Klimatyzacja\n-Elektryczne szyby i lusterka\n-Sk??rzana tapicerka\n-Komplet kluczyk??w\n-Ksi????ka serwisowa z CAR PASS\n-Ubezpieczenie\n-Faktura vat-mar??a\n\nSamoch??d na zimowych oponach , przygotowany do rejestracji op??acony i ubezpieczony kupuj??cy otrzymuje komplet dokument??w potrzebnych do rejestracji , faktur?? ,komplet kluczyk??w, potwierdzenie przebiegu i ubezpieczenie.', '1EAD385', 'VSSZZZ1PZ8R034472', '2008-03-05', 0, 0, 1, 0, 0, 0, 0, '2022-01-06 19:53:49', '2022-01-06 19:53:49');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (6, 1, 2, 9, 7, 'Seat leon fr 2.0d 184km', 'image-307223106329555134.webp', 52500, 'Bielsko-Bia??a', 2014, 154000, 1968, 184, 'Diesel', 'Manualna', 'FWD', 6, 5, 5, 'Bia??y', 'Metalik', 'Witam, do sprzedania seat leon Fr 2.0d 184km samochod sprowadzony z Niemiec.\nWyposa??enie:\n\n- ??wiat??a Full Led;\n- Nawigacja dotykowa GPS;\n- System Start- Stop;\n- Tempomat\n- Przednie siedzenia Sportowe;\n- System drive select - do wyboru 4 tryby jazdy\n- Klimatyzacja dwustrefowa;\n- Podgrzewane fotele;\n- ??wiat??a do jazdy dziennej - ledowe;\n- Sk??rzana wielofunkcyjna kierownica;\n- Czujnik deszczu;\n- Czujnik zmierzchu;\n- Czujniki parkowania prz??d i ty?? ;\n- Halogeny;\n- Spryskiwacze reflektor??w\n- Bluetooth;\n- Gniazdo AUX\n- Gniazdo USB\n- Centralny zamek + komplet kluczy;\n- Komputer pok??adowy;\n- 4x elektryczne szyby;\n- Elektrycznie sterowane i sk??adane lusterka boczne;\n- Podgrzewane lusterka boczne\n- Isofix;\n- O??wietlenie ledowe wewn??trz.', NULL, 'FM6SFM6FB0017MJML', '2014-05-12', 0, 0, 0, 0, 0, 0, 0, '2022-01-06 19:58:02', '2022-01-06 22:32:50');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (7, 1, 2, 9, 8, '12/2017 POLSKI SALON, 2.0TDi 150km, kombi', 'image-1206808184496546132.webp', 38000, 'Gorz??w Wielkopolski', 2017, 227000, 1968, 150, 'Diesel', 'Manualna', 'FWD', 5, 5, 5, 'Niebieski', 'Metalik', 'Sprzedam SEATA LEONA.\n\nSeat LEON z grudnia 2017 roku, POLSKI SALON, I W??A??CICIEL. Regularnie serwisowy w ASO na co posiadam ksi????k??, niedawno wymieniony kompletny rozrz??d.\n\n2.0TDi 150km, 6 bieg??w manualna skrzynia.\n\nSeat w stanie bardzo dobrym, zadbany, ??rodek niemal jak nowy. Je??d??ony tylko i wy????cznie w trasie. Wszystko chodzi idealnie, skrzynia, sprz??g??o, silnik itd. Samoch??d posiada kosmetyczne uszkodzenia lewego boku i lekko ty??u (uszkodzony zderzak prz??d, lekkie p??kni??cie lampy lewej, b??otnik prz??d, drzwi kierowcy, tylne drzwi w zasadzie minimalne uszkodzenie, tylny b??otnik, zderzak tylny i tylna klapa). S?? TO USZKODZENIA KOSMTYCZNE, baga??nik nienaruszony. Auto w pe??ni sprawne i u??ytkowane - szkoda nie zosta??a wpisana w histori??.\n\nBogata wersja wyposa??enia, du??a nawigacja, kamera, start-stop, czujniki prz??d i ty?? i wiele innych.\n\nSamoch??d przed szkod?? wyceniony na 63ty?? z??otych.', NULL, 'VSSZZZ5FZJR078450', '2017-12-21', 0, 0, 1, 1, 1, 0, 0, '2022-01-06 20:05:11', '2022-01-06 22:32:52');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (8, 1, 2, 8, 9, 'Seat Leon 1.9 TDI', 'image-265442693609343660.webp', 13900, 'Bydgoszcz', 2009, 208243, 1896, 105, 'Diesel', 'Manualna', 'FWD', 6, 5, 5, 'Czerwony', 'Metalik', 'Auto swiezo sprowadzne z Francji\nSamoch??d ??adny zadbany zar??wno pod wzgl??dem wizualnym jak i technicznym.\nSilnik pracuje bardzo ??adnie , zawieszenie niewybite.\nwymieniny rozrzad , olejie i filtry\nAuto gotowe do jazdy', 'BW373EA', 'VSSZZZ1PZ9R029683', '2009-03-19', 0, 0, 1, 1, 0, 0, 0, '2022-01-06 20:12:02', '2022-01-06 20:12:02');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (9, 1, 2, 9, 10, 'Seat Leon 3 ( Krajowy, 1 W??a??ciciel)', 'image-12319091922926589943.webp', 34900, 'Tychy', 2015, 212000, 1598, 105, 'Diesel', 'Manualna', 'FWD', 6, 5, 5, 'Bia??y', 'Metalik', 'Witam serdecznie . Przedmiotem aukcji jest samoch??d seat leon 3 generacji z ko??ca 2015r z niezawodnym silnikiem 1.6 tdi ktory sprowadza sie do spalania ok . 5.5l/100km .\nPrzebieg w aucie jest w 100% wiarygodny . Pe??na dokumentacja ( ksiazka serwisowa ) . przy przebiegu 178tys zosta?? wymieniony rorzad . W aucie wymienione zosta??y dodatkowo :\n-sprzeg??o\n-oleje ,filtry wymieniane na czas ( auto jezdzi??o co 13 tys do serwisu )\n-oraz wiele innych eksploacyjnych rzeczy ktore sa zaznaczone w ksiazce serwisowej .\n\nauto nie wymaga wk??adu w??asnego . Sprzedaje jako osoba prywatna. Cena 34 900 do negocjacji', 'SPS86174', 'VSSZZZ5FZFR123283', '2015-07-14', 0, 0, 0, 1, 1, 0, 0, '2022-01-06 20:15:26', '2022-01-06 20:15:26');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (10, 1, 2, 9, 11, 'LED, Alcantara,6 bieg??w, zadbany, serwisowany, po wymianie rozrz??du', 'image-15364579853304373989.jpg', 42900, 'O??wi??cim', 2014, 187000, 1598, 110, 'Diesel', 'Manualna', 'FWD', 5, 5, 5, 'Czarny', 'Metalik', 'Dzie?? dobry,\n\nZapraszam do zapoznania si?? z ofert?? sprzeda??y mojego prywatnego samochodu.\nSeat Leon z silnikiem 1.6 TDI o mocy 110KM, wyposa??ony w 6-biegow?? manualn?? skrzyni?? bieg??w.\n\nSamoch??d jest bardzo zadbany, regularnie serwisowany na dow??d czego posiadam faktury z napraw.\nOstatnio wykonano:\n-wymian?? kompletnego rozrz??du wraz z pomp?? wody\n-pe??en serwis olejowo-filtrowy\n-czyszczenie filtra DPF (gwarancja oraz faktura)\n\nNa wyposa??eniu samoch??d posiada m.in.\n-Lampy LED prz??d i ty??\n-Fotele sk??ra+alcantara\n-Podgrzewanie foteli\n-Du??a nawigacja wraz z systemem g??o??nom??wi??cym Bluetooth\n-Czujniki parkowania z przodu i ty??u\n-Czujniki deszczu oraz zmierzchu\n-Fotochromatyczne lusterko wsteczne\n-Kolorowy wy??wietlacz pomi??dzy zegarami\n-Fabrycznie przyciemnione tylne szyby\ni wiele wiele innych\n\nSamoch??d posiadam od roku, olej wymieniam co 15tys. km, ostatnia wymiana przy ok. 185tys.\nR??wnie?? przy oko??o 185tys zosta?? wymieniony kompletny rozrz??d wraz z pomp?? wody oraz zaw??r EGR, wszystko udokumentowane fakturami.\nOstatnio w samochodzie za??wieci?? si?? b????d filtra cz??stek sta??ych wobec czego uda??em si?? do profesjonalnego serwisu celem dokonania czyszczenia filtra na co posiadam faktur?? oraz gwarancj??.\n\nZ racji prowadzonej dzia??alno??ci samoch??d sprzedaj?? na faktur?? VAT- mar??a dzi??ki czemu kupuj??cy nie p??aci 2% podatku.\n\nZapraszam do ogl??dania i jazdy pr??bnej, wyra??am zgod?? na wizyt?? w dowolnym serwisie.', 'KOS1850E', 'VSSZZZ5FZFR085201', '2014-12-30', 0, 0, 1, 0, 1, 0, 0, '2022-01-06 20:22:06', '2022-01-06 20:22:06');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (11, 1, 2, 9, 12, 'Excellence PL Salon / serwis ASO / bezwypadek', 'image-6604312642341196350.jpg', 76900, 'Serock', 2019, 32750, 1498, 131, 'Benzyna', 'Manualna', 'FWD', 6, 5, 5, 'Br??zowy', 'Metalik', 'Na sprzeda?? Seat Leon w bardzo wysokiej opcji wyposa??enia. Z polskiego salonu. Odkupi??em go z komisu dealerskiego w Poznaniu jako roczne auto przy przebiegu niespe??na 12 ty??. km.\nAktualnie auto ma oko??o 32.750 km.\n\nSerwisy olejowe wykonywane co 15 tys km. Czyli przy 15 i 30 tys km.\n\nAuto w perfekcyjnym stanie. ??aden element nie by?? lakierowany. Absolutnie bezwypadkowe. Na gwarancji fabrycznej do lipca 2024 r.\n\nBardzo ciekawy kolor ciemna ??liwka / bak??a??an - w zale??no??ci od o??wietlenia.', 'WW9362X', 'VSSZZZ5FZKR134270', NULL, 0, 0, 1, 0, 1, 0, 0, '2022-01-06 20:27:24', '2022-01-06 20:27:24');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (12, 1, 2, 9, 13, 'Seat Leon 1.5 TSI Salon Polska, Gwarancja do 2024r', 'image-4365261590609500923.jpg', 76500, 'Pruszk??w', 2019, 62002, 1498, 130, 'Benzyna', 'Manualna', 'FWD', 6, 5, 5, 'Czarny', 'Metalik', 'Dzie?? dobry, posiadam na sprzeda?? bardzo ??adny samoch??d jakim jest Seat Leon w wersji Xcellence.\nSilnik 1.5 TSI 130KM po????czony z manualna skrzyni?? bieg??w gwarantuje dobre osi??gi, bezawaryjno???? oraz bardzo ma??e zu??ycie paliwa jak na silnik benzynowy (powtarzalna ??rednia w mie??cie to okolice 7l)\nWersja Xcellence w standardzie jest bardzo dobrze wyposa??ona, na pok??adzie mamy\nReflektory prz??d oraz ty?? w technologii Full Led\nAsystent ??wiate?? drogowych\nPodgrzewane przednie fotele\nOpcja full Link (po odblokowaniu mamy dost??p do Android Auto oraz Apple car play)\nAktywny tempomat\nAsystent pasa ruchu\nAuto Hold\nCzujniki parkowania prz??d/ty??\nO jakim?? standardowym wyposa??eniu nie b??d?? wspomina?? bo oczywi??cie tu jest, a lista by by??a d??uga.\nSeat 22 grudnia mia?? zrobiony rozszerzony przegl??d w ASO Seat Maran w kt??rego sk??ad wchodzi??a\nWymiana\nOleju\nFiltr oleju\nFiltr powietrza\nFiltr przeciwpy??kowy\n??wiece zap??onowe\nDodatkowo w sk??ad przegl??du rozszerzonego wchodzi??a kontrola nadwozia, podwozia oraz lakieru. Oczywi??cie wszystko odby??o si?? bez uwag.\nSamoch??d jest w naprawd?? super stanie, nie ma ??lad??w u??ytkowania, wn??trze jest czyste i zadbane. Samoch??d g????wnie pokonywa?? trasy.\nZapraszam do ogl??dzin, jazdy pr??bnej oraz zakupu.', 'ZS050MH', 'VSSZZZ5FZKR080504', '2019-04-11', 0, 0, 0, 0, 1, 0, 0, '2022-01-06 20:31:59', '2022-01-06 20:31:59');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (13, 1, 2, 8, 14, 'Cupra R Lift 310', 'image-8890348978975743969.jpg', 36900, 'Ostrowiec ??wi??tokrzyski', 2009, 243000, 1984, 265, 'Benzyna', 'Manualna', 'FWD', 6, 5, 5, 'Czarny', 'Metalik', 'Witam.\n\nNa sprzedam posiadam Seata Leona Cupre R.\nPojazd sprowadzony ze Szwajcarii. Jestem pierwszym w??a??cicielem w Polsce.\nAuto bezwypadkowe w bardzo dobrym stanie technicznym i wizualnym.\nCupra ??wie??o po serwisie olejowym wraz z wymian?? popychacza hpfp, nowe sprz??g??o, termostat, pompa vacum, nowe opony lato Dunlop Sport Maxx rt2, wyczyszczony nagar z dolotu, motor suchy bez wyciek??w.\nKsi????ka serwisowa prowadzona do ko??ca w ASO.\n\nZ dodatk??w w aucie:\n-Spr????yny obni??aj??ce KW\n-Oprogramowanie firmy ABT 310 KM\n-Komplet alufelg z oponami zimowymi Dunlop\n\nPolecam', 'TOS72016', 'VSSZZZ1PZAR020215', NULL, 0, 0, 1, 0, 1, 0, 0, '2022-01-06 20:38:01', '2022-01-06 20:38:01');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (14, 1, 2, 8, 15, 'Leon FR Ori lakier, niski przebieg, GPS, Xenon, nowe op??aty', 'image-9575550379634034789.jpg', 16900, 'Krak??w', 2007, 264570, 1968, 170, 'Diesel', 'Manualna', 'FWD', 6, 5, 5, 'Czarny', 'Metalik', 'Witam. Na sprzeda?? posiadam samoch??d Seat Leon II generacji w wersji FR. Wersja FR posiada inne zderzaki, kierownice logowan??, Ga??k?? zmiany bieg??w, fotele logowane, oraz zegary, a tak??e 2.0 diesla o mocy 170km. przebieg wynosi zaledwie 264570km.\nsamoch??d jest z 23.04.2007r, czyli z ko??c??wki produkcji.\nW samochodzie jest oryginalny lakier, brak jakichkolwiek wyciek??w, wszystko robione na czas, brak wk??adu w??asnego na ten moment.\n31.12.2021r dokonany zosta?? przegl??d samochodu, kt??ry przeszedl bez najmniejszych problem??w, jest to oferta prywatna.\nDo wgl??du ksi????ka serwisowa, gdy?? by?? serwisowany w ASO :)\n\nZ wyposa??enia dodatkowego samoch??d pr??cz pakietu FR posiada m.in. : podgrzewane fotele, pod??okietnik ( towar deficytowy w Seatach ), climatronic dotykowe radio DVD + GPS oraz kamera cofania, ??wiat??a Xenonowe w raz z spryskiwaczami w zderzaku, oraz delikatnie przyciemnione szyby z ty??u.\nwszystkie szyby s?? oryginalne, brak jakichkolwiek historii wypadkowej.', 'KOLUC21', 'VSSZZZ1PZ7R096507', NULL, 0, 0, 1, 0, 1, 0, 0, '2022-01-06 20:42:33', '2022-01-06 20:42:33');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (15, 1, 2, 8, 16, '2.0 T 310km ABT Cupra Xenon Bezwypadek Navi Idealna Unikat !!!', 'image-613086857189489520.jpg', 41900, 'Radom', 2010, 182141, 1984, 265, 'Benzyna', 'Manualna', 'FWD', 6, 5, 5, 'Czarny', 'Metalik', 'Oferuj?? do sprzeda??y bezwypadkowego Seata Leon Cupra R310 WCE ABT jedna z 200 sztuk z silnikiem 2,0 T 310km, oraz manualna 6 biegowa skrzynia bieg??w.\n\nAuto cale w oryginalnym lakierze, udost??pniam miernik na miejscu ogl??dzin.\nPrzebieg auta jest w 100% Oryginalny.\n\nData produkcji 2010\nAuto kupione od pierwszego w??a??ciciela. Serwisowane do ko??ca w autoryzowanym serwisie ASO.\n\nPrezentowana auto jest w bardzo dobrym stanie, nie wymaga ??adnych napraw ani remont??w.\nZawieszenie jest sztywne, auto doskonale si?? prowadzi, a silnik i skrzynia bieg??w pracuj?? idealnie.\n\nWyposa??enie auta:\n- Xenon\n- Cupra R310 ABT\n- Navi\n- Klimatyzacja\n- climatronic\n- elektryczne szyby\n- El. lusterka (Fotochrom podgrzewane)\n- Elektrochromatyczne lusterko wsteczne\n- Lakier metalizowany\n- Poduszki powietrzne airbag\n- Centralny zamek\n- Abs\n- Wspomaganie kierownicy\n- Radio CD\n- Isofix\n- Ksi????ka serwisowa\n- Immobilizer\n- ASR\n- Komputer\n- ??wiat??a przeciwmgielne\n- Pod??okietnik\n- Wielofunkcyjna kierownica\n- ??adna felga\n\nJe??li szukacie Pa??stwo samochodu pewnego i niezawodnego, to zapraszam do Radomia na jazd?? pr??bna.', NULL, 'VSSZZZ1PZAR055378', NULL, 0, 0, 1, 1, 1, 0, 0, '2022-01-06 20:48:24', '2022-01-06 22:32:54');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (16, 1, 2, 9, 17, 'Leon FR 184Km, 103 tys przebiegu', 'image-6658006988467728112.jpg', 41500, 'Skoki', 2017, 103500, 1968, 184, 'Diesel', 'Automatyczna', 'FWD', 5, 5, 5, 'Szary', 'Metalik', 'Witam\nSprzedam pi??knego Seata Leona FR, 184 konie, DSG, z ma??ym przebiegiem 103tys, samoch??d nie gro??ne uszkodzony pal??cy je??d????cy, 2 kluczyki, wszystkich ch??tnych zapraszam.', NULL, 'VSSZZZ5FZHR056203', NULL, 0, 1, 0, 0, 0, 0, 0, '2022-01-06 20:54:09', '2022-01-06 22:32:58');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (17, 1, 2, 10, 18, 'Seat Leon FR 1.5eTSI 150km DSG 2021 +opony zimowe + pow??oka ceramiczna', 'image-16001806121415820567.jpg', 119980, 'Kobi??r', 2021, 18000, 1498, 150, 'Benzyna', 'Automatyczna', 'FWD', 6, 5, 5, 'Czarny', 'Per??owy', 'Seat Leon FR 1.5 eTSI 150km DSG\nRok produkcji: 2021\nkolor: Midnight Black\n\nElementy wyposa??enia standardowego oraz opcjonalnego samochodu znajduj?? si?? na ostatnich zdj??ciach.\nSprzeda?? na podstawie umowy kupna- sprzeda??y.\n\nSamoch??d dodatkowo zosta?? wyposa??ony w :\n- komplet nowych opon zimowych\n- pow??oka ceramiczna na lakier\n- oryginalne dywaniki gumowe (dodatkowe)\n- ubezpieczenie opon letnich\n\nPojazd jest bezwypadkowy, kupiony w Polskim salonie, jestem pierwszym w??a??cicielem.', 'SPS82827', 'VSSZZZKLZMR077083', '2021-05-20', 0, 0, 1, 1, 1, 0, 0, '2022-01-06 20:59:00', '2022-01-06 20:59:00');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (18, 2, 3, 14, 19, 'Porsche 992 GT 3 Clubsport 2021, Od r??ki !!! Fabrycznie nowy !!!', 'image-15531357716478761483.jpg', 1320000, 'Warszawa', 2021, 54, 3996, 510, 'Benzyna', 'Automatyczna', 'RWD', 3, 2, 2, 'Szary', 'Metalik', 'Oferujemy fabrycznie nowy i limitowany model Porsche 911 GT 3 Clubsport !!!\n\nPojazd dost??pny od r??ki w naszym salonie !!!\n\nWyposaznie:\n\nN0 - Achatgrey Metalik\n72 - Wn??trze z rozszerzon?? sk??r??\nCechy Race Tex w kolorze czarnym / GT Silver\n\n6A9 - Pakiet Clubsport\n\nAMD -Motorsportset - Porsche Exclusive Manufaktur\nAML - Napis Porsche - Porsche Exclusive Manufaktur\nG1C - 7-biegowa dwusprz??g??owa skrzynia bieg??w Porsche PDK\n8LH - Pakiet Chrono\n012 - Zbiornik paliwa 90l\n2UH ??? Uk??ad podnoszenia przedniej osi\nC2Q - Ko??a 20\"/21\" 911 GT3\n1NI - Ko??a lakierowane w neodymie (jedwabny po??ysk) - Porsche Exclusive Manufaktur\n8JT - Przyciemniane reflektory LED PDLS\nKA2 - Asystent parkowania, oraz tylna kamera\nQQ2 - Pakiet oswietlenia wn??trza\nQ1K - Pe??ne fotele kube??kowe\nQE1 - Pakiet do przechowywania\n5 TB - Pakiet wn??trza Carbon (po??ysk)\n9VL - System d??wi??ku przestrzennego Bose\n\n\"Jeste??my oficjalnym i autoryzowanym dealerem Brabus\"\n\nGwarancja fabryczna rozpoczyna si?? z chwil?? dostawy przez producenta.\n\nProsimy o wcze??niejsze um??wienie wizyty w salonie sprzeda??y.', NULL, 'WP0ZZZ99ZLS216848', NULL, 1, 0, 1, 0, 0, 0, 0, '2022-01-06 21:10:05', '2022-01-06 22:32:55');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (19, 2, 3, 13, 20, 'Porsche GT2RS', 'image-10605296632153404237.jpg', 1911000, 'Warszawa', 2018, 43, 3800, 700, 'Benzyna', 'Automatyczna', 'RWD', 3, 2, 2, 'Bia??y', 'Metalik', 'Porsche GT2RS potw??r mocy i pi??kna. Widzisz j?? i zakochujesz si?? w niej, s??uchasz jej ryku do snu, prowadzisz j?? i robisz wszystko, aby j?? mie??. Najmocniejsza z serii 911. GT2RS zachwyca sportowymi detalami, w rzeczywisto??ci jest to legalny samoch??d wy??cigowy. 700KM, aerodynamiczne dodatki i ogromny tylny spojler ????cz?? si?? z eleganck?? biel?? przeplataj??c?? si?? z karbonowymi wstawkami.\n\n*przebieg 43km*\n*pakiet Sport Chrono*\n*6-punktowe pasy bezpiecze??stwa*\n*ceramiczny uk??ad hamulcowy*\n*pe??ne kube??kowe fotele*\n*system podnoszenia przedniej osi*\n*oryginalny pokrowiec Porsche*', NULL, 'WP0ZZZ99ZJS180775', NULL, 0, 0, 1, 1, 1, 0, 0, '2022-01-06 21:14:26', '2022-01-06 22:33:00');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (20, 1, 1, 4, 21, 'Seat Ibiza 1.4 benzyna Gaz 2007 / 16V*85km*63kW / Klima*4el szyby*AUX', 'image-12040873780043288801.jpg', 10990, 'Warszawa', 2007, 216976, 1390, 85, 'Benzyna', 'Manualna', 'FWD', 2, 5, 5, 'Srebrny', 'Metalik', 'Sprzedam ??adnego SEATA IBIZ?? 2007\n\nSilnik 1.4 benzyna. 16V 85km 63kW. Samoch??d bezwypadkowy zadbany wizualnie oraz technicznie. Auto bez oznak korozji. Rozrz??d, olej, filtry wymienione na 208tys. Pod??oga progi w bdb stanie, silnik oraz skrzynia bdb pracuj??.\n\n- abs\n- wspomaganie\n- 4el szyby\n- el lusterka\n- klimatyzacja manualna (sprawna, zatankowana)\n- esp\n- iso fix\n- Radio / AUX\n- alufelgi\n- Regulacja wysoko??ci kierownicy\n- Centralny zamek\n\nPRZEGL??D WA??NY DO MARCA 2022.', 'WY062VT', 'VSSZZZ6LZ7R162846', '2007-05-21', 0, 0, 1, 0, 1, 0, 0, '2022-01-06 21:22:51', '2022-01-06 21:50:09');
INSERT INTO `vehicle_marketplace_db`.`offer` (`id_offer`, `id_brand`, `id_model`, `id_generation`, `id_user`, `title`, `image`, `price`, `city`, `production_year`, `mileage`, `displacement`, `power`, `fuel`, `transmission`, `drive`, `id_body_style`, `doors`, `seats`, `color`, `color_type`, `description`, `license_plate`, `vin`, `first_registration`, `is_new`, `is_damaged`, `is_accident_free`, `is_first_owner`, `is_registered`, `is_right_hand_drive`, `archived`, `create_time`, `update_time`) VALUES (21, 1, 1, 5, 22, 'Seat Ibiza IV 6J 5 drzwi ! klima! Sprowadzona z Niemiec ! Pi??kny Stan!', 'image-1289789348300429809.jpg', 20000, 'Koszyce', 2010, 176000, 1390, 86, 'Benzyna', 'Manualna', 'FWD', 2, 5, 5, 'Bia??y', 'Metalik', 'Seat Ibiza IV 2010rok .\n1.4 mpi 86km - najlepsza i bezawaryjna jednostka nap??dowa\nBardzo ??adny stan , sprowadzona z Niemiec .\nprzebieg 176 ys km.!!\nKomplet dokument??w + ksiazka serwisowa.\nPrzebieg udokumentowany, potwierdzony oczywi??cie niemieckimi Tuv???ani . Aktualne badanie techniczne w niemczech na okres 2 lat ,co potwierdza , ze autko jest w super stanie !\nRok produkcji 2010 . . Auto odkupione od osoby prywatnej .dw??ch w??a??cicieli od nowo??ci .\nWersja 5 drzwiowa ,\nBogate wyposa??enie\n- elektryczne szyby\n-czujniki ci??nienia w ko??ach\n- klimatyzacja\n- wielofunkcyjna kierownica\n-do??wietlanie zakret??w\n- 8 x air bag + kurtyny.\n- gniazdo USB + AUX\n-alufelgi\ndodatkowo dorzucam komplet felg stalowych z oponami zimowymi .\nBardzo niskie spalanie\nSamochodzik , technicznie oraz mechanicznie w bardzo ??adnym stanie , co daje nam duzy komfort poruszania sie .\nBez luz??w , wyciek??w itp . Silnik suchutki , pracuje bardzo ??adnie .\nWn??trze r??wnie?? prezentuje si?? perfekcyjnie\nLakier nie wyp??owia??y , per??a.\nBez wgniotek , rys , obi?? .\n. Auto bezwypadkowe\nAutko naprawd?? w perfekcyjnym stanie .\nIbiza jak na swoj wiek wygl??da na bardzo poszanowany w??z.\nNie wymaga ??adnych napraw !\nW cenie op??aty celno skarbowe .( akcyza , przegl??d itp )\nKoszt rejestracji 256 zl .\nMo??liwo???? powrotu na ko??ach\nZapraszam na ogl??dziny , jazd?? pr??bna .\nZgadzam si?? na wizyt?? na stacji diagnostycznej , serwisie itp .', NULL, 'VSSZZZ6JZAR089789', '2010-02-10', 0, 0, 1, 0, 0, 0, 1, '2022-01-06 21:39:28', '2022-01-06 22:33:01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `vehicle_marketplace_db`.`equipment`
-- -----------------------------------------------------
START TRANSACTION;
USE `vehicle_marketplace_db`;
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (1, 'ABS');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (2, 'Alarm');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (3, 'Alufelgi');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (4, 'ASR (kontrola trakcji)');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (5, 'Asystent parkowania');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (6, 'Asystent pasa ruchu');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (7, 'Bluetooth');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (8, 'CD');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (9, 'Centralny zamek');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (10, 'Czujnik deszczu');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (11, 'Czujniki parkowania przednie');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (12, 'Czujniki parkowania tylne');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (13, 'Czujniki martwego pola');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (14, 'Czujnik zmierzchu');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (15, 'Dach panoramiczny');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (16, 'Elektrochromatyczne lusterka boczne');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (17, 'Elektrochromatyczne lusterko wsteczne');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (18, 'Elektryczne szyby przednie');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (19, 'Elektryczne szyby tylne');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (20, 'Elektrycznie ustawiane fotele');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (21, 'Elektrycznie ustawiane lusterka');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (22, 'ESP (stabilizacja toru jazdy)');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (23, 'Gniazdo AUX');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (24, 'Gniazdo SD');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (25, 'Gniazdo USB');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (26, 'Hak');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (27, 'HUD (wy??wietlacz przezierny)');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (28, 'Immobilizer');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (29, 'Isofix');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (30, 'Kamera cofania');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (31, 'Klimatyzacja automatyczna');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (32, 'Klimatyzacja czterostrefowa');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (33, 'Klimatyzacja dwustrefowa');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (34, 'Klimatyzacja manualna');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (35, 'Komputer pok??adowy');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (36, 'Kurtyny powietrzne');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (37, 'MP3');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (38, 'Nawigacja GPS');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (39, 'Odtwarzacz DVD');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (40, 'Ogranicznik pr??dko??ci');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (41, 'Ogrzewanie postojowe');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (42, 'Podgrzewana przednia szyba');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (43, 'Podgrzewane lusterka boczne');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (44, 'Podgrzewane przednie siedzenia');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (45, 'Podgrzewane tylne siedzenia');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (46, 'Poduszka powietrzna chroni??ca kolana');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (47, 'Poduszka powietrzna kierowcy');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (48, 'Poduszka powietrzna pasa??era');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (49, 'Poduszki boczne przednie');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (50, 'Poduszki boczne tylne');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (51, 'Przyciemniane szyby');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (52, 'Radio fabryczne');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (53, 'Radio niefabryczne');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (54, 'Regulowane zawieszenie');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (55, 'Relingi dachowe');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (56, 'System Start-Stop');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (57, 'Szyberdach');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (58, 'Tapicerka sk??rzana');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (59, 'Tapicerka welurowa');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (60, 'Tempomat');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (61, 'Tempomat aktywny');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (62, 'Tuner TV');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (63, 'Wielofunkcyjna kierownica');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (64, 'Wspomaganie kierownicy');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (65, 'Zmieniarka CD');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (66, '??opatki zmiany bieg??w');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (67, '??wiat??a do jazdy dziennej');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (68, '??wiat??a LED');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (69, '??wiat??a przeciwmgielne');
INSERT INTO `vehicle_marketplace_db`.`equipment` (`id_equipment`, `name`) VALUES (70, '??wiat??a Xenonowe');

COMMIT;


-- -----------------------------------------------------
-- Data for table `vehicle_marketplace_db`.`offer_equipment`
-- -----------------------------------------------------
START TRANSACTION;
USE `vehicle_marketplace_db`;
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (1, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (1, 2);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (1, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (1, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (1, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (1, 28);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (1, 34);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (1, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (1, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (1, 53);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (1, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (1, 69);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 2);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 4);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 5);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 7);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 8);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 10);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 11);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 12);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 16);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 17);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 19);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 20);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 21);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 23);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 24);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 25);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 29);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 31);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 33);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 35);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 36);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 37);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 38);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 39);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 42);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 43);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 44);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 46);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 49);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 50);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 51);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 52);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 56);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 58);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 59);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 60);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 67);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 68);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 69);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (2, 70);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 2);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 4);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 7);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 8);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 10);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 19);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 21);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 22);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 23);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 24);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 25);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 28);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 29);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 31);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 33);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 35);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 36);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 37);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 40);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 43);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 49);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 52);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 56);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 59);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 60);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 67);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (3, 69);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 2);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 4);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 7);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 8);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 16);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 21);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 22);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 23);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 24);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 25);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 28);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 29);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 34);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 35);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 36);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 37);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 43);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 46);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 49);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 52);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 59);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 67);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (4, 69);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 4);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 7);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 8);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 10);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 11);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 12);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 14);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 16);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 17);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 21);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 22);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 23);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 24);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 25);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 28);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 29);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 34);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 35);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 36);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 37);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 38);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 39);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 43);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 46);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 49);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 50);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 52);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 58);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 60);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (5, 69);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 2);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 4);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 5);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 7);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 8);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 11);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 12);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 19);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 21);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 22);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 23);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 25);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 28);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 29);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 37);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 46);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 49);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 51);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 56);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 61);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 65);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 69);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (6, 70);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 2);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 4);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 5);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 7);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 8);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 10);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 11);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 12);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 14);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 16);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 17);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 19);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 21);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 22);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 24);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 25);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 28);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 29);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 30);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 31);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 33);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 35);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 36);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 37);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 38);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 44);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 46);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 49);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 50);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 52);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 55);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 56);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 59);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 60);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 67);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (7, 68);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 4);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 8);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 19);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 21);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 23);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 28);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 31);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 33);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 35);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 36);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 52);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 60);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (8, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (9, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (9, 2);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (9, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (9, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (9, 12);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (9, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (9, 31);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (9, 35);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (9, 36);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (9, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (9, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (9, 49);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (9, 52);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (9, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (9, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 2);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 4);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 7);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 8);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 10);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 11);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 12);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 14);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 17);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 19);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 21);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 22);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 23);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 24);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 25);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 28);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 29);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 31);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 33);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 35);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 36);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 37);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 38);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 43);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 44);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 51);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 52);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 56);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 60);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 67);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 68);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (10, 69);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 4);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 6);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 7);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 8);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 10);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 11);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 12);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 14);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 17);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 19);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 21);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 22);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 23);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 25);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 28);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 29);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 31);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 33);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 35);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 36);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 37);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 40);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 43);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 44);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 49);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 51);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 52);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 56);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 61);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 67);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 68);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (11, 69);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 2);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 4);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 6);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 7);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 10);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 11);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 12);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 14);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 17);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 19);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 21);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 22);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 23);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 24);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 25);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 28);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 29);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 31);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 33);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 35);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 36);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 37);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 40);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 43);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 44);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 46);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 49);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 50);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 51);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 52);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 56);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 58);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 59);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 61);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 67);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 68);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (12, 69);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 2);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 4);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 5);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 8);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 10);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 12);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 19);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 21);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 22);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 23);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 25);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 28);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 29);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 31);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 33);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 37);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 43);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 46);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 49);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 51);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 52);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 59);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 60);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 67);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 69);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (13, 70);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 2);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 4);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 7);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 8);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 10);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 12);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 14);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 16);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 19);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 21);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 23);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 24);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 25);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 28);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 29);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 30);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 31);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 33);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 35);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 37);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 38);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 39);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 43);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 44);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 46);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 49);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 50);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 51);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 53);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 59);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 60);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 62);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 65);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 69);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (14, 70);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 2);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 4);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 7);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 8);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 10);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 11);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 12);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 16);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 17);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 19);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 20);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 21);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 23);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 24);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 25);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 28);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 29);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 31);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 33);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 35);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 36);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 37);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 38);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 43);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 44);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 46);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 49);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 50);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 51);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 52);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 60);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 67);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 68);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 69);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (15, 70);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 2);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 4);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 8);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 10);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 11);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 12);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 14);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 16);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 19);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 21);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 22);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 23);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 25);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 28);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 29);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 30);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 31);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 33);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 35);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 36);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 38);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 43);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 44);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 46);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 49);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 50);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 51);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 52);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 55);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 56);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 58);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 59);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 60);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 61);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 67);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 68);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (16, 69);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 2);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 4);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 5);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 6);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 7);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 10);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 11);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 12);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 14);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 21);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 22);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 23);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 25);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 28);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 29);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 31);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 35);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 36);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 37);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 38);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 43);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 44);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 46);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 49);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 50);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 51);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 52);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 56);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 61);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 66);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 67);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (17, 68);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 2);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 4);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 5);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 6);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 7);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 10);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 11);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 12);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 14);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 16);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 17);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 20);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 21);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 22);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 25);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 30);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 31);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 35);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 36);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 38);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 43);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 52);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 56);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 60);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 66);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (18, 68);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 2);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 4);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 7);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 10);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 11);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 12);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 14);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 30);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 31);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 35);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 38);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 52);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 54);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (19, 66);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 4);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 19);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 21);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 22);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 23);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 28);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 29);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 34);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 52);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 59);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 60);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 64);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (20, 69);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 1);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 2);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 3);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 8);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 9);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 18);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 23);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 24);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 28);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 29);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 34);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 35);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 36);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 37);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 46);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 47);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 48);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 49);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 50);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 52);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 59);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 63);
INSERT INTO `vehicle_marketplace_db`.`offer_equipment` (`id_offer`, `id_equipment`) VALUES (21, 64);

COMMIT;

