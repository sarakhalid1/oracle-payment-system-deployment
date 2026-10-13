-- Create Tables for Payment System
-- Author: Sara
-- Date: 2026-10-11
-- Description: Create Banks and Terminals tables + Sequences
-- ==========================================================

-- =====================================================
-- Create the Banks Table
-- =====================================================
CREATE TABLE Banks (
    Bank_ID NUMBER PRIMARY KEY,
    Bank_Name VARCHAR2(100) NOT NULL,
    Status VARCHAR2(20) DEFAULT 'Active',
    Created_data DATE DEFAULT SYSDATE
);

-- =====================================================
-- Create the Terminals Table
-- Foreign Key links each Terminal to a Bank
-- =====================================================
CREATE TABLE Terminals (
    Terminal_ID NUMBER PRIMARY KEY,
    Bank_ID NUMBER NOT NULL,
    Location VARCHAR2(100),
    Status VARCHAR2(20) DEFAULT 'Active',
    Created_date DATE DEFAULT SYSDATE,
    CONSTRAINT fk_bank FOREIGN KEY (Bank_ID) REFERENCES Banks(Bank_ID)
);

-- Create Sequences for Auto-Generated IDs
CREATE SEQUENCE bank_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE terminal_seq START WITH 1 INCREMENT BY 1;

-- Verify Tables Were Created
SELECT table_name from user_tables;
