use `metro train system`;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 1
Create a view named 'travel_payment_details' to display the details of the travel_payment having a payment amount greater than 30.
Input Format
The input tables are populated in the backend. 
Output Format
The output will have the below header if the view is created successfully.
All the columns from the travel_payment table. Column names as per ER diagram.
*/
CREATE VIEW travel_payment_details AS
SELECT *
FROM travel_payment
WHERE amount < 30;

SELECT * FROM travel_payment_details;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 2
Create a view named 'train_details_with_deviation' to display the metro train id, position, and updated time of all the trains having deviation.
While selecting the result set, make sure to remove the duplicate rows.
Input Format
The input tables are populated in the backend. 
Output Format
The output will have the below header if the view is created successfully.
id, position, updated_time
*/
CREATE VIEW train_details_with_deviation AS
SELECT DISTINCT mt.id, mt.position, mt.updated_time
FROM metro_train mt
JOIN train_arrival_time tat ON mt.id = tat.metro_train_id
WHERE tat.deviation IS NOT NULL AND tat.deviation <> 0;

SELECT * FROM train_details_with_deviation;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 3
Create a view named 'travel_card_details' to display all the details of travel_card.
Input Format
The input tables are populated in the backend. 
Output Format
The output will have the below header if the view is created successfully.
id, person_name, contact_number, balance 
*/
CREATE VIEW travel_card_details AS
SELECT *
FROM travel_card;

SELECT * FROM travel_card_details;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 4
Create a view named 'station_details_with_no_interchanges' to display the name and locality of the stations with no interchanges.
Input Format
The input tables are populated in the backend. 
Output Format
The output will have the below header if the view is created successfully.
name, locality
*/
CREATE VIEW station_details_with_no_interchanges AS
SELECT name, locality
FROM station
WHERE is_interchange = 0;

SELECT * FROM station_details_with_no_interchanges;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------