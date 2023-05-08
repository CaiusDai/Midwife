-- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the create table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been created.

-- This is only an example of how you add create table ddls to this file.
--   You may remove it.

CREATE TABLE HealthInstitution(
    hid INTEGER NOT NULL PRIMARY KEY ,
    email VARCHAR(30) NOT NULL,
    name VARCHAR(50) NOT NULL,
    phonenum VARCHAR(20) NOT NULL ,
    address VARCHAR(255) NOT NULL,
    website VARCHAR(255)
);

CREATE TABLE BirthCenter(
    hid INTEGER NOT NULL PRIMARY KEY,
    FOREIGN KEY (hid) REFERENCES HealthInstitution(hid)
);

CREATE TABLE CommuClinic(
    hid INTEGER NOT NULL PRIMARY KEY,
    FOREIGN KEY (hid) REFERENCES HealthInstitution(hid)
);

CREATE TABLE Midwife(
    practitionerid INTEGER NOT NULL PRIMARY KEY,
    instituteid INTEGER NOT NULL,
    name VARCHAR(50) NOT NULL,
    phonenum VARCHAR(20) NOT NULL ,
    email VARCHAR(30) NOT NULL,
    FOREIGN KEY (instituteid) REFERENCES
        HealthInstitution(hid)
);

CREATE TABLE InformationSession(
    sessionid INTEGER NOT NULL PRIMARY KEY,
    midwifeid INTEGER NOT NULL,
    time TIME NOT NULL,
    date DATE NOT NULL,
    language VARCHAR(20) NOT NULL,
    address VARCHAR(255) NOT NULL,
    leftquota INTEGER NOT NULL CHECK ( leftquota >=0 ),
    available BOOLEAN NOT NULL,
    FOREIGN KEY (midwifeid) REFERENCES Midwife(practitionerid),
    --This constrain checks before a session becomes available
    CONSTRAINT checkStatus CHECK (available ='F' OR
                                leftquota <> 0),
    CONSTRAINT overlap UNIQUE (address,time,date)
);

CREATE TABLE Mother (
    hcardid INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    profession VARCHAR(30) NOT NULL,
    address VARCHAR(255) NOT NULL,
    birthdate DATE NOT NULL,
    phonenum VARCHAR(20) NOT NULL,
    email VARCHAR(30) NOT NULL
);

CREATE TABLE Father(
    fatherid INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
    phonenum VARCHAR(20) NOT NULL,
    email VARCHAR(30) NOT NULL,
    profession VARCHAR(30) NOT NULL,
    address VARCHAR(255)
);

CREATE TABLE Couple(
    cpid INTEGER NOT NULL PRIMARY KEY,
    momid INTEGER NOT NULL,
    dadid INTEGER,
    FOREIGN KEY (momid) REFERENCES Mother(hcardid),
    FOREIGN KEY (dadid) REFERENCES Father(fatherid)
);

CREATE TABLE InforInvitation(
    cpid INTEGER NOT NULL ,
    sessionid INTEGER NOT NULL,
    attended BOOLEAN NOT NULL,
    PRIMARY KEY (cpid,sessionid),
    FOREIGN KEY (cpid) REFERENCES Couple(cpid),
    FOREIGN KEY (sessionid) REFERENCES InformationSession(sessionid)
);


CREATE TABLE Pregnancy(
    cpid INTEGER NOT NULL,
    numofpreg INTEGER NOT NULL CHECK(numofpreg>=0),
    backupid INTEGER,
    primaryid INTEGER,
    expectedbirthdate DATE NOT NULL,
    manualestimate DATE,
    finalestimate DATE,
    ultraestimate DATE,
    momblood VARCHAR(3),
    dadblood VARCHAR(3),
    lastmens DATE,
    isinterested BOOLEAN,
    birthcenterid INTEGER,
    numofbb INTEGER CHECK(numofbb>=0),
    ishomebirth BOOLEAN,
    attended BOOLEAN NOT NULL,
    PRIMARY KEY (cpid,numofpreg),
    FOREIGN KEY (cpid) REFERENCES Couple(cpid),
    FOREIGN KEY (backupid) REFERENCES Midwife(practitionerid),
    FOREIGN KEY (primaryid) REFERENCES Midwife(practitionerid),
    FOREIGN KEY (birthcenterid) REFERENCES BirthCenter(hid),
    --This constrain allows a primary midwife be assigned only when the couple shows interest
    --and has attended at least one of the sessions
    CONSTRAINT joinprog CHECK((primaryid IS NULL AND backupid IS NULL) OR (
        isinterested='True' AND attended='True')),
    --This constrain make sure the backup midwife is not the same one as primary midwife
    --and backup midwife is always assigned later than primary midwife
    CONSTRAINT differentmidwife CHECK((primaryid IS NULL AND backupid IS NULL )OR
        (primaryid <> backupid AND NOT
        (primaryid IS NULL AND backupid IS NOT NULL))),

    CONSTRAINT ifHomeBirth CHECK(ishomebirth IS NULL OR (birthcenterid IS NOT NULL AND ishomebirth='False')
        OR (birthcenterid IS NULL AND ishomebirth='True'))

);

CREATE TABLE Baby(
    babyid INTEGER NOT NULL PRIMARY KEY,
    cpid INTEGER NOT NULL,
    numofpreg INTEGER NOT NULL CHECK(numofpreg >0),
    name VARCHAR(30),
    gender VARCHAR(6) CHECK(gender='Male' OR gender='Female'),
    blood VARCHAR(3),
    birthdate Date,
    birthtime Time,
    FOREIGN KEY (cpid,numofpreg) REFERENCES Pregnancy(cpid,numofpreg)
);

CREATE TABLE Appointment(
    appid INTEGER NOT NULL PRIMARY KEY ,
    time TIME NOT NULL ,
    date DATE NOT NULL ,
    midwifeid INTEGER NOT NULL,
    cpid INTEGER NOT NULL ,
    numofpreg INTEGER NOT NULL,
    FOREIGN KEY (midwifeid) REFERENCES Midwife(practitionerid),
    FOREIGN KEY (cpid,numofpreg) REFERENCES Pregnancy(cpid,numofpreg),
    CONSTRAINT overlap UNIQUE (midwifeid,time,date)
);

CREATE TABLE Note(
    noteid INTEGER NOT NULL PRIMARY KEY,
    appid INTEGER NOT NULL,
    description VARCHAR(255),
    settime TIME,
    FOREIGN KEY (appid) REFERENCES Appointment(appid)
);

CREATE TABLE Technician(
    techid INTEGER NOT NULL PRIMARY KEY ,
    name VARCHAR(50) NOT NULL ,
    phonenum VARCHAR(20) NOT NULL,
    email VARCHAR(30)
);

CREATE TABLE Lab(
    name VARCHAR(50) NOT NULL,
    email VARCHAR(30) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phonenum VARCHAR(20) NOT NULL,
    PRIMARY KEY (name,email)
);

CREATE TABLE Test(
    testid INTEGER NOT NULL PRIMARY KEY,
    appid INTEGER NOT NULL,
    note VARCHAR(255),
    result VARCHAR(255),
    conductdate DATE,
    sampledate DATE,
    prescribedate DATE NOT NULL,
    testtype VARCHAR(255) NOT NULL,
    teststatus BOOLEAN NOT NULL,
    techid INTEGER,
    labname VARCHAR(50),
    labemail VARCHAR(30),
    FOREIGN KEY (appid) REFERENCES Appointment(appid),
    FOREIGN KEY (techid) REFERENCES Technician(techid),
    FOREIGN KEY (labname,labemail) REFERENCES Lab(name,email),
    --This constrain make sure once the result is uploaded,
    --it must have updated the technician id who conduct the test.
    CONSTRAINT techConduct CHECK (result IS NULL OR
                                 (result IS NOT NULL AND
                                  techid IS NOT NULL) ),
    --This constrain make sure once a test's status is True, all its required fields except Sampledate must not be empty
    CONSTRAINT validTest CHECK ( teststatus='F' OR (result IS NOT NULL AND
                                                    conductdate IS NOT NULL AND
                                                    techid IS NOT NULL AND
                                                    labname IS NOT NULL AND
                                                    labemail IS NOT NULL) )
    );

CREATE TABLE BabyTest(
    testid INTEGER NOT NULL PRIMARY KEY ,
    babyid INTEGER NOT NULL,
    FOREIGN KEY (babyid) REFERENCES Baby(babyid),
    FOREIGN KEY (testid) REFERENCES Test(testid)
);

CREATE TABLE MotherTest(
    testid INTEGER NOT NULL PRIMARY KEY ,
    motherid INTEGER NOT NULL,
    FOREIGN KEY (motherid) REFERENCES Mother(hcardid),
    FOREIGN KEY (testid) REFERENCES Test(testid)
);


