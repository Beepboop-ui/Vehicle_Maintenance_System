# Vehicle Maintenance & Service Tracking System

This is the supplied Tkinter desktop application packaged for the requested stack:

1. Python
2. Tkinter (included with standard Python for Windows installations)
3. MySQL Server
4. `mysql-connector-python`
5. Visual Studio Code

**Not used:** Flask, CustomTkinter, or Laragon.

## Project files

```text
Vehicle_Maintenance_System_Python_Tkinter_MySQL/
├── main.py
├── config.py
├── requirements.txt
├── README.md
└── database/
    ├── schema.sql
    └── mysql_user_setup.sql
```

## 1. Install/check requirements

- Install Python 3 from python.org and check **Add Python to PATH** in the installer.
- Install MySQL Server and MySQL Workbench. Workbench is the graphical SQL editor; MySQL Server is the database service.
- Install VS Code and open this project folder.
- In VS Code, select **Terminal → New Terminal**.

Check Python:

```powershell
py --version
```

Check Tkinter:

```powershell
py -m tkinter
```

A small Tk window should appear. Close it after checking.

## 2. Create the database and tables

1. Open MySQL Workbench and connect to your local server.
2. Open `database/schema.sql` in Workbench (File → Open SQL Script), or copy its contents into a query tab.
3. Click the lightning-bolt Execute button.
4. Run this to confirm the tables exist:

```sql
USE vehicle_maintenance_db;
SHOW TABLES;
DESCRIBE users;
DESCRIBE vehicles;
DESCRIBE maintenance_records;
```

Expected tables: `users`, `vehicles`, and `maintenance_records`.

If you already have data in these tables, back it up first. `CREATE TABLE IF NOT EXISTS` does not modify an existing table's columns. Do not drop the database to fix a column mismatch.

## 3. Create a restricted MySQL app account

1. In Workbench, open `database/mysql_user_setup.sql`.
2. Execute it after `schema.sql`.
3. The local demo account is `vm_app` with password `ChangeThisPassword_123!`.
4. `config.py` is already set to these same values. If you change the SQL account password, change `DB_PASSWORD` in `config.py` to match.

This account has access only to this application's database, rather than using MySQL's `root` account for the app.

## 4. Install the Python connector

In the VS Code terminal, from the folder containing `main.py`, run:

```powershell
py -m venv .venv
.\.venv\Scripts\python.exe -m pip install --upgrade pip
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
```

You do not need to activate the virtual environment; these commands avoid PowerShell activation-policy issues.

## 5. Test and launch

Test the database connection:

```powershell
.\.venv\Scripts\python.exe -c "from config import *; import mysql.connector; c=mysql.connector.connect(host=DB_HOST, port=DB_PORT, user=DB_USER, password=DB_PASSWORD, database=DB_NAME); print('MYSQL CONNECTED'); c.close()"
```

Then start the app:

```powershell
.\.venv\Scripts\python.exe main.py
```

## Demo app logins

| Role | Username | Password |
|---|---|---|
| Administrator | `admin` | `admin123` |
| Client | `client1` | `client123` |

Use these only for a local classroom demonstration. This supplied app version compares the app login passwords as plain text; before real use, replace this with a secure password-hashing implementation and change the demo credentials.

The sample client's vehicle owner is `Juan Dela Cruz`, matching the client account's full name. That match is needed because the current code filters client vehicles by `full_name` / `owner_name`.

## Quick troubleshooting

- **`No module named mysql`**: run the pip install command using `.venv\Scripts\python.exe` shown above.
- **`No module named config`**: make sure `config.py` sits beside `main.py` and your terminal is in that folder.
- **`Access denied for user 'vm_app'@'localhost'`**: rerun `database/mysql_user_setup.sql` in Workbench and check that `config.py` uses the same password.
- **`Unknown database 'vehicle_maintenance_db'`**: execute `database/schema.sql` first.
- **`Can't connect to MySQL server`**: confirm the MySQL Server Windows service is running and Workbench can connect to it.
- **Client sees no vehicles**: compare `users.full_name` with `vehicles.owner_name`; spelling and spacing should match.

## Scope note

This package keeps the uploaded `main.py` and supplies the supporting configuration, database SQL, dependency file, and setup guide. It does not use Flask, CustomTkinter, or Laragon.
