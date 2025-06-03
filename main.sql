-- Create the Salesman table if it does not exist
CREATE TABLE IF NOT EXISTS Salesman (
   Salesman_id TEXT PRIMARY KEY,
   name TEXT,
   city TEXT,
   Commission REAL
);

-- Insert sample data into the Salesman table
INSERT INTO Salesman (Salesman_id, name, city, Commission)
VALUES
    ('5001', 'James Hoog', 'New York', 0.15),
    ('5002', 'Nail Knite', 'Paris', 0.13),
    ('5005', 'Pit Alex', 'London', 0.11),
    ('5006', 'Mc Lyon', 'Paris', 0.14),
    ('5007', 'Paul Adam', 'Rome', 0.13),
    ('5003', 'Lauson Hen', 'San Jose', 0.12);

-- Create the Customer table if it does not exist
CREATE TABLE IF NOT EXISTS Customer (
   customer_id TEXT PRIMARY KEY,
   cust_name TEXT,
   city TEXT,
   grade INTEGER,
   Salesman_id TEXT,
   FOREIGN KEY (Salesman_id) REFERENCES Salesman(Salesman_id)
);

-- Insert sample data into the Customer table
INSERT INTO Customer (customer_id, cust_name, city, grade, Salesman_id)
VALUES
    ('3002', 'nick rimando', 'new york', 100, '5001'),
    ('3007', 'brad davis', 'new york', 200, '5001'),
    ('3005', 'fabiam johnson', 'Paris', 200, '5002'),
    ('3008', 'Kashan', 'Pakistan', 300, '5002'),
    ('3004', 'jozy altidor', 'paul', 300, '5006'),
    ('3009', 'graham zusi', 'california', 100, '5003'),
    ('3003', 'zaroon', 'moscow', 200, '5007'),
    ('3001', 'geoff cameron', 'berlin', NULL, '5005');

-- Create the Orders table if it does not exist
CREATE TABLE IF NOT EXISTS Orders (
   ord_no TEXT PRIMARY KEY,
   purch_amt REAL,
   ord_date TEXT,
   customer_id TEXT,
   Salesman_id TEXT,
   FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
   FOREIGN KEY (Salesman_id) REFERENCES Salesman(Salesman_id)
);

-- Insert sample data into the Orders table
INSERT INTO Orders (ord_no, purch_amt, ord_date, customer_id, Salesman_id)
VALUES
    ('70001', 150.5, '2012-10-05', '3005', '5002'),
    ('70002', 270.65, '2012-09-10', '3001', '5001'),
    ('70003', 65.26, '2012-10-05', '3002', '5003'),
    ('70004', 110.5, '2012-08-17', '3009', '5007'),
    ('70005', 948.5, '2012-09-10', '3005', '5005'),
    ('70006', 2400.6, '2012-07-27', '3007', '5006');

-- Queries

-- Matching customers and salesman by city
SELECT customer.cust_name, salesman.name, salesman.city
FROM Customer
JOIN Salesman ON Customer.city = Salesman.city;

-- Linking customers to their salesman
SELECT Customer.cust_name, Salesman.name
FROM Customer
JOIN Salesman ON Customer.Salesman_id = Salesman.Salesman_id;

-- Fetching orders where customer's city does not match salesman's city
SELECT Orders.ord_no, Customer.cust_name
FROM Orders
JOIN Customer ON Orders.customer_id = Customer.customer_id
JOIN Salesman ON Orders.Salesman_id = Salesman.Salesman_id
WHERE Customer.city != Salesman.city;