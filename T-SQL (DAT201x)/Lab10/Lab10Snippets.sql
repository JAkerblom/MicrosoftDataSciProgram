SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'SalesOrderDetail';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'SalesOrderHeader';

-- 10.1.1
declare @OrderDate datetime = getdate();
declare @DueDate datetime = dateadd(day, 7, getdate());
declare @CustomerID int = 1;
declare @SalesOrderID int;

set @SalesOrderID = NEXT VALUE FOR SalesLT.SalesOrderNumber; -- Started at 1 for some reason?

insert into SalesLT.SalesOrderHeader
	(SalesOrderID, OrderDate, DueDate, ShipMethod, CustomerID)
values
	(@SalesOrderID, @OrderDate, @DueDate, 'CARGO TRANSPORT 5', @CustomerID);

print @SalesOrderID;

select * from SalesLT.SalesOrderHeader;

delete from SalesLT.SalesOrderHeader
where SalesOrderID = 2;

-- 10.1.2
declare @SalesOrderID int
declare @ProductID int = 760;
declare @OrderQty int = 1;
declare @UnitPrice money = 782.99;

SET @SalesOrderID = 2;

if exists (select * from SalesLT.SalesOrderHeader where SalesOrderID = @SalesOrderID)
	begin
		insert into SalesLT.SalesOrderDetail 
			(SalesOrderID, OrderQty, ProductID, UnitPrice)
		values
			(@SalesOrderID, @OrderQty, @ProductID, @UnitPrice)
	end
else
	begin
		print 'The order does not exist'
	end

select * from SalesLT.SalesOrderHeader;

delete from SalesLT.SalesOrderHeader
where SalesOrderID = 2;

-- 10.2.1
select * from SalesLT.vGetAllCategories;
select distinct ProductCategoryID from SalesLT.vGetAllCategories;
select * from SalesLT.Product
where ProductCategoryID in
	(
		select ProductCategoryID from SalesLT.vGetAllCategories
		where ParentProductCategoryName = 'Bikes'
	);


declare @MarketAvg money = 2000;
declare @MaxPrice money = 5000;
declare @Increase numeric = 1.1;
declare @tmpAvg money;
declare @tmpMax	money;

select @tmpAvg = AVG(ListPrice), @tmpMax = MAX(ListPrice)
from SalesLT.Product
where ProductCategoryID in 
	(
		select distinct ProductCategoryID
		from SalesLT.vGetAllCategories
		where ParentProductCategoryName = 'Bikes'		
	);

while @tmpAvg < @MarketAvg
begin
	update SalesLT.Product
	set ListPrice = ListPrice * @Increase
	where ProductCategoryID in 
		(
			select distinct ProductCategoryID
			from SalesLT.vGetAllCategories
			where ParentProductCategoryName = 'Bikes'
		);
	
	select @tmpAvg = AVG(ListPrice), @tmpMax = MAX(ListPrice)
	from SalesLT.Product
	where ProductCategoryID in 
		(
			select distinct ProductCategoryID
			from SalesLT.vGetAllCategories
			where ParentProductCategoryName = 'Bikes'		
		);

	if @tmpMax >= @MaxPrice
		break
	else -- if this is even necessary?
		continue
end

print 'New average bike price:' + CONVERT(varchar, @tmpAvg);
print 'New maximum bike price:' + CONVERT(varchar, @tmpMax);