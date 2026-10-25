# Vehicle Maintenance & Service Tracking System

Basic SIA1 desktop system built with Python, Tkinter, MySQL, mysql-connector-python, and VS Code.

## Three major components
1. Tkinter GUI
2. Python OOP/application logic
3. MySQL relational database

## Modules
- Login/authentication
- Dashboard
- Vehicle management (CRUD)
- Maintenance records (CRUD)
- Service history

## Setup
1. Install Python 3 and MySQL Server.
2. Open a terminal in this project folder and install the dependencies:
   ```powershell
   python -m pip install -r requirements.txt
   ```
3. Initialize the database by running `database/schema.sql` in MySQL Workbench or another MySQL client. This script creates the database and tables and seeds the initial administrator account.
   Do not use the separate `vehicle_maintenance_database.sql` file for a fresh setup; it is an older script and does not match the current schema.
4. Set the database credentials in the terminal session you will use to run the app:
   ```powershell
   $env:DB_USER = "your_mysql_username"
   $env:DB_PASSWORD = "your_mysql_password"
   ```
   On Linux or macOS, use `export DB_USER="your_mysql_username"` and `export DB_PASSWORD="your_mysql_password"` instead.
5. Launch the app from this project folder:
   ```powershell
   python main.py
   ```

The initial application login is `admin` / `admin123`. Change this password after your first login. Keep your MySQL credentials out of source control; the app raises an error if `DB_USER` or `DB_PASSWORD` is missing.

