#################################################################
#################################################################
### PROJET CERTIFICATION : ELECTRIC CARBON FOOTPRINT _ SCHEMA ###
#################################################################
#################################################################


DROP SCHEMA IF EXISTS ElectricOrigin;
CREATE DATABASE ElectricOrigin CHARACTER SET utf8;
USE ElectricOrigin;

#############
## MaConso ##
#############
DROP TABLE IF EXISTS MaConso;
CREATE TABLE MaConso(
	date_hour DATETIME
	,consumption_hour INT
);


#######################
## ProductionFiliere ##
#######################
DROP TABLE IF EXISTS ProductionFiliere;
CREATE TABLE ProductionFiliere(
	date_hour DATETIME
	,BIOMASS INT
	,FOSSIL_GAS INT
	,FOSSIL_HARD_COAL INT
	,FOSSIL_OIL INT
	,HYDRO_PUMPED_STORAGE INT
	,HYDRO_RUN_OF_RIVER_AND_POUNDAGE INT
	,HYDRO_WATER_RESERVOIR INT
	,NUCLEAR INT
	,SOLAR INT
	,WASTE INT
	,WIND_ONSHORE INT
	,TOTAL INT
);


#################
## EmissionCO2 ##
#################
DROP TABLE IF EXISTS EmissionCO2;
CREATE TABLE EmissionCO2(
	filiere VARCHAR(7)
	,contribution DECIMAL(4,3) 
);


#################
## Utilisateur ##
#################
DROP TABLE IF EXISTS Utilisateur;
CREATE TABLE Utilisateur(
	utilisateur_id INT UNSIGNED AUTO_INCREMENT
	,nom VARCHAR(20)
	,prenom VARCHAR(20)
	,mail VARCHAR (40)
	,password CHAR(40)  CHARACTER SET ASCII NOT NULL
	,composition_menage TINYINT
	,PRIMARY KEY(utilisateur_id)
);


#####################
## CarbonFootprint ##
#####################
DROP TABLE IF EXISTS CarbonFootprint;
CREATE TABLE CarbonFootprint(
	carbonfootprint_id INT UNSIGNED AUTO_INCREMENT
	,poids DECIMAL(6,3)
	,utilisateur_id INT UNSIGNED
	,PRIMARY KEY(carbonfootprint_id)
);