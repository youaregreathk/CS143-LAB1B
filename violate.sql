/**************************Three primary key constraints**************************/

#1. id is the primary key in table Movie. It can't be NULL and must be unique.
INSERT INTO Movie VALUES(NULL, 'Bruce Lee', '2012', '5', 'Guangxian');
#ERROR 1048 (23000): Column 'id' cannot be null

#2. id is the primary key in table Actor. It can't be NULL and must be unique.
INSERT INTO Actor VALUES(10, 'Lee', 'Bruce', 'Male', '1943-06-30', '');
#ERROR 1062 (23000): Duplicate entry '10' for key 'PRIMARY'

#3. id is the primary key in table Director. It can't be NULL and must be unique.
INSERT INTO Director VALUES(16, 'Kwai', 'Shea', '1999-06-30', '');
#ERROR 1062 (23000): Duplicate entry '16' for key 'PRIMARY'




/**************************Six referential integrity constraints**************************/

#1	MovieGenre: mid refers to Movie id
UPDATE MovieGenre SET mid = mid + 1;
#ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`TEST'.MovieGenre`, CONSTRAINT `MovieDirector_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`))

#2	MovieDirector: mid refers to Movie id
UPDATE MovieDirector SET mid = mid - 1;
#ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`TEST'.MovieDirector`, CONSTRAINT `MovieDirector_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`))


#3	MovieDirector: did refers to Director id
UPDATE MovieDirector SET did = 1;
#ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`TEST'.MovieDirector`, CONSTRAINT `MovieDirector_ibfk_2` FOREIGN KEY (`did`) REFERENCES `Director` (`id`))


#4	MovieActor: mid refers to Movie id
UPDATE MovieActor SET mid = mid + 1;
#ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`TEST'.MovieActor`, CONSTRAINT `MovieActor_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`))


#5	MovieActor:	aid refers to Actor id
UPDATE MovieActor SET aid = aid - 1;
#ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`TEST'.MovieActor`, CONSTRAINT `MovieActor_ibfk_2` FOREIGN KEY (`aid`) REFERENCES `Actor` (`id`))


#6	Review: mid revers to Movie id
UPDATE Review SET mid = mid + 1;
#ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (``TEST'.MovieGenre`, CONSTRAINT `MovieGenre_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`))


/*********************Three CHECK constraints (Actually four CHECK constraints)*********************/
#The inserts/updates below go beyond what the ids or ratings should be. 
#Just pretend that MySQL supports these constraints.

#1	Movie id > 0 AND <= MaxPersonID.id
#INSERT INTO Movie VALUES (-1, 'Bruce Lee', '2012', '5', 'Universal');

#2	Actor id > 0 AND <= MaxMovieID.id
#UPDATE Actor SET id = 1000000 WHERE first = 'Jane';

#3	Director id > 0 AND <= MaxPersonID.id
#INSERT INTO Director VALUES (1000000, 'Lee', 'Bruce', '2008-12-12', '2009-12-12');

#4	Review rating >= 0 AND <= 5
#UPDATE Review SET rating = 10 WHERE mid = 10;



