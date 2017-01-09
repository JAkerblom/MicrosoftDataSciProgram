-- 11.1.1 + 11.1.2
select * from SalesLT.SalesOrderDetail
where SalesOrderID = 1;
select * from SalesLT.SalesOrderHeader;

DECLARE @SalesOrderID int = 2
begin try
	if exists 
		(
			select * from SalesLT.SalesOrderDetail
			where SalesOrderID = @SalesOrderID	
		)
	begin
		DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID; 
		DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
	end
	else
	begin
		DECLARE @err varchar(25);
		SET @err = 'Order #' + cast(@SalesOrderID as varchar) + ' does not exist.';
		THROW 50001, @err, 0
	end
end try
begin catch
	print ERROR_MESSAGE();
end catch

-- 11.2.1
DECLARE @SalesOrderID int = 0
begin try
	--if exists 
	--	(
	--		select * from SalesLT.SalesOrderDetail
	--		where SalesOrderID = @SalesOrderID	
	--	)
	--begin
		begin transaction
			DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID; 
			THROW 50001, 'Unexpected error', 0 --Uncomment to test transaction
			DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
		commit transaction
	--end
	--else
	--begin
	--	DECLARE @err varchar(25);
	--	SET @err = 'Order #' + cast(@SalesOrderID as varchar) + ' does not exist.';
	--	THROW 50001, @err, 0
	--end
end try
begin catch
	if @@TRANCOUNT > 0
	begin
		ROLLBACK TRANSACTION;
		THROW;
	end
	else 
	begin
		print ERROR_MESSAGE();
	end
end catch