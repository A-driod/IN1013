
-- Create tables
CREATE TABLE Client (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(50)
);

CREATE TABLE Supervisors (
    supervisor_id INT PRIMARY KEY,
    supervisor_first_name VARCHAR(50),
    supervisor_last_name VARCHAR(50)
);

CREATE TABLE Staff (
    staff_id INT PRIMARY KEY,
    staff_first_name VARCHAR(50),
    staff_last_name VARCHAR(50),
    supervisor_id INT,
    FOREIGN KEY (supervisor_id) REFERENCES Supervisors(supervisor_id)
);

CREATE TABLE Locations (
    location_id INT PRIMARY KEY,
    location_name VARCHAR(50),
    supervisor_id INT,
    FOREIGN KEY (supervisor_id) REFERENCES Supervisors(supervisor_id)
);

CREATE TABLE Invoices (
    invoice_id INT PRIMARY KEY,
    client_id INT,
    staff_id INT,
    location_id INT,
    total_amount DECIMAL(10, 2),
    invoice_date DATE,
    FOREIGN KEY (client_id) REFERENCES Client(client_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

-- Insert records
INSERT INTO Client (client_id, client_name) VALUES
(1, 'Tanya Singh'),
(2, 'Alice Brown'),
(3, 'Bob Smith');

INSERT INTO Supervisors (supervisor_id, supervisor_first_name, supervisor_last_name) VALUES
(201, 'Charles', 'Green');

INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, supervisor_id) VALUES
(101, 'John', 'Doe', 201),
(102, 'Zoe', 'Ball', 201),
(103, 'Sam', 'Wilson', 201);

INSERT INTO Locations (location_id, location_name, supervisor_id) VALUES
(301, 'Green Room', 201),
(302, 'Blue Room', 201);

INSERT INTO Invoices (invoice_id, client_id, staff_id, location_id, total_amount, invoice_date) VALUES
(1001, 1, 101, 301, 450.00, '2016-02-15'),
(1002, 2, 102, 302, 600.00, '2016-02-20'),
(1003, 3, 103, 301, 300.00, '2016-03-10');

-- Query tasks
-- 1. Find the name of the staff member who served a specific client
SELECT staff_first_name
FROM Invoices
JOIN Client ON Invoices.client_id = Client.client_id
JOIN Staff ON Invoices.staff_id = Staff.staff_id
WHERE Client.client_name = 'Tanya Singh';

-- 2. Identify unique invoice dates for a specific supervisor and location in February 2016
SELECT DISTINCT Invoices.invoice_date
FROM Invoices
JOIN Locations ON Invoices.location_id = Locations.location_id
JOIN Supervisors ON Locations.supervisor_id = Supervisors.supervisor_id
WHERE Supervisors.supervisor_first_name = 'Charles'
  AND Locations.location_name = 'Green Room'
  AND Invoices.invoice_date LIKE '2016-02%';

-- 3. Find distinct names of staff reporting to the same supervisor as a specific staff member
SELECT DISTINCT Staff.staff_first_name, Staff.staff_last_name
FROM Staff
JOIN Supervisors ON Staff.supervisor_id = Supervisors.supervisor_id
WHERE Supervisors.supervisor_id = (
    SELECT Supervisors.supervisor_id
    FROM Staff
    JOIN Supervisors ON Staff.supervisor_id = Supervisors.supervisor_id
    WHERE Staff.staff_first_name = 'Zoe' AND Staff.staff_last_name = 'Ball'
);

