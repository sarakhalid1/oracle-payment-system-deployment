# Oracle 19c Payment System Deployment

A hands-on deployment project simulating a real-world **Oracle 19c Payment System**. This project demonstrates practical skills in Linux administration, Oracle Database management, Bash automation, and Disaster Recovery.


## Project Overview

This project simulates the deployment and management of a payment system similar to what financial institutions use in production. It covers the full lifecycle: from OS-level user management to database schema design, automation, and disaster recovery.

## Technologies Used

| Category | Technology |
|---|---|
| **Operating System** | Oracle Linux 9 |
| **Database** | Oracle Database 19c (Multitenant: CDB + PDB) |
| **Language** | SQL, PL/SQL, Bash |
| **Tools** | SQL*Plus, VirtualBox, Git |
| **Concepts** | Deployment, Automation, DR, Security |

## Project Structure
oracle-payment-system-deployment/
│
├── 01-Linux-User-Management/
│ └── commands.sh
│
├── 02-Oracle-Database-Setup/
│ └── setup.sql
│
├── 03-Payment-System-Simulation/
│ ├── 01_create_tables.sql
│ ├── 02_create_procedures.sql
│ └── 03_test_data.sql
│
└── 04-Linux-Automation/
└── backup_script.sh

## What This Project Covers

### 1. Linux User Management
- Created a dedicated Linux user (`payment_admin`) with sudo privileges.
- Applied the Principle of Least Privilege.

### 2. Oracle Database Setup
- Created a dedicated Tablespace (`PAYMENT_DATA`) and PDB user (`PAYMENT_USER`).
- Configured privileges following Oracle best practices.

### 3. Payment System Simulation
- Designed `Banks` and `Terminals` tables with Foreign Key relationships.
- Implemented 3 Stored Procedures: `Add_New_Bank`, `Add_New_Terminal`, `Terminate_Terminal`.
- Used Soft Delete (Status = 'Inactive') for audit compliance.

### 4. Linux Automation
- Wrote a production-grade Bash script for automated database backups.
- Scheduled backups via Cronjob (daily at 2 AM).
- Implemented Log Rotation (7-day retention).
- Followed best practices: `set -euo pipefail`, `trap`, Secrets Management.

### 5. Disaster Recovery (DR) Simulation
- Created a baseline VM Snapshot (`DR_Site_Ready_v1.0`).
- Simulated a full disaster (deleted all data + dropped user).
- Verified successful recovery and data integrity.
  
## Skills Demonstrated

- **Linux:** `useradd`, `usermod`, `chmod`, `crontab`, `find`, `tar`
- **Bash Scripting:** Error handling, Secrets Management, Automation
- **Oracle 19c:** CDB, PDB, Tablespaces, Users, Grants, Stored Procedures
- **SQL/PLSQL:** DDL, DML, Procedures, Error Handling
- **Troubleshooting:** ORA errors, Permissions, Listener issues
- **DevOps:** Automation, DR, Version Synchronization

## Author

**Sara Khalid**
- GitHub: [@sarakhalid1](https://github.com/sarakhalid1)
- Location: Khartoum, Sudan





لو حصلت كلة 1: GitHub طلب منك تسوي
