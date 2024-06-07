# Creation of database METRO TRAIN SUSTEM if it does not exist
CREATE DATABASE IF NOT EXISTS `ELECTRICITY BILL SYSTEM`;
USE `ELECTRICITY BILL SYSTEM`;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Creation of Tables

# Creating Table electricity_connection_type if it does not exist
CREATE TABLE IF NOT EXISTS electricity_connection_type (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    connection_name VARCHAR(20) NOT NULL
);

# Creating Table slab if it does not exist
CREATE TABLE IF NOT EXISTS slab (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    connection_type_id INT(11),
    from_unit INT(11) NOT NULL,
    to_unit INT(11) NOT NULL,
    rate DOUBLE NOT NULL,
    FOREIGN KEY (connection_type_id) REFERENCES electricity_connection_type (id)
);

# Creating Table building_type if it does not exist
CREATE TABLE IF NOT EXISTS building_type (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    connection_type_id INT(11),
    FOREIGN KEY (connection_type_id) REFERENCES electricity_connection_type (id)
);

# Creating Table building if it does not exist
CREATE TABLE IF NOT EXISTS building (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    owner_name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    building_type_id INT(11),
    contact_number VARCHAR(100) NOT NULL,
    email_address VARCHAR(100) NULL,
    FOREIGN KEY (building_type_id) REFERENCES building_type (id)
);

# Creating Table meter if it does not exist
CREATE TABLE IF NOT EXISTS meter (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    meter_number VARCHAR(100) NOT NULL,
    building_id INT(11),
    FOREIGN KEY (building_id) REFERENCES building(id)
);

# Creating Table bill if  it does not exist
CREATE TABLE IF NOT EXISTS bill (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    meter_id INT(11),
    month INT(11) NOT NULL,
    year INT(11) NOT NULL,
    due_date DATE NOT NULL,
    total_units INT(11) NOT NULL,
    payable_amount DOUBLE NOT NULL,
    is_payed TINYINT(1) NOT NULL,
    payment_data DATE NULL,
    fine_amount DOUBLE NULL,
    FOREIGN KEY (meter_id) REFERENCES meter(id)
);

# Creating Table electricity_reading if it does not exist
CREATE TABLE IF NOT EXISTS electricity_reading (
    id INT(11) PRIMARY KEY,
    meter_id INT(11),
    day DATE NOT NULL,
    h1 INT(11) NULL,
    h2 INT(11) NULL,
    h3 INT(11) NULL,
    h4 INT(11) NULL,
    h5 INT(11) NULL,
    h6 INT(11) NULL,
    h7 INT(11) NULL,
    h8 INT(11) NULL,
    h9 INT(11) NULL,
    h10 INT(11) NULL,
    h11 INT(11) NULL,
    h12 INT(11) NULL,
    h13 INT(11) NULL,
    h14 INT(11) NULL,
    h15 INT(11) NULL,
    h16 INT(11) NULL,
    h17 INT(11) NULL,
    h18 INT(11) NULL,
    h19 INT(11) NULL,
    h20 INT(11) NULL,
    h21 INT(11) NULL,
    h22 INT(11) NULL,
    h23 INT(11) NULL,
    h24 INT(11) NULL,
    total_units INT(11),
    FOREIGN KEY (meter_id) REFERENCES meter(id)
);

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# INSERTION INTO TABLES
-- Inserting data into electricity_connection_type table
INSERT INTO electricity_connection_type (connection_name) VALUES 
('Residential'),
('Commercial'),
('Industrial');

-- Inserting data into slab table
INSERT INTO slab (connection_type_id, from_unit, to_unit, rate) VALUES 
(1, 0, 100, 5.5),
(1, 101, 200, 6.0),
(1, 201, 300, 6.5),
(2, 0, 100, 6.0),
(2, 101, 200, 6.5),
(2, 201, 300, 7.0),
(3, 0, 100, 7.0),
(3, 101, 200, 7.5),
(3, 201, 300, 8.0);

-- Inserting data into building_type table
INSERT INTO building_type (name, connection_type_id) VALUES 
('Apartment', 1),
('Office Complex', 2),
('Factory', 3);

INSERT INTO building_type (name, connection_type_id) VALUES ('Library', 4),('Police Station', 3);

-- Inserting data into building table
INSERT INTO building (owner_name, address, building_type_id, contact_number, email_address) VALUES 
('Ramesh', '12/A Gandhi Nagar, Mumbai', 1, '+91 9876543210', 'ramesh@gmail.com'),
('Suresh', '34/B MG Road, Bangalore', 2, '+91 9988776655', 'info@suenterprises.com'),
('axe Industries', '78 Industrial Area, Delhi', 3, '+91 9876541230', 'industries@gmail.com');

INSERT INTO building (owner_name, address, building_type_id, contact_number, email_address) VALUES ('read library', '7 lake shore, chennai', 4, '+91 9876541230', 'inds@gmail.com');
INSERT INTO building (owner_name, address, building_type_id, contact_number, email_address) VALUES ('1st police station', '7 lake shore, chennai', 3, '+91 9876541230', 'inds@gmail.com');

-- Inserting data into meter table
INSERT INTO meter (meter_number, building_id) VALUES 
('MTR123456', 1),
('MTR987654', 2),
('MTR456789', 3);

INSERT INTO meter (meter_number, building_id) VALUES 
('SG934826', 5);

-- Inserting data into bill table
INSERT INTO bill (meter_id, month, year, due_date, total_units, payable_amount, is_payed, payment_data, fine_amount) VALUES 
(1, 6, 2024, '2024-07-05', 250, 1500, 0, NULL, NULL),
(2, 6, 2024, '2024-07-05', 350, 2450, 0, NULL, NULL),
(3, 6, 2024, '2024-07-05', 500, 4000, 0, NULL, NULL);

-- Inserting data into electricity_reading table
-- Assuming readings for a day for each meter
INSERT INTO electricity_reading (id, meter_id, `day`, h1, h2, h3, h4, h5, h6, h7, h8, h9, h10, h11, h12, h13, h14, h15, h16, h17, h18, h19, h20, h21, h22, h23, h24, total_units) VALUES 
(1, 1, '2024-06-05', 100, 110, 115, 120, 125, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300, 310, 320),
(2, 2, '2024-06-05', 200, 210, 215, 220, 225, 230, 240, 250, 260, 270, 280, 290, 300, 310, 320, 330, 340, 350, 360, 370, 380, 390, 400, 410, 420),
(3, 3, '2024-06-05', 300, 310, 315, 320, 325, 330, 340, 350, 360, 370, 380, 390, 400, 410, 420, 430, 440, 450, 460, 470, 480, 490, 500, 510, 520);

select * from `electricity bill system`.electricity_reading;

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 1
Write a query to display all the building details in which the building type is ‘Library’. Display the records in ascending order based on their owner_name.
Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
id, owner_name, address, building_type_id, contact_number, email_address 
*/
SELECT *
FROM building
WHERE building_type_id = (SELECT id FROM building_type WHERE name = 'Library')
ORDER BY owner_name ASC;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
QUESTION 2
Write a query to display all the contact numbers of the building type 'Police Station'. Display the records in ascending order based on the contact number.
Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
contact_number 
*/
SELECT contact_number
FROM building
WHERE building_type_id = (SELECT id FROM building_type WHERE name = 'Police Station')
ORDER BY contact_number ASC;

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 3
Write a query to display the building type name of the meter number 'SG824012'.
Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
name
*/
SELECT name
FROM building_type
WHERE id = (SELECT building_type_id FROM building WHERE id = (SELECT building_id FROM meter WHERE meter_number = 'SG824012'));

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 4
Write a query to display the total units and payable amount of the particular meter number 'SG934826'.
Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
total_units, payable_amount
 */
SELECT total_units, payable_amount
FROM bill
WHERE meter_id = (SELECT id FROM meter WHERE meter_number = 'SG934826');

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUESTION 5
Write a query to display the number of buildings that have been charged for a fine amount. Give an alias name as 'building_count'.
Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
building_count  
*/
SELECT COUNT(id) AS building_count
FROM building
WHERE id IN (SELECT building_id FROM meter WHERE id IN 
           (SELECT meter_id FROM bill WHERE NOT 
           fine_amount IS NULL));

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
