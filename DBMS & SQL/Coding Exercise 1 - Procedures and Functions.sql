USE `metro train system`;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 1
Create a procedure named 'insertRoute' which has route_name as an input parameter with varchar(255) as its datatype. 
This procedure should take the count of the existing table records(route table) and add 1 with that to generate the new route id. 
The newly generated id along with the route_name should be inserted into the route table.
In Solution, write a procedure alone with the given specifications. The calling of the procedure with the input will be taken care of in the back end.

Hints:
Procedure name: insertRoute
Parameters: route_name(varchar(255))

Input Format
The input tables are populated in the backend. 

Output Format
The output will display the below header if the procedure is created successfully.
id, route_name 
*/
DELIMITER $$

CREATE PROCEDURE insertRoute(IN route_name VARCHAR(255))
BEGIN

DECLARE id_value int;

SELECT max(id) + 1 INTO id_value FROM route; /*alternatively we can take the count, then add 1*/

INSERT INTO route
VALUES
(id_value,route_name);
  
END$$
DELIMITER ;

CALL insertRoute('EAST COAST LINE');
CALL insertRoute('WEST COAST LINE');

SELECT * FROM route;

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 2
Create a function named 'findRoute' which has the metroTrainId as the input parameter and it should return the route name of the train.

Design Rules:
If there is a route name for a given metro train id then it should return the corresponding route name
In Solution, write a function alone with the given specifications. The calling of the function with the input will be taken care of in the back end.

Input Format
The input tables are populated in the backend. 

Output Format
The output will display the below header if the function is created successfully.
route_name
*/
DELIMITER $$

CREATE FUNCTION findRoute(metroTrainId int)
returns VARCHAR(255)
READS SQL DATA
BEGIN

DECLARE g VARCHAR(255);
SELECT A.route_name into g
FROM route A
join
metro_train B
ON A.id = B.route_id
WHERE B.id = metroTrainId;
RETURN g;

END$$
DELIMITER ;


SELECT findRoute(1005) as route_name;

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 3
Create a function named 'findTheScheduledTime' which has the metroTrainId as the input parameter and it should return the scheduled time of the train.

In Solution, write a function alone with the given specifications. The calling of the function with the input will be taken care of in the back end.

Hints:
Function Name: findTheScheduledTime
Input parameter: metroTrainId (int)

Design Rules:
If there is a metro train id then it should return at the scheduled time of that train

Input Format
The input tables are populated in the backend. 

Output Format
The output will display the below header if the function is created successfully.
scheduled_time 
*/
DELIMITER $$

CREATE FUNCTION findTheScheduledTime
(metroTrainId  int) 
returns DATETIME 
READS SQL DATA
BEGIN 

DECLARE g DATETIME; 

SELECT scheduled_time into g FROM train_schedule
WHERE metro_train_id = metroTrainId;

RETURN g; 

END$$
DELIMITER ;

SELECT findTheScheduledTime(1006) as scheduled_time;

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 4
Create a procedure named 'findAmount' which takes 2 input parameters namely, personName varchar(100), entryTime date time, and 1 output parameter namely, amount_out double. This procedure should find the amount for the travel_payment made by the person whose name is passed as an input parameter.

In Solution, write a procedure alone with the given specifications. The calling of the procedure with the input will be taken care of in the back end.

Hints:
Procedure name: findAmount
Parameters: personName(varchar(100)), entryTime(datetime), amount_out(double)

Input Format
The input tables are populated in the backend. 

Output Format
The output will display the below header if the procedure is created successfully.
amount 
*/
DELIMITER $$

CREATE PROCEDURE findAmount

(IN personName VARCHAR(100),
IN entryTime DATETIME,
OUT amount_out DOUBLE)

BEGIN

SELECT amount into amount_out FROM
travel_payment A
join
travel_card B
ON A.travel_card_id = B.id
WHERE
B.person_name = personName AND
A.entry_time = entryTime;

END$$

DELIMITER ;

CALL findAmount('ALEX','2017-12-22 11:20:15.0', @amount_out);
SELECT @amount_out as amount;

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------