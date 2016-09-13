-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ersti-we
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ersti-we` DEFAULT CHARACTER SET utf8 ;
USE `ersti-we` ;

-- -----------------------------------------------------
-- Table `ersti-we`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ersti-we`.`users` ;

CREATE TABLE IF NOT EXISTS `ersti-we`.`users` (
  `token` CHAR(8) NOT NULL,      -- registration token
  `emailtoken` CHAR(8) NOT NULL, -- email confirmation token
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  `gender` ENUM('male', 'female', 'other') NULL,
  `email` VARCHAR(45) NULL,
  `phone` VARCHAR(20) NULL,
  `address` VARCHAR(200) NULL,
  `info` VARCHAR(500) NULL,
  `birthday` VARCHAR(20) NULL,
  `food` ENUM('any', 'vegan', 'vegetarian') NULL,
  `study` ENUM('geoinf', 'geo', 'loek', 'zweifach') NULL,
  `year` INT NOT NULL, -- assigned year of the user
  `state` ENUM('free', 'registered', 'opted_out') NOT NULL DEFAULT 'free', -- flag, whether a token is used or not
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- date of registration
  `prev_user` CHAR(8) NULL, -- references the the user previous user of the spot (for waitlist registrations)
  PRIMARY KEY (`token`, `year`),
  FOREIGN KEY (`prev_user`) REFERENCES users(`token`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ersti-we`.`waitlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ersti-we`.`waitlist` ;

CREATE TABLE IF NOT EXISTS `ersti-we`.`waitlist` (
  `email` VARCHAR(45) NOT NULL,
  `year` INT NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`email`, `year`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Triggers
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS `registerUser`;

DELIMITER |
CREATE TRIGGER `registerUser` BEFORE UPDATE ON `users`
  FOR EACH ROW
  BEGIN
    DELETE FROM waitlist WHERE email=NEW.email AND year=NEW.year;
  END;
|
DELIMITER ;

-- Compatibility to mysql < 5.6.*
-- Same functionality as:
-- CREATE USER IF NOT EXISTS `ersti-we`;
GRANT SELECT ON *.* TO 'ersti-we';
DROP USER `ersti-we`;
CREATE USER `ersti-we`;

GRANT ALL PRIVILEGES ON `ersti-we`.* TO `ersti-we`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;