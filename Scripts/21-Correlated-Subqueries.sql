SELECT 
       SalesOrderID
      ,OrderDate
      ,SubTotal
      ,TaxAmt
      ,Freight
      ,TotalDue
	  ,MultiOrderCount = --correlated subquery
	  (
		  SELECT
		  COUNT(*)
		  FROM AdventureWorks2019.Sales.SalesOrderDetail B
		  WHERE A.SalesOrderID = B.SalesOrderID
		  AND B.OrderQty > 1 -- TODO: Why? Re-check the video
	  )
FROM AdventureWorks2019.Sales.SalesOrderHeader A