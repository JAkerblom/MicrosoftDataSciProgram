select * from SalesLT.vProductModelCatalogDescription
select * from SalesLT.Product

-- 7.1.1
select ProductID, p.Name, pm.Name, pm.Summary
from SalesLT.Product as p
join SalesLT.vProductModelCatalogDescription as pm
on p.ProductModelID = pm.ProductModelID

-- 7.1.2
declare @colors as table (Color nvarchar(15));

insert into @colors 
select distinct Color from SalesLT.Product
where Color is not null;

select * from @colors;

select ProductID, Name, Color from SalesLT.Product
where Color in (select Color from @colors);

-- 7.1.3
-- dbo.ufnGetAllCategories
select * from dbo.ufnGetAllCategories();
select * from SalesLT.ProductCategory; 

SELECT C.ParentProductCategoryName AS ParentCategory,
       C.ProductCategoryName AS Category,
       P.ProductID, P.Name AS ProductName
FROM SalesLT.Product AS P
JOIN dbo.ufnGetAllCategories() AS C
ON P.ProductCategoryID = C.ProductCategoryID
ORDER BY ParentCategory, Category, ProductName;

-- 7.2.1
select () as CompanyWName, 
select * from SalesLT.SalesOrderHeader;
select * from SalesLT.SalesOrderDetail;

select CompanyContact, SUM(CustomerRevenue) as TotRevenue
from
	(
		select CONCAT(c.CompanyName, CONCAT(' (' + c.FirstName + ' ', c.LastName + ')')), soh.TotalDue
		from SalesLT.SalesOrderHeader as soh
		join SalesLT.Customer as c
		on soh.CustomerID = c.CustomerID
	) as CustomerSales(CompanyContact, CustomerRevenue)
group by CompanyContact
order by CompanyContact;

with CustomerSales(CompanyContact, CustomerRevenue)
as
(
	select CONCAT(c.CompanyName, CONCAT(' (' + c.FirstName + ' ', c.LastName + ')')), soh.TotalDue
	from SalesLT.SalesOrderHeader as soh
	join SalesLT.Customer as c
	on soh.CustomerID = c.CustomerID	
)
select CompanyContact, SUM(CustomerRevenue) as TotRevenue
from CustomerSales
group by CompanyContact
order by CompanyContact;

--SELECT CompanyContact, SUM(SalesAmount) AS Revenue
--FROM
--	(SELECT CONCAT(c.CompanyName, CONCAT(' (' + c.FirstName + ' ', c.LastName + ')')), SOH.TotalDue
--	 FROM SalesLT.SalesOrderHeader AS SOH
--	 JOIN SalesLT.Customer AS c
--	 ON SOH.CustomerID = c.CustomerID) AS CustomerSales(CompanyContact, SalesAmount)
--GROUP BY CompanyContact
--ORDER BY CompanyContact;

--WITH CustomerSales(CompanyContact, SalesAmount)
--AS
--(SELECT CONCAT(c.CompanyName, CONCAT(' (' + c.FirstName + ' ', c.LastName + ')')), SOH.TotalDue
-- FROM SalesLT.SalesOrderHeader AS SOH
-- JOIN SalesLT.Customer AS c
-- ON SOH.CustomerID = c.CustomerID)
--SELECT CompanyContact, SUM(SalesAmount) AS Revenue
--FROM CustomerSales
--GROUP BY CompanyContact
--ORDER BY CompanyContact;