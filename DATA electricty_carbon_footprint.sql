###############################################################
### PROJET CERTIFICATION : ELECTRIC CARBON FOOTPRINT _ DATA ###
###############################################################

USE ElectricOrigin;
###############
## timeslots ##
###############
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CertificationData/timeslots.csv'
INTO TABLE timeslots
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
ignore 1 lines;

###########
## users ##
###########
INSERT INTO users(user_id, lastname, firstname, mail, password, number_people)
VALUES(116,'PEPIN-NEANG', 'Caroline', 'caroline.neang@gmail.com', 'mon_motdepasse', 2);

#######################
## production_fields ##
#######################
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CertificationData/production_fields.csv'
INTO TABLE production_fields
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
ignore 1 lines;

#################
## productions ##
#################
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CertificationData/productions.csv'
INTO TABLE productions
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
ignore 1 lines;

##################
## consumptions ##
##################
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CertificationData/consumptions.csv'
INTO TABLE consumptions
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
ignore 1 lines
(timeslot,user_id,consumption,@carbon_footprint)
SET carbon_footprint= nullif(@carbon_footprint, 'NULL');