use AdventureWorks2019

select ProductID, OrderQty, LineTotal
from Sales.SalesOrderDetail
order by 1, 2
--ProductID	OrderQty	LineTotal
--707	1	20.186500
--707	1	20.186500
--707	1	20.186500
--707	1	15.139890

select ProductID, OrderQty,
LineTotal = SUM(LineTotal)
from Sales.SalesOrderDetail
group by ProductID, OrderQty
order by 1, 2
--ProductID	OrderQty	LineTotal
--707	1	80124.593740
--707	2	5455.969950
--707	3	7689.607560
--707	4	11286.604140

-- SQL Server allows you to sort the result set based on the ordinal positions of columns that appear in the select list.
-- https://stackoverflow.com/questions/57126965/order-by-1-2-3-4

--Sum of line totals via OVER with PARTITION BY

SELECT
	ProductID,
	SalesOrderID,
	SalesOrderDetailID,
	OrderQty,
	UnitPrice,
	UnitPriceDiscount,
	LineTotal,
	ProductIDLineTotal = SUM(LineTotal) OVER(PARTITION BY ProductID, OrderQty)

FROM AdventureWorks2019.Sales.SalesOrderDetail

ORDER BY ProductID, OrderQty 

--ProductID	SalesOrderID	SalesOrderDetailID	OrderQty	UnitPrice	UnitPriceDiscount	LineTotal	ProductIDLineTotal
--707	43665	63	1	20.1865	0.00	20.186500	80124.593740
--707	43677	164	1	20.1865	0.00	20.186500	80124.593740
--707	43678	185	1	20.1865	0.00	20.186500	80124.593740