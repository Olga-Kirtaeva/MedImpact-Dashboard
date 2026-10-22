-- ==========================================
-- SQL DML Statements
-- ==========================================

-- ==========================================
-- INSERT Sample Data for MedImpact Dashboard
-- ==========================================

-- 1. PATIENT (10 patients)
INSERT INTO Patient (code, birth_year, sex) VALUES
('MUELLEA', 1988, 'F'),
('SCHMIM', 1975, 'M'),
('WEBERA', 1995, 'D'),
('BAUERR', 1965, 'F'),
('FISCHP', 2001, 'M'),
('HUBERK', 1990, 'M'),
('KOCHAN', 1982, 'F'),
('MEIERA', 1972, 'F'),
('WAGNEL', 1998, 'M'),
('SCHNEJ', 1985, 'D');

-- 2. MEDICATION (10 medications)
INSERT INTO Medication (name, trade_name, dosage_form) VALUES
('Ibuprofen', 'Brufen', 'Tablette'),
('Paracetamol', 'Dafalgan', 'Tablette'),
('Metformin', 'Glucophage', 'Tablette'),
('Atorvastatin', 'Sortis', 'Tablette'),
('Levothyroxine', 'Euthyrox', 'Tablette'),
('Amoxicillin', 'Amoxypen', 'Kapsel'),
('Omeprazole', 'Antra', 'Kapsel'),
('Salbutamol', 'Ventolin', 'Spray'),
('Insulin glargine', 'Lantus', 'Injektion'),
('Diazepam', 'Valium', 'Tablette');

-- ==========================================
-- 3. MEASUREMENT
-- ==========================================

-- Patient 1 (MUELLEA): 40 measurements (10 of each type)
-- Temperature (1-10)
INSERT INTO Measurement (measurement_type) VALUES
('Temperature'),('Temperature'),('Temperature'),('Temperature'),('Temperature'),
('Temperature'),('Temperature'),('Temperature'),('Temperature'),('Temperature');

-- BloodPressureSystolic (11-20)
INSERT INTO Measurement (measurement_type) VALUES
('BloodPressureSystolic'),('BloodPressureSystolic'),('BloodPressureSystolic'),('BloodPressureSystolic'),('BloodPressureSystolic'),
('BloodPressureSystolic'),('BloodPressureSystolic'),('BloodPressureSystolic'),('BloodPressureSystolic'),('BloodPressureSystolic');

-- BloodPressureDiastolic (21-30)
INSERT INTO Measurement (measurement_type) VALUES
('BloodPressureDiastolic'),('BloodPressureDiastolic'),('BloodPressureDiastolic'),('BloodPressureDiastolic'),('BloodPressureDiastolic'),
('BloodPressureDiastolic'),('BloodPressureDiastolic'),('BloodPressureDiastolic'),('BloodPressureDiastolic'),('BloodPressureDiastolic');

-- Glucose (31-40)
INSERT INTO Measurement (measurement_type) VALUES
('Glucose'),('Glucose'),('Glucose'),('Glucose'),('Glucose'),
('Glucose'),('Glucose'),('Glucose'),('Glucose'),('Glucose');

-- Patient 2 (SCHMIM): 40 measurements (10 of each type)
-- Temperature (41-50)
INSERT INTO Measurement (measurement_type) VALUES
('Temperature'),('Temperature'),('Temperature'),('Temperature'),('Temperature'),
('Temperature'),('Temperature'),('Temperature'),('Temperature'),('Temperature');

-- BloodPressureSystolic (51-60)
INSERT INTO Measurement (measurement_type) VALUES
('BloodPressureSystolic'),('BloodPressureSystolic'),('BloodPressureSystolic'),('BloodPressureSystolic'),('BloodPressureSystolic'),
('BloodPressureSystolic'),('BloodPressureSystolic'),('BloodPressureSystolic'),('BloodPressureSystolic'),('BloodPressureSystolic');

-- BloodPressureDiastolic (61-70)
INSERT INTO Measurement (measurement_type) VALUES
('BloodPressureDiastolic'),('BloodPressureDiastolic'),('BloodPressureDiastolic'),('BloodPressureDiastolic'),('BloodPressureDiastolic'),
('BloodPressureDiastolic'),('BloodPressureDiastolic'),('BloodPressureDiastolic'),('BloodPressureDiastolic'),('BloodPressureDiastolic');

-- Glucose (71-80)
INSERT INTO Measurement (measurement_type) VALUES
('Glucose'),('Glucose'),('Glucose'),('Glucose'),('Glucose'),
('Glucose'),('Glucose'),('Glucose'),('Glucose'),('Glucose');

-- Patients 3-10: 3 measurements of two types each (total 48 measurements)
-- Patient 3 (WEBERA): Temperature & Glucose (81-86)
INSERT INTO Measurement (measurement_type) VALUES
('Temperature'),('Temperature'),('Temperature'),
('Glucose'),('Glucose'),('Glucose');

-- Patient 4 (BAUERR): BloodPressureSystolic & BloodPressureDiastolic (87-92)
INSERT INTO Measurement (measurement_type) VALUES
('BloodPressureSystolic'),('BloodPressureSystolic'),('BloodPressureSystolic'),
('BloodPressureDiastolic'),('BloodPressureDiastolic'),('BloodPressureDiastolic');

-- Patient 5 (FISCHP): Temperature & BloodPressureSystolic (93-98)
INSERT INTO Measurement (measurement_type) VALUES
('Temperature'),('Temperature'),('Temperature'),
('BloodPressureSystolic'),('BloodPressureSystolic'),('BloodPressureSystolic');

-- Patient 6 (HUBERK): Glucose & BloodPressureDiastolic (99-104)
INSERT INTO Measurement (measurement_type) VALUES
('Glucose'),('Glucose'),('Glucose'),
('BloodPressureDiastolic'),('BloodPressureDiastolic'),('BloodPressureDiastolic');

-- Patient 7 (KOCHAN): Temperature & Glucose (105-110)
INSERT INTO Measurement (measurement_type) VALUES
('Temperature'),('Temperature'),('Temperature'),
('Glucose'),('Glucose'),('Glucose');

-- Patient 8 (MEIERA): BloodPressureSystolic & BloodPressureDiastolic (111-116)
INSERT INTO Measurement (measurement_type) VALUES
('BloodPressureSystolic'),('BloodPressureSystolic'),('BloodPressureSystolic'),
('BloodPressureDiastolic'),('BloodPressureDiastolic'),('BloodPressureDiastolic');

-- Patient 9 (WAGNEL): Temperature & BloodPressureDiastolic (117-122)
INSERT INTO Measurement (measurement_type) VALUES
('Temperature'),('Temperature'),('Temperature'),
('BloodPressureDiastolic'),('BloodPressureDiastolic'),('BloodPressureDiastolic');

-- Patient 10 (SCHNEJ): Glucose & BloodPressureSystolic (123-128)
INSERT INTO Measurement (measurement_type) VALUES
('Glucose'),('Glucose'),('Glucose'),
('BloodPressureSystolic'),('BloodPressureSystolic'),('BloodPressureSystolic');

-- ==========================================
-- 4. MEASURED
-- ==========================================

-- Patient 1 (MUELLEA): All 40 measurements
INSERT INTO Measured (patient_id, measurement_id, measured_datetime, context) VALUES
-- Temperature (1-10)
(1, 1, '2024-01-10 08:00:00', 'Morgens nüchtern'),
(1, 2, '2024-01-10 12:00:00', 'Vor dem Mittagessen'),
(1, 3, '2024-01-11 09:00:00', 'Nach dem Aufstehen'),
(1, 4, '2024-01-11 14:00:00', 'Nach dem Essen'),
(1, 5, '2024-01-12 10:00:00', 'Bei Kopfschmerzen'),
(1, 6, '2024-01-12 16:00:00', 'Nach dem Sport'),
(1, 7, '2024-01-13 08:30:00', 'Morgens'),
(1, 8, '2024-01-13 18:00:00', 'Abends'),
(1, 9, '2024-01-14 07:00:00', 'Früh morgens'),
(1, 10, '2024-01-14 20:00:00', 'Vor dem Schlafen'),
-- BloodPressureSystolic (11-20)
(1, 11, '2024-01-10 08:15:00', 'Sitzend, morgens'),
(1, 12, '2024-01-10 12:30:00', 'Nach dem Essen'),
(1, 13, '2024-01-11 09:15:00', 'In Ruhe'),
(1, 14, '2024-01-11 14:30:00', 'Nach Kaffee'),
(1, 15, '2024-01-12 10:15:00', 'Stehend'),
(1, 16, '2024-01-12 16:30:00', 'Nach Anstrengung'),
(1, 17, '2024-01-13 08:45:00', 'Morgens nüchtern'),
(1, 18, '2024-01-13 18:30:00', 'Abends'),
(1, 19, '2024-01-14 07:15:00', 'Liegend'),
(1, 20, '2024-01-14 20:15:00', 'Vor dem Schlafen'),
-- BloodPressureDiastolic (21-30)
(1, 21, '2024-01-10 08:15:00', 'Sitzend, morgens'),
(1, 22, '2024-01-10 12:30:00', 'Nach dem Essen'),
(1, 23, '2024-01-11 09:15:00', 'In Ruhe'),
(1, 24, '2024-01-11 14:30:00', 'Nach Kaffee'),
(1, 25, '2024-01-12 10:15:00', 'Stehend'),
(1, 26, '2024-01-12 16:30:00', 'Nach Anstrengung'),
(1, 27, '2024-01-13 08:45:00', 'Morgens nüchtern'),
(1, 28, '2024-01-13 18:30:00', 'Abends'),
(1, 29, '2024-01-14 07:15:00', 'Liegend'),
(1, 30, '2024-01-14 20:15:00', 'Vor dem Schlafen'),
-- Glucose (31-40)
(1, 31, '2024-01-10 08:30:00', 'Nüchtern, kapillar'),
(1, 32, '2024-01-10 13:00:00', 'Nach dem Essen'),
(1, 33, '2024-01-11 09:30:00', 'Morgens'),
(1, 34, '2024-01-11 15:00:00', 'Nachmittags'),
(1, 35, '2024-01-12 10:30:00', 'Vor dem Frühstück'),
(1, 36, '2024-01-12 17:00:00', 'Nach dem Abendessen'),
(1, 37, '2024-01-13 09:00:00', 'Kapillar'),
(1, 38, '2024-01-13 19:00:00', 'Abends'),
(1, 39, '2024-01-14 07:30:00', 'Frühmorgens'),
(1, 40, '2024-01-14 20:30:00', 'Spätabends');

-- Patient 2 (SCHMIM): All 40 measurements
INSERT INTO Measured (patient_id, measurement_id, measured_datetime, context) VALUES
-- Temperature (41-50)
(2, 41, '2024-01-10 07:30:00', 'Vor Metformin'),
(2, 42, '2024-01-10 11:30:00', 'Mittags'),
(2, 43, '2024-01-11 08:00:00', 'Morgens'),
(2, 44, '2024-01-11 13:00:00', 'Nach dem Essen'),
(2, 45, '2024-01-12 09:00:00', 'Bei Müdigkeit'),
(2, 46, '2024-01-12 15:00:00', 'Nachmittags'),
(2, 47, '2024-01-13 07:30:00', 'Vor Atorvastatin'),
(2, 48, '2024-01-13 17:00:00', 'Abends'),
(2, 49, '2024-01-14 08:30:00', 'Mit Diabetes-Symptomen'),
(2, 50, '2024-01-14 19:00:00', 'Vor dem Abendessen'),
-- BloodPressureSystolic (51-60)
(2, 51, '2024-01-10 07:45:00', 'Nüchtern, sitting'),
(2, 52, '2024-01-10 11:45:00', 'Nach Metformin'),
(2, 53, '2024-01-11 08:15:00', 'Morgens'),
(2, 54, '2024-01-11 13:15:00', 'Nach dem Mittagessen'),
(2, 55, '2024-01-12 09:15:00', 'Vor dem Essen'),
(2, 56, '2024-01-12 15:15:00', 'Nach dem Essen'),
(2, 57, '2024-01-13 07:45:00', 'Bei Schwindel'),
(2, 58, '2024-01-13 17:15:00', 'Abends'),
(2, 59, '2024-01-14 08:45:00', 'Morgens nüchtern'),
(2, 60, '2024-01-14 19:15:00', 'Vor Medikation'),
-- BloodPressureDiastolic (61-70)
(2, 61, '2024-01-10 07:45:00', 'Nüchtern, sitting'),
(2, 62, '2024-01-10 11:45:00', 'Nach Metformin'),
(2, 63, '2024-01-11 08:15:00', 'Morgens'),
(2, 64, '2024-01-11 13:15:00', 'Nach dem Mittagessen'),
(2, 65, '2024-01-12 09:15:00', 'Vor dem Essen'),
(2, 66, '2024-01-12 15:15:00', 'Nach dem Essen'),
(2, 67, '2024-01-13 07:45:00', 'Bei Schwindel'),
(2, 68, '2024-01-13 17:15:00', 'Abends'),
(2, 69, '2024-01-14 08:45:00', 'Morgens nüchtern'),
(2, 70, '2024-01-14 19:15:00', 'Vor Medikation'),
-- Glucose (71-80)
(2, 71, '2024-01-10 08:00:00', 'Nüchtern, vor Metformin'),
(2, 72, '2024-01-10 12:00:00', '2h nach Frühstück'),
(2, 73, '2024-01-11 08:30:00', 'Kapillar, nüchtern'),
(2, 74, '2024-01-11 13:30:00', 'Nach Mittagessen'),
(2, 75, '2024-01-12 09:30:00', 'Vor Insulin'),
(2, 76, '2024-01-12 15:30:00', 'Nach Insulin'),
(2, 77, '2024-01-13 08:00:00', 'Nüchternwert'),
(2, 78, '2024-01-13 17:30:00', 'Abendwert'),
(2, 79, '2024-01-14 09:00:00', 'Morgens'),
(2, 80, '2024-01-14 19:30:00', 'Vor dem Schlafen');

-- Patient 3 (WEBERA): Temperature & Glucose (81-86)
INSERT INTO Measured (patient_id, measurement_id, measured_datetime, context) VALUES
(3, 81, '2024-01-11 09:00:00', 'Nach dem Aufstehen'),
(3, 82, '2024-01-12 14:00:00', 'Nachmittags'),
(3, 83, '2024-01-13 10:00:00', 'Vor Paracetamol'),
(3, 84, '2024-01-11 10:00:00', 'Nüchtern'),
(3, 85, '2024-01-12 16:00:00', 'Nach dem Essen'),
(3, 86, '2024-01-13 12:00:00', 'Mittags');

-- Patient 4 (BAUERR): BloodPressureSystolic & BloodPressureDiastolic (87-92)
INSERT INTO Measured (patient_id, measurement_id, measured_datetime, context) VALUES
(4, 87, '2024-01-11 08:00:00', 'Sitzend, morgens'),
(4, 88, '2024-01-12 13:00:00', 'Nach dem Mittagessen'),
(4, 89, '2024-01-13 09:00:00', 'Vor Atorvastatin'),
(4, 90, '2024-01-11 08:00:00', 'Sitzend, morgens'),
(4, 91, '2024-01-12 13:00:00', 'Nach dem Mittagessen'),
(4, 92, '2024-01-13 09:00:00', 'Vor Atorvastatin');

-- Continue for patients 5-10 with similar pattern...

-- Patient 5 (FISCHP): Temperature & BloodPressureSystolic (93-98)
INSERT INTO Measured (patient_id, measurement_id, measured_datetime, context) VALUES
(5, 93, '2024-01-11 09:30:00', 'Mit Fieber'),
(5, 94, '2024-01-12 15:30:00', 'Nach Amoxicillin'),
(5, 95, '2024-01-13 11:30:00', 'Bei Gliederschmerzen'),
(5, 96, '2024-01-11 09:45:00', 'Stehend'),
(5, 97, '2024-01-12 15:45:00', 'Liegend'),
(5, 98, '2024-01-13 11:45:00', 'Sitzend');

-- Patient 6 (HUBERK): Glucose & BloodPressureDiastolic (99-104)
INSERT INTO Measured (patient_id, measurement_id, measured_datetime, context) VALUES
(6, 99, '2024-01-11 08:15:00', 'Nüchtern'),
(6, 100, '2024-01-12 14:15:00', 'Nach dem Essen'),
(6, 101, '2024-01-13 10:15:00', 'Vor Omeprazole'),
(6, 102, '2024-01-11 08:15:00', 'Morgens'),
(6, 103, '2024-01-12 14:15:00', 'Nachmittags'),
(6, 104, '2024-01-13 10:15:00', 'Bei Atemnot');

-- Patient 7 (KOCHAN): Temperature & Glucose (105-110)
INSERT INTO Measured (patient_id, measurement_id, measured_datetime, context) VALUES
(7, 105, '2024-01-11 08:30:00', 'Vor Salbutamol'),
(7, 106, '2024-01-12 14:30:00', 'Nach Asthmaanfall'),
(7, 107, '2024-01-13 10:30:00', 'Nach Inhalation'),
(7, 108, '2024-01-11 08:45:00', 'Nüchtern'),
(7, 109, '2024-01-12 14:45:00', 'Nach dem Essen'),
(7, 110, '2024-01-13 10:45:00', 'Bei Atembeschwerden');

-- Patient 8 (MEIERA): BloodPressureSystolic & BloodPressureDiastolic (111-116)
INSERT INTO Measured (patient_id, measurement_id, measured_datetime, context) VALUES
(8, 111, '2024-01-11 07:00:00', 'Vor Insulin'),
(8, 112, '2024-01-12 12:00:00', 'Nach Injektion'),
(8, 113, '2024-01-13 08:00:00', 'Morgens'),
(8, 114, '2024-01-11 07:00:00', 'Vor Insulin'),
(8, 115, '2024-01-12 12:00:00', 'Nach Injektion'),
(8, 116, '2024-01-13 08:00:00', 'Morgens');

-- Patient 9 (WAGNEL): Temperature & BloodPressureDiastolic (117-122)
INSERT INTO Measured (patient_id, measurement_id, measured_datetime, context) VALUES
(9, 117, '2024-01-11 22:00:00', 'Vor Diazepam'),
(9, 118, '2024-01-12 08:00:00', 'Nach Einnahme'),
(9, 119, '2024-01-13 10:00:00', 'Mittags'),
(9, 120, '2024-01-11 22:00:00', 'Abends'),
(9, 121, '2024-01-12 08:00:00', 'Morgens'),
(9, 122, '2024-01-13 10:00:00', 'Mittags');

-- Patient 10 (SCHNEJ): Glucose & BloodPressureSystolic (123-128)
INSERT INTO Measured (patient_id, measurement_id, measured_datetime, context) VALUES
(10, 123, '2024-01-11 16:00:00', 'Vor Ibuprofen'),
(10, 124, '2024-01-12 20:00:00', 'Nach Einnahme'),
(10, 125, '2024-01-13 09:00:00', 'Bei Kopfschmerzen'),
(10, 126, '2024-01-11 16:15:00', 'Sitzend'),
(10, 127, '2024-01-12 20:15:00', 'Stehend'),
(10, 128, '2024-01-13 09:15:00', 'Liegend');

-- ==========================================
-- 5. SPECIFIC MEASUREMENT TABLES
-- ==========================================

-- TEMPERATURE (Patient 1: 1-10, Patient 2: 41-50, Others: partial)
INSERT INTO Temperature (measurement_id, value, einheit, method) VALUES
-- Patient 1
(1, 36.5, '°C', 'oral'),
(2, 36.8, '°C', 'oral'),
(3, 37.2, '°C', 'axillary'),
(4, 36.9, '°C', 'oral'),
(5, 37.0, '°C', 'oral'),
(6, 37.1, '°C', 'axillary'),
(7, 36.7, '°C', 'oral'),
(8, 36.8, '°C', 'oral'),
(9, 36.6, '°C', 'oral'),
(10, 36.9, '°C', 'oral'),
-- Patient 2
(41, 36.4, '°C', 'oral'),
(42, 36.7, '°C', 'oral'),
(43, 37.0, '°C', 'axillary'),
(44, 36.9, '°C', 'oral'),
(45, 37.1, '°C', 'oral'),
(46, 37.3, '°C', 'axillary'),
(47, 36.8, '°C', 'oral'),
(48, 36.9, '°C', 'oral'),
(49, 37.2, '°C', 'oral'),
(50, 36.8, '°C', 'oral'),
-- Patient 3
(81, 36.8, '°C', 'oral'),
(82, 37.0, '°C', 'axillary'),
(83, 37.2, '°C', 'oral'),
-- Patient 5
(93, 38.2, '°C', 'oral'),
(94, 37.8, '°C', 'axillary'),
(95, 37.5, '°C', 'oral'),
-- Patient 7
(105, 36.9, '°C', 'oral'),
(106, 37.5, '°C', 'axillary'),
(107, 37.1, '°C', 'oral'),
-- Patient 9
(117, 36.7, '°C', 'oral'),
(118, 36.8, '°C', 'oral'),
(119, 36.6, '°C', 'oral');

-- BLOODPRESSURESYSTOLIC
INSERT INTO BloodPressureSystolic (measurement_id, value, einheit, position) VALUES
-- Patient 1
(11, 120, 'mmHg', 'sitting'),
(12, 125, 'mmHg', 'sitting'),
(13, 118, 'mmHg', 'standing'),
(14, 122, 'mmHg', 'sitting'),
(15, 130, 'mmHg', 'standing'),
(16, 128, 'mmHg', 'supine'),
(17, 119, 'mmHg', 'sitting'),
(18, 124, 'mmHg', 'sitting'),
(19, 121, 'mmHg', 'sitting'),
(20, 123, 'mmHg', 'standing'),
-- Patient 2
(51, 135, 'mmHg', 'sitting'),
(52, 138, 'mmHg', 'sitting'),
(53, 132, 'mmHg', 'standing'),
(54, 140, 'mmHg', 'sitting'),
(55, 136, 'mmHg', 'standing'),
(56, 134, 'mmHg', 'supine'),
(57, 142, 'mmHg', 'sitting'),
(58, 139, 'mmHg', 'sitting'),
(59, 137, 'mmHg', 'sitting'),
(60, 133, 'mmHg', 'standing'),
-- Patient 4
(87, 128, 'mmHg', 'sitting'),
(88, 132, 'mmHg', 'standing'),
(89, 130, 'mmHg', 'sitting'),
-- Patient 5
(96, 122, 'mmHg', 'standing'),
(97, 118, 'mmHg', 'supine'),
(98, 125, 'mmHg', 'sitting'),
-- Patient 8
(111, 130, 'mmHg', 'sitting'),
(112, 128, 'mmHg', 'standing'),
(113, 132, 'mmHg', 'sitting'),
-- Patient 10
(126, 125, 'mmHg', 'sitting'),
(127, 122, 'mmHg', 'standing'),
(128, 120, 'mmHg', 'supine');

-- BLOODPRESSUREDIASTOLIC
INSERT INTO BloodPressureDiastolic (measurement_id, value, einheit) VALUES
-- Patient 1
(21, 80, 'mmHg'),
(22, 82, 'mmHg'),
(23, 78, 'mmHg'),
(24, 81, 'mmHg'),
(25, 85, 'mmHg'),
(26, 83, 'mmHg'),
(27, 79, 'mmHg'),
(28, 82, 'mmHg'),
(29, 80, 'mmHg'),
(30, 81, 'mmHg'),
-- Patient 2
(61, 88, 'mmHg'),
(62, 90, 'mmHg'),
(63, 86, 'mmHg'),
(64, 92, 'mmHg'),
(65, 89, 'mmHg'),
(66, 87, 'mmHg'),
(67, 91, 'mmHg'),
(68, 88, 'mmHg'),
(69, 86, 'mmHg'),
(70, 89, 'mmHg'),
-- Patient 4
(90, 84, 'mmHg'),
(91, 86, 'mmHg'),
(92, 82, 'mmHg'),
-- Patient 6
(102, 82, 'mmHg'),
(103, 85, 'mmHg'),
(104, 80, 'mmHg'),
-- Patient 8
(114, 84, 'mmHg'),
(115, 82, 'mmHg'),
(116, 86, 'mmHg'),
-- Patient 9
(120, 79, 'mmHg'),
(121, 81, 'mmHg'),
(122, 83, 'mmHg');

-- GLUCOSE
INSERT INTO Glucose (measurement_id, value, einheit, glucose_type, fasting_status, time_since_meal) VALUES
-- Patient 1
(31, 95, 'mg/dL', 'capillary', TRUE, 10),
(32, 112, 'mg/dL', 'capillary', FALSE, 90),
(33, 92, 'mg/dL', 'capillary', TRUE, 12),
(34, 108, 'mg/dL', 'capillary', FALSE, 120),
(35, 98, 'mg/dL', 'capillary', TRUE, 8),
(36, 115, 'mg/dL', 'capillary', FALSE, 60),
(37, 94, 'mg/dL', 'capillary', TRUE, 9),
(38, 110, 'mg/dL', 'capillary', FALSE, 180),
(39, 96, 'mg/dL', 'venous', TRUE, 11),
(40, 105, 'mg/dL', 'venous', FALSE, 150),
-- Patient 2
(71, 145, 'mg/dL', 'capillary', TRUE, 10),
(72, 168, 'mg/dL', 'capillary', FALSE, 90),
(73, 138, 'mg/dL', 'capillary', TRUE, 12),
(74, 155, 'mg/dL', 'capillary', FALSE, 120),
(75, 142, 'mg/dL', 'capillary', TRUE, 8),
(76, 172, 'mg/dL', 'capillary', FALSE, 60),
(77, 148, 'mg/dL', 'capillary', TRUE, 9),
(78, 162, 'mg/dL', 'capillary', FALSE, 180),
(79, 140, 'mg/dL', 'venous', TRUE, 11),
(80, 158, 'mg/dL', 'venous', FALSE, 150),
-- Patient 3
(84, 102, 'mg/dL', 'capillary', TRUE, 15),
(85, 118, 'mg/dL', 'capillary', FALSE, 75),
(86, 110, 'mg/dL', 'venous', FALSE, 120),
-- Patient 6
(99, 108, 'mg/dL', 'capillary', TRUE, 10),
(100, 125, 'mg/dL', 'capillary', FALSE, 90),
(101, 115, 'mg/dL', 'venous', TRUE, 8),
-- Patient 7
(108, 112, 'mg/dL', 'capillary', TRUE, 12),
(109, 130, 'mg/dL', 'capillary', FALSE, 60),
(110, 122, 'mg/dL', 'venous', FALSE, 180),
-- Patient 10
(123, 98, 'mg/dL', 'capillary', FALSE, 30),
(124, 105, 'mg/dL', 'capillary', FALSE, 90),
(125, 102, 'mg/dL', 'venous', TRUE, 10);

-- ==========================================
-- 6. MEDICATIONINTAKE (Sample data for correlation analysis)
-- ==========================================

-- Patient 1: Ibuprofen intake around measurement times
INSERT INTO MedicationIntake (patient_id, medication_id, datetime, dose, notes) VALUES
(1, 1, '2024-01-10 07:30:00', '1 Tablette (400mg)', 'Bei leichten Kopfschmerzen'),
(1, 1, '2024-01-11 08:30:00', '1 Tablette (400mg)', 'Morgendosis'),
(1, 1, '2024-01-12 09:30:00', '1 Tablette (400mg)', 'Bei stärkeren Schmerzen'),
(1, 2, '2024-01-13 20:30:00', '1 Tablette (500mg)', 'Abends bei Fieber');

-- Patient 2: Metformin and Atorvastatin regular intake
INSERT INTO MedicationIntake (patient_id, medication_id, datetime, dose, notes) VALUES
(2, 3, '2024-01-10 07:00:00', '2 Tabletten (500mg)', 'Morgens nüchtern'),
(2, 4, '2024-01-10 20:00:00', '1 Tablette (20mg)', 'Abends'),
(2, 3, '2024-01-11 07:00:00', '2 Tabletten (500mg)', 'Morgens nüchtern'),
(2, 4, '2024-01-11 20:00:00', '1 Tablette (20mg)', 'Abends'),
(2, 3, '2024-01-12 07:00:00', '2 Tabletten (500mg)', 'Morgens nüchtern'),
(2, 4, '2024-01-12 20:00:00', '1 Tablette (20mg)', 'Abends');

-- Patient 3: Paracetamol as needed
INSERT INTO MedicationIntake (patient_id, medication_id, datetime, dose, notes) VALUES
(3, 2, '2024-01-11 09:30:00', '1 Tablette (500mg)', 'Bei Spannungskopfschmerz'),
(3, 2, '2024-01-12 13:30:00', '1 Tablette (500mg)', 'Nach dem Essen');

-- Patient 5: Antibiotics course
INSERT INTO MedicationIntake (patient_id, medication_id, datetime, dose, notes) VALUES
(5, 6, '2024-01-10 08:00:00', '1 Kapsel (500mg)', 'Beginn Antibiotikatherapie'),
(5, 6, '2024-01-10 20:00:00', '1 Kapsel (500mg)', 'Abenddosis'),
(5, 1, '2024-01-11 09:00:00', '1 Tablette (400mg)', 'Bei Fieber');

-- Continue with other patients as needed...
