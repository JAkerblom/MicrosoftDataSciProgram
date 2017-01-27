-- Remove all records from transactions.
TRUNCATE TABLE dbo.transactions;

-- 1st time: Check to see if values persisted or not
-- 2nd time: Check to see if table is filled again after running custom pipeline (copytrans)
SELECT * FROM dbo.transactions;


