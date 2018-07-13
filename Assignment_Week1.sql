

-- Assignment_Week1.sql
-- Mohit Munjal(munjal.mohit@gmail.com)

select @@version;

#1 Which destination in the flights database is the furthest distance away, based on information in the flights table. Show the SQL query(s) that support your conclusion.
SELECT origin AS 'Origin', dest AS 'Destination',
distance AS 'Furthest Distance'
FROM flights
ORDER BY distance desc
LIMIT 1;
#Answer: JFK Airport to HNL Airport is the furthest distance away 4983 miles.

#2 What are the different numbers of engines in the planes table? For each number of engines, which aircraft have the most number of seats? Show the SQL statement(s) that support your result.
SELECT engines AS 'Type of Engine', model AS 'Aircraft', manufacturer AS 'Manufacturer',
MAX(seats) AS 'Most Number of Seats'
FROM planes
GROUP BY engines
ORDER BY MAX(seats);
#Answer: There are four different numbers of engines in the planes table. With 1 engine, aircraft Cessna 150 has the most number of seats with 16 seats; with 2 engines, aircraft Embraer EMB-145XR has the most number of seats with 400 seats;
# with 3 engines, aircraft Airbus A330-223 has the most number of seats with 379 seats; and with 4 engines, aircraft Airbus Industrie A340-313 has the most number of seats with 450 seats.

#3 Show the total number of flights.
SELECT
COUNT(1) AS 'Total Number of Flights'
FROM flights;
#Answer: The total number of flights is 336,776.

#4 Show the total number of flights by airline (carrier).
SELECT carrier AS 'Airline',
COUNT(1) AS 'Total Number of Flights'
FROM flights
GROUP BY carrier;
#Answer: The total number of  flights by airline - 9E: 18460, AA: 32729, AS: 714, B6: 54635, DL:48110, EV: 54173, F9: 685, FL: 3260, HA: 342, MQ: 26397, OO: 32, UA: 58665, US: 20536, VX: 5162, WN: 12275, YV: 601.

#5 Show all of the airlines, ordered by number of flights in descending order.
SELECT carrier AS 'Airline',
COUNT(1) AS 'Total Number of Flights'
FROM flights
GROUP BY carrier
ORDER BY COUNT(1) DESC;
#Answer: All of the airlines in descending order by number of flights - UA, B6, EV, DL, AA, MQ, US, 9E, WN, VX, FL, AS, F9, YV, HA, OO.

#6 Show only the top 5 airlines, by number of flights, ordered by number of flights in descending order.
SELECT carrier AS 'Airline',
COUNT(1) AS 'Total Number of Flights'
FROM flights
GROUP BY carrier
ORDER BY COUNT(1) DESC
LIMIT 5;
#Answer: The top 5 airlines in descending order by number of flights - UA, B6, EV, DL, AA.

#7 Show only the top 5 airlines, by number of flights of distance 1,000 miles or greater, ordered by number of flights in descending order.
SELECT carrier AS 'Airline',
COUNT(1) AS 'Total Number of Flights'
FROM flights
WHERE distance >= 1000
GROUP BY carrier
ORDER BY COUNT(1) DESC
LIMIT 5;
#Answer: The top 5 airlines in descending order by number of flights of distance 1,000 miles or greater - UA, B6, DL, AA, EV.

#8 Create a question that (a) uses data from the flights database, and (b) requires aggregation to answer it, and write down both the question, and the query that answers the question.
#Question: Show only the top 5 airlines that arrived on schedule.
SELECT carrier AS 'Airline',
COUNT(flight) as 'Arrival on Time'
FROM flights
WHERE arr_delay<=0 
GROUP BY carrier
ORDER BY count(flight) DESC
LIMIT 5;
#Answer: The top 5 airlines with arrival on time - UA:35560, DL: 31245, B6: 30440, EV: 26624, AA: 21241.
