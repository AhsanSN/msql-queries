-- 1. Fetch Customers who have not placed any order in Mar 2016. (Customer Name)
-- all people - (people who ordered in march 2017)

/**
select
  c.CustomerID
from 
	sales.Customers c 
where 
	c.CustomerID not in (
		select
  c.CustomerID
from 
	sales.Customers c inner join sales.Orders o on c.CustomerID = o.CustomerID
where year(o.OrderDate)=2016 and month(o.OrderDate)= 3
group by c.CustomerID
)

-- 2. Select orders that contain items that are packaged in 'Pair'.

select
	o.OrderID
from
	sales.Orders o
where
	o.OrderID in 
	(
		select
			ol.OrderID
		from
			sales.OrderLines ol
		where
			ol.PackageTypeID in 
			(
				select
				  pt.PackageTypeID
				from
					Warehouse.PackageTypes pt
				where
					pt.PackageTypeName = 'pair'
			)
	)

	


-- find the employee who processed the first order in year 2015

select
	 top 1 PersonID, FullName
from
	Application.people p INNER JOIN sales.orders o on p.PersonID = o.SalespersonPersonID
where
	year(o.PickingCompletedWhen) = 2015
order by
	month(o.PickingCompletedWhen) , day(o.PickingCompletedWhen)
	
	-- 4. Select all orders that have backorders. The result will show the duration (in days) between pickup of two orders

select
	DATEDIFF(day,rig.PickingCompletedWhen,lef.PickingCompletedWhen) as 'diff of pickup dates'
from
	sales.Orders lef inner join sales.Orders rig on lef.OrderID = rig.BackorderOrderID
where 
	rig.BackorderOrderID is not null-- and lef.BackorderOrderID is null
	and (rig.PickingCompletedWhen is not null
	and lef.PickingCompletedWhen is not null)



-- 5. Select all orders and the difference between their order and delivery dates.

select
	o.orderid, DATEDIFF(day, o.OrderDate, o.ExpectedDeliveryDate) as 'diff'
FROM 
	sales.Orders o

**/


-- 6. Select all orders and their backorders. In case the backorder is not there, the order should
-- still appear with backorder id NUll.
-- Result : OrderID, PickingCompletionDate for order, BackOrderID, PickingCompletionDate for
-- BackOrder, Difference between two dates.

select
	o.OrderID, o.PickingCompletedWhen,  o.BackorderOrderID, bo.PickingCompletedWhen, DATEDIFF(day, o.PickingCompletedWhen, bo.PickingCompletedWhen) as 'diff'	
from
	sales.Orders o left outer join sales.Orders bo on o.OrderID = bo.BackorderOrderID

