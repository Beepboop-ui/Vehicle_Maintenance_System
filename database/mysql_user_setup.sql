-- Run in MySQL Workbench AFTER running schema.sql.
-- These are local demo credentials. Change them before using the system beyond a class demo.
CREATE USER IF NOT EXISTS 'vm_app'@'localhost'
  IDENTIFIED BY 'ChangeThisPassword_123!';
ALTER USER 'vm_app'@'localhost'
  IDENTIFIED BY 'ChangeThisPassword_123!';
GRANT SELECT, INSERT, UPDATE, DELETE
  ON vehicle_maintenance_db.* TO 'vm_app'@'localhost';
FLUSH PRIVILEGES;
