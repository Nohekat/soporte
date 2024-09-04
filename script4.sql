-- Crear la base de datos
USE script4;

-- Crear la tabla Country
CREATE TABLE Countries (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL
);

-- Crear la tabla City
CREATE TABLE Cities (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Countries(ID)
);

-- Crear la tabla FlightCategories
CREATE TABLE FlightCategories (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Description VARCHAR(255)
);

-- Crear la tabla Customers
CREATE TABLE Customers (
    ID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(100),
    DateOfBirth DATE,
    CityID INT,
    FOREIGN KEY (CityID) REFERENCES Cities(ID)
);

-- Crear la tabla FrequentFlyerCards
CREATE TABLE FrequentFlyerCards (
    CardNumber INT PRIMARY KEY IDENTITY(1,1),
    MilesAccumulated INT,
    MealPreference VARCHAR(10),
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(ID)
);

-- Crear la tabla Airports
CREATE TABLE Airports (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    CityID INT,
    FOREIGN KEY (CityID) REFERENCES Cities(ID)
);

-- Crear la tabla PlaneModels
CREATE TABLE PlaneModels (
    ID INT PRIMARY KEY IDENTITY(1,1),
    ModelName VARCHAR(100),
    Details VARBINARY(MAX)
);

-- Crear la tabla Airplanes
CREATE TABLE Airplanes (
    RegistrationID BIGINT PRIMARY KEY,
    ModelID INT,
    OperationalStatus VARCHAR(50),
    OperationalSince DATE,
    FOREIGN KEY (ModelID) REFERENCES PlaneModels(ID)
);

-- Crear la tabla Flights
CREATE TABLE Flights (
    ID INT PRIMARY KEY IDENTITY(1,1),
    FlightCode VARCHAR(10) NOT NULL,
    Airline VARCHAR(100),
    FlightCategoryID INT,
    DepartureAirportID INT,
    ArrivalAirportID INT,
    ScheduledDeparture DATETIME,
    ScheduledArrival DATETIME,
    BoardingGate VARCHAR(10),
    FOREIGN KEY (FlightCategoryID) REFERENCES FlightCategories(ID),
    FOREIGN KEY (DepartureAirportID) REFERENCES Airports(ID),
    FOREIGN KEY (ArrivalAirportID) REFERENCES Airports(ID)
);

-- Crear la tabla Seats
CREATE TABLE Seats (
    ID INT PRIMARY KEY IDENTITY(1,1),
    SeatNumber VARCHAR(10),
    ClassType VARCHAR(50),
    AirplaneID BIGINT,
    FOREIGN KEY (AirplaneID) REFERENCES Airplanes(RegistrationID)
);

-- Crear la tabla Tickets
CREATE TABLE Tickets (
    ID INT PRIMARY KEY IDENTITY(1,1),
    BookingReference VARCHAR(50),
    CustomerID INT,
    FlightID INT,
    SeatID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(ID),
    FOREIGN KEY (FlightID) REFERENCES Flights(ID),
    FOREIGN KEY (SeatID) REFERENCES Seats(ID)
);

-- Crear la tabla CheckIns
CREATE TABLE CheckIns (
    ID INT PRIMARY KEY IDENTITY(1,1),
    TicketID INT,
    CheckInDate DATETIME,
    CheckedIn VARCHAR(10),  -- 'Yes' or 'No'
    PenaltyFee DECIMAL(10, 2) DEFAULT 0.00,
    FOREIGN KEY (TicketID) REFERENCES Tickets(ID)
);

-- Crear la tabla Luggage
CREATE TABLE Luggage (
    ID INT PRIMARY KEY IDENTITY(1,1),
    TicketID INT,
    LuggageWeight DECIMAL(5, 2),
    LuggagePieces INT,
    FOREIGN KEY (TicketID) REFERENCES Tickets(ID)
);

-- Insertar datos en Countries
INSERT INTO Countries (Name) VALUES ('Bolivia');

-- Insertar datos en Cities
INSERT INTO Cities (Name, CountryID) VALUES 
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

-- Insertar datos en FlightCategories
INSERT INTO FlightCategories (Name, Description) VALUES 
('Economy', 'Clase estándar con comodidades básicas'),
('Business', 'Clase premium con mayor comodidad y servicios adicionales'),
('First Class', 'Clase de lujo con el más alto nivel de servicio'),
('Premium Economy', 'Clase económica mejorada con comodidades adicionales');

-- Insertar datos en Customers
INSERT INTO Customers (FullName, DateOfBirth, CityID) VALUES 
('Juan Pérez', '1990-01-01', 1),
('Ana García', '1985-05-15', 2),
('Carlos Martínez', '1992-08-30', 3),
('Marta López', '1988-11-12', 4),
('Luis Rodríguez', '1995-07-22', 5),
('Sofia Morales', '1990-09-19', 6),
('Miguel Salazar', '1983-12-05', 7),
('Laura Fernández', '1994-03-11', 8),
('Eduardo Ramírez', '1987-10-23', 9),
('Patricia Jiménez', '1991-04-18', 10);

-- Insertar datos en FrequentFlyerCards
INSERT INTO FrequentFlyerCards (MilesAccumulated, MealPreference, CustomerID) VALUES 
(5000, 'A', 1),
(10000, 'B', 2),
(15000, 'C', 3),
(20000, 'D', 4),
(25000, 'E', 5),
(30000, 'F', 6),
(35000, 'G', 7),
(40000, 'H', 8),
(45000, 'I', 9),
(50000, 'J', 10);

-- Insertar datos en Airports
INSERT INTO Airports (Name, CityID) VALUES 
('El Alto International Airport', 1),
('Viru Viru International Airport', 2),
('Jorge Wilstermann International Airport', 3),
('Sucre Airport', 4),
('Tarija Airport', 5);

-- Insertar datos en PlaneModels
INSERT INTO PlaneModels (ModelName, Details) VALUES 
('Boeing 737', NULL),
('Airbus A320', NULL),
('Boeing 747', NULL),
('Airbus A380', NULL),
('Embraer E195', NULL);

-- Insertar datos en Airplanes
INSERT INTO Airplanes (RegistrationID, ModelID, OperationalStatus, OperationalSince) VALUES 
(5001, 1, 'Active', '2019-01-01'),
(5002, 2, 'Active', '2018-05-01'),
(5003, 3, 'Maintenance', '2021-06-15'),
(5004, 4, 'Active', '2020-09-10'),
(5005, 5, 'Inactive', '2022-02-20');

-- Insertar datos en Flights
INSERT INTO Flights (FlightCode, Airline, FlightCategoryID, DepartureAirportID, ArrivalAirportID, ScheduledDeparture, ScheduledArrival, BoardingGate) VALUES 
('F1001', 'AeroBol', 1, 1, 2, '2024-09-01 08:00:00', '2024-09-01 10:00:00', 'A1'),
('F1002', 'AeroBol', 2, 2, 3, '2024-09-01 11:00:00', '2024-09-01 13:00:00', 'B2'),
('F1003', 'AeroBol', 3, 3, 4, '2024-09-01 14:00:00', '2024-09-01 16:00:00', 'C3'),
('F1004', 'AeroBol', 4, 4, 5, '2024-09-01 17:00:00', '2024-09-01 19:00:00', 'D4');

-- Insertar datos en Seats
INSERT INTO Seats (SeatNumber, ClassType, AirplaneID) VALUES 
('1A', 'Economy', 5001),
('2B', 'Business', 5002),
('3C', 'First Class', 5003),
('4D', 'Premium Economy', 5004),
('5E', 'Economy', 5005);

-- Insertar datos en Tickets
INSERT INTO Tickets (BookingReference, CustomerID, FlightID, SeatID) VALUES 
('BKREF1001', 1, 1, 1),
('BKREF1002', 2, 2, 2),
('BKREF1003', 3, 3, 3),
('BKREF1004', 4, 4, 4),
('BKREF1005', 5, 1, 5),
('BKREF1006', 6, 2, 1),
('BKREF1007', 7, 3, 2),
('BKREF1008', 8, 4, 3),
('BKREF1009', 9, 1, 4),
('BKREF1010', 10, 2, 5);

-- Insertar datos en CheckIns (estado de cada ticket)
INSERT INTO CheckIns (TicketID, CheckInDate, CheckedIn, PenaltyFee) VALUES
(1, '2024-09-01 07:00:00', 'Yes', 0.00), -- Juan Pérez subió al avión
(2, '2024-09-01 10:00:00', 'No', 50.00), -- Ana García no subió al avión
(3, '2024-09-01 13:00:00', 'Yes', 0.00), -- Carlos Martínez subió al avión
(4, '2024-09-01 16:00:00', 'No', 50.00), -- Marta López no subió al avión
(5, '2024-09-01 09:00:00', 'Yes', 0.00), -- Luis Rodríguez subió al avión
(6, '2024-09-01 12:00:00', 'Yes', 0.00), -- Sofia Morales subió al avión
(7, '2024-09-01 15:00:00', 'No', 50.00), -- Miguel Salazar no subió al avión
(8, '2024-09-01 18:00:00', 'Yes', 0.00), -- Laura Fernández subió al avión
(9, '2024-09-01 08:00:00', 'No', 50.00), -- Eduardo Ramírez no subió al avión
(10, '2024-09-01 11:00:00', 'Yes', 0.00); -- Patricia Jiménez subió al avión

-- Consultas para verificar clientes que deben multas
SELECT 
    C.ID AS CustomerID,
    C.FullName AS CustomerName,
    T.ID AS TicketID,
    CH.CheckedIn,
    CH.PenaltyFee
FROM 
    Customers C
JOIN 
    Tickets T ON C.ID = T.CustomerID
JOIN 
    CheckIns CH ON T.ID = CH.TicketID
WHERE 
    CH.CheckedIn = 'No';  -- Clientes que no subieron al avión y deben pagar multa

-- Consultas para verificar todos los vuelos y el estado de check-in de los clientes
SELECT 
    F.FlightCode,
    F.Airline,
    C.FullName AS CustomerName,
    CH.CheckedIn AS CheckInStatus,
    CH.PenaltyFee AS PenaltyIfAny
FROM 
    Flights F
JOIN 
    Tickets T ON F.ID = T.FlightID
JOIN 
    Customers C ON T.CustomerID = C.ID
JOIN 
    CheckIns CH ON T.ID = CH.TicketID;
