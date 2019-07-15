DROP SCHEMA IF EXISTS ElectricOrigin;
CREATE DATABASE ElectricOrigin CHARACTER SET utf8;
USE ElectricOrigin;

#############
## MaConso ##
#############

DROP TABLE IF EXISTS MaConso;
CREATE TABLE MaConso(
	date_hour
	,consumption_hour
);


#######################
## ProductionFiliere ##
#######################
DROP TABLE IF EXISTS ProductionFiliere;
CREATE TABLE ProductionFiliere(
	TIME_SLOT
	,BIOMASS
	,FOSSIL_GAS
	,FOSSIL_HARD_COAL
	,FOSSIL_OIL
	,HYDRO_PUMPED_STORAGE
	,HYDRO_RUN_OF_RIVER_AND_POUNDAGE
	,HYDRO_WATER_RESERVOIR
	,NUCLEAR
	,SOLAR
	,WASTE
	,WIND_ONSHORE
	,TOTAL
);


#################
## EmissionCO2 ##
#################
DROP TABLE IF EXISTS EmissionCO2;
CREATE TABLE EmissionCO2(
	charbon
	,fioul
	,gaz
	,dechets
);


#################
## Utilisateur ##
#################
DROP TABLE IF EXISTS Utilisateur;
CREATE TABLE Utilisateur(
	id
	,nom
	,prenom
	,mail
	,password
	,composition_menage

);


#####################
## CarbonFootprint ##
#####################
DROP TABLE IF EXISTS CarbonFootprint;
CREATE TABLE CarbonFootprint(
	id
	,poids
	,utilisateur_id
);