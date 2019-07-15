DROP SCHEMA IF EXISTS ElectricOrigin;
CREATE DATABASE ElectricOrigin CHARACTER SET 'utf8';
USE ElectricOrigin;

#############
## MaConso ##
#############

DROP TABLE IF EXISTS MaConso;
CREATE TABLE MaConso(
	date_hour TEXT
	,consumption_hour TEXT
);


#######################
## ProductionFiliere ##
#######################
DROP TABLE IF EXISTS ProductionFiliere;
CREATE TABLE ProductionFiliere(
);


#################
## EmissionCO2 ##
#################
DROP TABLE IF EXISTS EmissionCO2;
CREATE TABLE EmissionCO2(
);


#################
## Utilisateur ##
#################
DROP TABLE IF EXISTS Utilisateur;
CREATE TABLE Utilisateur(
);


#####################
## CarbonFootprint ##
#####################
DROP TABLE IF EXISTS CarbonFootprint;
CREATE TABLE CarbonFootprint(
);