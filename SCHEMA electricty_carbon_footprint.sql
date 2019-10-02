#################################################################
### PROJET CERTIFICATION : ELECTRIC CARBON FOOTPRINT _ SCHEMA ###
#################################################################

DROP SCHEMA IF EXISTS ElectricOrigin;
CREATE DATABASE ElectricOrigin CHARACTER SET utf8;
USE ElectricOrigin;

##################
## consumptions ##
##################
DROP TABLE IF EXISTS consumptions;
CREATE TABLE consumptions(
	timeslot DATETIME NOT NULL
	,user_id INT NOT NULL
	,consumption INT NOT NULL
	,carbon_footprint DECIMAL(6,3) NULL
	,PRIMARY KEY(timeslot, user_id)
);

###############
## timeslots ##
###############
DROP TABLE IF EXISTS timeslots;
CREATE TABLE timeslots(
	timeslot DATETIME NOT NULL
	,season ENUM('spring','summer','fall','winter') NULL
	,day_night ENUM('day', 'night') NULL
	,PRIMARY KEY(timeslot)
);
ALTER TABLE consumptions ADD CONSTRAINT fk_consumptions_timeslot FOREIGN KEY(timeslot) REFERENCES timeslots(timeslot);

###########
## users ##
###########
DROP TABLE IF EXISTS users;
CREATE TABLE users(
	user_id INT  NOT NULL
	,lastname VARCHAR(20) NULL
	,firstname VARCHAR(20) NULL
	,mail VARCHAR(40) NULL
	,password TEXT NULL
	,number_people TINYINT NULL DEFAULT 1
	,PRIMARY KEY(user_id)
);
ALTER TABLE consumptions ADD CONSTRAINT fk_consumptions_user_id FOREIGN KEY(user_id) REFERENCES users(user_id);

#################
## productions ##
#################
DROP TABLE IF EXISTS productions;
CREATE TABLE productions(
	timeslot DATETIME NOT NULL
	,production_field VARCHAR(50) NOT NULL
	,production INT NOT NULL
	,PRIMARY KEY(timeslot, production_field)
);
ALTER TABLE productions ADD CONSTRAINT fk_productions_timeslot FOREIGN KEY(timeslot) REFERENCES timeslots(timeslot);

#######################
## production_fields ##
#######################
DROP TABLE IF EXISTS production_fields;
CREATE TABLE production_fields(
	name VARCHAR(50) NOT NULL
	,C02_tons_per_MWh DECIMAL(4,3) NOT NULL
	,PRIMARY KEY(name)
);
ALTER TABLE productions ADD CONSTRAINT fk_productions_productionfields FOREIGN KEY(production_field) REFERENCES production_fields(name);