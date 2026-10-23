-- Vehicle Maintenance & Service Tracking System
-- Run in MySQL Workbench. This creates missing objects but does not delete data.
CREATE DATABASE IF NOT EXISTS vehicle_maintenance_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE vehicle_maintenance_db;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'client'
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS vehicles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plate_number VARCHAR(30) NOT NULL UNIQUE,
    owner_name VARCHAR(100) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year INT NOT NULL,
    vehicle_type VARCHAR(50) NOT NULL,
    contact_number VARCHAR(30) NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS maintenance_records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    service_date DATE NOT NULL,
    service_type VARCHAR(120) NOT NULL,
    description TEXT NULL,
    mileage INT NULL,
    cost DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    status VARCHAR(30) NOT NULL DEFAULT 'Scheduled',
    INDEX idx_maintenance_vehicle (vehicle_id),
    INDEX idx_maintenance_date (service_date),
    CONSTRAINT fk_maintenance_vehicle
        FOREIGN KEY (vehicle_id) REFERENCES vehicles(id)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- Demo-only accounts for this version of main.py (which checks plain-text passwords).
-- INSERT IGNORE keeps existing accounts/passwords unchanged if the script is rerun.
INSERT IGNORE INTO users (username, password, full_name, role) VALUES
('admin', 'admin123', 'System Administrator', 'admin'),
('client1', 'client123', 'Juan Dela Cruz', 'client');

-- Demo vehicle. Owner name must match client1's full_name for the client portal filter.
INSERT IGNORE INTO vehicles
    (plate_number, owner_name, brand, model, year, vehicle_type, contact_number)
VALUES
    ('DEMO-100', 'Juan Dela Cruz', 'Toyota', 'Vios', 2022, 'Sedan', '09171234567');

-- Demo maintenance record is added only if the vehicle exists and no matching
-- demo record exists. If you rerun this script, this may add a duplicate service row.
INSERT INTO maintenance_records
    (vehicle_id, service_date, service_type, description, mileage, cost, status)
SELECT v.id, '2026-10-20', 'Periodic Maintenance', 'Demo service record for tracking status.', 25000, 3500.00, 'In Progress'
FROM vehicles v
WHERE v.plate_number = 'DEMO-100'
  AND NOT EXISTS (
      SELECT 1 FROM maintenance_records m
      WHERE m.vehicle_id = v.id
        AND m.service_type = 'Periodic Maintenance'
        AND m.description = 'Demo service record for tracking status.'
  );
