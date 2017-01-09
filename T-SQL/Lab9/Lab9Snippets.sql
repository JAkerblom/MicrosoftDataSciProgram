SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'ProductCategory';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'Product';

-- 9.1.1
insert into SalesLT.Product 
	(Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
values
	('LED Lights', 'LT-L123', 2.56, 12.99, 37, GETDATE())

select @@identity;
select scope_identity();
select ident_current('SalesLT.Product') as LastID;

select top 10 * from SalesLT.Product
order by SellStartDate desc

delete * from SalesLT.Product
where ProductID = 1001;

-- 9.1.2
insert into SalesLT.ProductCategory
	(ParentProductCategoryID, Name)
values
	(4, 'Bells and Horns');

select * from SalesLT.ProductCategory;

select ident_current('SalesLT.ProductCategory') as LastID;

declare @LastID int;
set @LastID = ident_current('SalesLT.ProductCategory');

insert into SalesLT.Product
	(Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
values
	('Bicycle Bell', 'BB-RING', 2.47, 4.99, @LastID, getdate()),
	('Bicycle Horn', 'BB-PARP', 1.29, 3.75, @LastID, getdate());

select top 10 * from SalesLT.Product
order by SellStartDate desc

SELECT c.Name As Category, p.Name AS Product
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory as c ON p.ProductCategoryID = c.ProductCategoryID
WHERE p.ProductCategoryID = IDENT_CURRENT('SalesLT.ProductCategory');

-- 9.2.1
update SalesLT.Product
set ListPrice = ListPrice * 1.10
where ProductCategoryID = 
	(
		select ProductCategoryID from SalesLT.ProductCategory where Name = 'Bells and Horns'
	);

select * from SalesLT.Product
order by ProductID desc;

-- 9.2.2
select * from SalesLT.Product as p
join SalesLT.ProductCategory as pc
on p.ProductCategoryID = pc.ProductCategoryID
where p.ProductID = 1001;

update SalesLT.Product
set DiscontinuedDate = getdate()
where 
	ProductCategoryID = 37
	and
	ProductNumber <> 'LT-L123';

select * from SalesLT.Product as p
join SalesLT.ProductCategory as pc
on p.ProductCategoryID = pc.ProductCategoryID
where p.ProductCategoryID = 37;

-- 9.3.1
select * from SalesLT.Product
order by ProductID desc;

delete from SalesLT.Product
where ProductCategoryID =
	(
		select ProductCategoryID from SalesLT.ProductCategory where Name = 'Bells and Horns'
	);

delete from SalesLT.ProductCategory
where ProductCategoryID = 
	(
		select ProductCategoryID from SalesLT.ProductCategory where Name = 'Bells and Horns'
	);