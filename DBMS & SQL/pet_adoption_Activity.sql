CREATE DATABASE IF NOT EXISTS pet_adoption;
USE pet_adoption;

CREATE TABLE IF NOT EXISTS pet_adoption.adoptions (
    animal_id INT NOT NULL,
    name VARCHAR(40),
    contact VARCHAR(40)
);

CREATE TABLE IF NOT EXISTS pet_adoption.animals (
    id INT NOT NULL,
    name VARCHAR(40),
    breed VARCHAR(30),
    color VARCHAR(30),
    gender VARCHAR(10),
    status INT
);

SELECT * FROM pet_adoption.animals;

SELECT * FROM pet_adoption.adoptions;

INSERT INTO pet_adoption.animals (id, name, breed, color, gender, status) VALUES (501,'Bellyflop','Beagle','Brown','Male',0);
INSERT INTO pet_adoption.animals (id, name, breed, color, gender, status) VALUES (502,'Snowy','Husky','White','Female',0);
INSERT INTO pet_adoption.animals (id, name, breed, color, gender, status) VALUES (503,'Princes','Pomarnian','Black','Female',0);
INSERT INTO pet_adoption.animals (id, name, breed, color, gender, status) VALUES (504,'Cricket','Chihuahua','Brown','Female',0);
INSERT INTO pet_adoption.animals (id, name, breed, color, gender, status) VALUES (505,'Spot','Dalmation','Black and White','Male',0);

SELECT id, breed FROM pet_adoption.animals;

SELECT name FROM pet_adoption.animals WHERE gender='Female';

SELECT id FROM pet_adoption.animals WHERE status=0;

UPDATE pet_adoption.animals SET color='Brown and red' WHERE name='Spot';

UPDATE pet_adoption.animals SET gender='Red' WHERE id=501;

UPDATE pet_adoption.animals SET status=1 WHERE gender='Female';

DELETE FROM pet_adoption.animals WHERE id=501;

SELECT * FROM pet_adoption.animals;

INSERT INTO pet_adoption.adoptions (animal_id, name, contact) VALUES (101,'Pinnochio','pinnocchio@gmail.com');

SELECT * FROM pet_adoption.adoptions;

ALTER TABLE pet_adoption.adoptions DROP COLUMN date;

INSERT INTO pet_adoption.adoptions (animal_id, name, contact) VALUES (102,'Stella','Stella@gmail.com');
INSERT INTO pet_adoption.adoptions (animal_id, name, contact) VALUES (103,'Bob','bob@gmail.com');
INSERT INTO pet_adoption.adoptions (animal_id, name, contact) VALUES (104,'alex','alex@gmail.com');
INSERT INTO pet_adoption.adoptions (animal_id, name, contact) VALUES (105,'sunny','sunny@gmail.com');

SELECT * FROM pet_adoption.adoptions;

SELECT * FROM pet_adoption.animals ORDER BY status DESC;

SELECT * FROM pet_adoption.animals ORDER BY color DESC;

ALTER TABLE pet_adoption.animals DROP COLUMN species;

ALTER TABLE pet_adoption.animals ADD species VARCHAR(20);

SELECT * FROM pet_adoption.animals;

UPDATE pet_adoption.animals SET species='Dog';

INSERT INTO pet_adoption.animals (id, name, breed, color, gender, status, species) VALUES (401,'Meowcat1','asian','Brown','Male',0,'Cat');
INSERT INTO pet_adoption.animals (id, name, breed, color, gender, status, species) VALUES (402,'Meowcat2','africa','white','Female',1,'Cat');
INSERT INTO pet_adoption.animals (id, name, breed, color, gender, status, species) VALUES (403,'Meowcat3','africa','Black','FeMale',1,'Cat');
INSERT INTO pet_adoption.animals (id, name, breed, color, gender, status, species) VALUES (404,'Meowcat4','bengal','Black and white','Male',0,'Cat');

SELECT * FROM pet_adoption.animals ORDER BY id;

CREATE TABLE pet_adoption.shelter (
    id INT,
    name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO pet_adoption.shelter (id, name, location) VALUES (1,'Animals for Homes','Smart city');

SELECT * FROM pet_adoption.shelter;

ALTER TABLE pet_adoption.animals ADD shelter INT;

SELECT * FROM pet_adoption.animals;

UPDATE pet_adoption.animals SET shelter=1;

INSERT INTO pet_adoption.shelter (id, name, location) VALUES (2,'Adopt animals','Green Town');
INSERT INTO pet_adoption.shelter (id, name, location) VALUES (3,'Give Life','Blue Hills');
INSERT INTO pet_adoption.animals (id, name, breed, color, gender, status, species, shelter) VALUES (301,'Snoopy','asian','Brown','Male',0,'Dog',2);
INSERT INTO pet_adoption.animals (id, name, breed, color, gender, status, species, shelter) VALUES (302,'tommy','asian','Brown','Male',1,'Cat',3);

SELECT * FROM pet_adoption.shelter;

SELECT * FROM pet_adoption.shelter ORDER BY id DESC;

#Using DDL:

SELECT * FROM pet_adoption.animals;

ALTER TABLE pet_adoption.animals modify COLUMN name CHAR(10);

ALTER TABLE pet_adoption.animals modify COLUMN name VARCHAR(50);

ALTER TABLE pet_adoption.animals ADD age_of_species INT;

SELECT * FROM pet_adoption.animals;

ALTER TABLE animal_data DROP COLUMN SPECIES;

SELECT * FROM animal_data;

SELECT COLUMN_NAME, COLUMN_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'pet_adoption' AND TABLE_NAME = 'animals';

