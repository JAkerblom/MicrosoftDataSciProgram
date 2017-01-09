-- Exam q.8
select TOP 10 * from SalesLT.SalesOrderDetail;
select * from SalesLT.SalesOrderHeader;
select * from SalesLT.Product;

select TOP 10 * from SalesLT.SalesOrderDetail
order by SalesOrderID;
select sod.ProductID, p.ProductID, p.Name, p.ProductNumber 
from SalesLT.SalesOrderDetail as sod
join SalesLT.SalesOrderHeader as soh
on sod.SalesOrderID = soh.SalesOrderID
right join SalesLT.Product as p
on sod.ProductID = p.ProductID
order by sod.SalesOrderID;

-- Exam q.
print IIF(ISNUMERIC(ISNULL('X21', 0)) = 1, 'this', 'that');

-- Exam q.17
select * from SalesLT.Customer;
select * from SalesLT.Address;

--SELECT a.City, a.CountryRegion, SUM(o.TotalDue) AS Revenue
SELECT a.CountryRegion, a.City, SUM(o.TotalDue) AS Revenue
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress as ca
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.Address as a
ON a.AddressID = ca.AddressID
JOIN SalesLT.SalesOrderHeader AS o 
ON o.CustomerID = c.CustomerID
GROUP BY GROUPING SETS (CountryRegion, (CountryRegion, City), ());