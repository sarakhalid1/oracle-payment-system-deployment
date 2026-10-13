-- =====================================================
-- File 3: Test Data & Verification
-- Author: Sara
-- Date: 2026-10-11
-- Description: Insert test data and verify operations
-- ====================================================

SET SERVEROUTPUT ON;

-- STEP 1: Add Banks using Procedures
EXEC Add_New_Bank (1, 'Bank of Khartoum');
EXEC Add_New_Bank (2, 'Faisal Islamic Bank');

-- Add Terminals using Procedures
EXEC Add_New_Terminal(101, 1, 'Khartoum Main Branch');
EXEC Add_New_Terminal(102, 1, 'Omdurman Branch');
EXEC Add_New_Terminal(201, 2, 'Bahri Branch');

-- Modify a Terminal (Update Location)
UPDATE Terminals SET Location = 'Khartoum North Branch' WHERE Terminal_ID = 102;

-- Terminate a Terminal (Soft Delete)
EXEC Terminate_Terminal(101);

-- Verify All Data
SELECT * FROM Banks;
SELECT * FROM Terminals;

