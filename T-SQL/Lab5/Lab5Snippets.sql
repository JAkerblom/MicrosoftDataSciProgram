select * from SalesLT.Product
select * from SalesLT.Customer
select * from SalesLT.CustomerAddress
select * from SalesLT.SalesOrderHeader
select * from SalesLT.SalesOrderDetail

-- 5.1.1
select p.ProductID, UPPER(p.Name) as ProductName, ROUND(Weight, 0) as ApproxWeight
from SalesLT.Product as p

-- 5.1.2
select p.ProductID, 
	UPPER(p.Name) as ProductName, 
	ROUND(Weight, 0) as ApproxWeight, 
	YEAR(SellStartDate) as SellStartYear, 
	MONTH(SellStartDate) as SellStartMonth
from SalesLT.Product as p

select p.ProductID, 
	UPPER(p.Name) as ProductName, 
	ROUND(Weight, 0) as ApproxWeight, 
	YEAR(SellStartDate) as SellStartYear, 
	DateName(mm, SellStartDate) as SellStartMonth
from SalesLT.Product as p

-- 5.1.3
select p.ProductID, 
	UPPER(p.Name) as ProductName, 
	ROUND(Weight, 0) as ApproxWeight, 
	YEAR(SellStartDate) as SellStartYear, 
	DateName(mm, SellStartDate) as SellStartMonth,
	LEFT(p.ProductNumber, 2) as ProductType
from SalesLT.Product as p

-- 5.1.4
select p.ProductID, 
	UPPER(p.Name) as ProductName, 
	ROUND(Weight, 0) as ApproxWeight, 
	YEAR(SellStartDate) as SellStartYear, 
	DateName(mm, SellStartDate) as SellStartMonth,
	LEFT(p.ProductNumber, 2) as ProductType
from SalesLT.Product as p
where ISNUMERIC(Size) = 1

-- 5.2.1
select c.CompanyName,
	Rank() Over(order by TotalDue desc) as RankByTotalDue
from SalesLT.SalesOrderHeader as soh
join SalesLT.Customer as c
on soh.CustomerID = c.CustomerID
order by RankByTotalDue

-- 5.3.1
select p.Name as ProductName, SUM(sod.LineTotal) as TotalProdRevenue
from SalesLT.SalesOrderDetail as sod
join SalesLT.Product as p
on sod.ProductID = p.ProductID
group by p.Name, sod.ProductID
order by TotalProdRevenue desc;

-- 5.3.2
select p.Name as ProductName, SUM(sod.LineTotal) as TotalProdRevenue
from SalesLT.SalesOrderDetail as sod
join SalesLT.Product as p
on sod.ProductID = p.ProductID
where p.ListPrice > 1000
group by sod.ProductID, p.Name
order by TotalProdRevenue desc

-- 5.3.3
select p.Name as ProductName, SUM(sod.LineTotal) as TotalProdRevenue
from SalesLT.SalesOrderDetail as sod
join SalesLT.Product as p
on sod.ProductID = p.ProductID
where p.ListPrice > 1000
group by sod.ProductID, p.Name
having SUM(sod.LineTotal) > 20000
order by TotalProdRevenue desc
