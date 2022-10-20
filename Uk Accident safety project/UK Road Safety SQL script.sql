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

/*Creating Table for accidents_median */

CREATE TABLE accidents_median(
vehicle_types VARCHAR(100) NOT NULL,
severity INTEGER NOT NULL);

/* Computing the Data Analysis */

/*Creating the Index on the accident index for faster computation */

CREATE INDEX accident_index
ON accident(accident_index);

CREATE INDEX accident_index
ON vehicles(accident_index);


/* Task 2 Evaluate Accident Severity and Total Accidents per Vehicle Type */

SELECT vt.vehicle_type AS 'Vehicle Type', a.accident_severity AS 'Severity', COUNT(vt.vehicle_type) AS 'Number of Accidents'
FROM accident a
INNER JOIN vehicles v ON a.accident_index = v.accident_index
INNER JOIN vehicle_types vt ON v.vehicle_type = vt.vehicle_code
GROUP BY 1
ORDER BY 2,3;

/* Task 3 Calculate the Average Severity by vehicle type. */
SELECT vt.vehicle_type AS 'Vehicle Type', AVG(a.accident_severity) AS 'Average Severity', COUNT(vt.vehicle_type) AS 'Number of Accidents'
FROM accident a
INNER JOIN vehicles v ON a.accident_index = v.accident_index
INNER JOIN vehicle_types vt ON v.vehicle_type = vt.vehicle_code
GROUP BY 1
ORDER BY 2,3;

/* Task 4 Calculate the Average Severity and Total Accidents by Motorcycle. */

SELECT vt.vehicle_type AS 'Vehicle Type', AVG(a.accident_severity) AS 'Average Severity', COUNT(vt.vehicle_type) AS 'Number of Accidents'
FROM accident a
INNER JOIN vehicles v ON a.accident_index = v.accident_index
INNER JOIN vehicle_types vt ON v.vehicle_type = vt.vehicle_code
WHERE vt.vehicle_type LIKE '%motorcycle%'
GROUP BY 1
ORDER BY 2,3;


