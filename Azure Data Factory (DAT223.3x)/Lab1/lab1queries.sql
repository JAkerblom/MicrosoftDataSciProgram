CREATE TABLE transactions(id int identity, tdate date, amount decimal);

SELECT * FROM dbo.transactions;

-- Tried inserting a row from here and then reran the pipeline.
INSERT INTO transactions
		(tdate, amount)
		VALUES
		(GETDATE(), 100);
-- Results were that it appended rows from blob file, and not wrote the contents over the sql database.
--		id	tdate		amount
--2	2016-01-01	125
--3	2016-01-01	99
--4	2016-01-01	198
--5	2016-01-02	129
--6	2016-01-02	125
--7	2016-01-02	99
--8	2016-01-03	125
--9	2016-01-03	99
--10	2016-01-03	198
--11	2017-01-24	100					<---- This is the inserted row
--12	2016-01-01	129
--13	2016-01-01	125
--14	2016-01-01	99
--15	2016-01-01	198
--16	2016-01-02	129
--17	2016-01-02	125
--18	2016-01-02	99
--19	2016-01-03	125
--20	2016-01-03	99
--21	2016-01-03	198