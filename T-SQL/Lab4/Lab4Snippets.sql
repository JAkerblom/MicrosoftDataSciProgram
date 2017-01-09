select * from SalesLT.CustomerAddress;
select * from SalesLT.Customer;
select * from SalesLT.Address;

-- 4.1.1
select c.CompanyName, a.AddressLine1, a.City, 'Billing' as AddressType
from SalesLT.Customer as c
join SalesLT.CustomerAddress as ca
on c.CustomerID = ca.CustomerID
join SalesLT.Address as a
on ca.AddressID = a.AddressID
where ca.AddressType = 'Main Office';

-- 4.1.2
select c.CompanyName, a.AddressLine1, a.City, 'Shipping' as AddressType
from SalesLT.Customer as c
join SalesLT.CustomerAddress as ca
on c.CustomerID = ca.CustomerID
join SalesLT.Address as a
on ca.AddressID = a.AddressID
where ca.AddressType = 'Shipping';

-- 4.1.3
select c.CompanyName, a.AddressLine1, a.City, 'Billing' as AddressType
from SalesLT.Customer as c
join SalesLT.CustomerAddress as ca
on c.CustomerID = ca.CustomerID
join SalesLT.Address as a
on ca.AddressID = a.AddressID
where ca.AddressType = 'Main Office'
union all
select c.CompanyName, a.AddressLine1, a.City, 'Shipping'
from SalesLT.Customer as c
join SalesLT.CustomerAddress as ca
on c.CustomerID = ca.CustomerID
join SalesLT.Address as a
on ca.AddressID = a.AddressID
where ca.AddressType = 'Shipping'
order by c.CompanyName, AddressType;

-- 4.2.1
select c.CompanyName 
from SalesLT.Customer as c
join SalesLT.CustomerAddress as ca
on c.CustomerID = ca.CustomerID
where ca.AddressType = 'Main Office'
except
select c.CompanyName 
from SalesLT.Customer as c
join SalesLT.CustomerAddress as ca
on c.CustomerID = ca.CustomerID
where ca.AddressType = 'Shipping'
order by CompanyName;

-- 4.2.2
select c.CompanyName 
from SalesLT.Customer as c
join SalesLT.CustomerAddress as ca
on c.CustomerID = ca.CustomerID
where ca.AddressType = 'Main Office'
intersect
select c.CompanyName 
from SalesLT.Customer as c
join SalesLT.CustomerAddress as ca
on c.CustomerID = ca.CustomerID
where ca.AddressType = 'Shipping';

