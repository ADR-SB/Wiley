use `electricity bill system new`;
/*QUESTION 1
Create a view named 'building_details' to display all the details of the building.
Input Format
The input tables are populated in the backend. 

Output Format
The output will have the below header if the view is created successfully.
id, owner_name, address, building_type_id, contact_number, email_address  */

CREATE VIEW building_details AS
SELECT * FROM building;

SELECT * FROM building_details;

/*QUESTION 2
Create a view named 'building_owners' to display all the owners of the building.

Input Format
The input tables are populated in the backend. 

Output Format
The output will have the below header if the view is created successfully.
owner_name*/

CREATE VIEW building_owners AS
SELECT owner_name
FROM building;

SELECT * FROM building_owners;

/*QUESTION 3
Create a view named 'owner_details' to display the owner name and contact number of the buildings having length of the owner name greater than 15.
Input Format
The input tables are populated in the backend. 

Output Format
The output will have the below header if the view is created successfully.
owner_name, contact_number*/

CREATE VIEW owner_details AS
SELECT owner_name, contact_number
FROM building
WHERE CHAR_LENGTH(owner_name) > 5;
drop view owner_details;

SELECT * FROM owner_details;

/*QUESTION 4
Create a view named 'electricity_reading_details' to display all the details of the electricity having total units per day greater than 500 units.

Input Format
The input tables are populated in the backend. 

Output Format
The Output header will have all the columns from electricity_reading table.*/

CREATE VIEW electricity_reading_details AS
SELECT *
FROM electricity_reading
WHERE total_units > 500;
drop view electricity_reading_details;
SELECT * FROM electricity_reading_details;
/*QUESTION 5
Create a view named 'all_payable_amount' to display the meter number and its corresponding payable amount in the bill.

Input Format
The input tables are populated in the backend. 

Output Format
The output will have the below header if the view is created successfully.
meter_number, payable_amount*/

CREATE VIEW all_payable_amount AS
SELECT meter.meter_number, bill.payable_amount
FROM bill
JOIN meter ON bill.meter_id = meter.id;
SELECT * FROM all_payable_amount;