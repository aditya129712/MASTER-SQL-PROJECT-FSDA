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

