-- Query 1
-- Retrieve the date and total amount of bills where the customer’s name is 'Bob Crow'
SELECT bill_date, bill_total
FROM restBill
WHERE cus_name = 'Bob Crow';

-- Query 2
-- Get a list of unique customer names that end with 'Smith', sorting them in descending order
SELECT DISTINCT cust_name
FROM restBill
WHERE cust_name LIKE '%Smith'
ORDER BY cust_name DESC;

-- Query 3
-- Find unique customer names where the second character is 'C' and the name has at least three characters
SELECT DISTINCT cust_name
FROM restBill
WHERE cust_name LIKE '_C%';

-- Query 4
-- Retrieve unique combinations of first name and surname for staff members who have a value in the headwaiter field
SELECT DISTINCT first_name, surname
FROM restStaff
WHERE headwaiter IS NOT NULL;

-- Query 5
-- Select all columns from bills where the bill date is between February 1, 2016, and February 28, 2016
SELECT *
FROM restBill
WHERE bill_date BETWEEN '160201' AND '160228';

-- Query 6
-- Get a list of unique bill dates from 2015, ordered by the bill date
SELECT DISTINCT bill_date
FROM restBill
WHERE bill_date BETWEEN '150101' AND '151231'
ORDER BY bill_date;