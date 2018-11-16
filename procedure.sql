
create Procedure usp_searchproducts
	@vcStartswith varchar(20) = '',
	@isupplierId int = null,
	@dpricefrom decimal(18,2) = 0.0,
	@dpriceto decimal(18,2) = 999999999999.99
as
begin
	--fill in the blanks
	select
		StockItemName, s.[SupplierName], UnitPrice
	from
		Warehouse.StockItems si inner join Purchasing.Suppliers s on
		si.SupplierID = s.SupplierID
	where
		StockItemName like @vcStartswith + '%'
		and si.SupplierID = @isupplierId
		and UnitPrice >= @dpricefrom 
		and UnitPrice <= @dpriceto

end

exec usp_searchproducts 

drop procedure usp_searchproducts
