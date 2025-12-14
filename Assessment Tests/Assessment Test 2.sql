-- Assessment Test 2

-- Note: First test the new exercises database is working (exercises.tar)
-- Note: We have two schemas in this database. Thus, we have to mention name of the schema when reading tables.

SELECT *
FROM cd.bookings;

SELECT *
FROM cd.facilities;

SELECT *
FROM cd.members;

-- Challenge 1: How can you retrieve all the information from the cd.facilities table?

SELECT *
FROM cd.facilities;

-- Challenge 2: Print out a list of all of the facilities and their cost to memebers.

SELECT name, membercost
FROM cd.facilities;


-- Challenge 3: Produce a list of facilities that charge a fee to members.

SELECT *
FROM cd.facilities
WHERE membercost != 0;

-- Challenge 4: Produce a list of facilities that charge a fee to memebers,
-- and that fee is less than 1/50th of the monthly maintenance cost.
-- Return the facid, facility name, memeber cost, and monthly maintenance of the facilities.

SELECT facid, name, membercost, monthlymaintenance
FROM cd.facilities
WHERE membercost != 0 
AND membercost < monthlymaintenance/(50);

-- Challenge 5: Produce a list of facilities with the word 'Tennis' in their name.

SELECT *
FROM cd.facilities
WHERE name LIKE '%Tennis%';

-- Challenge 6: Retrieve the deatils of the facilities with ID 1 and 5 without "OR" operator.

SELECT *
FROM cd.facilities
WHERE facid IN (1,5);

-- Challenge 7: Produce a list of members who joined the start of September 2012.
-- Return memid, surname, firstname, and joindate of the members.

SELECT *
FROM cd.members;

SELECT memid, surname, firstname, joindate
FROM cd.members
--WHERE TO_CHAR(joindate, 'mm-dd-yyyy') >= '09-01-2012';
WHERE joindate >= '2012-09-01';

-- Challenge 8: Produce an ordered list of first 10 surnames in the members table.

SELECT DISTINCT(surname)
FROM cd.members
ORDER BY surname ASC
LIMIT 10;

-- Challenge 9: Get the signup date of your last memeber.

SELECT *
FROM cd.members;

SELECT joindate
FROM cd.members
ORDER BY joindate DESC
LIMIT 1;

-- Alternative approach:

SELECT MAX(joindate)
FROM cd.members;

-- Challenge 10: Count the number of faciltities that have a cost to guest of 10 or more.

SELECT *
FROM cd.facilities;

SELECT COUNT(*)
FROM cd.facilities
WHERE guestcost >= 10;

-- Challenge 11: Produce a list of the total number of slots booked per facility in the month of September 12.
-- Output table should contain facility id and slots, sorted by the number of slots.

SELECT *
FROM cd.bookings;

SELECT facid, SUM(slots) AS Total_Slots
FROM cd.bookings
WHERE EXTRACT(MONTH FROM starttime) = 9
GROUP BY facid
ORDER BY SUM(slots) ASC;

-- Challenge 12: Produce a list of facilities with more than 1000 slots booked.
-- Output table should contain facility id and total slots, sorted by facility id.

SELECT facid, SUM(slots) AS Total_Slots
FROM cd.bookings 
GROUP BY facid
HAVING SUM(slots) > 1000
ORDER BY facid ASC;

-- Challenge 13: Produce a list of the start times for bookings for tennis courts, for the date '2012-09-01'.
-- Return table should contain start time and facility name, order by the time.

SELECT *
FROM cd.bookings;

SELECT *
FROM cd.facilities;

SELECT cd.bookings.starttime AS start_time, cd.facilities.name
FROM cd.bookings
INNER JOIN cd.facilities ON cd.bookings.facid = cd.facilities.facid
WHERE cd.facilities.name LIKE 'Tennis%' AND TO_CHAR(cd.bookings.starttime, 'mm-dd-yyyy') = '09-21-2012'
ORDER BY cd.bookings.starttime ASC;

-- Challenge 14: Produce a list of the start times for bookings by members name "David Farrell"

SELECT *
FROM cd.bookings;

SELECT *
FROM cd.members;

SELECT cd.bookings.starttime AS start_time
FROM cd.bookings
INNER JOIN cd.members ON cd.bookings.memid = cd.members.memid
WHERE cd.members.firstname = 'David' AND cd.members.surname = 'Farrell';
