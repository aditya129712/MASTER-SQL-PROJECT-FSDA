CREATE DATABASE AG_UK_SAFETY_DATABASE;
USE AG_UK_SAFETY_DATABASE;

/* -------------------------------- */
/* CREATE TABLES AND LOAD THE DATASET */

CREATE TABLE accident(
	accident_index VARCHAR(20) NOT NULL,
    accident_severity INTEGER NOT NULL
);

CREATE TABLE vehicles(
	accident_index VARCHAR(20) NOT NULL,
    vehicle_type VARCHAR(50) NOT NULL
);



CREATE TABLE vehicle_types(
	vehicle_code INTEGER NOT NULL,
    vehicle_type VARCHAR(60) NOT NULL
);


/* -------------------------------- */
/* LOAD THE DATASET */

LOAD DATA INFILE 'C:\\Users\\Accidents_2015.csv'
INTO TABLE accident
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @dummy, @dummy, @dummy, @dummy, @dummy, @col2, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
SET accident_index=@col1, accident_severity=@col2;

SELECT * FROM accident;

LOAD DATA INFILE 'C:\\Users\\Vehicles_2015.csv'
INTO TABLE vehicles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @dummy, @col2, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
SET accident_index=@col1, vehicle_type=@col2;

SELECT * FROM vehicles;

LOAD DATA INFILE 'C:\\Users\\vehicle_types.csv'
INTO TABLE vehicle_types
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT * FROM vehicle_types;

