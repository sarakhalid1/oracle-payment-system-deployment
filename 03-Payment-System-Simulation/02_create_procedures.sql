-- ====================================================================
-- Create Stored Procedures
-- Author: Sara
-- Date: 2026-10-11
-- Description: Reusable procedures for Add/Modify/Terminate operations
-- ====================================================================

-- =====================================================
-- Procedure - Add New Bank
-- =====================================================
CREATE OR REPLACE PROCEDURE Add_New_Bank (
    p_Bank_ID IN NUMBER,
    p_Bank_Name IN VARCHAR2
) AS
BEGIN
    INSERT INTO Banks (Bank_ID, Bank_Name, Status)
    VALUES (p_Bank_ID, p_Bank_Name, 'Active');
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Bank' || ' ' || p_Bank_Name || ' ' || 'added successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


-- Procedure - Add New Terminal
CREATE OR REPLACE PROCEDURE Add_New_Terminal (
    p_Terminal_ID IN NUMBER,
    p_Bank_ID IN NUMBER,
    p_Location IN VARCHAR2
) AS 
BEGIN
    INSERT INTO Terminals (Terminal_ID, Bank_ID, Location, Status)
    VALUES (p_Terminal_ID, p_Bank_ID, p_Location, 'Active');
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Terminal ' || ' ' || p_Terminal_ID || ' ' || ' added successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- Procedure - Terminate Terminal (Soft Delete)
CREATE OR REPLACE PROCEDURE Terminate_Terminal (
    p_Terminal_ID IN NUMBER
) AS
BEGIN
    UPDATE Terminals SET Status = 'Inactive' WHERE Terminal_ID = p_Terminal_ID;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Terminal ' || p_Terminal_ID || ' terminated successfully.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
-- Verify Procedures Were Created
SELECT object_name, object_type, status
FROM user_objects
WHERE object_type = 'PROCEDURE';
