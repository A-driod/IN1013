-- Define a table for customer information
CREATE TABLE ClientDetails (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(50)
);

-- Define a table for headwaiter information
CREATE TABLE Supervisors (
    supervisor_id INT PRIMARY KEY,
    supervisor_firstname VARCHAR(50),
    supervisor_lastname VARCHAR(50)
);

-- Define a table for waiter information
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_firstname VARCHAR(50),
    employee_lastname VARCHAR(50),
    supervisor_id INT,
    FOREIGN KEY (supervisor_id) REFERENCES Supervisors(supervisor_id)
);

-- Define a table for room information
CREATE TABLE Locations (
    location_id INT PRIMARY KEY,
    location_label VARCHAR(50),
    supervisor_id INT,
    FOREIGN KEY (supervisor_id) REFERENCES Supervisors(supervisor_id)
);

-- Define a table for invoices
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    client_id INT,
    employee_id INT,
    location_id INT,
    transaction_amount DECIMAL(10, 2),
    transaction_date DATE,
    FOREIGN KEY (client_id) REFERENCES ClientDetails(client_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

-- Insert customer data
INSERT INTO ClientDetails (client_id, client_name) VALUES
(1, 'Tanya Singh'),
(2, 'Alice Brown'),
(3, 'Bob Smith');

-- Insert headwaiter data
INSERT INTO Supervisors (supervisor_id, supervisor_firstname, supervisor_lastname) VALUES
(201, 'Charles', 'Green');

-- Insert waiter data
INSERT INTO Employees (employee_id, employee_firstname, employee_lastname, supervisor_id) VALUES
(101, 'John', 'Doe', 201),
(102, 'Zoe', 'Ball', 201),
(103, 'Sam', 'Wilson', 201);

-- Insert room data
INSERT INTO Locations (location_id, location_label, supervisor_id) VALUES
(301, 'Emerald Room', 201),
(302, 'Azure Room', 201);

-- Insert transaction data
INSERT INTO Transactions (transaction_id, client_id, employee_id, location_id, transaction_amount, transaction_date) VALUES
(1001, 1, 101, 301, 450.00, '2016-02-15'),
(1002, 2, 102, 302, 600.00, '2016-02-20'),
(1003, 3, 103, 301, 300.00, '2016-03-10');

-- Retrieve customers spending more than 450.00 when 'Charles' supervised their experience
SELECT DISTINCT ClientDetails.client_name
FROM Transactions
JOIN ClientDetails ON Transactions.client_id = ClientDetails.client_id
JOIN Supervisors ON Transactions.employee_id = Supervisors.supervisor_id
WHERE Transactions.transaction_amount > 450.00 AND Supervisors.supervisor_firstname = 'Charles';

-- Identify the supervisor for a client complaint logged on January 11, 2016
SELECT Supervisors.supervisor_firstname, Supervisors.supervisor_lastname
FROM Transactions
JOIN ClientDetails ON Transactions.client_id = ClientDetails.client_id
JOIN Supervisors ON Transactions.employee_id = Supervisors.supervisor_id
WHERE ClientDetails.client_name = 'Nerida' AND Transactions.transaction_date = '2016-01-11';

-- Retrieve the names of clients associated with the smallest transaction amount
SELECT ClientDetails.client_name
FROM Transactions
JOIN ClientDetails ON Transactions.client_id = ClientDetails.client_id
WHERE Transactions.transaction_amount = (
    SELECT MIN(transaction_amount) FROM Transactions
