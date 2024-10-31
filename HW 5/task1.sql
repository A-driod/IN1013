-- Query 1
-- Calculate the total income by summing all bill totals
SELECT SUM(bill_total) AS Income
FROM restBill;

-- Query 2
-- Calculate total income specifically for bills between February 1, 2016, and February 28, 2016
SELECT SUM(bill_total) AS "Feb Income"
FROM restBill
WHERE bill_date BETWEEN '160201' AND '160228';

-- Query 3
-- Find the average amount of a bill
SELECT AVG(bill_total) AS average_bill
FROM restBill;

-- Query 4
-- Retrieve the minimum, maximum, and average number of seats for tables in the 'Blue' room
SELECT 
    MIN(no_of_seats) AS Min, 
    MAX(no_of_seats) AS Max, 
    AVG(no_of_seats) AS Avg
FROM restRest_table
WHERE room_name = 'Blue';

-- Query 5
-- Count the distinct number of tables served by waiters with IDs 004 or 002
SELECT COUNT(DISTINCT table_no) AS DistinctTables
FROM restBill
WHERE waiter_no IN (004, 002);