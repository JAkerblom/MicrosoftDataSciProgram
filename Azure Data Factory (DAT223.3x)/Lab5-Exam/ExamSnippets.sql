-- Line items
select * from dbo.LineItems;
-- Orders
select * from dbo.Orders
order by OrderDate;

select * from dbo.Orders
where OrderDate = '2016/03/07';

select * from dbo.Orders
where OrderDate between '2016/03/01' and '2016/03/31'
order by OrderDate;

-- Count orders by day
SELECT OrderDate, COUNT(*) AS Orders
FROM dbo.Orders
GROUP BY OrderDate
ORDER BY OrderDate;

-- Check a specific order
SELECT * FROM dbo.Orders
WHERE OrderID = 68417;

-- Check line items for a specific order
SELECT * FROM dbo.LineItems
WHERE OrderID = 68417;

select OrderID, COUNT(*) as NrOfLineItems from dbo.LineItems
where OrderID = 68417
group by OrderID;

-- erase the tables
truncate table dbo.Orders;
truncate table dbo.LineItems;