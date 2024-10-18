-- Create Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENTs,
    CategoryName VARCHAR(100) NOT NULL,
);

-- Create Authors Table
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY AUTO_INCREMENTs,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
);

-- Create Books Table
CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENTs,
    Title VARCHAR(255) NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    Publisher VARCHAR(100),
    YearOfPublication INT,
    CategoryID INT,
    AuthorID INT,
    AvailabilityStatus BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

-- Create Members Table
CREATE TABLE Members (
    MemberID INT PRIMARY KEY AUTO_INCREMENTs,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(20),
    MembershipDate DATE NOT NULL,
);

-- Create Staff Table
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY AUTO_INCREMENTs,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Role VARCHAR(100),
    HireDate DATE NOT NULL,
);

-- Create Loans Table
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY AUTO_INCREMENTs,
    BookID INT,
    MemberID INT,
    LoanDate DATE NOT NULL,
    ReturnDate DATE,
    StaffID INT,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

-- Insert Sample Data into Categories Table
INSERT INTO Categories (CategoryName) VALUES 
('Fiction'),
('Science'),
('Technology');

-- Insert Sample Data into Authors Table
INSERT INTO Authors (FirstName, LastName) VALUES 
('F. Scott', 'Fitzgerald'),
('Stephen', 'Hawking'),
('Isaac', 'Asimov');

-- Insert Sample Data into Books Table
INSERT INTO Books (Title, ISBN, Publisher, YearOfPublication, CategoryID, AuthorID) VALUES 
('The Great Gatsby', '9780743273565', 'Scribner', 1925, 1, 1),
('A Brief History of Time', '9780553380163', 'Bantam', 1988, 2, 2),
('Foundation', '9780553293357', 'Gnome Press', 1951, 3, 3);

-- Insert Sample Data into Members Table
INSERT INTO Members (FirstName, LastName, Address, Email, PhoneNumber, MembershipDate) VALUES 
('John', 'Doe', '123 Main St', 'john.doe@example.com', '1234567890', CURDATE()),
('Jane', 'Smith', '456 Elm St', 'jane.smith@example.com', '0987654321', CURDATE());

-- Insert Sample Data into Staff Table
INSERT INTO Staff (FirstName, LastName, Role, HireDate) VALUES 
('Alice', 'Smith', 'Librarian', CURDATE()),
('Bob', 'Johnson', 'Assistant', CURDATE());

-- Borrow a Book (Loan Entry)
INSERT INTO Loans (BookID, MemberID, LoanDate, StaffID) VALUES 
(1, 1, CURDATE(), 1);

-- Update Book Availability
UPDATE Books SET AvailabilityStatus = FALSE WHERE BookID = 1;

-- Return a Book (Update Loan and Availability)
UPDATE Loans 
SET ReturnDate = CURDATE() 
WHERE LoanID = 1;

UPDATE Books 
SET AvailabilityStatus = TRUE 
WHERE BookID = 1;

-- View All Borrowed Books by a Member
SELECT Books.Title, Books.AuthorID, Loans.LoanDate, Loans.ReturnDate 
FROM Loans 
JOIN Books ON Loans.BookID = Books.BookID 
JOIN Members ON Loans.MemberID = Members.MemberID
WHERE Members.MemberID = 1;
