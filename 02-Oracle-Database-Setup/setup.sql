-- ===========================================================
-- Part B: Oracle Database Setup for Payment System
-- Author: Sara
-- Date: 2026-10-10
-- Description: Create Tablespace and User for Payment modules
-- ===========================================================


drop USER  PAYMENT_USER CASCADE;
DROP TABLESPACE payment_data including contents and datafiles; 
-- Step 1: Create a dedicated Tablespace for payment data
-- AUTOEXTEND ensures the tablespace grows automatically when full
CREATE TABLESPACE payment_data
DATAFILE 'payment_data01.dbf'
SIZE 100M
AUTOEXTEND ON NEXT 10M MAXSIZE 500M;

-- Verify Tablespace creation
SELECT tablespace_name, status FROM dba_tablespaces WHERE tablespace_name = 'PAYMENT_DATA';

-- Step 2: Create the PAYMENT_USER
CREATE USER PAYMENT_USER IDENTIFIED BY "Payment@123"
DEFAULT TABLESPACE payment_data
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON payment_data;

-- Step 3: Grant necessary privileges
GRANT CONNECT, RESOURCE, CREATE TABLE, CREATE SESSION, CREATE PROCEDURE, CREATE SEQUENCE, CREATE VIEW TO PAYMENT_USER;

-- Step 4: Verify the user was created successfully
SELECT username, default_tablespace, account_status
FROM dba_users
WHERE username = 'PAYMENT_USER';

