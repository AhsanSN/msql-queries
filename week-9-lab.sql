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
**/

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
	--order, orderlines, stockitem, package
