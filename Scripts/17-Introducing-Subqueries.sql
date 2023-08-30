SELECT
SalesOrderID,
SalesOrderDetailID,
LineTotal,
LineTotalRanking = ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC)
FROM AdventureWorks2019.Sales.SalesOrderDetail

SELECT
SalesOrderID,
SalesOrderDetailID,
LineTotal,
LineTotalRanking = ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC)
FROM AdventureWorks2019.Sales.SalesOrderDetail
where ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC) = 1 
-- Error Msg 4108, Level 15, State 1, Line 16
-- Windowed functions can only appear in the SELECT or ORDER BY clauses. !!!

SELECT
SalesOrderID,
SalesOrderDetailID,
LineTotal,
LineTotalRanking = ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC)
FROM AdventureWorks2019.Sales.SalesOrderDetail
where LineTotalRanking = 1
-- Msg 207, Level 16, State 1, Line 24
-- Invalid column name 'LineTotalRanking'.

-- Q: - So how to apply criteria to a fields we genetare with window functions ?
-- A: - using Subqueries

-- Selecting the most expensive item per order in a single query

-- One Virtual table per 1 select sub query
-- Referring to tyhat query in outer query

SELECT * FROM

( -- Virtual table
SELECT
SalesOrderID,
SalesOrderDetailID,
LineTotal,
LineTotalRanking = ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC)
FROM AdventureWorks2019.Sales.SalesOrderDetail
) AVirtTableName

WHERE LineTotalRanking = 1
