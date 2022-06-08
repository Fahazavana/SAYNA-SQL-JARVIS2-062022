CREATE SCHEMA IF NOT EXISTS `Jarvis` DEFAULT CHARACTER SET utf8;


CREATE TABLE IF NOT EXISTS `Jarvis`.`Utilisateur` (
	`idUtilisateur` INT NOT NULL AUTO_INCREMENT,
	`nomUtilisateur` VARCHAR(45) NULL,
	`prenomUtilisateur` VARCHAR(45) NOT NULL,
	`emailUtilisateur` VARCHAR(45) NOT NULL,
	`sexeutilistauer` CHAR(1) NOT NULL,
	`dateNaissanceUtilisateur` DATE NULL,
	`motDePasseUtilisateur` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`idUtilisateur`)
) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Jarvis`.`Domiciles` (
	`idDomicile` INT NOT NULL AUTO_INCREMENT,
	`AdresseDomicile` VARCHAR(45) NULL,
	`AnneConstruction` DATE NULL,
	`Superficie` REAL NULL,
	PRIMARY KEY (`idDomicile`)
) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Jarvis`.`Membre` (
	`idMembre` INT NOT NULL AUTO_INCREMENT,
	`Utilisateur_idUtilisateur` INT NOT NULL,
	`enParente` VARCHAR(45) NULL,
	PRIMARY KEY (`idMembre`, `Utilisateur_idUtilisateur`),
	CONSTRAINT `fk_Membre_Utilisateur` FOREIGN KEY (`Utilisateur_idUtilisateur`) REFERENCES `Jarvis`.`Utilisateur` (`idUtilisateur`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Jarvis`.`CoProprietaire` (
	`id_CoProprietaire` INT NOT NULL AUTO_INCREMENT,
	`Utilisateur_idUtilisateur` INT NOT NULL,
	PRIMARY KEY (`id_CoProprietaire`, `Utilisateur_idUtilisateur`),
	CONSTRAINT `fk_CoProprietaire_Utilisateur1` FOREIGN KEY (`Utilisateur_idUtilisateur`) REFERENCES `Jarvis`.`Utilisateur` (`idUtilisateur`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `Jarvis`.`Proprietaire` (
	`id_Proprietaire` INT NOT NULL AUTO_INCREMENT,
	`Utilisateur_idUtilisateur` INT NOT NULL,
	`Domiciles_idDomicile` INT NOT NULL,
	PRIMARY KEY (
		`id_Proprietaire`,
		`Utilisateur_idUtilisateur`,
		`Domiciles_idDomicile`
	),
	INDEX `fk_Proprietaire_Domiciles1_idx` (`Domiciles_idDomicile` ASC) VISIBLE,
	CONSTRAINT `fk_Proprietaire_Utilisateur1` FOREIGN KEY (`Utilisateur_idUtilisateur`) REFERENCES `Jarvis`.`Utilisateur` (`idUtilisateur`) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `fk_Proprietaire_Domiciles1` FOREIGN KEY (`Domiciles_idDomicile`) REFERENCES `Jarvis`.`Domiciles` (`idDomicile`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Jarvis`.`Habiter` (
	`Utilisateur_idUtilisateur` INT NOT NULL,
	`Domiciles_idDomicile` INT NOT NULL,
	PRIMARY KEY (
		`Utilisateur_idUtilisateur`,
		`Domiciles_idDomicile`
	),
	INDEX `fk_Utilisateur_has_Domiciles_Domiciles1_idx` (`Domiciles_idDomicile` ASC) VISIBLE,
	INDEX `fk_Utilisateur_has_Domiciles_Utilisateur1_idx` (`Utilisateur_idUtilisateur` ASC) VISIBLE,
	CONSTRAINT `fk_Utilisateur_has_Domiciles_Utilisateur1` FOREIGN KEY (`Utilisateur_idUtilisateur`) REFERENCES `Jarvis`.`Utilisateur` (`idUtilisateur`) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `fk_Utilisateur_has_Domiciles_Domiciles1` FOREIGN KEY (`Domiciles_idDomicile`) REFERENCES `Jarvis`.`Domiciles` (`idDomicile`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Jarvis`.`Inviter` (
  `Utilisateur_idUtilisateur` INT NOT NULL,
  `Proprietaire_id_Proprietaire` INT NOT NULL,
  `Proprietaire_Utilisateur_idUtilisateur` INT NOT NULL,
  `Proprietaire_Domiciles_idDomicile` INT NOT NULL,
  PRIMARY KEY (`Utilisateur_idUtilisateur`, `Proprietaire_id_Proprietaire`, `Proprietaire_Utilisateur_idUtilisateur`, `Proprietaire_Domiciles_idDomicile`),
  INDEX `fk_Utilisateur_has_Proprietaire_Proprietaire1_idx` (`Proprietaire_id_Proprietaire` ASC, `Proprietaire_Utilisateur_idUtilisateur` ASC, `Proprietaire_Domiciles_idDomicile` ASC) VISIBLE,
  INDEX `fk_Utilisateur_has_Proprietaire_Utilisateur1_idx` (`Utilisateur_idUtilisateur` ASC) VISIBLE,
  CONSTRAINT `fk_Utilisateur_has_Proprietaire_Utilisateur1`
    FOREIGN KEY (`Utilisateur_idUtilisateur`)
    REFERENCES `Jarvis`.`Utilisateur` (`idUtilisateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Utilisateur_has_Proprietaire_Proprietaire1`
    FOREIGN KEY (`Proprietaire_id_Proprietaire` , `Proprietaire_Utilisateur_idUtilisateur` , `Proprietaire_Domiciles_idDomicile`)
    REFERENCES `Jarvis`.`Proprietaire` (`id_Proprietaire` , `Utilisateur_idUtilisateur` , `Domiciles_idDomicile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Jarvis`.`Pieces` (
	`idPiece` INT NOT NULL AUTO_INCREMENT,
	`nomPiece` VARCHAR(45) NULL,
	PRIMARY KEY (`idPiece`)
) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Jarvis`.`Contenir` (
  `Domiciles_idDomicile` INT NOT NULL,
  `Pieces_idPiece` INT NOT NULL,
  PRIMARY KEY (`Domiciles_idDomicile`, `Pieces_idPiece`),
  INDEX `fk_Domiciles_has_Pieces_Pieces1_idx` (`Pieces_idPiece` ASC) VISIBLE,
  INDEX `fk_Domiciles_has_Pieces_Domiciles1_idx` (`Domiciles_idDomicile` ASC) VISIBLE,
  CONSTRAINT `fk_Domiciles_has_Pieces_Domiciles1`
    FOREIGN KEY (`Domiciles_idDomicile`)
    REFERENCES `Jarvis`.`Domiciles` (`idDomicile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Domiciles_has_Pieces_Pieces1`
    FOREIGN KEY (`Pieces_idPiece`)
    REFERENCES `Jarvis`.`Pieces` (`idPiece`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `Jarvis`.`Appareils` (
	`idAppareils` INT NOT NULL AUTO_INCREMENT,
	`nomAppareil` VARCHAR(45) NULL,
	`typeAppareil` VARCHAR(45) NULL,
	PRIMARY KEY (`idAppareils`)
) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Jarvis`.`SeTrouve` (
  `Appareils_idAppareils` INT NOT NULL,
  `Pieces_idPiece` INT NOT NULL,
  PRIMARY KEY (`Appareils_idAppareils`, `Pieces_idPiece`),
  INDEX `fk_Appareils_has_Pieces_Pieces1_idx` (`Pieces_idPiece` ASC) VISIBLE,
  INDEX `fk_Appareils_has_Pieces_Appareils1_idx` (`Appareils_idAppareils` ASC) VISIBLE,
  CONSTRAINT `fk_Appareils_has_Pieces_Appareils1`
    FOREIGN KEY (`Appareils_idAppareils`)
    REFERENCES `Jarvis`.`Appareils` (`idAppareils`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appareils_has_Pieces_Pieces1`
    FOREIGN KEY (`Pieces_idPiece`)
    REFERENCES `Jarvis`.`Pieces` (`idPiece`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;