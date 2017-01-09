-- 1.1.1
select * from SalesLT.Customer;

-- 1.1.2
select Title, FirstName, MiddleName, LastName, Suffix from SalesLT.Customer;

-- 1.1.3
select SalesPerson, (Title + ' ' + LastName) As CustomerName from SalesLT.Customer;

-- 1.2.1
select (STR(CustomerID) + ': ' + CompanyName) As IDwCompany from SalesLT.Customer;

-- 1.2.2
select * from SalesLT.SalesOrderHeader;
select (SalesOrderNumber + ' (' + CAST(RevisionNumber As char(1)) + ')') As FormattedOrderNumber from SalesLT.SalesOrderHeader;
select (CONVERT(nvarchar(30), OrderDate, 102)) As FormattedOrderDate from SalesLT.SalesOrderHeader;

-- 1.3.1
select (FirstName + ISNULL(' ' + MiddleName, '') + ' ' + LastName) As ContactName from SalesLT.Customer;

-- 1.3.2
UPDATE SalesLT.Customer SET EmailAddress = NULL WHERE CustomerID % 7 = 1;
select CustomerID, (ISNULL(EmailAddress, Phone)) As PrimaryContact 
from SalesLT.Customer;
select CustomerID, COALESCE(EmailAddress, Phone) As PrimaryContact 
from SalesLT.Customer;

-- 1.3.3
UPDATE SalesLT.SalesOrderHeader SET ShipDate = NULL WHERE SalesOrderID > 71899;
select SalesOrderID, OrderDate,
	Case 
		When ShipDate IS NULL Then 'AwaitingShipment'
		Else 'Shipped'
	End As ShippingStatus 
from SalesLT.SalesOrderHeader;
