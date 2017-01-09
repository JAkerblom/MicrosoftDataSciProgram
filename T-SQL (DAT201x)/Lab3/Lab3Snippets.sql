select * from SalesLT.Customer;
select * from SalesLT.SalesOrderHeader;
select * from SalesLT.CustomerAddress;
select * from SalesLT.Address;

-- 3.1.1
select c.CompanyName, soh.SalesOrderID, soh.TotalDue 
from SalesLT.Customer as c
join SalesLT.SalesOrderHeader as soh
on c.CustomerID = soh.CustomerID;

-- 3.1.2
select 
	c.CompanyName, 
	soh.SalesOrderID, soh.TotalDue, 
	addr.AddressLine1, ISNULL(addr.AddressLine2, '') as AddressLine2, addr.City, addr.StateProvince, addr.PostalCode, addr.CountryRegion
from SalesLT.Customer as c
join SalesLT.SalesOrderHeader as soh
on c.CustomerID = soh.CustomerID
join SalesLT.CustomerAddress as caddr
on c.CustomerID = caddr.CustomerID and AddressType = 'Main Office'
join SalesLT.Address as addr
on caddr.AddressID = addr.AddressID;

-- 3.2.1
select 
	c.CompanyName, c.FirstName, c.LastName,
	soh.SalesOrderID, soh.TotalDue
from SalesLT.Customer as c
left join SalesLT.SalesOrderHeader as soh
on c.CustomerID = soh.CustomerID
order by soh.SalesOrderID desc;

-- 3.2.2
select 
	c.CustomerID, c.CompanyName, c.FirstName + c.LastName as ContactName, c.Phone
from SalesLT.Customer as c
left join SalesLT.CustomerAddress as caddr
on c.CustomerID = caddr.CustomerID
where caddr.AddressID IS NULL;

-- 3.2.3
select * from SalesLT.SalesOrderDetail;
select * from SalesLT.SalesOrderHeader;
select c.CustomerID, p.ProductID
from SalesLT.Customer as c
full join SalesLT.SalesOrderHeader as soh
on c.CustomerID = soh.CustomerID
full join SalesLT.SalesOrderDetail as sod
on soh.SalesOrderID = sod.SalesOrderID
full join SalesLT.Product as p
on sod.ProductID = p.ProductID
where soh.SalesOrderID IS NULL
order by ProductID,	CustomerID;

