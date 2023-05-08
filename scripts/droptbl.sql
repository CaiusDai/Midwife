-- Include your drop table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the drop table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been dropped (reverse of the creation order).

-- This is only an example of how you add drop table ddls to this file.
--   You may remove it.

DROP TABLE MotherTest;
DROP TABLE BabyTest;
DROP TABLE Test;
DROP TABLE Lab;
DROP TABLE Technician;
DROP TABLE Note;
DROP TABLE Appointment;
DROP TABLE Baby;
DROP TABLE Pregnancy;
DROP TABLE InforInvitation;
DROP TABLE Couple;
DROP TABLE Father;
DROP TABLE Mother;
DROP TABLE InformationSession;
DROP TABLE Midwife;
DROP TABLE CommuClinic;
DROP TABLE BirthCenter;
DROP TABLE HealthInstitution;
