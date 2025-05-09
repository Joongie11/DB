CREATE TRIGGER TR_Product_Audit
    ON Product
    AFTER INSERT, UPDATE, DELETE
    AS
BEGIN
    SET NOCOUNT ON;

    -- INSERT
    INSERT INTO ProductAudit (ProductID, ActionType)
    SELECT ProductID, 'INSERT'
    FROM inserted
    WHERE NOT EXISTS (
        SELECT 1 FROM deleted WHERE deleted.ProductID = inserted.ProductID
    );

    -- UPDATE
    INSERT INTO ProductAudit (ProductID, ActionType)
    SELECT inserted.ProductID, 'UPDATE'
    FROM inserted
             INNER JOIN deleted ON inserted.ProductID = deleted.ProductID;

    -- DELETE
    INSERT INTO ProductAudit (ProductID, ActionType)
    SELECT ProductID, 'DELETE'
    FROM deleted
    WHERE NOT EXISTS (
        SELECT 1 FROM inserted WHERE inserted.ProductID = deleted.ProductID
    );
END;

    ALTER TABLE Customer
        ADD IsDeleted BIT DEFAULT 0;

    CREATE TRIGGER TR_Customer_Delete
        ON Customer
        INSTEAD OF DELETE
        AS
    BEGIN
        UPDATE Customer
        SET IsDeleted = 1
        WHERE CustomerID IN (SELECT CustomerID FROM deleted);
    END;

        SELECT * FROM ProductAudit;

        CREATE TRIGGER TR_DDL_Logger
            ON DATABASE
            FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
            AS
        BEGIN
            DECLARE @EventData XML;
            SET @EventData = EVENTDATA();

            INSERT INTO DDL_ChangeLog (EventType, ObjectName, LoginName, EventData)
            VALUES (
                       @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)'),
                       @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(256)'),
                       @EventData.value('(/EVENT_INSTANCE/LoginName)[1]', 'NVARCHAR(256)'),
                       @EventData
                   );
        END;

        ALTER TABLE TestDDL ADD Age INT;

        DROP TABLE TestDDL;

        SELECT * FROM DDL_ChangeLog ORDER BY EventTime DESC;