select * from SalesLT.Customer;
select * from SalesLT.SalesOrderDetail;
select * from SalesLT.SalesOrderHeader;
select * from SalesLT.CustomerAddress;
select * from SalesLT.Address;

SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Customer			AS c
JOIN SalesLT.CustomerAddress	AS ca ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address			AS a ON ca.AddressID = a.AddressID
JOIN SalesLT.SalesOrderHeader	AS soh ON soh.CustomerID = c.CustomerID
GROUP BY GROUPING SETS(a.CountryRegion, a.StateProvince, ())
ORDER BY a.CountryRegion, a.StateProvince;

SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Customer			AS c
JOIN SalesLT.CustomerAddress	AS ca ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address			AS a ON ca.AddressID = a.AddressID
JOIN SalesLT.SalesOrderHeader	AS soh ON soh.CustomerID = c.CustomerID
GROUP BY GROUPING SETS(a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince;

SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Customer			AS c
JOIN SalesLT.CustomerAddress	AS ca ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address			AS a ON ca.AddressID = a.AddressID
JOIN SalesLT.SalesOrderHeader	AS soh ON soh.CustomerID = c.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince;

SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Customer			AS c
JOIN SalesLT.CustomerAddress	AS ca ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address			AS a ON ca.AddressID = a.AddressID
JOIN SalesLT.SalesOrderHeader	AS soh ON soh.CustomerID = c.CustomerID
--GROUP BY ROLLUP(a.CountryRegion, a.StateProvince)
GROUP BY GROUPING SETS((a.CountryRegion, a.StateProvince), ())
ORDER BY a.CountryRegion, a.StateProvince;

-- Same as the rollup alternative
SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Customer			AS c
JOIN SalesLT.CustomerAddress	AS ca ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address			AS a ON ca.AddressID = a.AddressID
JOIN SalesLT.SalesOrderHeader	AS soh ON soh.CustomerID = c.CustomerID
--GROUP BY ROLLUP(a.CountryRegion, a.StateProvince)
GROUP BY GROUPING SETS(a.CountryRegion, (a.CountryRegion, a.StateProvince), ())
ORDER BY a.CountryRegion, a.StateProvince;