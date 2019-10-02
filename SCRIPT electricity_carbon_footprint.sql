#################################################################
### PROJET CERTIFICATION : ELECTRIC CARBON FOOTPRINT _ SCRIPT ###
#################################################################

# Exportation de la table users en CSV 
SELECT * FROM users
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CertificationData/users_DB.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

#####Intéger les valeurs de la colonne carbon_footprint dans la table consumptions:
#1) créer une table consumptionstemp;
#2) remplir la date temporaire à partir d'une requette impliquant la table consumptions
#3) vider la table consumptions 
#4) Charger la table consumptions à partir de la table consumptionstemp

DROP TABLE IF EXISTS consumptionstemp;
CREATE TABLE consumptionstemp(
	timeslot DATETIME NOT NULL
	,user_id INT NOT NULL
	,consumption INT NOT NULL
	,carbon_footprint DECIMAL(6,3) NULL
	,PRIMARY KEY(timeslot, user_id)
);

INSERT INTO consumptionstemp(
	SELECT consumptions.timeslot
	,consumptions.user_id
	,consumptions.consumption
	,consumptions.consumption * (SUM(production_fields.C02_tons_per_MWh * productions.production)/SUM(productions.production))
	FROM consumptions
	INNER JOIN productions ON consumptions.timeslot = productions.timeslot  
	INNER JOIN production_fields ON productions.production_field = production_fields.name
	GROUP BY consumptions.timeslot
);

TRUNCATE TABLE consumptions;
INSERT INTO consumptions SELECT * FROM consumptionstemp;
TRUNCATE TABLE consumptionstemp;

# Exportation de la table consumptions en CSV 
SELECT * FROM consumptions
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CertificationData/consumptions_fullDB.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';



#Production total / heure 
#->Somme de la production de toute les filieres de chaque timeslot de la table productions
SELECT timeslot, SUM(production) FROM productions GROUP BY timeslot;

# emission co² filière
SELECT * FROM production_fields;

# emission de tonne de CO² par heure de la production francaise d'électricité  
# -> Jointure des tables productions & production_fields
#   ->sum(prodFiliereA * emission filiereA, prodFiliereB * emission filiereB,...) 
SELECT timeslot, SUM(C02_tons_per_MWh * production) 
FROM productions
INNER JOIN production_fields ON productions.production_field = production_fields.name 
GROUP BY timeslot
LIMIT 20;

# emission moyenne de tonne de CO²/MWh de la production française d'électricité pour chaque heure 
# -> Jointure table production&production field
#   ->sum(prodFiliereA*emission filiereA, prodFiliereB*emission filiereB,...)/sum(production) 
SELECT timeslot, SUM(C02_tons_per_MWh * production)/SUM(production)
FROM productions
INNER JOIN production_fields ON productions.production_field = production_fields.name 
GROUP BY timeslot
LIMIT 20;


# production sur toute la période (10 fév au 16 juillet)
SELECT SUM(production) FROM productions;


# production par mois : Mars
SELECT SUM(production) FROM productions 
WHERE timeslot >= '2019-03-01 00:00:00' AND timeslot < '2019-04-01 00:00:00';

# production par mois
SELECT MONTH(timeslot) AS 'n° de mois', SUM(production) AS 'production total en MW'FROM productions
WHERE MONTH(timeslot) = 2
UNION SELECT MONTH(timeslot), SUM(production) FROM productions
WHERE MONTH(timeslot) = 3
UNION SELECT MONTH(timeslot), SUM(production) FROM productions
WHERE MONTH(timeslot) = 4
UNION SELECT MONTH(timeslot), SUM(production) FROM productions
WHERE MONTH(timeslot) = 5
UNION SELECT MONTH(timeslot), SUM(production) FROM productions
WHERE MONTH(timeslot) = 6
UNION SELECT MONTH(timeslot), SUM(production) FROM productions
WHERE MONTH(timeslot) = 7;


# J'affiche pour chaque heure, la consommation et la production totale d'électricité.
# Je fais une jointure sur le timeslot entre les tables consumptions et productions
SELECT consumptions.timeslot, consumptions.consumption, SUM(productions.production)
FROM consumptions
INNER JOIN productions ON consumptions.timeslot = productions.timeslot  
WHERE consumptions.user_id = 116
GROUP BY consumptions.timeslot
LIMIT 20;

# J'affiche pour chaque heure, la consommation et l'émission de CO² moyen
# Je fais une jointure sur le timeslot entre les tables consumptions et productions
# puis une jointure sur la filière de production entre les tables productions et production_fields
SELECT consumptions.timeslot, consumptions.consumption, SUM(production_fields.C02_tons_per_MWh * productions.production)/SUM(productions.production) AS 'g_CO2/KWh'
FROM consumptions
INNER JOIN productions ON consumptions.timeslot = productions.timeslot  
INNER JOIN production_fields ON productions.production_field = production_fields.name
WHERE consumptions.user_id = 116
GROUP BY consumptions.timeslot
LIMIT 20;

# J'affiche pour chaque heure l'émission de C0² selon la consommation d'électricité pour l'utilisateur n°116
SELECT consumptions.timeslot, consumptions.consumption * (SUM(production_fields.C02_tons_per_MWh * productions.production)/SUM(productions.production)) AS 'g_CO2'
FROM consumptions
INNER JOIN productions ON consumptions.timeslot = productions.timeslot  
INNER JOIN production_fields ON productions.production_field = production_fields.name
WHERE consumptions.user_id = 116
GROUP BY consumptions.timeslot
LIMIT 20;
