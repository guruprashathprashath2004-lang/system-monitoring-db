-- ============================================= TASK 04 =============================================

-- =============================================
-- TechVille Municipal Management System Database
-- Created by: Guru Prashath
-- Registration No: KD/HDCSE/CMU/79/05
-- =============================================

-- ================================================================================================
-- ============================================ TABLES ============================================
-- ================================================================================================

-- ======================== CITIZEN TABLE ========================
CREATE TABLE Citizen (
    CitizenID CHAR(4) CHECK (CitizenID LIKE '[C][0-9][0-9][0-9]'),
    Name VARCHAR(100) NOT NULL,
    DateOfBirth DATE,
    Street VARCHAR(100),
    City VARCHAR(50),
    Email VARCHAR(100),

    CONSTRAINT Citizen_PK PRIMARY KEY (CitizenID)
);

-- ======================== CITIZEN PHONE TABLE ========================
CREATE TABLE CitizenPhone (
    CitizenID CHAR(4),
    Phone CHAR(10),

    CONSTRAINT CitizenPhone_PK PRIMARY KEY (CitizenID, Phone),
    CONSTRAINT CitizenPhone_FK FOREIGN KEY (CitizenID)
        REFERENCES Citizen (CitizenID)
);

-- ======================== MUNICIPAL AGENCY TABLE ========================
CREATE TABLE MunicipalAgency (
    AgencyID CHAR(4) CHECK (AgencyID LIKE '[A][0-9][0-9][0-9]'),
    Name VARCHAR(100),
    ServiceType VARCHAR(50),
    Contact CHAR(10),

    CONSTRAINT Agency_PK PRIMARY KEY (AgencyID)
);

-- ======================== SERVICE TABLE ========================
CREATE TABLE Service (
    ServiceID CHAR(4) CHECK (ServiceID LIKE '[S][0-9][0-9][0-9]'),
    ServiceName VARCHAR(100),
    AgencyID CHAR(4),

    CONSTRAINT Service_PK PRIMARY KEY (ServiceID),
    CONSTRAINT Service_FK FOREIGN KEY (AgencyID)
        REFERENCES MunicipalAgency (AgencyID)
);

-- ======================== UTILITY ACCOUNT TABLE ========================
CREATE TABLE UtilityAccount (
    AccountID CHAR(5) CHECK (AccountID LIKE 'UA[0-9][0-9][0-9]'),
    ServiceType VARCHAR(50),
    BillingAmount DECIMAL(10,2),
    CitizenID CHAR(4),

    CONSTRAINT Account_PK PRIMARY KEY (AccountID),
    CONSTRAINT Account_FK FOREIGN KEY (CitizenID)
        REFERENCES Citizen (CitizenID)
);

-- ======================== BILL TABLE (WEAK ENTITY) ========================
CREATE TABLE Bill (
    BillID CHAR(4) CHECK (BillID LIKE '[B][0-9][0-9][0-9]'),
    AccountID CHAR(5),
    Amount DECIMAL(10,2),
    DueDate DATE,
    Status VARCHAR(20) CHECK (Status IN ('Paid','Unpaid')),

    CONSTRAINT Bill_PK PRIMARY KEY (BillID, AccountID),
    CONSTRAINT Bill_FK FOREIGN KEY (AccountID)
        REFERENCES UtilityAccount (AccountID)
);

-- ======================== PAYMENT TABLE ========================
CREATE TABLE Payment (
    PaymentID CHAR(4) CHECK (PaymentID LIKE '[P][0-9][0-9][0-9]'),
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    AccountID CHAR(5),

    CONSTRAINT Payment_PK PRIMARY KEY (PaymentID),
    CONSTRAINT Payment_FK FOREIGN KEY (AccountID)
        REFERENCES UtilityAccount (AccountID)
);

-- ======================== COMPLAINT TABLE ========================
CREATE TABLE Complaint (
    ComplaintID CHAR(5) CHECK (ComplaintID LIKE 'CP[0-9][0-9][0-9]'),
    Description VARCHAR(255),
    Status VARCHAR(20) CHECK (Status IN ('Pending','Resolved')),
    Date DATE,
    CitizenID CHAR(4),
    AgencyID CHAR(4),

    CONSTRAINT Complaint_PK PRIMARY KEY (ComplaintID),
    CONSTRAINT Complaint_FK1 FOREIGN KEY (CitizenID)
        REFERENCES Citizen (CitizenID),
    CONSTRAINT Complaint_FK2 FOREIGN KEY (AgencyID)
        REFERENCES MunicipalAgency (AgencyID)
);

-- ======================== EMERGENCY INCIDENT TABLE ========================
CREATE TABLE EmergencyIncident (
    IncidentID CHAR(4) CHECK (IncidentID LIKE '[I][0-9][0-9][0-9]'),
    Type VARCHAR(50),
    Street VARCHAR(100),
    City VARCHAR(50),
    Status VARCHAR(20) CHECK (Status IN ('Pending','Resolved')),
    CitizenID CHAR(4),

    CONSTRAINT Incident_PK PRIMARY KEY (IncidentID),
    CONSTRAINT Incident_FK FOREIGN KEY (CitizenID)
        REFERENCES Citizen (CitizenID)
);

-- ====================================================================================
-- ================================== INSERT DATA =====================================
-- ====================================================================================

-- ======================== CITIZEN ========================
INSERT INTO Citizen VALUES 
('C001','Kasun Perera','1995-05-10','Negombo Road','Negombo','kasun@gmail.com'),
('C002','Nimal Silva','1988-03-22','Galle Road','Colombo','nimal@gmail.com'),
('C003','Saman Kumara','1992-07-15','Kandy Street','Kandy','saman@gmail.com'),
('C004','Amal Fernando','1990-01-11','Main Street','Kurunegala','amal@gmail.com'),
('C005','Sunil Perera','1985-09-09','Lake Road','Colombo','sunil@gmail.com'),
('C006','Ruwan Silva','1993-12-01','Temple Road','Gampaha','ruwan@gmail.com'),
('C007','Dilshan Jay','1996-04-18','Station Road','Jaffna','dilshan@gmail.com'),
('C008','Tharindu Lakmal','1998-06-25','Beach Road','Matara','tharindu@gmail.com'),
('C009','Ishan Fernando','1991-11-30','Hill Street','Badulla','ishan@gmail.com'),
('C010','Chamara Silva','1987-02-14','Market Road','Anuradhapura','chamara@gmail.com'),
('C011','Supun Perera','1999-08-08','Park Road','Colombo','supun@gmail.com'),
('C012','Janith Silva','1994-10-21','New Road','Negombo','janith@gmail.com'),
('C013','Kavindu Perera','2000-05-05','Old Road','Galle','kavindu@gmail.com'),
('C014','Nadeesha Silva','1997-03-03','Temple Lane','Kegalle','nadeesha@gmail.com'),
('C015','Pasindu Fernando','1996-12-12','River Road','Kalutara','pasindu@gmail.com');

-- ======================== CITIZEN PHONE ========================
INSERT INTO CitizenPhone VALUES
('C001','0711111111'),('C002','0722222222'),('C003','0733333333'),
('C004','0744444444'),('C005','0755555555'),('C006','0766666666'),
('C007','0777777777'),('C008','0788888888'),('C009','0799999999'),
('C010','0700000000'),('C011','0712345678'),('C012','0723456789'),
('C013','0734567890'),('C014','0745678901'),('C015','0756789012');

-- ======================== MUNICIPAL AGENCY ========================
INSERT INTO MunicipalAgency VALUES
('A001','Colombo Waste Dept','Waste','0111111111'),
('A002','Water Board','Water','0112222222'),
('A003','Electricity Board','Power','0113333333'),
('A004','Road Development','Road','0114444444'),
('A005','Fire Service','Emergency','0115555555'),
('A006','Health Dept','Health','0116666666'),
('A007','Drainage Board','Drainage','0117777777'),
('A008','Parks Dept','Parks','0118888888'),
('A009','Transport Dept','Transport','0119999999'),
('A010','Police Dept','Security','0111010101'),
('A011','Housing Authority','Housing','0112020202'),
('A012','Education Dept','Education','0113030303'),
('A013','IT Services','IT','0114040404'),
('A014','Revenue Dept','Finance','0115050505'),
('A015','Urban Council','Admin','0116060606');

-- ======================== SERVICE ========================
INSERT INTO Service VALUES
('S001','Garbage Collection','A001'),
('S002','Water Supply','A002'),
('S003','Electric Supply','A003'),
('S004','Road Repair','A004'),
('S005','Fire Rescue','A005'),
('S006','Hospital Service','A006'),
('S007','Drain Cleaning','A007'),
('S008','Park Maintenance','A008'),
('S009','Bus Service','A009'),
('S010','Police Service','A010'),
('S011','Housing Support','A011'),
('S012','School Service','A012'),
('S013','Online Services','A013'),
('S014','Tax Service','A014'),
('S015','City Admin','A015');

-- ======================== UTILITY ACCOUNT ========================
INSERT INTO UtilityAccount VALUES
('UA001','Water',2500,'C001'),
('UA002','Electric',3200,'C002'),
('UA003','Water',1500,'C003'),
('UA004','Electric',2800,'C004'),
('UA005','Water',2200,'C005'),
('UA006','Electric',3100,'C006'),
('UA007','Water',2700,'C007'),
('UA008','Electric',3500,'C008'),
('UA009','Water',2000,'C009'),
('UA010','Electric',2900,'C010'),
('UA011','Water',2600,'C011'),
('UA012','Electric',3300,'C012'),
('UA013','Water',2400,'C013'),
('UA014','Electric',3600,'C014'),
('UA015','Water',2100,'C015');

-- ======================== BILL ========================
INSERT INTO Bill VALUES
('B001','UA001',2500,'2026-04-01','Unpaid'),
('B002','UA002',3200,'2026-04-02','Paid'),
('B003','UA003',1500,'2026-04-03','Unpaid'),
('B004','UA004',2800,'2026-04-04','Paid'),
('B005','UA005',2200,'2026-04-05','Unpaid'),
('B006','UA006',3100,'2026-04-06','Paid'),
('B007','UA007',2700,'2026-04-07','Unpaid'),
('B008','UA008',3500,'2026-04-08','Paid'),
('B009','UA009',2000,'2026-04-09','Unpaid'),
('B010','UA010',2900,'2026-04-10','Paid'),
('B011','UA011',2600,'2026-04-11','Unpaid'),
('B012','UA012',3300,'2026-04-12','Paid'),
('B013','UA013',2400,'2026-04-13','Unpaid'),
('B014','UA014',3600,'2026-04-14','Paid'),
('B015','UA015',2100,'2026-04-15','Unpaid');

-- ======================== PAYMENT ========================
INSERT INTO Payment VALUES
('P001',2500,'2026-03-01','UA001'),
('P002',3200,'2026-03-02','UA002'),
('P003',1500,'2026-03-03','UA003'),
('P004',2800,'2026-03-04','UA004'),
('P005',2200,'2026-03-05','UA005'),
('P006',3100,'2026-03-06','UA006'),
('P007',2700,'2026-03-07','UA007'),
('P008',3500,'2026-03-08','UA008'),
('P009',2000,'2026-03-09','UA009'),
('P010',2900,'2026-03-10','UA010'),
('P011',2600,'2026-03-11','UA011'),
('P012',3300,'2026-03-12','UA012'),
('P013',2400,'2026-03-13','UA013'),
('P014',3600,'2026-03-14','UA014'),
('P015',2100,'2026-03-15','UA015');

-- ======================== COMPLAINT ========================
INSERT INTO Complaint VALUES
('CP001','Water leakage','Pending','2026-03-01','C001','A002'),
('CP002','Power cut','Resolved','2026-03-02','C002','A003'),
('CP003','Garbage issue','Pending','2026-03-03','C003','A001'),
('CP004','Road damage','Resolved','2026-03-04','C004','A004'),
('CP005','Fire emergency','Pending','2026-03-05','C005','A005'),
('CP006','Hospital delay','Resolved','2026-03-06','C006','A006'),
('CP007','Drain block','Pending','2026-03-07','C007','A007'),
('CP008','Park damage','Resolved','2026-03-08','C008','A008'),
('CP009','Bus delay','Pending','2026-03-09','C009','A009'),
('CP010','Security issue','Resolved','2026-03-10','C010','A010'),
('CP011','Housing issue','Pending','2026-03-11','C011','A011'),
('CP012','School issue','Resolved','2026-03-12','C012','A012'),
('CP013','System error','Pending','2026-03-13','C013','A013'),
('CP014','Tax issue','Resolved','2026-03-14','C014','A014'),
('CP015','Admin issue','Pending','2026-03-15','C015','A015');

-- ======================== EMERGENCY INCIDENT ========================
INSERT INTO EmergencyIncident VALUES
('I001','Fire','Main St','Colombo','Pending','C001'),
('I002','Accident','Galle Rd','Colombo','Resolved','C002'),
('I003','Flood','Lake Rd','Gampaha','Pending','C003'),
('I004','Fire','Hill St','Kandy','Resolved','C004'),
('I005','Accident','Park Rd','Matara','Pending','C005'),
('I006','Flood','Temple Rd','Kurunegala','Resolved','C006'),
('I007','Fire','Beach Rd','Galle','Pending','C007'),
('I008','Accident','River Rd','Kalutara','Resolved','C008'),
('I009','Flood','Station Rd','Jaffna','Pending','C009'),
('I010','Fire','Market Rd','Anuradhapura','Resolved','C010'),
('I011','Accident','Old Rd','Negombo','Pending','C011'),
('I012','Flood','New Rd','Badulla','Resolved','C012'),
('I013','Fire','School Rd','Kegalle','Pending','C013'),
('I014','Accident','Bus Stand','Colombo','Resolved','C014'),
('I015','Flood','Canal Rd','Gampaha','Pending','C015');

-- =============================================
--                   RUN TABLES 
-- =============================================

SELECT * FROM Citizen;
SELECT * FROM CitizenPhone;
SELECT * FROM MunicipalAgency;
SELECT * FROM Service;
SELECT * FROM UtilityAccount;
SELECT * FROM Bill;
SELECT * FROM Payment;
SELECT * FROM Complaint;
SELECT * FROM EmergencyIncident;

-- ============================================= TASK 04 =============================================

-- Retrieve all citizen details
SELECT * FROM Citizen;

 -- Retrieve complaint details related to a specific service
SELECT 
    comp.ComplaintID,
    comp.Description,
    comp.Status,
    comp.Date,
    s.ServiceName,
    m.Name AS AgencyName
FROM Complaint comp
JOIN MunicipalAgency m ON comp.AgencyID = m.AgencyID
JOIN Service s ON m.AgencyID = s.AgencyID
WHERE s.ServiceName = 'Water Supply';

-- Retrieve utility account details for a specific citizen 
SELECT 
    c.Name,
    u.AccountID,
    u.ServiceType,
    u.BillingAmount
FROM Citizen c
JOIN UtilityAccount u ON c.CitizenID = u.CitizenID
WHERE c.CitizenID = 'C001';

-- Retrieve citizens who have filed more than one complaint
SELECT 
    c.CitizenID,
    c.Name,
    COUNT(comp.ComplaintID) AS ComplaintCount
FROM Citizen c
JOIN Complaint comp ON c.CitizenID = comp.CitizenID
GROUP BY c.CitizenID, c.Name
HAVING COUNT(comp.ComplaintID) > 1;

-- Retrieve the department managing the highest number of services 
-- along with the average bill amount of its utility accounts

SELECT 
    m.AgencyID,
    m.Name AS AgencyName,
    COUNT(s.ServiceID) AS TotalServices,
    AVG(b.Amount) AS AvgBillAmount
FROM MunicipalAgency m
JOIN Service s ON m.AgencyID = s.AgencyID
JOIN UtilityAccount u ON u.ServiceType = s.ServiceName
JOIN Bill b ON u.AccountID = b.AccountID
GROUP BY m.AgencyID, m.Name
ORDER BY TotalServices DESC;

-- ===============================================
--                TESTCASE QUERIES 
-- ===============================================

INSERT INTO Citizen VALUES ('C016','Test User','2000-01-01','Test St','Colombo','test@gmail.com');

INSERT INTO Citizen VALUES ('X001','Invalid User','2000-01-01','Test St','Colombo','test@gmail.com');

INSERT INTO UtilityAccount VALUES ('UA999','Water',2000,'C999');

SELECT * FROM Citizen;

SELECT c.Name, comp.Description
FROM Citizen c
JOIN Complaint comp ON c.CitizenID = comp.CitizenID;

SELECT COUNT(*) FROM Complaint;

SELECT CitizenID, COUNT(*) 
FROM Complaint
GROUP BY CitizenID
HAVING COUNT(*) > 1;

INSERT INTO Bill VALUES ('B999','UA001',2000,'2026-05-01','Invalid');

SELECT * FROM Bill WHERE Amount < 0;

SELECT * FROM Complaint WHERE Status = 'Pending';

-- ===============================================
-- DROP TABLES (Reverse Order for depends problem)
-- ===============================================

DROP TABLE EmergencyIncident;
DROP TABLE Complaint;
DROP TABLE Payment;
DROP TABLE Bill;
DROP TABLE UtilityAccount;
DROP TABLE Service;
DROP TABLE CitizenPhone;
DROP TABLE MunicipalAgency;
DROP TABLE Citizen;