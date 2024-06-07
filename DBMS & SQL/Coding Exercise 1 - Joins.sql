-- Insert data into route table
INSERT INTO route (route_name) VALUES 
('North East line'),
('Circle line'),
('Downtown line'),
('East West line'),
('North South line');

-- Insert data into station table
INSERT INTO station (name, locality, is_interchange) VALUES 
('HarbourFront', 'Singapore', 1),
('Dhoby Ghaut', 'Singapore', 1),
('Serangoon', 'Singapore', 1),
('Buona Vista', 'Singapore', 1),
('Promenade', 'Singapore', 1);

-- Insert data into station_route table
INSERT INTO station_route (station_id, route_id, position) VALUES 
(1, 1, 1), -- HarbourFront on North East line
(2, 1, 2), -- Dhoby Ghaut on North East line
(3, 1, 3), -- Serangoon on North East line
(4, 2, 1), -- Buona Vista on Circle line
(5, 2, 2); -- Promenade on Circle line

-- Insert data into metro_train table
INSERT INTO metro_train (route_id, position, updated_time, forward) VALUES 
(2, 1, '2017-12-21 08:00:00', 1), -- Circle line
(2, 2, '2017-12-21 09:00:00', 1), -- Circle line
(1, 1, '2017-12-21 10:00:00', 1), -- North East line
(1, 2, '2017-12-21 11:00:00', 1), -- North East line
(3, 1, '2017-12-21 12:00:00', 1); -- Downtown line

-- Insert data into train_schedule table
INSERT INTO train_schedule (metro_train_id, station_id, scheduled_time) VALUES 
(1, 4, '2017-12-21 08:15:00'), -- Buona Vista
(2, 5, '2017-12-21 09:15:00'), -- Promenade
(3, 1, '2017-12-21 10:15:00'), -- HarbourFront
(4, 2, '2017-12-21 11:15:00'), -- Dhoby Ghaut
(5, 3, '2017-12-21 12:15:00'); -- Serangoon

-- Insert data into travel_card table
INSERT INTO travel_card (person_name, contact_number, balance) VALUES ('ALEX', '+65 95227525', 35.21);
INSERT INTO travel_card (person_name, contact_number, balance) VALUES ('KENNY', '+65 85227415', 40.00);
INSERT INTO travel_card (person_name, contact_number, balance) VALUES ('MICHAEL', '+65 62582155', 52.29);
INSERT INTO travel_card (person_name, contact_number, balance) VALUES ('GERARD EE', '+65 87892541', 20.00);
INSERT INTO travel_card (person_name, contact_number, balance) VALUES ('KAM NING', '+65 78245225', 49.25);

-- Insert data into travel_payment table
INSERT INTO travel_payment (travel_card_id, entry_station_id, entry_time, exit_station_id, exit_time, amount) VALUES 
(1, 1, '2017-12-21 07:30:00', 2, '2017-12-21 07:45:00', 30.00), -- ALEX
(2, 1, '2017-12-21 08:00:00', 3, '2017-12-21 08:30:00', 28.00), -- KENNY
(3, 2, '2017-12-21 09:00:00', 4, '2017-12-21 09:30:00', 26.00), -- MICHAEL
(4, 2, '2017-12-21 09:15:00', 5, '2017-12-21 09:45:00', 22.00), -- GERARD EE
(5, 4, '2017-12-21 09:30:00', 5, '2017-12-21 09:45:00', 29.00); -- KAM NING

-- Insert data into train_arrival_time table
INSERT INTO train_arrival_time (metro_train_id, station_id, train_schedule_id, actual_time, deviation) VALUES 
(1, 4, 1, '2017-12-21 08:15:00', 0), -- Buona Vista
(2, 5, 2, '2017-12-21 09:15:00', 0), -- Promenade
(3, 1, 3, '2017-12-21 10:15:00', 0), -- HarbourFront
(4, 2, 4, '2017-12-21 11:15:00', 0), -- Dhoby Ghaut
(5, 3, 5, '2017-12-21 12:15:00', 0); -- Serangoon

-- Insert additional data into travel_card table
INSERT INTO travel_card (person_name, contact_number, balance) VALUES ('BEN', '+65 98765432', 10.00);
INSERT INTO travel_card (person_name, contact_number, balance) VALUES ('CAROL', '+65 87654321', 40.00);
-- Insert data into travel_card table
INSERT INTO travel_card (person_name, contact_number, balance) VALUES ('ALICE', '+65 12345678', 30.00);

-- Insert data into travel_payment table
INSERT INTO travel_payment (travel_card_id, entry_station_id, entry_time, exit_station_id, exit_time, amount) VALUES (6, 1, '2017-12-21 07:30:00', 2, '2017-12-21 07:45:00', 30.00); -- ALICE

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 1
Write a query to display the names and contact numbers of persons whose destination station is on the route 'North East line' with a payment of more than 25. Display the records in ascending order based on person's name.
Input Format
The input tables are populated in the backend
Output Format
Follow the below output header for the query to be considered..
person_name, contact_number 
*/
SELECT person_name, contact_number
FROM 
travel_card A JOIN travel_payment B
ON A.id = B.travel_card_id
JOIN
station C ON B.exit_station_id = C.id
JOIN
station_route D ON C.id = D.station_id
JOIN route E ON E.id = D.route_id
WHERE E.route_name = 'North East line'
AND B.amount > 25
ORDER BY 1;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 2
Write a query to display the name and locality of the stations with the metro trains scheduled to arrive on '2017-12-21' along the route 'Circle line'. Display the records in ascending order based on the station name.
Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
name, locality
*/
SELECT name, locality
FROM
station A
JOIN train_schedule B On A.id = B.station_id
JOIN station_route C ON A.id = C.station_id
JOIN route D ON D.id = C.route_id
WHERE route_name = 'Circle line'
AND B.scheduled_time LIKE '2017-12-21%'
ORDER BY 1;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 3
Write a query to display a person's name, contact number, and balance details, 
who have a minimum balance on their travel card. If there are multiple records, display the record in descending order by person name.
Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
person_name, contact_number, balance
*/
SELECT person_name, contact_number, balance
FROM
travel_card
WHERE balance in
(SELECT min(balance) FROM travel_card)
ORDER BY 1 DESC;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 4
Write a query to display the person's name, contact number, balance, entry_time, and exit_time of all the details, who has the second highest balance on their travel cards. Display the records in ascending order based on their person_name.
Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
person_name, contact_number, balance, entry_time, exit_time 
*/
SELECT A.person_name, A.contact_number, A.balance, 
B.entry_time, B.exit_time
FROM 
travel_card A 
JOIN travel_payment B
ON A.id = B.travel_card_id
WHERE balance =
(SELECT distinct balance FROM
 travel_card t1
 WHERE 2 = (SELECT COUNT(DISTINCT balance)
            FROM travel_card t2
            WHERE t2.balance >= t1.balance))
ORDER BY 1;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 5
Write a query to display the person's name, contact number, and balance of all the travelers, who traveled for a maximum number of times. 
If there are multiple records then display the records in descending order by person name.
Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
person_name, contact_number, balance
*/
SELECT person_name, contact_number, balance 
FROM travel_card A JOIN 
(SELECT travel_card_id, count(*) as times 
 FROM travel_payment group by 1 ) B 
ON A.id = B.travel_card_id
WHERE B.times = 2 ORDER By 1 DESC;
