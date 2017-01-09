-- 2.1.1
select City, StateProvince from SalesLT.Address;

-- 2.1.2 
select top 10 percent Name from SalesLT.Product
order by Weight desc;

-- 2.1.3
select Name, Weight from SalesLT.Product
order by Weight desc
offset 10 rows
fetch next 100 rows only;

-- 2.2.1
select Name, Color, Size from SalesLT.Product
where ProductModelID = 1;

-- 2.2.2
select ProductNumber, Name from SalesLT.Product
where Color in ('black', 'red', 'white')
and Size in ('S', 'M');

-- 2.2.3
select ProductNumber, Name, ListPrice from SalesLT.Product
where ProductNumber like 'BK-%';

-- 2.2.4
select ProductNumber, Name, ListPrice from SalesLT.Product
where ProductNumber like 'BK-[^R]%-[0-9][0-9]';

