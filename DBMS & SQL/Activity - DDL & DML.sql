CREATE DATABASE IF NOT EXISTS MovieCatalogue;


USE MovieCatalogue;


CREATE TABLE IF NOT EXISTS `Genre` (
	`GenreID` int not null auto_increment,
	`GenreName` varchar(30) not null,
    PRIMARY KEY (`GenreID`)
);

CREATE TABLE IF NOT EXISTS `Rating` (
	`RatingID` int not null auto_increment,
	`RatingName` varchar(5) not null,
    PRIMARY KEY (`RatingID`)
);

CREATE TABLE IF NOT EXISTS `Director` (
	`DirectorID` int not null auto_increment,
	`FirstName` varchar(30) not null,
	`LastName` varchar(30) not null,
	`BirthDate` date null,
    PRIMARY KEY (`DirectorID`)
);

CREATE TABLE IF NOT EXISTS `Actor` (
	`ActorID`  int not null auto_increment,
	`FirstName` varchar(30) not null,
	`LastName` varchar(30) not null,
	`BirthDate` date null,
    PRIMARY KEY (`ActorID`)
);

CREATE TABLE IF NOT EXISTS `Movie` (
	`MovieID` int not null auto_increment,
	`GenreID` int not null,
	`DirectorID` int null,
	`RatingID` int null,
	`Title` varchar(128) not null,
	`ReleaseDate` date null,
    PRIMARY KEY (`MovieID`)
);


ALTER TABLE `Movie`
 ADD CONSTRAINT `fk_MovieGenre` FOREIGN KEY (`GenreID`) REFERENCES `Genre`
(`GenreID`) ON DELETE NO ACTION;
ALTER TABLE `Movie`
 ADD CONSTRAINT `fk_MovieDirector` FOREIGN KEY (`DirectorID`) REFERENCES `Director`
(`DirectorID`) ON DELETE NO ACTION;
ALTER TABLE `Movie`
 ADD CONSTRAINT `fk_MovieRating` FOREIGN KEY (`RatingID`) REFERENCES `Rating`
(`RatingID`) ON DELETE NO ACTION;

CREATE TABLE IF NOT EXISTS `CastMember` (
	`CastMemberID` int not null auto_increment,
	`ActorID` int not null,
	`MovieID` int not null,
	`Role` varchar(50) not null,
    PRIMARY KEY (`CastMemberID`)
);

ALTER TABLE `CastMember`
 ADD CONSTRAINT `fkCastMemberActor` FOREIGN KEY (`ActorID`) REFERENCES `Actor`
(`ActorID`) ON DELETE NO ACTION;


ALTER TABLE `CastMember`
 ADD CONSTRAINT `fkCastMemberMovie` FOREIGN KEY (`MovieID`) REFERENCES `Movie`
(`MovieID`) ON DELETE NO ACTION;


/*------------------------------------dml-------------------------------------------------*/


INSERT INTO MovieCatalogue.Actor (ActorID, FirstName, LastName, BirthDate)
VALUES (1, 'Bill', 'Murray', '1950/9/21'),
(2, 'Dan', 'Aykroyd', '1952/7/1'),
(3, 'John', 'Candy', '1950/10/31'),
(4, 'Steve', 'Martin', NULL),
(5, 'Sylvester', 'Stallone', NULL);

INSERT INTO MovieCatalogue.Director (DirectorID, FirstName, LastName, BirthDate)
VALUES (1, 'Ivan', 'Reitman', '1946/10/27'),
(2, 'Ted', 'Kotcheff', NULL);

INSERT INTO MovieCatalogue.Rating (RatingID, RatingName)
VALUES (1, 'G'),
(2, 'PG'),
(3, 'PG-13'),
(4, 'R');


INSERT INTO MovieCatalogue.Genre (GenreID, GenreName)
VALUES (1, 'Action'),
(2, 'Comedy'),
(3, 'Drama'),
(4, 'Horror');

INSERT INTO MovieCatalogue.Movie (MovieID, GenreID, DirectorID, RatingID, Title, ReleaseDate)
VALUES (1, 1, 2, 4, 'Rambo: First Blood', '1982/10/22'),
(2, 2, NULL, 4, 'Planes, Trains & Automobiles', '1987/11/25'),
(3, 2, 1, 2, 'Ghostbusters', NULL),
(4, 2, NULL, 2, 'The Great Outdoors', '1988/6/17');


INSERT INTO MovieCatalogue.CastMember (CastMemberID, ActorID, MovieID, `Role`)
VALUES (1, 5, 1, 'John Rambo'),
(2, 4, 2, 'Neil Page'),
(3, 3, 2, 'Del Griffith'),
(4, 1, 3, 'Dr. Peter Venkman'),
(5, 2, 3, 'Dr. Raymond Stanz'),
(6, 2, 4, 'Roman Craig'),
(7, 3, 4, 'Chet Ripley');

UPDATE MovieCatalogue.Movie
SET Title = 'Ghostbusters (1984)',
ReleaseDate = '1984/6/8'
WHERE MovieID = 3;

UPDATE MovieCatalogue.Genre
SET GenreName = 'Action/Adventure'
WHERE GenreID = 1;

SELECT * FROM MovieCatalogue.actor;
SELECT * FROM MovieCatalogue.castmember;
SELECT * FROM MovieCatalogue.director;
SELECT * FROM MovieCatalogue.genre;
SELECT * FROM MovieCatalogue.movie;
SELECT * FROM MovieCatalogue.rating;

DELETE FROM MovieCatalogue.CastMember WHERE MovieID = 1;
DELETE FROM Movie WHERE MovieID = 1;


ALTER TABLE MovieCatalogue.Actor ADD DateOfDeath date NULL;

UPDATE MovieCatalogue.Actor
SET DateOfDeath = '1994/3/4'
WHERE ActorID = 3;