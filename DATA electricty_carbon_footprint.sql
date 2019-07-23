###############################################################
###############################################################
### PROJET CERTIFICATION : ELECTRIC CARBON FOOTPRINT _ DATA ###
###############################################################
###############################################################

USE ElectricOrigin;


#################
## EmissionCO2 ##
#################
INSERT INTO EmissionCO2 (filiere, contribution)
VALUES ('FOSSIL_HARD_COAL', 0.986)
	,('FOSSIL_OIL', 0.777)
	,('FOSSIL_GAS', 0.474)
	,('BIOMASS', 0.988)
	,('WASTE',0.988)
	,('HYDRO_PUMPED_STORAGE', 0)
	,('HYDRO_RUN_OF_RIVER_AND_POUNDAGE', 0)
	,('HYDRO_WATER_RESERVOIR', 0)
	,('NUCLEAR', 0)
	,('SOLAR', 0)
	,('WIND_ONSHORE', 0);



#################
## Utilisateur ##
#################
INSERT INTO Utilisateur(nom, prenom, mail, password, composition_menage)
VALUES('PEPIN-NEANG', 'Caroline', 'caroline.neang@gmail.com', SHA1('mon_motdepasse'), 2);


#############
## MaConso ##
#############
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CertificationData/fournisseur/ConsoEnedis_df_1002.csv'
INTO TABLE MaConso
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
ignore 1 lines;


#######################
## ProductionFiliere ##
#######################
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CertificationData/RTE/ProductionFiliere.csv'
INTO TABLE ProductionFiliere
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
ignore 1 lines;

#####################
## CarbonFootprint ##
#####################
INSERT INTO CarbonFootprint(poids, utilisateur_id)
VALUES();