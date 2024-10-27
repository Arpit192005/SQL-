-- Create Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    product_description TEXT,
    price DECIMAL(10, 2),
    stock_quantity INT
);

-- Create Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address TEXT
);

-- Create Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create OrderDetails Table
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Create Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_date DATE,
    amount_paid DECIMAL(10, 2),
    payment_method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Step 4: Insert Example Data

-- Insert into Products Table
INSERT INTO Products (product_name, product_description, price, stock_quantity)
VALUES 
('Laptop', 'High-end gaming laptop', 1200.00, 50),
('Smartphone', 'Latest model smartphone', 800.00, 100),
('Headphones', 'Noise-cancelling headphones', 150.00, 200);

-- Insert into Customers Table
INSERT INTO Customers (first_name, last_name, email, phone, address)
VALUES 
('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Main St, City, Country'),
('Jane', 'Smith', 'jane.smith@example.com', '0987654321', '456 Oak St, City, Country');

-- Insert a New Order for Customer 1 (John Doe)
INSERT INTO Orders (customer_id, order_date, total_amount)
VALUES (1, CURDATE(), 2400.00);  -- Assuming total amount is $2400 for 2 Laptops

-- Insert Order Details for the Order
INSERT INTO OrderDetails (order_id, product_id, quantity, price)
VALUES (1, 1, 2, 1200.00);  -- Assuming order ID = 1, product ID = 1 (Laptop), quantity = 2

-- Insert Payment for the Order
INSERT INTO Payments (order_id, payment_date, amount_paid, payment_method)
VALUES (1, CURDATE(), 2400.00, 'Credit Card');  -- Assuming order ID = 1

-- Step 5: Update Stock After Order
UPDATE Products
SET stock_quantity = stock_quantity - 2
WHERE product_id = 1;  -- Assuming product ID = 1 and 2 units were ordered

-- Step 6: Queries to Retrieve Data

-- View Customer Orders
SELECT Orders.order_id, Customers.first_name, Customers.last_name, Orders.order_date, Orders.total_amount
FROM Orders
JOIN Customers ON Orders.customer_id = Customers.customer_id
WHERE Orders.customer_id = 1;  -- View orders of customer with ID = 1 (John Doe)

-- Get Order Details for a Specific Order
SELECT OrderDetails.order_detail_id, Products.product_name, OrderDetails.quantity, OrderDetails.price
FROM OrderDetails
JOIN Products ON OrderDetails.product_id = Products.product_id
WHERE OrderDetails.order_id = 1;  -- Details for order ID = 1
