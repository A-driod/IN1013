
-- Define table for storing customer details
CREATE TABLE ClientInfo (
    client_id INT PRIMARY KEY,
    client_fullname VARCHAR(50)
);

-- Define table for headwaiters' details
CREATE TABLE SupervisorDetails (
    supervisor_id INT PRIMARY KEY,
    supervisor_first_name VARCHAR(50),
    supervisor_last_name VARCHAR(50)
);

-- Define table for waiters' details
CREATE TABLE EmployeeDetails (
    employee_id INT PRIMARY KEY,
    employee_first_name VARCHAR(50),
    employee_last_name VARCHAR(50),
    supervisor_id INT,
    FOREIGN KEY (supervisor_id) REFERENCES SupervisorDetails(supervisor_id)
);

-- Define table for room information
CREATE TABLE RoomDetails (
    room_id INT PRIMARY KEY,
    room_label VARCHAR(50),
    supervisor_id INT,
    FOREIGN KEY (supervisor_id) REFERENCES SupervisorDetails(supervisor_id)
);

-- Define table for transaction records
CREATE TABLE PaymentRecords (
    transaction_id INT PRIMARY KEY,
    client_id INT,
    employee_id INT,
    room_id INT,
    transaction_total DECIMAL(10, 2),
    transaction_date DATE,
    FOREIGN KEY (client_id) REFERENCES ClientInfo(client_id),
    FOREIGN KEY (employee_id) REFERENCES EmployeeDetails(employee_id),
    FOREIGN KEY (room_id) REFERENCES RoomDetails(room_id)
);

-- Define table for table seating arrangements
CREATE TABLE SeatingArrangements (
    seating_id INT PRIMARY KEY,
    room_id INT,
    capacity INT,
    FOREIGN KEY (room_id) REFERENCES RoomDetails(room_id)
);

-- Insert records into ClientInfo
INSERT INTO ClientInfo (client_id, client_fullname) VALUES
(1, 'Tanya Singh'),
(2, 'Alice Brown'),
(3, 'Bob Smith');

-- Insert records into SupervisorDetails
INSERT INTO SupervisorDetails (supervisor_id, supervisor_first_name, supervisor_last_name) VALUES
(201, 'Charles', 'Green');

-- Insert records into EmployeeDetails
INSERT INTO EmployeeDetails (employee_id, employee_first_name, employee_last_name, supervisor_id) VALUES
(101, 'John', 'Doe', 201),
(102, 'Zoe', 'Ball', 201),
(103, 'Sam', 'Wilson', 201);

-- Insert records into RoomDetails
INSERT INTO RoomDetails (room_id, room_label, supervisor_id) VALUES
(301, 'Emerald Hall', 201),
(302, 'Azure Hall', 201);

-- Insert records into PaymentRecords
INSERT INTO PaymentRecords (transaction_id, client_id, employee_id, room_id, transaction_total, transaction_date) VALUES
(1001, 1, 101, 301, 450.00, '2016-02-15'),
(1002, 2, 102, 302, 600.00, '2016-02-20'),
(1003, 3, 103, 301, 300.00, '2016-03-10');

-- Insert records into SeatingArrangements
INSERT INTO SeatingArrangements (seating_id, room_id, capacity) VALUES
(401, 301, 4),
(402, 301, 8),
(403, 302, 10),
(404, 302, 6);

-- Retrieve waiters handling two or more transactions on a single day
SELECT EmployeeDetails.employee_first_name, EmployeeDetails.employee_last_name, PaymentRecords.transaction_date, 
       COUNT(PaymentRecords.transaction_id) AS transaction_count
FROM PaymentRecords
JOIN EmployeeDetails ON PaymentRecords.employee_id = EmployeeDetails.employee_id
GROUP BY EmployeeDetails.employee_first_name, EmployeeDetails.employee_last_name, PaymentRecords.transaction_date
HAVING COUNT(PaymentRecords.transaction_id) >= 2;

-- Identify rooms with tables accommodating more than six guests and their counts
SELECT RoomDetails.room_label, COUNT(SeatingArrangements.seating_id) AS seating_count
FROM RoomDetails
JOIN SeatingArrangements ON SeatingArrangements.room_id = RoomDetails.room_id
WHERE SeatingArrangements.capacity > 6
GROUP BY RoomDetails.room_label;

-- Total transaction amounts per room
SELECT RoomDetails.room_label, SUM(PaymentRecords.transaction_total) AS total_transactions
FROM PaymentRecords
JOIN RoomDetails ON PaymentRecords.room_id = RoomDetails.room_id
GROUP BY RoomDetails.room_label;

-- Supervisor details and total transactions their team processed
SELECT SupervisorDetails.supervisor_first_name, SupervisorDetails.supervisor_last_name, 
       SUM(PaymentRecords.transaction_total) AS total_supervised_transactions
FROM PaymentRecords
JOIN EmployeeDetails ON PaymentRecords.employee_id = EmployeeDetails.employee_id
JOIN SupervisorDetails ON EmployeeDetails.supervisor_id = SupervisorDetails.supervisor_id
GROUP BY SupervisorDetails.supervisor_first_name, SupervisorDetails.supervisor_last_name
ORDER BY total_supervised_transactions DESC;

-- Customers with an average transaction above 400
SELECT ClientInfo.client_fullname
FROM PaymentRecords
JOIN ClientInfo ON PaymentRecords.client_id = ClientInfo.client_id
GROUP BY ClientInfo.client_fullname
HAVING AVG(PaymentRecords.transaction_total) > 400;

-- Retrieve waiters handling three or more transactions on a single day
SELECT EmployeeDetails.employee_first_name, EmployeeDetails.employee_last_name, 
       COUNT(PaymentRecords.transaction_id) AS transaction_count
FROM PaymentRecords
JOIN EmployeeDetails ON PaymentRecords.employee_id = EmployeeDetails.employee_id
GROUP BY EmployeeDetails.employee_first_name, EmployeeDetails.employee_last_name, PaymentRecords.transaction_date
HAVING COUNT(PaymentRecords.transaction_id) >= 3;
