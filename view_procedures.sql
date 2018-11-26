-- 1. Write a view that gives summary of all products
-- Result: Product Name, Supplier name, Category, Price, No. of Orders, Total qty sold

/**
create view ProductsSummary as
select 
	p.ProductName, s.CompanyName, c.CategoryName, n.[nOrders], n.qtySold
from
(
	select 
		p.ProductID, count(p.ProductID) as [nOrders], sum(od.Quantity) as [qtySold]
	from 
		Products p inner join  [order details] od on od.ProductID = p.ProductID
	group by p.ProductID
) as n
	inner join Products p on p.ProductID = n.ProductID
	inner join Suppliers s on p.SupplierID = s.SupplierID
	inner join Categories c on p.CategoryID = c.CategoryID
	

-- 2. Write a view that gives summary of all employees
-- Result: Employee Name, Manager Name, Age, No. of years with the company, No. of orders
-- Processed
create view EmployeesSummary as
select 
	e.FirstName + ' '+e.LastName as [Name], m.FirstName + ' '+ m.LastName as [Manager Name],  DATEDIFF(year, e.BirthDate, GETDATE()) as [Age] , DATEDIFF(year, e.HireDate, GETDATE()) as [Duration], emp.nOrders
from
(
	select 
		count(e.EmployeeID) as [nOrders], e.EmployeeID
	from 
		Employees e inner join Orders o on e.EmployeeID = o.EmployeeID
	group by e.EmployeeID
) as emp
	inner join Employees e on e.EmployeeID = emp.EmployeeID
	left outer join Employees m on e.ReportsTo = m.EmployeeID	



--3. Write a stored procedure named ‘OfferDiscount’ that takes a ProductID and Discount% as
-- parameters and performs the following operations:
--a. Reduce the product’s unit price by Discount%
--b. Apply this discount on all orders that are yet to be shipped

--3a.
create procedure OfferDisc @ProductID int, @Discount money as 
begin
UPDATE 
	Products 
set 
	Unitprice = Unitprice - (Unitprice * @Discount/100) 
where 
	ProductID = @ProductID 
end
**/
--select top 1 * from Products
--select * from [Order Details] where ProductID 

--3b.
UPDATE 
	Products
set 
	Unitprice = Unitprice - (Unitprice * 10/100) 
where 
 	ProductID in (select ProductID from [Order Details] where ProductID = 1) AND 
	(o.ShippedDate > getdate())


--exec OfferDisc 1, 10
