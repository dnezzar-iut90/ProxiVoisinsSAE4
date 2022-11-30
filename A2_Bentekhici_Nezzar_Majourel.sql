/*
:::: GROUPE 5 ::::
NEZZAR Dalia
MAJOUREL Ambre
BENTEKHICI Noham
::::::::::::::::::

///////////////
   SOMMAIRE
///////////////
1. SUPPRESSION DE TABLES
2. CREATION DE TABLES DE COVOITURAGE
3. ENREGISTREMENTS
4. JEUX DE TESTS, JOINTURES, ETC.
///////////////

*/

/*1. TABLES SUPPRIMEES*/

DROP TABLE IF EXISTS utilise, VOITURE, MODELE, RESERVATION, TRAJET, UTILISATEUR, MARQUE, TYPE_ASSURANCE, ASSURANCE, COMMUNE, PERMIS;


/*2. TABLES COVOITURAGE*/

CREATE TABLE PERMIS(
   id_permis VARCHAR(12) PRIMARY KEY,
   date_d_obtention DATE,
   nombre_de_points INT
);

CREATE TABLE COMMUNE(
   id_commune int PRIMARY KEY AUTO_INCREMENT,
   nom_commune VARCHAR(50),
   code_postal VARCHAR(50)
);

CREATE TABLE TYPE_ASSURANCE(
   id_type int PRIMARY KEY AUTO_INCREMENT,
   type_d_assurance VARCHAR(50)
);

CREATE TABLE ASSURANCE(
   id_assurance int PRIMARY KEY AUTO_INCREMENT,
   date_d_expiration DATE,
   id_type INT NOT NULL,
   FOREIGN KEY(id_type) REFERENCES TYPE_ASSURANCE(id_type)
);


CREATE TABLE MARQUE(
   id_marque int PRIMARY KEY AUTO_INCREMENT,
   marque VARCHAR(50)
);

CREATE TABLE UTILISATEUR(
   id_utilisateur int PRIMARY KEY AUTO_INCREMENT,
   nom_user VARCHAR(50),
   prenom_user VARCHAR(50),
   date_naissance Date,
   sexe VARCHAR(1),
   numero_de_telephone VARCHAR(13),
   fumeurO_N BOOLEAN,
   adresse VARCHAR(50),
   newsletterO_N BOOLEAN,
   conducteurO_N BOOLEAN,
   id_permis VARCHAR(12),
   id_commune INT NOT NULL,
   FOREIGN KEY(id_permis) REFERENCES PERMIS(id_permis),
   FOREIGN KEY(id_commune) REFERENCES COMMUNE(id_commune)
);

CREATE TABLE TRAJET(
   id_trajet int PRIMARY KEY AUTO_INCREMENT,
   date_heure_de_depart DATETIME,
   date_heure_d_arrivee DATETIME,
   distance_parcourue VARCHAR(50),
   nombre_de_place_s INT,
   lieu_destinationoudepart VARCHAR(50),
   id_utilisateur INT NOT NULL,
   id_commune INT NOT NULL,
   FOREIGN KEY(id_utilisateur) REFERENCES UTILISATEUR(id_utilisateur),
   FOREIGN KEY(id_commune) REFERENCES COMMUNE(id_commune)
);

CREATE TABLE RESERVATION(
   id_reservation int PRIMARY KEY AUTO_INCREMENT,
   date_de_reservation DATE,
   id_trajet INT NOT NULL,
   id_utilisateur INT NOT NULL,
   FOREIGN KEY(id_trajet) REFERENCES TRAJET(id_trajet),
   FOREIGN KEY(id_utilisateur) REFERENCES UTILISATEUR(id_utilisateur)
);

CREATE TABLE MODELE(
   id_modele int PRIMARY KEY AUTO_INCREMENT,
   modele VARCHAR(50),
   nombre_de_sieges INT,
   id_marque INT NOT NULL,
   FOREIGN KEY(id_marque) REFERENCES MARQUE(id_marque)
);

CREATE TABLE VOITURE(
   plaque_voiture VARCHAR(50) PRIMARY KEY,
   date_d_achat VARCHAR(50),
   kilometrage INT,
   date_de_mise_en_circulation DATE,
   id_assurance INT NOT NULL,
   id_modele INT NOT NULL,
   id_utilisateur INT NOT NULL,
   FOREIGN KEY(id_assurance) REFERENCES ASSURANCE(id_assurance),
   FOREIGN KEY(id_modele) REFERENCES MODELE(id_modele),
   FOREIGN KEY(id_utilisateur) REFERENCES UTILISATEUR(id_utilisateur)
);



/* 3. ENREGISTREMENTS   */

INSERT INTO PERMIS (id_permis, date_d_obtention, nombre_de_points) VALUES
(000316820586, '1996-01-25', 12),
(020048653207, '2012-08-14', 9);

INSERT INTO COMMUNE(id_commune, nom_commune, code_postal) VALUES
(1, 'Saint-Côve-Sur-Vincelles', 16122);

INSERT INTO UTILISATEUR (id_utilisateur, nom_user, prenom_user, date_naissance, sexe, numero_de_telephone, fumeurO_N, adresse, newsletterO_N, conducteurO_N, id_permis, id_commune) VALUES
(1, 'LECOMPTE', 'Karim', '1978-04-22', 'H', '0657894635', TRUE, '8 Avenue de la Rocade', FALSE, TRUE, 000316820586, 1),
(2, 'ROGER', 'Aida', '2001-12-11', 'F', '0754893268', FALSE, '4 bis rue de la Riviere', TRUE, FALSE, NULL, 1),
(3, 'DA SILVA', 'Woody', '1994-07-07', 'H', '0684531982', TRUE, '77 chemin Hoareau', FALSE, TRUE, 020048653207, 1);

INSERT INTO TYPE_ASSURANCE(id_type, type_d_assurance) VALUES
(1, 'Assurance au tiers'),
(2, 'Assurance tous risque'),
(3, 'Assurance au kilomètre');

INSERT INTO ASSURANCE (id_assurance, date_d_expiration, id_type) VALUES
(1, '2024-03-14', '1'),
(2, '2023-08-22', '2'),
(3, '2024-01-11', '3');

INSERT INTO TRAJET (id_trajet, date_heure_de_depart, date_heure_d_arrivee, distance_parcourue, nombre_de_place_s, lieu_destinationoudepart, id_utilisateur, id_commune) VALUES
(1, '2022-11-30 14:30:00', '2022-11-30 14:45:00', '10', '3', 'Intermarché', 3, 1),
(2, '2022-12-02 11:05:00', '2022-12-02 11:30:00', '11', '1', 'Auchan', 3, 1),
(3, '2023-01-05 09:10:00', '2023-01-05 10:15:00', '53', '2', 'Hôpital', 1, 1);

INSERT INTO MARQUE (id_marque, marque) VALUES
(1, 'Renault'),
(2, 'Volkswagen');

INSERT INTO MODELE (id_modele, modele, nombre_de_sieges, id_marque) VALUES
(1, 'Espace', '7', 1),
(2, 'Tiguan', '5', 2);

INSERT INTO VOITURE (plaque_voiture, date_d_achat, kilometrage, date_de_mise_en_circulation, id_assurance, id_modele, id_utilisateur) VALUES
('EH-806-LV', '2002-06-22', '20355', '2002-06-22', 1, 1, 3),
('ME-018-YY','2005-03-09', '15762', '2005-03-09', 1, 2, 1);

INSERT INTO RESERVATION(id_reservation, date_de_reservation, id_trajet, id_utilisateur) VALUES
(1, '2022-11-18', 1, 2),
(2, '2022-11-25', 2, 1);


/* 4. TESTS, JOINTURES, etc   */

SELECT * from UTILISATEUR;
SELECT * from TRAJET;
SELECT * from RESERVATION;

SHOW TABLES;

SELECT COUNT(*) as "Nombre d'utilisateurs"
FROM UTILISATEUR;

SELECT COUNT(*) as "Nombre de trajet"
FROM TRAJET;

SELECT COMMUNE.nom_commune, nom_user
FROM UTILISATEUR
INNER JOIN COMMUNE
    ON UTILISATEUR.id_commune = COMMUNE.id_commune
WHERE UTILISATEUR.nom_user='LECOMPTE';

SELECT MODELE.modele, plaque_voiture
FROM VOITURE
INNER JOIN MODELE
    ON VOITURE.id_modele = MODELE.id_modele;

SELECT UTILISATEUR.nom_user, UTILISATEUR.prenom_user, id_trajet, date_heure_de_depart
FROM TRAJET
INNER JOIN UTILISATEUR
    ON TRAJET.id_utilisateur = UTILISATEUR.id_utilisateur;

SELECT id_reservation as 'Reservation n', id_utilisateur as 'Numero utilisateur'
FROM RESERVATION
WHERE id_trajet=1 and id_utilisateur=2;
