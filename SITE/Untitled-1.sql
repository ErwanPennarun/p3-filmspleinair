-- MySQL Script generated by MySQL Workbench
-- Fri Dec 20 14:08:54 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

/* CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ; */

-- -----------------------------------------------------
-- Table `mydb`.`DispoLivreur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DispoLivreur` (
  `disponible` TINYINT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`disponible`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Livreur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Livreur` (
  `idLivreur` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `prenom` VARCHAR(45) NULL,
  `telephone` VARCHAR(45) NULL,
  `longitude` DECIMAL NULL,
  `latitude` DECIMAL NULL,
  `DispoLivreur_disponible` TINYINT NULL,
  PRIMARY KEY (`idLivreur`),
  INDEX `fk_Livreur_DispoLivreur_idx` (`DispoLivreur_disponible` ASC) ,
  CONSTRAINT `fk_Livreur_DispoLivreur`
    FOREIGN KEY (`DispoLivreur_disponible`)
    REFERENCES `mydb`.`DispoLivreur` (`disponible`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Adresse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Adresse` (
  `idAdresse` INT NOT NULL AUTO_INCREMENT,
  `numeroRue` SMALLINT NULL,
  `voie` VARCHAR(45) NULL,
  `codePostal` SMALLINT NULL,
  PRIMARY KEY (`idAdresse`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Commande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Commande` (
  `idCommande` INT NOT NULL AUTO_INCREMENT,
  `dateCommande` DATE NULL,
  `heureCommande` TIME NULL,
  `prixCommande` DECIMAL NULL,
  `modePaiement` VARCHAR(45) NULL,
  `Livreur_idLivreur` INT NULL,
  `Adresse_idAdresse` INT NULL,
  PRIMARY KEY (`idCommande`, `Livreur_idLivreur`, `Adresse_idAdresse`),
  INDEX `fk_Commande_Livreur1_idx` (`Livreur_idLivreur` ASC) ,
  INDEX `fk_Commande_Adresse1_idx` (`Adresse_idAdresse` ASC) ,
  CONSTRAINT `fk_Commande_Livreur1`
    FOREIGN KEY (`Livreur_idLivreur`)
    REFERENCES `mydb`.`Livreur` (`idLivreur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Commande_Adresse1`
    FOREIGN KEY (`Adresse_idAdresse`)
    REFERENCES `mydb`.`Adresse` (`idAdresse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`StatuCommande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`StatuCommande` (
  `statutCommande` VARCHAR(45) NOT NULL,
  `Commande_idCommande` INT NULL,
  `Commande_Livreur_idLivreur` INT NULL,
  INDEX `fk_StatuCommande_Commande1_idx` (`Commande_idCommande` ASC, `Commande_Livreur_idLivreur` ASC) ,
  CONSTRAINT `fk_StatuCommande_Commande1`
    FOREIGN KEY (`Commande_idCommande` , `Commande_Livreur_idLivreur`)
    REFERENCES `mydb`.`Commande` (`idCommande` , `Livreur_idLivreur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `idClient` INT NOT NULL AUTO_INCREMENT,
  `nomClient` VARCHAR(45) NULL,
  `prenomClient` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `telephone` VARCHAR(45) NULL,
  `Adresse_idAdresse` INT NOT NULL,
  `Commande_idCommande` INT NOT NULL,
  `Commande_Livreur_idLivreur` INT NOT NULL,
  PRIMARY KEY (`idClient`, `Adresse_idAdresse`, `Commande_idCommande`, `Commande_Livreur_idLivreur`),
  INDEX `fk_Client_Adresse1_idx` (`Adresse_idAdresse` ASC) ,
  INDEX `fk_Client_Commande1_idx` (`Commande_idCommande` ASC, `Commande_Livreur_idLivreur` ASC) ,
  CONSTRAINT `fk_Client_Adresse1`
    FOREIGN KEY (`Adresse_idAdresse`)
    REFERENCES `mydb`.`Adresse` (`idAdresse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Client_Commande1`
    FOREIGN KEY (`Commande_idCommande` , `Commande_Livreur_idLivreur`)
    REFERENCES `mydb`.`Commande` (`idCommande` , `Livreur_idLivreur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Plat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Plat` (
  `idPlat` INT NOT NULL,
  `nomPlat` VARCHAR(45) NULL,
  `photoPlat` BLOB NULL,
  `datePlat` DATE NULL,
  PRIMARY KEY (`idPlat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Dessert`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Dessert` (
  `idDessert` INT NOT NULL,
  `nomDessert` VARCHAR(45) NULL,
  `photoDessert` BLOB NULL,
  `dateDessert` DATE NULL,
  PRIMARY KEY (`idDessert`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MenuDuJour`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MenuDuJour` (
  `idMenuDuJour` INT NOT NULL AUTO_INCREMENT,
  `nomPlat` VARCHAR(45) NULL,
  `nomDessert` VARCHAR(45) NULL,
  `Commande_idCommande` INT NULL,
  `Commande_Livreur_idLivreur` INT NULL,
  `Plat_idPlat` INT NOT NULL,
  `Dessert_idDessert` INT NOT NULL,
  PRIMARY KEY (`idMenuDuJour`, `Commande_idCommande`, `Commande_Livreur_idLivreur`, `Plat_idPlat`, `Dessert_idDessert`),
  INDEX `fk_MenuDuJour_Commande1_idx` (`Commande_idCommande` ASC, `Commande_Livreur_idLivreur` ASC) ,
  INDEX `fk_MenuDuJour_Plat1_idx` (`Plat_idPlat` ASC) ,
  INDEX `fk_MenuDuJour_Dessert1_idx` (`Dessert_idDessert` ASC) ,
  CONSTRAINT `fk_MenuDuJour_Commande1`
    FOREIGN KEY (`Commande_idCommande` , `Commande_Livreur_idLivreur`)
    REFERENCES `mydb`.`Commande` (`idCommande` , `Livreur_idLivreur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MenuDuJour_Plat1`
    FOREIGN KEY (`Plat_idPlat`)
    REFERENCES `mydb`.`Plat` (`idPlat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MenuDuJour_Dessert1`
    FOREIGN KEY (`Dessert_idDessert`)
    REFERENCES `mydb`.`Dessert` (`idDessert`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Chef`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Chef` (
  `idChef` INT NOT NULL AUTO_INCREMENT,
  `prenom` VARCHAR(45) NULL,
  `nom` VARCHAR(45) NULL,
  `MenuDuJour_idMenuDuJour` INT NULL,
  `MenuDuJour_Commande_idCommande` INT NULL,
  `MenuDuJour_Commande_Livreur_idLivreur` INT NULL,
  `MenuDuJour_Plat_idPlat` INT NULL,
  `MenuDuJour_Dessert_idDessert` INT NULL,
  PRIMARY KEY (`idChef`, `MenuDuJour_idMenuDuJour`, `MenuDuJour_Commande_idCommande`, `MenuDuJour_Commande_Livreur_idLivreur`, `MenuDuJour_Plat_idPlat`, `MenuDuJour_Dessert_idDessert`),
  INDEX `fk_Chef_MenuDuJour1_idx` (`MenuDuJour_idMenuDuJour` ASC, `MenuDuJour_Commande_idCommande` ASC, `MenuDuJour_Commande_Livreur_idLivreur` ASC, `MenuDuJour_Plat_idPlat` ASC, `MenuDuJour_Dessert_idDessert` ASC) ,
  CONSTRAINT `fk_Chef_MenuDuJour1`
    FOREIGN KEY (`MenuDuJour_idMenuDuJour` , `MenuDuJour_Commande_idCommande` , `MenuDuJour_Commande_Livreur_idLivreur` , `MenuDuJour_Plat_idPlat` , `MenuDuJour_Dessert_idDessert`)
    REFERENCES `mydb`.`MenuDuJour` (`idMenuDuJour` , `Commande_idCommande` , `Commande_Livreur_idLivreur` , `Plat_idPlat` , `Dessert_idDessert`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`StockLivreur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`StockLivreur` (
  `nombreDessert` DECIMAL NULL,
  `nombrePlats` DECIMAL NULL,
  `Livreur_idLivreur` INT NOT NULL,
  INDEX `fk_StockLivreur_Livreur1_idx` (`Livreur_idLivreur` ASC) ,
  CONSTRAINT `fk_StockLivreur_Livreur1`
    FOREIGN KEY (`Livreur_idLivreur`)
    REFERENCES `mydb`.`Livreur` (`idLivreur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
