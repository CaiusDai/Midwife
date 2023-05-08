-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the parent tables!

INSERT INTO HealthInstitution (hid,email,name,phonenum,address,website)
VALUES
    (18, 'goodbirth@gmail.com', 'GoodBirth', '(306)795-7415', '3225 rue Levy,Montreal', NULL),
    (35, 'newlife@gmail.com', 'NewLife', '(416)725-9591', '2136 René-Lévesque Blvd,Montreal', NULL),
    (52, 'nicebirth@gmail.com', 'NiceBirth', '(902)728-7374', '3058 Côte Joyeuse,St Agapit', NULL),
    (69, 'tomorrow@gmail.com', 'Tomorrow', '(506)759-3728', '1659 Scarth Street,Montreal', NULL),
    (86, 'saintlouis@gmail.com', 'Lac-Saint-Louis', '(514)260-6902', '4241 Paradise Crescent,Hauterive', 'saintlouis.com'),
    (103, 'goodhealth@gmail.com', 'GoodHealth', '(418)243-3819', '1486 rue Boulay,St Hugues', NULL),
    (120, 'wishywave@gmail.com', 'WishyWave', '(579)237-2841', '1877 rue Levy,Montreal', NULL),
    (137, 'universalbody@gmail.com', 'Universal Body Clinic', '(514)925-9862', '1725 Rue De La Gare,La Dore', NULL),
    (154, 'healingclinic@gmail.com', 'The Healing Clinic', '(902)577-3663', '3129 rue Garneau,Quebec', NULL),
    (171, 'medicazone@gmail.com', 'Medica Zone', '(450)412-3779', '4015 rue Parc,Sherbrooke', NULL);

INSERT INTO BirthCenter (hid)
VALUES
    ('18'),
    ('35'),
    ('52'),
    ('69'),
    ('86');

INSERT INTO CommuClinic (hid)
VALUES
    ('103'),
    ('120'),
    ('137'),
    ('154'),
    ('171');

INSERT INTO Midwife (practitionerid,instituteid,name,phonenum,email)
VALUES
    (22, 86, 'Marion Girard', '418-555-0130', 'marion@gmail.com'),
    (41, 52, 'Martin Zhang', '418-555-0169', 'martin@gmail.com'),
    (60, 120, 'Caius Dai', '418-555-0119', 'caius@gmail.com'),
    (79, 171, 'Jeffery Tan', '418-555-0160', 'jeffery@gmail.com'),
    (98, 18, 'Circle Ren', '418-555-0132', 'circle@gmail.com'),
    (117, 69, 'Alex Run', '403-662-6319 ', 'alex@gmail.com');

INSERT INTO InformationSession (sessionid,midwifeid,time,date,language,address,leftquota,available)
VALUES
    (12, 22, '14:00:00', '2021-1-1', 'English', '4122 Boulevard Laflèche,St Georges', 47, 'F'),
    (19, 41, '15:00:00', '2022-1-1', 'English', '4672 rue Ontario Ouest,Montreal', 48, 'F'),
    (26, 60, '11:00:00', '2022-1-12', 'English', '3142 chemin Hudson,Montreal', 48, 'T'),
    (33, 79, '14:00:00', '2022-6-6', 'French', '106 chemin Georges,Lavaltrie', 48, 'T'),
    (40, 98, '11:00:00', '2022-7-7', 'English', '3483 St-Jerome Street,St Jerome', 49, 'T'),
    (47, 117, '11:00:00', '2021-1-31', 'Franch', '1807 avenue de Port-Royal,Bonaventure', 48, 'F');


INSERT INTO Mother (hcardid,name,profession,address,birthdate,phonenum,email)
VALUES
    (24, 'Cynthia Chen', 'Professor', '1434 Papineau Avenue,Montreal', '1995-11-17', '250-271-7626 ', 'cynthia@gmail.com'),
    (35, 'Victoria Gutierrez', 'Human Resource Manager', '1026 Boulevard Cremazie,Quebec', '1993-06-14', '705-382-3418 ', 'victoria@gmail.com'),
    (46, 'Trish Nickerson', 'Engineer', '756 rue Garneau,Quebec', '1992-05-14', '905-330-7202 ', 'trish@gmail.com'),
    (57, 'Gwen Wilkinson', 'Maid', '2317 avenue Royale,Quebec', '1998-10-28', '306-563-3207 ', 'gwen@gmail.com'),
    (68, 'Lynne Hamel', 'Lawyer', '316 rue Garneau,Quebec', '1995-08-14', '450-505-4410 ', 'lynne@gmail.com'),
    (79, 'Lily Barrette', 'Software Developer', '4794 rue Garneau,Quebec', '1998-01-17', '416-923-1528 ', 'lily@gmail.com');

INSERT INTO Father (fatherid,name,birthdate,phonenum,email,profession,address)
VALUES
    (58, 'Evan Klein', '1991-1-3', '403-465-7039 ', 'evan@gmail.com', 'Engineer', NULL),
    (95, 'Roger Charron', '1993-4-8', '905-749-0928 ', 'roger@gmail.com', 'Information Security Analyst', NULL),
    (132, 'John Breton', '1996-7-29', '250-995-1204 ', 'john@gmail.com', 'Aircraft pilot', NULL),
    (169, 'Igor Carriere', '1989-4-13', '604-997-2012 ', 'igor@gmail.com', 'Marketing Manager', NULL),
    (206, 'Will Schultz', '1994-6-30', '905-467-2492 ', 'will@gmail.com', 'Taxi Driver', NULL);

INSERT INTO Couple (cpid,momid,dadid)
VALUES
    (46, 24, 58),
    (85, 35, 95),
    (124, 46, 132),
    (163, 57, 169),
    (202, 68, 206),
    (241, 79, NULL);

INSERT INTO InforInvitation (cpid,sessionid,attended)
VALUES
    (46, 12, 'T'),
    (85, 12, 'T'),
    (46, 19, 'T'),
    (85, 19, 'T'),
    (163, 19, 'T'),
    (124, 26, 'T'),
    (202, 26, 'F'),
    (241, 26, 'F');

INSERT INTO Pregnancy (cpid,numofpreg,backupid,primaryid,expectedbirthdate,manualestimate,finalestimate,ultraestimate,momblood,dadblood,lastmens,isinterested,birthcenterid,numofbb,ishomebirth,attended)
VALUES
    (46, 1, 41, 22, '2021-8-1', '2021-8-15', '2021-8-15', '2021-8-7', 'A', 'A', '2020-10-14', 'T', 86, 2, 'F', 'T'),
    (85, 1, 41, 22, '2021-9-1', '2021-9-15', '2021-9-7', '2021-9-7', 'O', NULL, '2020-11-14', 'T', 86, 2, 'F', 'T'),
    (46, 2, NULL, 22, '2022-7-1', '2022-7-1', NULL, NULL, 'A', 'A', '2021-9-18', 'T', NULL, NULL, NULL, 'T'),
    (85, 2, NULL, 117, '2022-7-1', '2022-7-2', '2022-7-5', '2022-7-5', 'O', NULL, '2021-9-10', 'T', NULL, 2, NULL, 'T'),
    (163,1, 22, 79, '2022-7-1', '2022-7-3', '2022-7-6', '2022-7-6', NULL, NULL, '2021-9-16', 'T', NULL, NULL, NULL, 'T'),
    (124,1, NULL, 22, '2022-7-1', NULL, NULL, NULL, NULL,NULL,'2021-9-10', 'T', NULL, NULL, NULL, 'T'),
    (202,1, NULL, NULL, '2022-7-1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'F'),
    (241,1, NULL, NULL, '2022-7-1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'F');

INSERT INTO Baby (babyid,cpid,numofpreg,name,gender,blood,birthdate,birthtime)
VALUES
    (6, 46, 1, 'Jack Klein', 'Male', 'A', '2021-8-15', '12:00:00'),
    (13, 46, 1, 'Mike Klein', 'Male', 'A', '2021-8-15', '12:05:00'),
    (20, 85, 1, 'Katty Charron', 'Female', 'O', '2021-9-7', '12:10:00'),
    (27, 85, 1, 'Marry Charron', 'Female', 'O', '2021-9-7', '12:15:00'),
    (34, 85, 2, NULL, NULL, NULL, NULL, NULL),
    (41, 85, 2, NULL, NULL, NULL, NULL, NULL);

INSERT INTO Appointment (appid,time,date,midwifeid,cpid,numofpreg)
VALUES
    (4, '11:00:00', '2021-1-10', 22, 46, 1),
    (7, '11:00:00', '2021-1-11', 22, 85, 1),
    (10, '11:00:00', '2021-2-10', 22, 46, 1),
    (13, '11:00:00', '2021-2-11', 22, 85, 1),
    (16, '11:00:00', '2021-3-10', 22, 46, 1),
    (19, '11:00:00', '2021-3-11', 22, 85, 1),
    (22, '11:00:00', '2021-4-10', 41, 46, 1),
    (25, '11:00:00', '2021-4-11', 41, 85, 1),
    (28, '11:00:00', '2022-1-10', 22, 46, 2),
    (31, '11:00:00', '2022-1-11', 117, 85, 2),
    (34, '11:00:00', '2022-1-12', 79, 163, 1),
    (37, '11:00:00', '2022-2-10', 22, 46, 2),
    (40, '11:00:00', '2022-2-11', 117, 85, 2),
    (43, '11:00:00', '2022-2-12', 79, 163, 1),
    (46, '11:00:00', '2022-2-14', 117, 85, 2),
    (49, '11:00:00', '2022-2-14', 22, 163, 1),
    (52, '11:00:00', '2022-3-21', 22, 46, 2),
    (55, '11:00:00', '2022-3-22', 22, 163, 1),
    (58, '11:00:00', '2022-3-23', 117, 85, 2),
    (61, '11:00:00', '2022-2-15', 117, 85, 2);
    (64, '16:00:00', '2021-3-10', 22, 85, 1);
    (67, '16:00:00', '2021-03-11', 22, 124,1);


INSERT INTO Note (noteid,appid,description,settime)
VALUES
    (8, 4, 'Take Blood sample to test iron content', '11:30:00'),
    (13, 7, 'Take Blood sample to test iron content', '11:30:00'),
    (18, 10, 'Discuss birth date estimation', '11:30:00'),
    (23, 13, 'Discuss birth date estimation', '11:30:00'),
    (28, 16, 'Prescribe dating ultrasound', '11:30:00'),
    (33, 19, 'Prescribe dating ultrasound', '11:30:00'),
    (38, 22, 'Settle the final estimation and record blood type', '11:30:00'),
    (43, 25, 'Settle the final estimation and record blood type', '11:30:00'),
    (48, 28, 'Take Blood sample to test iron content and discuss the birth date', '11:30:00'),
    (53, 31, 'Take Blood sample to test iron content and discuss the birth date', '11:30:00'),
    (58, 34, 'Take Blood sample to test iron content and discuss the birth date', '11:30:00'),
    (63, 37, 'Take Blood sample to test iron content', '11:30:00'),
    (68, 40, 'Take Blood sample to test iron content', '11:30:00'),
    (73, 43, 'Take Blood sample to test iron content', '11:30:00'),
    (78, 46, 'ultralsound', '11:30:00'),
    (83, 49, 'ultralsound', '11:30:00');

INSERT INTO Technician (techid,name,phonenum,email)
VALUES
    (68, 'Neal Crouch', '514-715-7028 ', 'neal@gmail.com'),
    (127, 'Bryony Bull', '250-730-3258 ', 'bryony@gmail.com'),
    (186, 'Naseem Jackson', '613-391-3687 ', 'naseem@gmail.com'),
    (245, 'Mollie Noble', '450-230-4071 ', 'mollie@gmail.com'),
    (304, 'Cecil Harman', '705-693-0121 ', 'cecil@gmail.com');

INSERT INTO Lab (name,email,address,phonenum)
VALUES
    ('Analyte Research Lab', 'analyte@gmail.com', '3758 Saskatchewan Dr,Montreal', '705-526-4245 '),
    ('MedLife Lab', 'medlife@gmail.com', '2555 rue Levy,Montreal', '604-830-9716 '),
    ('LabCity', 'labcity@gmail.com', '3964 Duke Street,Montreal', '905-671-5229 '),
    ('ChemTime Lab', 'chemtime@gmail.com', '2994 rue Garneau,Quebec', '416-738-4383 '),
    ('Bob Lab', 'boblab@gmail.com', '1263 Saint-Denis Street,Montreal', '819-461-8822');

INSERT INTO Test (testid,appid,note,result,conductdate,sampledate,prescribedate,testtype,teststatus,techid,labname,labemail)
VALUES
    (13, 4, 'Normal', 'Fall in normal range', '2021-1-11', '2021-1-10', '2021-1-10', 'Blood Iron Content', 'T', 68, 'Analyte Research Lab', 'analyte@gmail.com'),
    (24, 7, 'Normal', 'Fall in normal range', '2021-1-12', '2021-1-11', '2021-1-11', 'Blood Iron Content', 'T', 127, 'MedLife Lab', 'medlife@gmail.com'),
    (35, 16, 'Normal', '2021/8/7', '2021-3-11', '2021-3-11', '2021-3-10', 'Dating Ultrasound', 'T', 68, 'Analyte Research Lab', 'analyte@gmail.com'),
    (46, 19, 'Normal', '2021/9/7', '2021-3-12', '2021-3-12', '2021-3-11', 'Dating Ultrasound', 'T', 68, 'Analyte Research Lab', 'analyte@gmail.com'),
    (57, 22, 'Normal', '2', '2021-4-11', '2021-4-11', '2021-4-10', 'Num of Babies', 'T', 245, 'ChemTime Lab', 'chemtime@gmail.com'),
    (68, 25, 'Normal', '2', '2021-4-12', '2021-4-12', '2021-4-11', 'Num of Babies', 'T', 245, 'ChemTime Lab', 'chemtime@gmail.com'),
    (79, 22, 'Normal', 'Male', '2021-4-11', '2021-4-11', '2021-4-10', 'Gender of Baby', 'T', 68, 'Analyte Research Lab', 'analyte@gmail.com'),
    (90, 25, 'Normal', 'Female', '2021-4-12', '2021-4-12', '2021-4-11', 'Gender of Baby', 'T', 68, 'Analyte Research Lab', 'analyte@gmail.com'),
    (101, 22, 'Normal', 'Male', '2021-4-11', '2021-4-11', '2021-4-10', 'Gender of Baby', 'T', 68, 'Analyte Research Lab', 'analyte@gmail.com'),
    (112, 25, 'Normal', 'Female', '2021-4-12', '2021-4-12', '2021-4-11', 'Gender of Baby', 'T', 68, 'Analyte Research Lab', 'analyte@gmail.com'),
    (123, 28, 'Normal', 'Fall in normal range', '2022-1-11', '2022-1-10', '2022-1-10', 'Blood Iron Content', 'T', 127, 'MedLife Lab', 'medlife@gmail.com'),
    (134, 31, 'Normal', 'Fall in normal range', '2022-1-12', '2022-1-11', '2022-1-11', 'Blood Iron Content', 'T', 127, 'MedLife Lab', 'medlife@gmail.com'),
    (145, 34, 'Normal', 'Fall in normal range', '2022-1-13', '2022-1-12', '2022-1-12', 'Blood Iron Content', 'T', 127, 'MedLife Lab', 'medlife@gmail.com'),
    (156, 37, 'Normal', 'Fall in normal range', '2022-2-11', '2022-2-10', '2022-2-10', 'Blood Iron Content', 'T', 127, 'MedLife Lab', 'medlife@gmail.com'),
    (167, 40, 'Normal', 'Fall in normal range', '2022-2-12', '2022-2-11', '2022-2-11', 'Blood Iron Content', 'T', 127, 'MedLife Lab', 'medlife@gmail.com'),
    (178, 43, 'Normal', 'Fall in normal range', '2022-2-13', '2022-2-12', '2022-2-12', 'Blood Iron Content', 'T', 127, 'MedLife Lab', 'medlife@gmail.com'),
    (189, 46, 'Normal', '2022/7/5', '2022-2-15', '2022-2-15', '2022-2-14', 'Dating Ultrasound', 'T', 68, 'Analyte Research Lab', 'analyte@gmail.com'),
    (200, 49, 'Normal', '2022/7/6', '2022-2-15', '2022-2-15', '2022-2-14', 'Dating Ultrasound', 'T', 68, 'Analyte Research Lab', 'analyte@gmail.com'),
    (211, 61, 'Normal', '2', '2022-2-16', '2022-2-16', '2022-2-15', 'Num of Babies', 'T', 68, 'Analyte Research Lab', 'analyte@gmail.com');

INSERT INTO BabyTest (testid,babyid)
VALUES
    (79, 6),
    (90, 20),
    (101, 13),
    (112, 27);

INSERT INTO MotherTest (testid,motherid)
VALUES
    (13, 24),
    (24, 35),
    (35, 24),
    (46, 35),
    (57, 24),
    (68, 35),
    (123,24),
    (134, 35),
    (145, 57),
    (156, 24),
    (167, 35),
    (178, 57),
    (189, 35),
    (200, 57),
    (211, 35);
