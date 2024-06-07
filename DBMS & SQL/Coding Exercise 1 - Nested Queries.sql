# Creation of database METRO TRAIN SUSTEM if it does not exist
CREATE DATABASE IF NOT EXISTS `METRO TRAIN SYSTEM`;
USE `METRO TRAIN SYSTEM`;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Creation of Tables

# Creating Table route if it does not exist
CREATE TABLE IF NOT EXISTS route (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    route_name VARCHAR(255)
);

# Creating table station if it does not exist
CREATE TABLE IF NOT EXISTS station (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    locality VARCHAR(100),
    is_interchange TINYINT(1)
);

# Creating table station_route if it does not exist
CREATE TABLE IF NOT EXISTS station_route (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    station_id INT(11),
    route_id INT(11),
    position INT(11),
    FOREIGN KEY (station_id) REFERENCES station(id),
    FOREIGN KEY (route_id) REFERENCES route(id)
);

# Creating table metro_train if it does not exist
CREATE TABLE IF NOT EXISTS metro_train (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    route_id INT(11),
    position INT(11),
    updated_time DATETIME,
    forward TINYINT(1),
    FOREIGN KEY (route_id) REFERENCES route(id)
);

# Creating table train_shedule if it does not exist
CREATE TABLE IF NOT EXISTS train_schedule (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    metro_train_id INT(11),
    station_id INT(11),
    scheduled_time DATETIME,
    FOREIGN KEY (metro_train_id) REFERENCES metro_train(id),
    FOREIGN KEY (station_id) REFERENCES station(id)
);

# Creating table travel_card if it does not exist
CREATE TABLE IF NOT EXISTS travel_card (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    person_name VARCHAR(100),
    contact_number VARCHAR(100),
    balance DOUBLE
);

# Creating table travel_payment if it does not exist
CREATE TABLE IF NOT EXISTS travel_payment (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    travel_card_id INT(11),
    entry_station_id INT(11),
    entry_time DATETIME,
    exit_station_id INT(11),
    exit_time DATETIME,
    amount DOUBLE,
    FOREIGN KEY (travel_card_id) REFERENCES travel_card(id),
    FOREIGN KEY (entry_station_id) REFERENCES station(id),
    FOREIGN KEY (exit_station_id) REFERENCES station(id)
);

# Creating table train_arrival_time if it does not exist
CREATE TABLE IF NOT EXISTS train_arrival_time (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    metro_train_id INT(11),
    station_id INT(11),
    train_schedule_id INT(11),
    actual_time DATETIME,
    deviation INT(11),
    FOREIGN KEY (metro_train_id) REFERENCES metro_train(id),
    FOREIGN KEY (station_id) REFERENCES station(id),
    FOREIGN KEY (train_schedule_id) REFERENCES train_schedule(id)
);
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

show tables;

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Inserting routes
INSERT INTO route (route_name) VALUES
('East-West-line'),
('Downtown-line');

# Inserting stations
INSERT INTO station (name, locality, is_interchange) VALUES
('Jurong East', 'West', 1),
('Clementi', 'West', 0),
('Bugis', 'Central', 1),
('Chinatown', 'Central', 1),
('City Hall', 'Central', 1),
('Pasir Ris', 'East', 1),
('Tampines', 'East', 0);

# Mapping stations to routes
INSERT INTO station_route (station_id, route_id, position) VALUES
(1, 1, 1), 
(2, 1, 2), 
(3, 1, 3), 
(4, 1, 4), 
(5, 1, 5), 
(6, 2, 1), 
(7, 2, 2); 

# Inserting metro trains
INSERT INTO metro_train (route_id, position, updated_time, forward) VALUES
(1, 1, NOW(), 1),
(2, 1, NOW(), 1);

# Inserting train schedules
INSERT INTO train_schedule (metro_train_id, station_id, scheduled_time) VALUES
(1, 1, '2017-12-21 08:00:00'), 
(1, 5, '2017-12-21 08:30:00'), 
(2, 6, '2017-12-21 08:15:00'), 
(2, 7, '2017-12-21 08:45:00'); 

# Inserting travel cards
INSERT INTO travel_card (person_name, contact_number, balance) VALUES
('John Doe', '1234567890', 50.00),
('Jane Smith', '9876543210', 100.00);

# Inserting travel payments
INSERT INTO travel_payment (travel_card_id, entry_station_id, entry_time, exit_station_id, exit_time, amount) VALUES
(1, 1, '2017-12-23 08:00:00', 5, '2017-12-23 08:20:00', 2.50), 
(2, 6, '2017-12-23 08:15:00', 7, '2017-12-23 08:35:00', 2.50); 

# Inserting train arrival times
INSERT INTO train_arrival_time (metro_train_id, station_id, train_schedule_id, actual_time, deviation) VALUES
(1, 1, 1, '2017-12-21 08:05:00', 5), 
(1, 5, 2, '2017-12-21 08:35:00', 5), 
(2, 6, 3, '2017-12-21 08:20:00', 5), 
(2, 7, 4, '2017-12-21 08:50:00', 5); 

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM route;

SELECT * FROM station;

SELECT * FROM station_route;

SELECT * FROM metro_train;

SELECT * FROM train_schedule;

SELECT * FROM travel_card;

SELECT * FROM travel_payment;

SELECT * FROM train_arrival_time;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#QUESTION 1
#Write a query to display all the train details that belong to the ‘East-West line’. Display the records in ascending order based on the updated_time.Input Format
#The input tables are populated in the backend. 
#Output Format
#Follow the below output header for the query to be considered.
#id, route_id, position, updated_time, forward 
SELECT * FROM metro_train
WHERE route_id = (SELECT id FROM route 
                  WHERE route_name='East-West-line') 
ORDER BY updated_time;
/*
1	1	1	2024-06-05 12:47:15	1
*/

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* QUESTION 2
Write a query to display the station details which belong to the route 'Downtown line'. Display the records in ascending order based on station_name.
Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
id, name, locality, is_interchange */
SELECT * FROM station 
WHERE id IN 
    (SELECT station_id FROM station_route 
     WHERE route_id = 
         (SELECT id FROM route 
          WHERE route_name='DOWNTOWN-LINE')) 
ORDER BY name;
/*
6	Pasir Ris	East	1
7	Tampines	East	0
*/

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 
QUESTION 3
Write a query to display person name and contact number of all persons who traveled on 2017-12-23. Display the records in ascending order based on the person's name.
Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
person_name, contact_number
*/
SELECT person_name, contact_number 
FROM travel_card
WHERE id IN 
    (SELECT travel_card_id 
     FROM travel_payment 
     WHERE DAY(entry_time) = 23
       AND MONTH(entry_time) = 12 
       AND YEAR(entry_time) = 2017) 
ORDER BY person_name;
/*
Jane Smith	9876543210
John Doe	1234567890
*/

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 4
Write a query to display all the train details scheduled on '2017-12-21'. Display the records in ascending order based on position.
Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
id, route_id, position, updated_time, forward 
*/
SELECT * FROM metro_train 
WHERE id IN
    (SELECT metro_train_id 
     FROM train_schedule 
     WHERE DAY(scheduled_time) = 21
       AND MONTH(scheduled_time) = 12 
       AND YEAR(scheduled_time) = 2017) 
ORDER BY position;
/*
1	1	1	2024-06-05 12:47:15	1
2	2	1	2024-06-05 12:47:15	1
*/

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 5
Write a query to display the metro train id, position, and updated time of all the trains having deviation. Display the records in ascending order based on updated time.
Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
id, position, updated_time 
*/
SELECT id, position, updated_time
FROM metro_train
WHERE id IN 
    (SELECT metro_train_id 
     FROM train_arrival_time 
     WHERE deviation > 0)
ORDER BY updated_time ASC;
/*
1	1	2024-06-05 12:47:15
2	1	2024-06-05 12:47:15
*/


#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------