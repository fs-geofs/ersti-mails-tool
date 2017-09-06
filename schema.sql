-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ersti-mails
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ersti-mails` DEFAULT CHARACTER SET utf8 ;
USE `ersti-mails` ;

-- -----------------------------------------------------
-- Table `ersti-mails`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ersti-mails`.`users` ;

CREATE TABLE IF NOT EXISTS `ersti-mails`.`users` (
  `email` VARCHAR(50) NOT NULL NULL,
  `year` INT NOT NULL,
  `newsletter` BOOLEAN NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- date of registration
  PRIMARY KEY (`email`, `year`),
) ENGINE = InnoDB;

-- Compatibility to mysql < 5.6.*, replacing
-- CREATE USER IF NOT EXISTS `ersti-we`;
CREATE USER `ersti-mails`;
GRANT ALL PRIVILEGES ON `ersti-mails`.* TO `ersti-mails`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
