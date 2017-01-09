-- Base query
SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY a.CountryRegion, a.StateProvince
ORDER BY a.CountryRegion, a.StateProvince;

-- 8.1.1
select a.CountryRegion, a.StateProvince, sum(soh.TotalDue) as Revenue
from SalesLT.Address as a
join SalesLT.CustomerAddress as ca on ca.AddressID = a.AddressID
join SalesLT.Customer as c on c.CustomerID = ca.CustomerID
join SalesLT.SalesOrderHeader as soh on soh.CustomerID = c.CustomerID
group by rollup(a.CountryRegion, a.StateProvince)
order by a.CountryRegion, a.StateProvince;

-- 8.1.2
select 
	a.CountryRegion, 
	a.StateProvince, 
	IIF(
		GROUPING_ID(a.CountryRegion) = 1 and GROUPING_ID(a.StateProvince) = 1,
		'Total',
		IIF(
			GROUPING_ID(a.StateProvince) = 1,
			a.CountryRegion + ' Subtotal',
			a.StateProvince + ' Subtotal'
		)
	) as Level,
	sum(soh.TotalDue) as Revenue
from SalesLT.Address 			as a
join SalesLT.CustomerAddress 	as ca 	on ca.AddressID = a.AddressID
join SalesLT.Customer 			as c 	on c.CustomerID = ca.CustomerID
join SalesLT.SalesOrderHeader 	as soh 	on soh.CustomerID = c.CustomerID
group by rollup(a.CountryRegion, a.StateProvince)
order by a.CountryRegion, a.StateProvince;

-- 8.1.3
select 
	a.CountryRegion, 
	a.StateProvince,
	a.City,
	IIF(
		GROUPING_ID(a.CountryRegion) = 1 and GROUPING_ID(a.StateProvince) = 1,
		'Total',
		IIF(
			GROUPING_ID(a.StateProvince) = 1,
			a.CountryRegion + ' Subtotal',
			a.StateProvince + ' Subtotal'
		)
	) as LevelOne,
	CHOOSE(
		1 + GROUPING_ID(a.CountryRegion) + GROUPING_ID(a.StateProvince) + GROUPING_ID(a.City), 
		a.City + ' Subtotal', 			-- if 1 (city is not null, and hence all others aren't either)
		a.StateProvince + ' Subtotal', 	-- if 2 (city is null but no other)
		a.CountryRegion + ' Subtotal', 	-- if 3 ...
		'Total' 						-- if 4
	) AS LevelTwo,
	sum(soh.TotalDue) as Revenue
from SalesLT.Address 			as a
join SalesLT.CustomerAddress 	as ca 	on ca.AddressID = a.AddressID
join SalesLT.Customer 			as c 	on c.CustomerID = ca.CustomerID
join SalesLT.SalesOrderHeader 	as soh 	on soh.CustomerID = c.CustomerID
group by rollup(a.CountryRegion, a.StateProvince, a.City)
order by a.CountryRegion, a.StateProvince, a.City;

-- 8.2.1
--Customer sales by parent category
SELECT * FROM
(SELECT cat.ParentProductCategoryName, cust.CompanyName, sod.LineTotal
 FROM SalesLT.SalesOrderDetail AS sod
 JOIN SalesLT.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
 JOIN SalesLT.Customer AS cust ON soh.CustomerID = cust.CustomerID
 JOIN SalesLT.Product AS prod ON sod.ProductID = prod.ProductID
 JOIN SalesLT.vGetAllCategories AS cat ON prod.ProductcategoryID = cat.ProductCategoryID) AS catsales
PIVOT (SUM(LineTotal) FOR ParentProductCategoryName IN ([Accessories], [Bikes], [Clothing], [Components])) AS pivotedsales
ORDER BY CompanyName;

select * from
(
	select cat.ParentProductCategoryName, c.CompanyName, sod.LineTotal
	from SalesLT.SalesOrderDetail 	as sod
	join SalesLT.SalesOrderHeader 	as soh 	on sod.SalesOrderID = soh.SalesOrderID
	join SalesLT.Customer 			as c 	on soh.CustomerID = c.CustomerID
	join SalesLT.Product 			as p	on sod.ProductID = p.ProductID
	join SalesLT.vGetAllCategories 	as cat 	on p.ProductCategoryID = cat.ProductCategoryID
) as catsales
pivot
(
	sum(LineTotal) 
	for ParentProductCategoryName
	in 
	(
		[Accessories],
		[Bikes],
		[Clothing],
		[Components]
	)
) as pivotedsales
order by CompanyName;

