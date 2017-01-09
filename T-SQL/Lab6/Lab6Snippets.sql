select * from SalesLT.Product
select * from SalesLT.SalesOrderDetail

-- 6.1.1
Select ProductID, AVG(sod.UnitPrice) as AvgUnitPrice
from SalesLT.SalesOrderDetail as sod
group by sod.ProductID

select p.ProductID, p.Name, p.ListPrice
from SalesLT.Product as p
where p.ListPrice > (
		Select AVG(sod.UnitPrice) as AvgUnitPrice
		from SalesLT.SalesOrderDetail as sod
		where p.ProductID = sod.ProductID
	);

select ProductID, Name, ListPrice
from SalesLT.Product
where ListPrice > (
		select AVG(UnitPrice)
		from SalesLT.SalesOrderDetail
	)
order by ProductID;

-- 6.1.2
select ProductID, Name, ListPrice
from SalesLT.Product
where ListPrice > 100 and (
		select MIN(LineTotal)
		from SalesLT.SalesOrderDetail
	) < 200
order by ProductID;

-- gets to same thing as answer below
select p.ProductID, p.Name, p.ListPrice
from SalesLT.Product as p
where p.ListPrice >= 100.00 and (
		Select MIN(sod.UnitPrice)
		from SalesLT.SalesOrderDetail as sod
		where p.ProductID = sod.ProductID
	) < 100.00
order by ProductID;

select ProductID, Name, ListPrice
from SalesLT.Product
where ProductID IN (
		select ProductID from SalesLT.SalesOrderDetail
		where UnitPrice < 100.00
	)
and ListPrice >= 100.00
order by ProductID;

-- 6.1.3
select p.ProductID, p.Name, p.ListPrice, sod.UnitPrice
from SalesLT.Product as p
join SalesLT.SalesOrderDetail as sod
on p.ProductID = sod.ProductID
order by ProductID;

-- doesn't just retrieve the sold ones, but also unsold. This is actually an error. See solution below (clumsy one)
select p.ProductID, p.Name, p.ListPrice, 
	(
		Select AVG(sod.UnitPrice)
		from SalesLT.SalesOrderDetail as sod
		where p.ProductID = sod.ProductID
	) as AvgUnitPrice
from SalesLT.Product as p
order by ProductID;


select distinct p.ProductID, p.Name, p.ListPrice, 
	(
		Select AVG(sod.UnitPrice)
		from SalesLT.SalesOrderDetail as sod
		where p.ProductID = sod.ProductID
	) as AvgUnitPrice
from SalesLT.Product as p
join SalesLT.SalesOrderDetail as gsod
on p.ProductID = gsod.ProductID
order by p.ProductID;

-- 6.1.4
select distinct p.ProductID, p.Name, p.ListPrice, p.StandardCost,
	(
		Select AVG(sod.UnitPrice)
		from SalesLT.SalesOrderDetail as sod
		where p.ProductID = sod.ProductID
	) as AvgUnitPrice
from SalesLT.Product as p
join SalesLT.SalesOrderDetail as gsod
on p.ProductID = gsod.ProductID
where p.StandardCost > (
		select AVG(sod.UnitPrice) 
		from SalesLT.SalesOrderDetail as sod
		where p.ProductID = sod.ProductID
	)
order by p.ProductID;

-- 6.2.1
select soh.SalesOrderID, soh.CustomerID, cinfo.FirstName, cinfo.LastName, soh.TotalDue
from SalesLT.SalesOrderHeader as soh
cross apply dbo.ufnGetCustomerInformation(soh.CustomerID) as cinfo
order by soh.SalesOrderID;

-- 6.2.2
select ca.CustomerID, cinfo.FirstName, cinfo.LastName, a.AddressLine1, a.City
from SalesLT.CustomerAddress as ca
join SalesLT.Address as a
on ca.AddressID = a.AddressID
cross apply dbo.ufnGetCustomerInformation(CustomerID) as cinfo
order by ca.CustomerID;