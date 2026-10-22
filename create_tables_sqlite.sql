-- ==========================================
-- SQL DDL Statements
-- ==========================================

-- ==========================================
-- RESET (Drop tables in reverse order of dependency)
-- ==========================================

-- PostgreSQL reset (inactive): DROP TABLE IF EXISTS Glucose;
-- PostgreSQL reset (inactive): DROP TABLE IF EXISTS BloodPressureDiastolic;
-- PostgreSQL reset (inactive): DROP TABLE IF EXISTS BloodPressureSystolic;
-- PostgreSQL reset (inactive): DROP TABLE IF EXISTS Temperature;

-- Beziehungstabellen (abhängig von Haupttabellen)
-- PostgreSQL reset (inactive): DROP TABLE IF EXISTS Measured;
-- PostgreSQL reset (inactive): DROP TABLE IF EXISTS MedicationIntake;

-- Haupttabellen
-- PostgreSQL reset (inactive): DROP TABLE IF EXISTS Measurement;
-- PostgreSQL reset (inactive): DROP TABLE IF EXISTS Medication;
-- PostgreSQL reset (inactive): DROP TABLE IF EXISTS Patient;

-- ==========================================
-- CREATE Tables (in order of dependency)
-- ==========================================

-- Kerntabellen (Independent Entity Types)
CREATE TABLE Patient (
-- PostgreSQL: patient_id SERIAL PRIMARY KEY,
    patient_id INTEGER PRIMARY KEY AUTOINCREMENT,
    code TEXT NOT NULL UNIQUE,
    birth_year INTEGER NOT NULL,
    sex CHAR(1) NOT NULL CHECK(sex IN ('M', 'F', 'D')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Medication (
-- PostgreSQL: medication_id SERIAL PRIMARY KEY,
    medication_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    trade_name TEXT,
    dosage_form TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Measurement (
-- PostgreSQL: measurement_id SERIAL PRIMARY KEY,
    measurement_id INTEGER PRIMARY KEY AUTOINCREMENT,
    measurement_type TEXT NOT NULL CHECK(measurement_type IN (
        'Temperature', 'BloodPressureSystolic', 'BloodPressureDiastolic',
        'Glucose'
    )),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Beziehungstabellen (Relationship Tables)
CREATE TABLE MedicationIntake (
-- PostgreSQL: intake_id SERIAL PRIMARY KEY,
    intake_id INTEGER PRIMARY KEY AUTOINCREMENT,
    patient_id INTEGER NOT NULL,
    medication_id INTEGER NOT NULL,
    datetime TIMESTAMP NOT NULL,
    dose TEXT NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (medication_id) REFERENCES Medication(medication_id),
    UNIQUE(patient_id, medication_id, datetime)
);

CREATE TABLE Measured (
-- PostgreSQL: measured_id SERIAL PRIMARY KEY,
    measured_id INTEGER PRIMARY KEY AUTOINCREMENT,
    patient_id INTEGER NOT NULL,
    measurement_id INTEGER NOT NULL UNIQUE, -- 1:1 mit Measurement
    measured_datetime TIMESTAMP NOT NULL,
    context TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (measurement_id) REFERENCES Measurement(measurement_id)
);

-- ISA-abhängige Messungstypen (Spezialisierungen)
CREATE TABLE Temperature (
    measurement_id INTEGER PRIMARY KEY,
    value DECIMAL(5,2) NOT NULL,
    einheit TEXT NOT NULL DEFAULT '°C',
    method TEXT CHECK(method IN ('oral', 'axillary', 'rectal', 'tympanic', 'temporal')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (measurement_id) REFERENCES Measurement(measurement_id)
);

CREATE TABLE BloodPressureSystolic (
    measurement_id INTEGER PRIMARY KEY,
    value INTEGER NOT NULL,
    einheit TEXT NOT NULL DEFAULT 'mmHg',
    position TEXT CHECK(position IN ('sitting', 'standing', 'supine')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (measurement_id) REFERENCES Measurement(measurement_id)
);

CREATE TABLE BloodPressureDiastolic (
    measurement_id INTEGER PRIMARY KEY,
    value INTEGER NOT NULL,
    einheit TEXT NOT NULL DEFAULT 'mmHg',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (measurement_id) REFERENCES Measurement(measurement_id)
);

CREATE TABLE Glucose (
    measurement_id INTEGER PRIMARY KEY,
    value INTEGER NOT NULL,
    einheit TEXT NOT NULL DEFAULT 'mg/dL',
    glucose_type TEXT NOT NULL CHECK(glucose_type IN ('capillary', 'venous')),
    fasting_status BOOLEAN NOT NULL DEFAULT FALSE,
    time_since_meal INTEGER, -- in Minuten
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (measurement_id) REFERENCES Measurement(measurement_id)
);
