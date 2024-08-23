USE AeroGestor;

-- Creación de tablas
CREATE TABLE Country (
    CountryID INT PRIMARY KEY IDENTITY(1,1),
    CountryName VARCHAR(100) NOT NULL
);

CREATE TABLE City (
    CityID INT PRIMARY KEY IDENTITY(1,1),
    CityName VARCHAR(100) NOT NULL,
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);

CREATE TABLE FlightCategory (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(100) NOT NULL,
    Description VARCHAR(255)
);

CREATE TABLE FrequentFlyerCard (
    FFCNumber INT PRIMARY KEY IDENTITY(1,1),
    Miles INT,
    MealCode VARCHAR(10)
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    DateOfBirth DATE,
    Name VARCHAR(100),
    CityID INT,
    FFCNumber INT,
    FOREIGN KEY (CityID) REFERENCES City(CityID),
    FOREIGN KEY (FFCNumber) REFERENCES FrequentFlyerCard(FFCNumber)
);

CREATE TABLE PlaneModel (
    ModelID INT PRIMARY KEY IDENTITY(1,1),
    Description VARCHAR(100),
    Graphic VARBINARY(MAX)
);

CREATE TABLE Airplane (
    RegistrationNumber BIGINT PRIMARY KEY,
    BeginOfOperation DATE,
    Status VARCHAR(50),
    ModelID INT,
    FOREIGN KEY (ModelID) REFERENCES PlaneModel(ModelID)
);

CREATE TABLE Airport (
    AirportID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    StartLocation VARCHAR(100),
    GoalLocation VARCHAR(100)
);

CREATE TABLE Flight (
    FlightNumber INT PRIMARY KEY IDENTITY(1,1),
    DepartureTime DATETIME,
    Description VARCHAR(255),
    Type VARCHAR(50),
    Airline VARCHAR(100),
    BoardingTime DATETIME,
    FlightDate DATE,
    Gate VARCHAR(10),
    CheckInCounter VARCHAR(10),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES FlightCategory(CategoryID)
);

-- Aumenté la longitud de la columna Size para evitar truncamiento
CREATE TABLE Seat (
    SeatID INT PRIMARY KEY IDENTITY(1,1),
    Size VARCHAR(20),
    Number VARCHAR(10),
    Location VARCHAR(50),
    AirplaneRegistrationNumber BIGINT,
    FOREIGN KEY (AirplaneRegistrationNumber) REFERENCES Airplane(RegistrationNumber)
);

CREATE TABLE Ticket (
    TicketID INT PRIMARY KEY IDENTITY(1,1),
    TicketingCode VARCHAR(50),
    CustomerID INT,
    FlightNumber INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (FlightNumber) REFERENCES Flight(FlightNumber)
);

CREATE TABLE Coupon (
    CouponID INT PRIMARY KEY IDENTITY(1,1),
    DateOfRedemption DATE,
    Class VARCHAR(50),
    Standby VARCHAR(50),
    MealCode VARCHAR(10),
    TicketID INT,
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID)
);

CREATE TABLE AvailableSeat (
    SeatID INT,
    FlightNumber INT,
    PRIMARY KEY (SeatID, FlightNumber),
    FOREIGN KEY (SeatID) REFERENCES Seat(SeatID),
    FOREIGN KEY (FlightNumber) REFERENCES Flight(FlightNumber)
);

CREATE TABLE PiecesOfLuggage (
    LuggageID INT PRIMARY KEY IDENTITY(1,1),
    Number INT,
    Weight DECIMAL(5, 2),
    TicketID INT,
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID)
);

-- Inserción de datos
-- Insertar datos en Country
INSERT INTO Country (CountryName) VALUES ('Bolivia');

-- Insertar datos en City
INSERT INTO City (CityName, CountryID) VALUES 
('Santa Cruz', 1),
('La Paz', 1),
('Cochabamba', 1),
('Sucre', 1),
('Tarija', 1),
('Potosí', 1),
('Oruro', 1),
('Beni', 1),
('Pando', 1),
('Chuquisaca', 1);

-- Insertar datos en FlightCategory
INSERT INTO FlightCategory (CategoryName, Description) VALUES 
('Economy', 'Standard class with basic amenities'),
('Business', 'Premium class with additional comfort and services'),
('First Class', 'Luxury class with the highest level of service'),
('Premium Economy', 'Enhanced amenities compared to standard economy');

-- Insertar datos en FrequentFlyerCard
INSERT INTO FrequentFlyerCard (Miles, MealCode) VALUES 
(5000, 'A'),
(10000, 'B'),
(15000, 'C'),
(20000, 'D'),
(25000, 'E');

-- Insertar datos en Customer
INSERT INTO Customer (DateOfBirth, Name, CityID, FFCNumber) VALUES 
('1990-01-01', 'Juan Pérez', 1, 1),
('1985-05-15', 'Ana García', 2, 2),
('1992-08-30', 'Carlos Martínez', 3, 3),
('1988-11-12', 'Marta López', 4, 4),
('1995-07-22', 'Luis Rodríguez', 5, 5),
('1990-09-19', 'Sofia Morales', 6, 1),
('1983-12-05', 'Miguel Salazar', 7, 2),
('1994-03-11', 'Laura Fernández', 8, 3),
('1987-10-23', 'Eduardo Ramírez', 9, 4),
('1991-04-18', 'Patricia Jiménez', 10, 5);

-- Insertar datos en PlaneModel
INSERT INTO PlaneModel (Description, Graphic) VALUES 
('Boeing 737', NULL),
('Airbus A320', NULL),
('Boeing 747', NULL),
('Airbus A380', NULL),
('Embraer E195', NULL);

-- Insertar datos en Airplane
INSERT INTO Airplane (RegistrationNumber, BeginOfOperation, Status, ModelID) VALUES 
(1001, '2020-01-15', 'Active', 1),
(1002, '2019-06-22', 'Active', 2),
(1003, '2021-11-30', 'Maintenance', 3),
(1004, '2018-08-10', 'Active', 4),
(1005, '2022-03-05', 'Inactive', 5);

-- Insertar datos en Airport
INSERT INTO Airport (Name, StartLocation, GoalLocation) VALUES 
('El Alto International Airport', 'Santa Cruz', 'La Paz'),
('Viru Viru International Airport', 'La Paz', 'Cochabamba'),
('Jorge Wilstermann International Airport', 'Cochabamba', 'Tarija'),
('Sucre Airport', 'Tarija', 'Potosí'),
('Tarija Airport', 'Potosí', 'Oruro'),
('Potosí Airport', 'Oruro', 'Beni'),
('Oruro Airport', 'Beni', 'Pando'),
('Beni Airport', 'Pando', 'Chuquisaca'),
('Pando Airport', 'Chuquisaca', 'Santa Cruz'),
('Chuquisaca Airport', 'Santa Cruz', 'La Paz');

-- Insertar datos en Flight
INSERT INTO Flight (DepartureTime, Description, Type, Airline, BoardingTime, FlightDate, Gate, CheckInCounter, CategoryID) VALUES 
('2024-09-01 08:00:00', 'Santa Cruz to La Paz', 'Domestic', 'AeroBol', '2024-09-01 07:00:00', '2024-09-01', 'A1', '1', 1),
('2024-09-01 10:00:00', 'La Paz to Cochabamba', 'Domestic', 'AeroBol', '2024-09-01 09:00:00', '2024-09-01', 'B2', '2', 2),
('2024-09-01 12:00:00', 'Cochabamba to Tarija', 'Domestic', 'AeroBol', '2024-09-01 11:00:00', '2024-09-01', 'C3', '3', 3),
('2024-09-01 14:00:00', 'Tarija to Potosí', 'Domestic', 'AeroBol', '2024-09-01 13:00:00', '2024-09-01', 'D4', '4', 4),
('2024-09-01 16:00:00', 'Potosí to Oruro', 'Domestic', 'AeroBol', '2024-09-01 15:00:00', '2024-09-01', 'E5', '5', 1);

-- Insertar datos en Seat
INSERT INTO Seat (Size, Number, Location, AirplaneRegistrationNumber) VALUES 
('Economy', '1A', 'Front', 1001),
('Business', '2B', 'Middle', 1002),
('First Class', '3C', 'Back', 1003),
('Economy', '4D', 'Middle', 1004),
('Business', '5E', 'Front', 1005);

-- Insertar datos en Ticket
INSERT INTO Ticket (TicketingCode, CustomerID, FlightNumber) VALUES 
('TCK123456', 1, 1),
('TCK123457', 2, 2),
('TCK123458', 3, 3),
('TCK123459', 4, 4),
('TCK123460', 5, 5),
('TCK123461', 6, 1),
('TCK123462', 7, 2),
('TCK123463', 8, 3),
('TCK123464', 9, 4),
('TCK123465', 10, 5);

-- Insertar datos en Coupon
INSERT INTO Coupon (DateOfRedemption, Class, Standby, MealCode, TicketID) VALUES 
('2024-08-01', 'Economy', 'No', 'A', 1),
('2024-08-02', 'Business', 'Yes', 'B', 2),
('2024-08-03', 'First Class', 'No', 'C', 3),
('2024-08-04', 'Economy', 'Yes', 'D', 4),
('2024-08-05', 'Business', 'No', 'E', 5);

-- Insertar datos en AvailableSeat
INSERT INTO AvailableSeat (SeatID, FlightNumber) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Insertar datos en PiecesOfLuggage
INSERT INTO PiecesOfLuggage (Number, Weight, TicketID) VALUES 
(1, 23.50, 1),
(2, 18.00, 2),
(3, 25.00, 3),
(4, 20.50, 4),
(5, 22.75, 5),
(6, 19.00, 6),
(7, 21.00, 7),
(8, 24.00, 8),
(9, 20.00, 9),
(10, 23.00, 10);
