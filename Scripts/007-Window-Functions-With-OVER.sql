use AdventureWorks2019;

select * from Sales.SalesOrderHeader;
select TotalDue, * from Sales.SalesOrderHeader;
select sum(TotalDue) from Sales.SalesOrderHeader; -- 123216786.1159, loose all columns and rows

select 
TotalSales = sum(TotalDue),
SalesPersonID
from Sales.SalesOrderHeader
group by SalesPersonID;

--YTD Sales Via Aggregate Query:
SELECT [Total YTD Sales] = SUM(SalesYTD)
      ,[Max YTD Sales] = MAX(SalesYTD)
FROM AdventureWorks2019.Sales.SalesPerson
--Total YTD Sales	Max YTD Sales
--36277591.9034		4251368.5497


-- Aggregate Functions collapse you rows in a groups based on unique values in a columns you inslude in the select statement
-- vs.
-- Window Functions - allow to retaint all row delails while perfirming the same type of aggregate calculations. sum or count

-- OVER() keyword

--YTD Sales With OVER:

SELECT BusinessEntityID
      ,TerritoryID
      ,SalesQuota
      ,Bonus
      ,CommissionPct
      ,SalesYTD
	  ,SalesLastYear
      ,[Total YTD Sales] = SUM(SalesYTD) OVER()
      ,[Max YTD Sales] = MAX(SalesYTD) OVER()
      ,[% of Best Performer] = SalesYTD / MAX(SalesYTD) OVER()

FROM AdventureWorks2019.Sales.SalesPerson