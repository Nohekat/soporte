create database aeroportSC;
use aeroportSC;
-- 1. Creación de la tabla `Country`
CREATE TABLE Country (
    CountryID CHAR(8) PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Code CHAR(5) NOT NULL
);

-- 2. Creación de la tabla `City`
CREATE TABLE City (
    CityID CHAR(8) PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    CountryID CHAR(8) NOT NULL,
    CONSTRAINT FK_City_Country FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);

-- 3. Creación de la tabla `Airport`
CREATE TABLE Airport (
    AirportID CHAR(8) PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    CityID CHAR(8) NOT NULL,
    Code NVARCHAR(10) NOT NULL,
    CONSTRAINT FK_Airport_City FOREIGN KEY (CityID) REFERENCES City(CityID)
);

-- 4. Creación de la tabla `Airline`
CREATE TABLE Airline (
    AirlineID CHAR(8) PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL
);

-- 5. Creación de la tabla `FlightRoute`
CREATE TABLE FlightRoute (
    RouteID CHAR(8) PRIMARY KEY,
    Description NVARCHAR(MAX) NOT NULL,
    Distance FLOAT NOT NULL,
    Duration FLOAT NOT NULL
);

-- 6. Creación de la tabla `Flight`
CREATE TABLE Flight (
    FlightID CHAR(8) PRIMARY KEY,
    AirlineID CHAR(8) NOT NULL,
    RouteID CHAR(8) NOT NULL,
    FlightNumber NVARCHAR(10) NOT NULL,
    CONSTRAINT FK_Flight_Airline FOREIGN KEY (AirlineID) REFERENCES Airline(AirlineID),
    CONSTRAINT FK_Flight_Route FOREIGN KEY (RouteID) REFERENCES FlightRoute(RouteID)
);
-- 7. Creación de la tabla `FlightStatus`
CREATE TABLE FlightStatus (
    StatusID CHAR(8) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);

-- 8. Creación de la tabla `Passenger`
CREATE TABLE Passenger (
    PassengerID CHAR(8) PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    DateOfBirth DATE NOT NULL
);

-- 9. Creación de la tabla `Booking`
CREATE TABLE Booking (
    BookingID CHAR(8) PRIMARY KEY,
    PassengerID CHAR(8) NOT NULL,
    FlightID CHAR(8) NOT NULL,
    Status NVARCHAR(100),
    Date DATE NOT NULL,
    CONSTRAINT FK_Booking_Passenger FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID),
    CONSTRAINT FK_Booking_Flight FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);

-- 10. Creación de la tabla `FlightCrew`
CREATE TABLE FlightCrew (
    CrewID CHAR(8) PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL
);

-- 11. Creación de la tabla `FlightLog`
CREATE TABLE FlightLog (
    LogID CHAR(8) PRIMARY KEY,
    FlightID CHAR(8) NOT NULL,
    ChangeType NVARCHAR(100) NOT NULL,
    NewDepartureTime DATETIME,
    NewArrivalTime DATETIME,
    ChangeReason NVARCHAR(MAX),
    CONSTRAINT FK_FlightLog_Flight FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);

-- 12. Creación de la tabla `Gate`
CREATE TABLE Gate (
    GateID CHAR(8) PRIMARY KEY,
    Number NVARCHAR(10) NOT NULL,
    AirportID CHAR(8) NOT NULL,
    CONSTRAINT FK_Gate_Airport FOREIGN KEY (AirportID) REFERENCES Airport(AirportID)
);

-- 13. Creación de la tabla `Seat`
CREATE TABLE Seat (
    SeatID CHAR(8) PRIMARY KEY,
    FlightID CHAR(8) NOT NULL,
    SeatType NVARCHAR(100) NOT NULL,
    Size NVARCHAR(100),
    Location NVARCHAR(255),
    CONSTRAINT FK_Seat_Flight FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);

-- 14. Creación de la tabla `SeatType`
CREATE TABLE SeatType (
    SeatTypeID CHAR(8) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255)
);

-- 15. Creación de la tabla `PlaneModel`
CREATE TABLE PlaneModel (
    PlaneModelID CHAR(8) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Capacity INT NOT NULL
);

-- 16. Creación de la tabla `Airplane`
CREATE TABLE Airplane (
    AirplaneID CHAR(8) PRIMARY KEY,
    RegistrationNumber NVARCHAR(20) NOT NULL,
    AirlineID CHAR(8) NOT NULL,
    PlaneModelID CHAR(8) NOT NULL,
    CONSTRAINT FK_Airplane_Airline FOREIGN KEY (AirlineID) REFERENCES Airline(AirlineID),
    CONSTRAINT FK_Airplane_Model FOREIGN KEY (PlaneModelID) REFERENCES PlaneModel(PlaneModelID)
);

-- 17. Creación de la tabla `FlightAssignment`
CREATE TABLE FlightAssignment (
    AssignmentID CHAR(8) PRIMARY KEY,
    FlightID CHAR(8) NOT NULL,
    CrewID CHAR(8) NOT NULL,
    CONSTRAINT FK_FlightAssignment_Flight FOREIGN KEY (FlightID) REFERENCES Flight(FlightID),
    CONSTRAINT FK_FlightAssignment_Crew FOREIGN KEY (CrewID) REFERENCES FlightCrew(CrewID)
);

-- 18. Creación de la tabla `ParkingSpot`
CREATE TABLE ParkingSpot (
    ParkingSpotID CHAR(8) PRIMARY KEY,
    Location NVARCHAR(255) NOT NULL,
    Status NVARCHAR(50) NOT NULL,
    AirportID CHAR(8) NOT NULL,
    CONSTRAINT FK_ParkingSpot_Airport FOREIGN KEY (AirportID) REFERENCES Airport(AirportID)
);

-- 19. Creación de la tabla `BaggageClaim`
CREATE TABLE BaggageClaim (
    ClaimID CHAR(8) PRIMARY KEY,
    ClaimArea NVARCHAR(50) NOT NULL,
    AirportID CHAR(8) NOT NULL,
    CONSTRAINT FK_BaggageClaim_Airport FOREIGN KEY (AirportID) REFERENCES Airport(AirportID)
);

-- 20. Creación de la tabla `CheckIn`
CREATE TABLE CheckIn (
    CheckInID CHAR(8) PRIMARY KEY,
    Description NVARCHAR(255)
);

-- 21. Creación de la tabla `TransactionLog`
CREATE TABLE TransactionLog (
    LogID CHAR(8) PRIMARY KEY,
    Date DATETIME NOT NULL,
    Amount MONEY NOT NULL,
    Status NVARCHAR(50)
);

-- 23. Creación de la tabla `PaymentMethod`
CREATE TABLE PaymentMethod (
    PaymentMethodID CHAR(8) PRIMARY KEY,
    MethodName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255)
);

-- 22. Creación de la tabla `Payment`
CREATE TABLE Payment (
    PaymentID CHAR(8) PRIMARY KEY,
    Date DATETIME NOT NULL,
    Amount MONEY NOT NULL,
    PaymentMethodID CHAR(8) NOT NULL,
    CONSTRAINT FK_Payment_PaymentMethod FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethod(PaymentMethodID)
);



-- 24. Creación de la tabla `Ticket`
CREATE TABLE Ticket (
    TicketID CHAR(8) PRIMARY KEY,
    BookingID CHAR(8) NOT NULL,
    CheckInID CHAR(8),
    CONSTRAINT FK_Ticket_Booking FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
    CONSTRAINT FK_Ticket_CheckIn FOREIGN KEY (CheckInID) REFERENCES CheckIn(CheckInID)
);

-- 25. Creación de la tabla `Coupon`
CREATE TABLE Coupon (
    CouponID CHAR(8) PRIMARY KEY,
    Code NVARCHAR(20) NOT NULL,
    DateOfRedemption DATETIME,
    Status NVARCHAR(50) NOT NULL
);

-- 26. Creación de la tabla `MealCode`
CREATE TABLE MealCode (
    MealCodeID CHAR(8) PRIMARY KEY,
    Description NVARCHAR(255)
);

-- 27. Creación de la tabla `FrequentFlyerCard`
CREATE TABLE FrequentFlyerCard (
    CardID CHAR(8) PRIMARY KEY,
    Miles INT NOT NULL,
    PassengerID CHAR(8) NOT NULL,
    CONSTRAINT FK_FrequentFlyerCard_Passenger FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);

-- 28. Creación de la tabla `PiecesOfLuggage`
CREATE TABLE PiecesOfLuggage (
    LuggageID CHAR(8) PRIMARY KEY,
    Weight FLOAT NOT NULL,
    PassengerID CHAR(8) NOT NULL,
    CONSTRAINT FK_PiecesOfLuggage_Passenger FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);

-- 29. Creación de la tabla `FlightChangeLog`
CREATE TABLE FlightChangeLog (
    ChangeLogID CHAR(8) PRIMARY KEY,
    FlightID CHAR(8) NOT NULL,
    ChangeType NVARCHAR(100) NOT NULL,
    NewDepartureTime DATETIME,
    NewArrivalTime DATETIME,
    ChangeReason NVARCHAR(MAX),
    CONSTRAINT FK_FlightChangeLog_Flight FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);

-- 30. Creación de la tabla `FlightNumber`
CREATE TABLE FlightNumber (
    FlightNumberID CHAR(8) PRIMARY KEY,
    Name NVARCHAR(20) NOT NULL,
    Description NVARCHAR(255) NOT NULL
);

-- 31. Creación de la tabla `Escala`
CREATE TABLE Escala (
    EscalaID CHAR(8) PRIMARY KEY,
    Description NVARCHAR(255) NOT NULL,
    FlightID CHAR(8) NOT NULL,
    CONSTRAINT FK_Escala_Flight FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);

-- 32. Creación de la tabla `AvailableSeat`
CREATE TABLE AvailableSeat (
    AvailableSeatID CHAR(8) PRIMARY KEY,
    SeatID CHAR(8) NOT NULL,
    FlightID CHAR(8) NOT NULL,
    Status NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_AvailableSeat_Seat FOREIGN KEY (SeatID) REFERENCES Seat(SeatID),
    CONSTRAINT FK_AvailableSeat_Flight FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);

-- 33. Creación de la tabla `FlightType`
CREATE TABLE FlightType (
    FlightTypeID CHAR(8) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255) NOT NULL
);

-- 1. Insertar datos en la tabla `Country`
INSERT INTO Country (CountryID, Name, Code) VALUES ('CNT00001', 'Bolivia', 'BO');
INSERT INTO Country (CountryID, Name, Code) VALUES ('CNT00002', 'United States', 'US');
INSERT INTO Country (CountryID, Name, Code) VALUES ('CNT00003', 'Argentina', 'AR');
INSERT INTO Country (CountryID, Name, Code) VALUES ('CNT00004', 'Brazil', 'BR');
INSERT INTO Country (CountryID, Name, Code) VALUES ('CNT00005', 'Peru', 'PE');

-- 2. Insertar datos en la tabla `City`
INSERT INTO City (CityID, Name, CountryID) VALUES ('CTY00001', 'Santa Cruz', 'CNT00001');
INSERT INTO City (CityID, Name, CountryID) VALUES ('CTY00002', 'La Paz', 'CNT00001');
INSERT INTO City (CityID, Name, CountryID) VALUES ('CTY00003', 'Miami', 'CNT00002');
INSERT INTO City (CityID, Name, CountryID) VALUES ('CTY00004', 'Buenos Aires', 'CNT00003');
INSERT INTO City (CityID, Name, CountryID) VALUES ('CTY00005', 'Sao Paulo', 'CNT00004');
INSERT INTO City (CityID, Name, CountryID) VALUES ('CTY00006', 'Lima', 'CNT00005');

-- 3. Insertar datos en la tabla `Airport`
INSERT INTO Airport (AirportID, Name, CityID, Code) VALUES ('APT00001', 'Viru Viru', 'CTY00001', 'VVI');
INSERT INTO Airport (AirportID, Name, CityID, Code) VALUES ('APT00002', 'El Alto', 'CTY00002', 'LPB');
INSERT INTO Airport (AirportID, Name, CityID, Code) VALUES ('APT00003', 'Miami International', 'CTY00003', 'MIA');
INSERT INTO Airport (AirportID, Name, CityID, Code) VALUES ('APT00004', 'Ezeiza', 'CTY00004', 'EZE');
INSERT INTO Airport (AirportID, Name, CityID, Code) VALUES ('APT00005', 'Guarulhos', 'CTY00005', 'GRU');
INSERT INTO Airport (AirportID, Name, CityID, Code) VALUES ('APT00006', 'Jorge Chavez', 'CTY00006', 'LIM');

-- 4. Insertar datos en la tabla `Airline`
INSERT INTO Airline (AirlineID, Name) VALUES ('ALN00001', 'Boliviana de Aviación');
INSERT INTO Airline (AirlineID, Name) VALUES ('ALN00002', 'American Airlines');
INSERT INTO Airline (AirlineID, Name) VALUES ('ALN00003', 'Aerolíneas Argentinas');
INSERT INTO Airline (AirlineID, Name) VALUES ('ALN00004', 'LATAM');
INSERT INTO Airline (AirlineID, Name) VALUES ('ALN00005', 'Avianca');

-- 5. Insertar datos en la tabla `FlightRoute`
INSERT INTO FlightRoute (RouteID, Description, Distance, Duration) VALUES ('RTE00001', 'Santa Cruz - Miami', 4500, 6.5);
INSERT INTO FlightRoute (RouteID, Description, Distance, Duration) VALUES ('RTE00002', 'La Paz - Buenos Aires', 3000, 4.5);
INSERT INTO FlightRoute (RouteID, Description, Distance, Duration) VALUES ('RTE00003', 'Lima - Sao Paulo', 4000, 5.5);
INSERT INTO FlightRoute (RouteID, Description, Distance, Duration) VALUES ('RTE00004', 'Santa Cruz - Lima', 2500, 3.0);
INSERT INTO FlightRoute (RouteID, Description, Distance, Duration) VALUES ('RTE00005', 'Buenos Aires - Miami', 7000, 8.0);

-- 6. Insertar datos en la tabla `SeatType`
INSERT INTO SeatType (SeatTypeID, Name, Description) VALUES ('STP00001', 'Economy', 'Economy class seat');
INSERT INTO SeatType (SeatTypeID, Name, Description) VALUES ('STP00002', 'Business', 'Business class seat');
INSERT INTO SeatType (SeatTypeID, Name, Description) VALUES ('STP00003', 'First Class', 'First class seat');

-- 7. Insertar datos en la tabla `PlaneModel`
INSERT INTO PlaneModel (PlaneModelID, Name, Capacity) VALUES ('PLM00001', 'Boeing 737', 180);
INSERT INTO PlaneModel (PlaneModelID, Name, Capacity) VALUES ('PLM00002', 'Airbus A320', 200);
INSERT INTO PlaneModel (PlaneModelID, Name, Capacity) VALUES ('PLM00003', 'Boeing 777', 350);

-- 8. Insertar datos en la tabla `Airplane`
INSERT INTO Airplane (AirplaneID, RegistrationNumber, AirlineID, PlaneModelID) VALUES ('APL00001', 'CP-1234', 'ALN00001', 'PLM00001');
INSERT INTO Airplane (AirplaneID, RegistrationNumber, AirlineID, PlaneModelID) VALUES ('APL00002', 'N-5678', 'ALN00002', 'PLM00002');
INSERT INTO Airplane (AirplaneID, RegistrationNumber, AirlineID, PlaneModelID) VALUES ('APL00003', 'AR-4321', 'ALN00003', 'PLM00003');

-- 9. Insertar datos en la tabla `FlightType`
INSERT INTO FlightType (FlightTypeID, Name, Description) VALUES ('FLTTYP01', 'Domestic', 'Domestic flight');
INSERT INTO FlightType (FlightTypeID, Name, Description) VALUES ('FLTTYP02', 'International', 'International flight');

-- 10. Insertar datos en la tabla `Passenger`
INSERT INTO Passenger (PassengerID, Name, DateOfBirth) VALUES ('PSG00001', 'Juan Perez', '1990-03-21');
INSERT INTO Passenger (PassengerID, Name, DateOfBirth) VALUES ('PSG00002', 'Maria Garcia', '1985-07-15');
INSERT INTO Passenger (PassengerID, Name, DateOfBirth) VALUES ('PSG00003', 'Carlos Diaz', '1978-11-23');
INSERT INTO Passenger (PassengerID, Name, DateOfBirth) VALUES ('PSG00004', 'Ana Torres', '1992-05-30');

-- 11. Insertar datos en la tabla `Booking`
INSERT INTO Booking (BookingID, PassengerID, FlightID, Status, Date) VALUES ('BKG00001', 'PSG00001', 'FLT00001', 'Confirmed', '2021-06-15');
INSERT INTO Booking (BookingID, PassengerID, FlightID, Status, Date) VALUES ('BKG00002', 'PSG00002', 'FLT00002', 'Confirmed', '2021-07-21');
INSERT INTO Booking (BookingID, PassengerID, FlightID, Status, Date) VALUES ('BKG00003', 'PSG00003', 'FLT00003', 'Confirmed', '2021-08-12');
INSERT INTO Booking (BookingID, PassengerID, FlightID, Status, Date) VALUES ('BKG00004', 'PSG00004', 'FLT00004', 'Confirmed', '2021-09-05');

-- 12. Insertar datos en la tabla `FlightStatus`
INSERT INTO FlightStatus (StatusID, Name) VALUES ('ST000001', 'Scheduled');
INSERT INTO FlightStatus (StatusID, Name) VALUES ('ST000002', 'Departed');
INSERT INTO FlightStatus (StatusID, Name) VALUES ('ST000003', 'Arrived');
INSERT INTO FlightStatus (StatusID, Name) VALUES ('ST000004', 'Cancelled');

-- 13. Insertar al menos 10 datos en la tabla `FlightLog`
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00001', 'FLT00001', 'Reschedule', '2021-06-15 10:00', '2021-06-15 16:30', 'Operational reasons');
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00002', 'FLT00002', 'Cancellation', NULL, NULL, 'Weather conditions');
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00003', 'FLT00003', 'Delay', '2021-08-12 12:00', '2021-08-12 18:00', 'Technical issue');
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00004', 'FLT00004', 'Reschedule', '2021-09-05 14:30', '2021-09-05 20:00', 'Staff shortage');
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00005', 'FLT00005', 'Delay', '2021-07-10 15:00', '2021-07-10 21:00', 'Runway congestion');
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00006', 'FLT00006', 'Cancellation', NULL, NULL, 'Political unrest');
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00007', 'FLT00007', 'Delay', '2021-09-17 08:00', '2021-09-17 14:00', 'Fuel shortage');
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00008', 'FLT00008', 'Reschedule', '2021-10-10 11:30', '2021-10-10 18:30', 'Weather conditions');
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00009', 'FLT00009', 'Cancellation', NULL, NULL, 'Airport closure');
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00010', 'FLT00010', 'Delay', '2021-11-02 09:00', '2021-11-02 15:00', 'Technical issue');

-- 14. Insertar datos en la tabla `Gate`
INSERT INTO Gate (GateID, Number, AirportID) VALUES ('GTE00001', 'A1', 'APT00001');
INSERT INTO Gate (GateID, Number, AirportID) VALUES ('GTE00002', 'B2', 'APT00002');
INSERT INTO Gate (GateID, Number, AirportID) VALUES ('GTE00003', 'C3', 'APT00003');
INSERT INTO Gate (GateID, Number, AirportID) VALUES ('GTE00004', 'D4', 'APT00004');

-- 15. Insertar datos en la tabla `Seat`
INSERT INTO Seat (SeatID, FlightID, SeatType, Size, Location) VALUES ('SEAT0001', 'FLT00001', 'Economy', 'Standard', 'Front');
INSERT INTO Seat (SeatID, FlightID, SeatType, Size, Location) VALUES ('SEAT0002', 'FLT00001', 'Business', 'Large', 'Middle');
INSERT INTO Seat (SeatID, FlightID, SeatType, Size, Location) VALUES ('SEAT0003', 'FLT00002', 'Economy', 'Standard', 'Back');
INSERT INTO Seat (SeatID, FlightID, SeatType, Size, Location) VALUES ('SEAT0004', 'FLT00002', 'First Class', 'Extra Large', 'Front');

-- 16. Insertar datos en la tabla `FlightAssignment`
INSERT INTO FlightAssignment (AssignmentID, FlightID, CrewID) VALUES ('ASS00001', 'FLT00001', 'CRW00001');
INSERT INTO FlightAssignment (AssignmentID, FlightID, CrewID) VALUES ('ASS00002', 'FLT00002', 'CRW00002');
INSERT INTO FlightAssignment (AssignmentID, FlightID, CrewID) VALUES ('ASS00003', 'FLT00003', 'CRW00003');

-- 17. Insertar datos en la tabla `ParkingSpot`
INSERT INTO ParkingSpot (ParkingSpotID, Location, Status, AirportID) VALUES ('PKS00001', 'A1', 'Available', 'APT00001');
INSERT INTO ParkingSpot (ParkingSpotID, Location, Status, AirportID) VALUES ('PKS00002', 'B1', 'Occupied', 'APT00002');
INSERT INTO ParkingSpot (ParkingSpotID, Location, Status, AirportID) VALUES ('PKS00003', 'C1', 'Available', 'APT00003');

-- 18. Insertar datos en la tabla `BaggageClaim`
INSERT INTO BaggageClaim (ClaimID, ClaimArea, AirportID) VALUES ('BAG00001', 'Area A', 'APT00001');
INSERT INTO BaggageClaim (ClaimID, ClaimArea, AirportID) VALUES ('BAG00002', 'Area B', 'APT00002');

-- 19. Insertar datos en la tabla `CheckIn`
INSERT INTO CheckIn (CheckInID, Description) VALUES ('CHK00001', 'Check-in counter A1');
INSERT INTO CheckIn (CheckInID, Description) VALUES ('CHK00002', 'Check-in counter B2');

-- 20. Insertar datos en la tabla `TransactionLog`
INSERT INTO TransactionLog (LogID, Date, Amount, Status) VALUES ('TRN00001', '2021-06-01', 500.00, 'Completed');
INSERT INTO TransactionLog (LogID, Date, Amount, Status) VALUES ('TRN00002', '2021-07-15', 750.00, 'Pending');

-- 21. Insertar datos en la tabla `Payment`
INSERT INTO Payment (PaymentID, Date, Amount, PaymentMethodID) VALUES ('PAY00001', '2021-06-01', 500.00, 'PMT00001');
INSERT INTO Payment (PaymentID, Date, Amount, PaymentMethodID) VALUES ('PAY00002', '2021-07-15', 750.00, 'PMT00002');

-- 22. Insertar datos en la tabla `PaymentMethod`
INSERT INTO PaymentMethod (PaymentMethodID, MethodName, Description) VALUES ('PMT00001', 'Credit Card', 'Visa/Mastercard');
INSERT INTO PaymentMethod (PaymentMethodID, MethodName, Description) VALUES ('PMT00002', 'Cash', 'Cash Payment');

-- 23. Insertar datos en la tabla `Ticket`
INSERT INTO Ticket (TicketID, BookingID, CheckInID) VALUES ('TCK00001', 'BKG00001', 'CHK00001');
INSERT INTO Ticket (TicketID, BookingID, CheckInID) VALUES ('TCK00002', 'BKG00002', 'CHK00002');

-- 24. Insertar datos en la tabla `Coupon`
INSERT INTO Coupon (CouponID, Code, DateOfRedemption, Status) VALUES ('CPN00001', 'SUMMER21', '2021-06-01', 'Redeemed');
INSERT INTO Coupon (CouponID, Code, DateOfRedemption, Status) VALUES ('CPN00002', 'WINTER21', '2021-07-15', 'Expired');

-- 25. Insertar datos en la tabla `MealCode`
INSERT INTO MealCode (MealCodeID, Description) VALUES ('MEAL001', 'Vegetarian');
INSERT INTO MealCode (MealCodeID, Description) VALUES ('MEAL002', 'Non-Vegetarian');

-- 26. Insertar datos en la tabla `FrequentFlyerCard`
INSERT INTO FrequentFlyerCard (CardID, Miles, PassengerID) VALUES ('FFC00001', 10000, 'PSG00001');
INSERT INTO FrequentFlyerCard (CardID, Miles, PassengerID) VALUES ('FFC00002', 20000, 'PSG00002');

-- 27. Insertar datos en la tabla `PiecesOfLuggage`
INSERT INTO PiecesOfLuggage (LuggageID, Weight, PassengerID) VALUES ('LUG00001', 20.5, 'PSG00001');
INSERT INTO PiecesOfLuggage (LuggageID, Weight, PassengerID) VALUES ('LUG00002', 15.0, 'PSG00002');

-- 28. Insertar datos en la tabla `FlightChangeLog`
INSERT INTO FlightChangeLog (ChangeLogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason)
VALUES ('FLCHG0001', 'FLT00001', 'Reschedule', '2021-06-15 12:00', '2021-06-15 18:00', 'Operational reasons');

-- 29. Insertar datos en la tabla `FlightNumber`
INSERT INTO FlightNumber (FlightNumberID, Name, Description) VALUES ('FLN00001', 'AA100', 'American Airlines Flight 100');

-- 30. Insertar datos en la tabla `Escala`
INSERT INTO Escala (EscalaID, Description, FlightID) VALUES ('ESC00001', 'Miami', 'FLT00001');

-- 31. Insertar datos en la tabla `AvailableSeat`
INSERT INTO AvailableSeat (AvailableSeatID, SeatID, FlightID, Status) VALUES ('AVS00001', 'SEAT0001', 'FLT00001', 'Available');

-- 32. Insertar datos en la tabla `FlightType`
INSERT INTO FlightType (FlightTypeID, Name, Description) VALUES ('FLTTYP01', 'International', 'International Flight');

-- 33. Insertar datos en la tabla `FlightCrew`
INSERT INTO FlightCrew (CrewID, Name) VALUES ('CRW00001', 'John Doe');

INSERT INTO Seat (SeatID, FlightID, SeatType, Size, Location) VALUES ('SEAT0001', 'FLT00001', 'Economy', 'Standard', 'Front');
INSERT INTO Seat (SeatID, FlightID, SeatType, Size, Location) VALUES ('SEAT0002', 'FLT00001', 'Business', 'Large', 'Middle');
INSERT INTO Seat (SeatID, FlightID, SeatType, Size, Location) VALUES ('SEAT0003', 'FLT00002', 'Economy', 'Standard', 'Back');
INSERT INTO Seat (SeatID, FlightID, SeatType, Size, Location) VALUES ('SEAT0004', 'FLT00002', 'First Class', 'Extra Large', 'Front');


INSERT INTO Booking (BookingID, PassengerID, FlightID, Status, Date) VALUES ('BKG00001', 'PSG00001', 'FLT00001', 'Confirmed', '2021-06-15');
INSERT INTO Booking (BookingID, PassengerID, FlightID, Status, Date) VALUES ('BKG00002', 'PSG00002', 'FLT00002', 'Confirmed', '2021-07-21');
INSERT INTO Booking (BookingID, PassengerID, FlightID, Status, Date) VALUES ('BKG00003', 'PSG00003', 'FLT00003', 'Confirmed', '2021-08-12');
INSERT INTO Booking (BookingID, PassengerID, FlightID, Status, Date) VALUES ('BKG00004', 'PSG00004', 'FLT00004', 'Confirmed', '2021-09-05');

INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00001', 'FLT00001', 'Reschedule', '2021-06-15 10:00', '2021-06-15 16:30', 'Operational reasons');
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00002', 'FLT00002', 'Cancellation', NULL, NULL, 'Weather conditions');
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00003', 'FLT00003', 'Delay', '2021-08-12 12:00', '2021-08-12 18:00', 'Technical issue');
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00004', 'FLT00004', 'Reschedule', '2021-09-05 14:30', '2021-09-05 20:00', 'Staff shortage');
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00005', 'FLT00005', 'Delay', '2021-07-10 15:00', '2021-07-10 21:00', 'Runway congestion');
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00006', 'FLT00006', 'Cancellation', NULL, NULL, 'Political unrest');
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00007', 'FLT00007', 'Delay', '2021-09-17 08:00', '2021-09-17 14:00', 'Fuel shortage');
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00008', 'FLT00008', 'Reschedule', '2021-10-10 11:30', '2021-10-10 18:30', 'Weather conditions');
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00009', 'FLT00009', 'Cancellation', NULL, NULL, 'Airport closure');
INSERT INTO FlightLog (LogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason) 
VALUES ('FLG00010', 'FLT00010', 'Delay', '2021-11-02 09:00', '2021-11-02 15:00', 'Technical issue');
INSERT INTO FlightAssignment (AssignmentID, FlightID, CrewID) VALUES ('ASS00001', 'FLT00001', 'CRW00001');
INSERT INTO FlightAssignment (AssignmentID, FlightID, CrewID) VALUES ('ASS00002', 'FLT00002', 'CRW00002');
INSERT INTO FlightAssignment (AssignmentID, FlightID, CrewID) VALUES ('ASS00003', 'FLT00003', 'CRW00003');
INSERT INTO Payment (PaymentID, Date, Amount, PaymentMethodID) VALUES ('PAY00001', '2021-06-01', 500.00, 'PMT00001');
INSERT INTO Payment (PaymentID, Date, Amount, PaymentMethodID) VALUES ('PAY00002', '2021-07-15', 750.00, 'PMT00002');


INSERT INTO Ticket (TicketID, BookingID, CheckInID) VALUES ('TCK00001', 'BKG00001', 'CHK00001');
INSERT INTO Ticket (TicketID, BookingID, CheckInID) VALUES ('TCK00002', 'BKG00002', 'CHK00002');
INSERT INTO FlightChangeLog (ChangeLogID, FlightID, ChangeType, NewDepartureTime, NewArrivalTime, ChangeReason)
VALUES ('FLCHG0001', 'FLT00001', 'Reschedule', '2021-06-15 12:00', '2021-06-15 18:00', 'Operational reasons');
INSERT INTO Escala (EscalaID, Description, FlightID) VALUES ('ESC00001', 'Miami', 'FLT00001');
INSERT INTO AvailableSeat (AvailableSeatID, SeatID, FlightID, Status) VALUES ('AVS00001', 'SEAT0001', 'FLT00001', 'Available');

INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00001', 'ALN00001', 'RTE00001', 'AA1001');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00002', 'ALN00002', 'RTE00002', 'AA1002');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00003', 'ALN00001', 'RTE00003', 'AA1003');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00004', 'ALN00003', 'RTE00001', 'AA1004');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00005', 'ALN00004', 'RTE00004', 'AA1005');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00006', 'ALN00005', 'RTE00005', 'AA1006');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00007', 'ALN00001', 'RTE00001', 'AA1007');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00008', 'ALN00002', 'RTE00002', 'AA1008');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00009', 'ALN00003', 'RTE00003', 'AA1009');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00010', 'ALN00004', 'RTE00004', 'AA1010');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00011', 'ALN00005', 'RTE00005', 'AA1011');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00012', 'ALN00001', 'RTE00001', 'AA1012');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00013', 'ALN00002', 'RTE00002', 'AA1013');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00014', 'ALN00003', 'RTE00003', 'AA1014');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00015', 'ALN00004', 'RTE00004', 'AA1015');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00016', 'ALN00005', 'RTE00005', 'AA1016');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00017', 'ALN00001', 'RTE00001', 'AA1017');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00018', 'ALN00002', 'RTE00002', 'AA1018');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00019', 'ALN00003', 'RTE00003', 'AA1019');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00020', 'ALN00004', 'RTE00004', 'AA1020');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00021', 'ALN00005', 'RTE00005', 'AA1021');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00022', 'ALN00001', 'RTE00001', 'AA1022');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00023', 'ALN00002', 'RTE00002', 'AA1023');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00024', 'ALN00003', 'RTE00003', 'AA1024');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00025', 'ALN00004', 'RTE00004', 'AA1025');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00026', 'ALN00005', 'RTE00005', 'AA1026');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00027', 'ALN00001', 'RTE00001', 'AA1027');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00028', 'ALN00002', 'RTE00002', 'AA1028');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00029', 'ALN00003', 'RTE00003', 'AA1029');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00030', 'ALN00004', 'RTE00004', 'AA1030');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00031', 'ALN00005', 'RTE00005', 'AA1031');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00032', 'ALN00001', 'RTE00001', 'AA1032');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00033', 'ALN00002', 'RTE00002', 'AA1033');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00034', 'ALN00003', 'RTE00003', 'AA1034');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00035', 'ALN00004', 'RTE00004', 'AA1035');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00036', 'ALN00005', 'RTE00005', 'AA1036');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00037', 'ALN00001', 'RTE00001', 'AA1037');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00038', 'ALN00002', 'RTE00002', 'AA1038');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00039', 'ALN00003', 'RTE00003', 'AA1039');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00040', 'ALN00004', 'RTE00004', 'AA1040');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00041', 'ALN00005', 'RTE00005', 'AA1041');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00042', 'ALN00001', 'RTE00001', 'AA1042');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00043', 'ALN00002', 'RTE00002', 'AA1043');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00044', 'ALN00003', 'RTE00003', 'AA1044');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00045', 'ALN00004', 'RTE00004', 'AA1045');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00046', 'ALN00005', 'RTE00005', 'AA1046');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00047', 'ALN00001', 'RTE00001', 'AA1047');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00048', 'ALN00002', 'RTE00002', 'AA1048');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00049', 'ALN00003', 'RTE00003', 'AA1049');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00050', 'ALN00004', 'RTE00004', 'AA1050');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00051', 'ALN00005', 'RTE00005', 'AA1051');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00052', 'ALN00001', 'RTE00001', 'AA1052');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00053', 'ALN00002', 'RTE00002', 'AA1053');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00054', 'ALN00003', 'RTE00003', 'AA1054');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00055', 'ALN00004', 'RTE00004', 'AA1055');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00056', 'ALN00005', 'RTE00005', 'AA1056');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00057', 'ALN00001', 'RTE00001', 'AA1057');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00058', 'ALN00002', 'RTE00002', 'AA1058');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00059', 'ALN00003', 'RTE00003', 'AA1059');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00060', 'ALN00004', 'RTE00004', 'AA1060');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00061', 'ALN00005', 'RTE00005', 'AA1061');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00062', 'ALN00001', 'RTE00001', 'AA1062');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00063', 'ALN00002', 'RTE00002', 'AA1063');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00064', 'ALN00003', 'RTE00003', 'AA1064');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00065', 'ALN00004', 'RTE00004', 'AA1065');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00066', 'ALN00005', 'RTE00005', 'AA1066');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00067', 'ALN00001', 'RTE00001', 'AA1067');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00068', 'ALN00002', 'RTE00002', 'AA1068');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00069', 'ALN00003', 'RTE00003', 'AA1069');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00070', 'ALN00004', 'RTE00004', 'AA1070');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00071', 'ALN00005', 'RTE00005', 'AA1071');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00072', 'ALN00001', 'RTE00001', 'AA1072');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00073', 'ALN00002', 'RTE00002', 'AA1073');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00074', 'ALN00003', 'RTE00003', 'AA1074');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00075', 'ALN00004', 'RTE00004', 'AA1075');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00076', 'ALN00005', 'RTE00005', 'AA1076');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00077', 'ALN00001', 'RTE00001', 'AA1077');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00078', 'ALN00002', 'RTE00002', 'AA1078');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00079', 'ALN00003', 'RTE00003', 'AA1079');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00080', 'ALN00004', 'RTE00004', 'AA1080');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00081', 'ALN00005', 'RTE00005', 'AA1081');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00082', 'ALN00001', 'RTE00001', 'AA1082');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00083', 'ALN00002', 'RTE00002', 'AA1083');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00084', 'ALN00003', 'RTE00003', 'AA1084');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00085', 'ALN00004', 'RTE00004', 'AA1085');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00086', 'ALN00005', 'RTE00005', 'AA1086');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00087', 'ALN00001', 'RTE00001', 'AA1087');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00088', 'ALN00002', 'RTE00002', 'AA1088');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00089', 'ALN00003', 'RTE00003', 'AA1089');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00090', 'ALN00004', 'RTE00004', 'AA1090');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00091', 'ALN00005', 'RTE00005', 'AA1091');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00092', 'ALN00001', 'RTE00001', 'AA1092');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00093', 'ALN00002', 'RTE00002', 'AA1093');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00094', 'ALN00003', 'RTE00003', 'AA1094');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00095', 'ALN00004', 'RTE00004', 'AA1095');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00096', 'ALN00005', 'RTE00005', 'AA1096');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00097', 'ALN00001', 'RTE00001', 'AA1097');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00098', 'ALN00002', 'RTE00002', 'AA1098');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00099', 'ALN00003', 'RTE00003', 'AA1099');
INSERT INTO Flight (FlightID, AirlineID, RouteID, FlightNumber) VALUES ('FLT00100', 'ALN00004', 'RTE00004', 'AA1100');

--  trigger insertar un nuevo vuelo
CREATE TRIGGER trg_AfterInsertFlight
AFTER INSERT ON Flight
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(255);
    SET msg = CONCAT('Se ha añadido un nuevo vuelo: ', NEW.FlightNumber, 
                     ' desde ', (SELECT Name FROM City WHERE Id = NEW.DepartureCityId),
                     ' hasta ', (SELECT Name FROM City WHERE Id = NEW.ArrivalCityId));
    
    INSERT INTO FlightLog (Message, CreatedAt) VALUES (msg, NOW());
END;
