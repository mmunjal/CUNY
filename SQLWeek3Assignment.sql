/*
Mohit Munjal
Week3 Assignment -RDBMS
BRIDGE SQL
*/

/*
  Week 3 Assignment: SQL Project:  Building a Relational Database Management System
  SQL_Week3.sql
  */
  
  /*
  This project is where you show off your ability to (1) translate a business requirement into a database design, 
  (2) design a database using one-to-many and many-to-many relationships,    and (3) know when to use LEFT and/or
 RIGHT JOINs to build result sets for reporting.
  */
  
  /*
  An organization grants key-card access to rooms based on groups that key-card holders belong to.  You may assume that 
users below to only one group.  Your job is to design the database that supports   the key-card system.
  */
  
  /*
  There are six users, and four groups.  Modesto and Ayine are in group “I.T.”  Christopher and Cheong woo are in group
  “Sales”.  There are four rooms:  “101”, “102”, “Auditorium A”, and “Auditorium B”. Saulat is in group “Administration.”
  Group “ Operations” currently doesn’t have any users assigned. I.T. should be able to access Rooms 101 and 102.
  Sales should be able to access Rooms 102 and Auditorium A.  Administration does not have access to any rooms. Heidy
 is a new employee, who has not yet been assigned to any group.
  */
  
  /*
  After you determine the tables any relationships between the tables (One to many? Many to one? Many to many?), you 
should create the tables and populate them with the information indicated above. 
  */
  
  # I have created a new schema named "training" in order to do the work. I have set it as default.
  
  CREATE SCHEMA IF NOT EXISTS `training`;
  USE `training`;
  
-- ----------------------------------------------
-- Table `Users`
-- ----------------------------------------------
DROP TABLE IF EXISTS tblUsers;
 
CREATE TABLE tblUsers
(
  user_id int PRIMARY KEY,
  fname varchar(30) NOT NULL
);

INSERT INTO tblUsers ( user_id, fname ) VALUES ( 1, 'Modesto');
INSERT INTO tblUsers ( user_id, fname ) VALUES ( 2, 'Ayine');
INSERT INTO tblUsers ( user_id, fname ) VALUES ( 3, 'Christopher');
INSERT INTO tblUsers ( user_id, fname ) VALUES ( 4, 'Cheng woo');
INSERT INTO tblUsers ( user_id, fname ) VALUES ( 5, 'Saulat');
INSERT INTO tblUsers ( user_id, fname ) VALUES ( 6, 'Heidy');

SELECT * FROM tblUsers;
  
-- ----------------------------------------------
-- Table `Groups`
-- ----------------------------------------------
DROP TABLE IF EXISTS tblGroups;
 
CREATE TABLE tblGroups
(
  group_id int PRIMARY KEY,
  ngroup varchar(30) NOT NULL
);

INSERT INTO tblGroups ( group_id, ngroup ) VALUES ( 1, 'I.T.');
INSERT INTO tblGroups ( group_id, ngroup ) VALUES ( 2, 'Sales');
INSERT INTO tblGroups ( group_id, ngroup ) VALUES ( 3, 'Administration');
INSERT INTO tblGroups ( group_id, ngroup ) VALUES ( 4, 'Operations');

SELECT * FROM tblGroups;


-- ----------------------------------------------
-- Table `Rooms`
-- ----------------------------------------------
DROP TABLE IF EXISTS tblRooms;
 
CREATE TABLE tblRooms
(
  room_id int PRIMARY KEY,
  room varchar(30) NOT NULL
);

INSERT INTO tblRooms ( room_id, room ) VALUES ( 1, '101'         );
INSERT INTO tblRooms ( room_id, room ) VALUES ( 2, '102'         );
INSERT INTO tblRooms ( room_id, room ) VALUES ( 3, 'Auditorium A');
INSERT INTO tblRooms ( room_id, room ) VALUES ( 4, 'Auditorium B');

SELECT * FROM tblRooms;


-- ----------------------------------------------
-- Table `User Groups`
-- ----------------------------------------------
DROP TABLE IF EXISTS tblUserGroups;
 
CREATE TABLE tblUserGroups
(
  user_id int REFERENCES tblUsers,
  group_id int REFERENCES tblGroups
);

INSERT INTO tblUserGroups ( user_id, group_id ) VALUES ( 1   , 1   );
INSERT INTO tblUserGroups ( user_id, group_id ) VALUES ( 2   , 1   );
INSERT INTO tblUserGroups ( user_id, group_id ) VALUES ( 3   , 2   );
INSERT INTO tblUserGroups ( user_id, group_id ) VALUES ( 4   , 2   );
INSERT INTO tblUserGroups ( user_id, group_id ) VALUES ( 5   , 3   );
INSERT INTO tblUserGroups ( user_id, group_id ) VALUES ( NULL, 4   );
INSERT INTO tblUserGroups ( user_id, group_id ) VALUES ( 6   , NULL);

SELECT * FROM tblUserGroups;


-- ----------------------------------------------
-- Table `Room Access`
-- ----------------------------------------------
DROP TABLE IF EXISTS tblRoomAccess;
 
CREATE TABLE tblRoomAccess
(
  room_id int REFERENCES tblRomms,
  group_id int REFERENCES tblGroups
);

INSERT INTO tblRoomAccess ( room_id, group_id ) VALUES ( 1   , 1   );
INSERT INTO tblRoomAccess ( room_id, group_id ) VALUES ( 2   , 1   );
INSERT INTO tblRoomAccess ( room_id, group_id ) VALUES ( 2   , 2   );
INSERT INTO tblRoomAccess ( room_id, group_id ) VALUES ( 3   , 2   );
INSERT INTO tblRoomAccess ( room_id, group_id ) VALUES ( NULL, 3   );

SELECT * FROM tblRoomAccess;

/*
Next, write SELECT statements that provide the following information:
*/

/*
All groups, and the users in each group. A group should appear even if there are no users assigned to the group.
*/

SELECT
TU.user_id AS `ID`,
TU.fname As`Name`,
TG.ngroup AS `Group`
FROM tblUserGroups As TUG
LEFT JOIN tblUsers AS TU ON TUG.user_id = TU.user_id
LEFT JOIN tblGroups AS TG ON TUG.group_id = TG.group_id;


/*
All rooms, and the groups assigned to each room.  The rooms should appear even if no groups have been assigned
 to them.
*/

SELECT
TR.room_id AS `ID`,
TR.room As`Name`,
TG.ngroup AS `Group`
FROM tblRoomAccess As TRG
RIGHT JOIN tblRooms AS TR ON TRG.room_id = TR.room_id
LEFT JOIN tblGroups AS TG ON TRG.group_id = TG.group_id;

/*
A list of users, the groups that they belong to, and the rooms to which they are assigned.  This should be sorted 
alphabetically by user, then by group, then by room.
*/

SELECT 
TU.user_id AS `ID`,
TU.fname AS `Name`,
TG.ngroup AS `Group`,
TR.room As `Room`
FROM tblUsers AS TU
LEFT JOIN tblUserGroups AS TUG ON TU.user_id = TUG.user_id
LEFT JOIN tblGroups AS TG ON TUG.group_id = TG.group_id
LEFT JOIN tblRoomAccess AS TRA ON TG.group_id = TRA.group_id
LEFT JOIN tblRooms AS TR ON TRA.room_id = TR.room_id
GROUP BY  TU.user_id, TG.group_id, TR.room_id
ORDER BY TU.fname, TG.ngroup, TR.room;
