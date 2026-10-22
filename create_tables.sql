-- ==========================================
-- SQL DDL Statements
-- ==========================================

-- ==========================================
-- RESET (Drop tables in reverse order of dependency)
-- ==========================================

DROP TABLE IF EXISTS Glucose;
DROP TABLE IF EXISTS BloodPressureDiastolic;
DROP TABLE IF EXISTS BloodPressureSystolic;
DROP TABLE IF EXISTS Temperature;

-- Beziehungstabellen (abhängig von Haupttabellen)
DROP TABLE IF EXISTS Measured;
DROP TABLE IF EXISTS MedicationIntake;

-- Haupttabellen
DROP TABLE IF EXISTS Measurement;
DROP TABLE IF EXISTS Medication;
DROP TABLE IF EXISTS Patient;

-- ==========================================
-- CREATE Tables (in order of dependency)
-- ==========================================

-- Kerntabellen (Independent Entity Types)
CREATE TABLE Patient (
    patient_id SERIAL PRIMARY KEY,
    code TEXT NOT NULL UNIQUE,
    birth_year INTEGER NOT NULL,
    sex CHAR(1) NOT NULL CHECK(sex IN ('M', 'F', 'D')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Medication (
    medication_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    trade_name TEXT,
    dosage_form TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Measurement (
    measurement_id SERIAL PRIMARY KEY,
    measurement_type TEXT NOT NULL CHECK(measurement_type IN (
        'Temperature', 'BloodPressureSystolic', 'BloodPressureDiastolic',
        'Glucose'
    )),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Beziehungstabellen (Relationship Tables)
CREATE TABLE MedicationIntake (
    intake_id SERIAL PRIMARY KEY,
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
    measured_id SERIAL PRIMARY KEY,
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
