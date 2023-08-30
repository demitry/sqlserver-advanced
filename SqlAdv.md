# The Advanced SQL Server Masterclass For Data Analysis

<!-- TOC -->

- [The Advanced SQL Server Masterclass For Data Analysis](#the-advanced-sql-server-masterclass-for-data-analysis)
    - [Introducing Window Functions With OVER [7]](#introducing-window-functions-with-over-7)
    - [Introducing Window Functions With OVER - Exercises [8]](#introducing-window-functions-with-over---exercises-8)
    - [PARTITION BY [9]](#partition-by-9)
    - [PARTITION BY - Exercises [10]](#partition-by---exercises-10)
    - [ROW_NUMBER [11]](#row_number-11)
    - [ROW_NUMBER - Exercises [12]](#row_number---exercises-12)
    - [RANK and DENSE_RANK [13]](#rank-and-dense_rank-13)
    - [RANK and DENSE_RANK - Exercises [14]](#rank-and-dense_rank---exercises-14)
    - [LEAD and LAG [15]](#lead-and-lag-15)
    - [LEAD and LAG - Exercises [16]](#lead-and-lag---exercises-16)
    - [Introducing Subqueries [17]](#introducing-subqueries-17)
    - [Introducing Subqueries - Exercises [18]](#introducing-subqueries---exercises-18)
    - [Scalar Subqueries [19]](#scalar-subqueries-19)
    - [Scalar Subqueries - Exercises [20]](#scalar-subqueries---exercises-20)
    - [Correlated Subqueries [21]](#correlated-subqueries-21)
    - [Correlated Subqueries - Exercises [22]](#correlated-subqueries---exercises-22)
    - [EXISTS [23]](#exists-23)
    - [EXISTS - Exercises [24]](#exists---exercises-24)
    - [FOR XML PATH With STUFF [25]](#for-xml-path-with-stuff-25)
    - [FOR XML PATH With STUFF - Exercises [26]](#for-xml-path-with-stuff---exercises-26)
    - [PIVOT - Part 1 [27]](#pivot---part-1-27)
    - [PIVOT - Part 2 [28]](#pivot---part-2-28)
    - [PIVOT - Exercises [29]](#pivot---exercises-29)
    - [CTEs - Part 1 [30]](#ctes---part-1-30)
    - [CTEs - Part 2 [31]](#ctes---part-2-31)
    - [CTEs - Exercise [32]](#ctes---exercise-32)
    - [Recursive CTEs [33]](#recursive-ctes-33)
    - [Recursive CTEs - Exercises [34]](#recursive-ctes---exercises-34)
    - [Temp Tables - Part 1 [35]](#temp-tables---part-1-35)
    - [Temp Tables - Part 2 [36]](#temp-tables---part-2-36)
    - [Temp Tables - Exercises [37]](#temp-tables---exercises-37)
    - [CREATE and INSERT [38]](#create-and-insert-38)
    - [CREATE and INSERT - Exercise [39]](#create-and-insert---exercise-39)
    - [TRUNCATE - Part 1 [40]](#truncate---part-1-40)
    - [TRUNCATE - Part 2 [41]](#truncate---part-2-41)
    - [TRUNCATE - Exercise [42]](#truncate---exercise-42)
    - [UPDATE - Part 1 [43]](#update---part-1-43)
    - [UPDATE - Part 2 [44]](#update---part-2-44)
    - [UPDATE - Exercise [45]](#update---exercise-45)
    - [DELETE [46]](#delete-46)
    - [Optimizing With UPDATE - Part 1 [47]](#optimizing-with-update---part-1-47)
    - [Optimizing With UPDATE - Part 2 [48]](#optimizing-with-update---part-2-48)
    - [Optimizing With UPDATE - Exercise [49]](#optimizing-with-update---exercise-49)
    - [An Improved EXISTS With UPDATE [50]](#an-improved-exists-with-update-50)
    - [An Improved EXISTS With UPDATE - Exercise [51]](#an-improved-exists-with-update---exercise-51)
    - [Introducing Indexes [52]](#introducing-indexes-52)
    - [Optimizing With Indexes - Example [53]](#optimizing-with-indexes---example-53)
    - [Optimizing With Indexes - Exercise [54]](#optimizing-with-indexes---exercise-54)
    - [Lookup Tables - Part 1 [55]](#lookup-tables---part-1-55)
    - [Lookup Tables - Part 2 [56]](#lookup-tables---part-2-56)
    - [Lookup Tables - Exercises [57]](#lookup-tables---exercises-57)
    - [Variables - Part 1 [58]](#variables---part-1-58)
    - [Variables - Exercise 1 [59]](#variables---exercise-1-59)
    - [Variables - Part 2 [60]](#variables---part-2-60)
    - [Variables - Exercise 2 [61]](#variables---exercise-2-61)
    - [Introducing User Defined Functions [62]](#introducing-user-defined-functions-62)
    - [NOTE TO STUDENTS [63]](#note-to-students-63)
    - [Making Functions Flexible With Parameters [64]](#making-functions-flexible-with-parameters-64)
    - [User Defined Functions - Exercises [65]](#user-defined-functions---exercises-65)
    - [Stored Procedures [66]](#stored-procedures-66)
    - [Stored Procedures - Exercise [67]](#stored-procedures---exercise-67)
    - [Control Flow With IF Statements [68]](#control-flow-with-if-statements-68)
    - [Control Flow With IF Statements - Exercise [69]](#control-flow-with-if-statements---exercise-69)
    - [Using Multiple IF Statements [70]](#using-multiple-if-statements-70)
    - [Using Multiple IF Statements - Exercise [71]](#using-multiple-if-statements---exercise-71)
    - [Dynamic SQL - Part 1 [72]](#dynamic-sql---part-1-72)
    - [Dynamic SQL - Part 2 [73]](#dynamic-sql---part-2-73)
    - [Dynamic SQL - Exercises [74]](#dynamic-sql---exercises-74)

<!-- /TOC -->


## Introducing Window Functions With OVER [7]

- Window functions allow you to **include aggregate calculations without changing the output**
- The aggregate calculation is tacked as an **additional column**
- It is possible to **group these calculations** like we can with aggregate queries, using the PARTITION

**Aggregate Functions** collapse you rows in a groups based on unique values in a columns you include in the select statement

vs.

**Window Functions** - allow to retain all row details while performing the same type of aggregate calculations. sum or count

```sql
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
```

## Introducing Window Functions With OVER - Exercises [8]

```sql
-- Introducing Window Functions With OVER - Exercises

-- Exercise 1
-- Create a query with the following columns:
-- FirstName and LastName, from the Person.Person table**
-- JobTitle, from the HumanResources.Employee table**
-- Rate, from the HumanResources.EmployeePayHistory table**
-- A derived column called "AverageRate" that returns the average of all values in the "Rate" column, in each row
-- **All the above tables can be joined on BusinessEntityID
-- All the tables can be inner joined, and you do not need to apply any criteria.

select avg(Rate) from  HumanResources.EmployeePayHistory -- 17.7588

select p.FirstName, p.LastName, hre.JobTitle, hist.Rate,
	AverageRate = AVG(hist.Rate) OVER() -- 17.7588
from Person.Person p
inner join HumanResources.Employee hre
on p.BusinessEntityID = hre.BusinessEntityID
inner join HumanResources.EmployeePayHistory hist
on p.BusinessEntityID = hist.BusinessEntityID
order by Rate

-- Exercise 2
-- Enhance your query from Exercise 1 by adding a derived column called
-- "MaximumRate" that returns the largest of all values in the "Rate" column, in each row.

select p.FirstName, p.LastName, hre.JobTitle, hist.Rate,
	AverageRate = AVG(hist.Rate) OVER(), -- 17.7588
	MaximumRate = MAX(hist.Rate) OVER()
from Person.Person p
inner join HumanResources.Employee hre
on p.BusinessEntityID = hre.BusinessEntityID
inner join HumanResources.EmployeePayHistory hist
on p.BusinessEntityID = hist.BusinessEntityID
order by Rate desc
--Ken	Sánchez	Chief Executive Officer	125.50	17.7588	125.50

-- Exercise 3
-- Enhance your query from Exercise 2 by adding a derived column called
-- "DiffFromAvgRate" that returns the result of the following calculation:
-- An employees's pay rate, MINUS the average of all values in the "Rate" column.

select p.FirstName, p.LastName, hre.JobTitle, hist.Rate,
	AverageRate = AVG(hist.Rate) OVER(), -- 17.7588
	MaximumRate = MAX(hist.Rate) OVER(),
	DiffFromAvgRate = Rate - AVG(hist.Rate) OVER()
from Person.Person p
inner join HumanResources.Employee hre
on p.BusinessEntityID = hre.BusinessEntityID
inner join HumanResources.EmployeePayHistory hist
on p.BusinessEntityID = hist.BusinessEntityID
order by DiffFromAvgRate desc

-- Exercise 4
-- Enhance your query from Exercise 3 by adding a derived column called
-- "PercentofMaxRate" that returns the result of the following calculation:
-- An employees's pay rate, DIVIDED BY the maximum of all values in the "Rate" column, times 100.

select p.FirstName, p.LastName, hre.JobTitle, hist.Rate,
	AverageRate = AVG(hist.Rate) OVER(), -- 17.7588
	MaximumRate = MAX(hist.Rate) OVER(),
	DiffFromAvgRate = Rate - AVG(hist.Rate) OVER(),
	PercentofMaxRate = (Rate / MAX(hist.Rate) OVER()) * 100
from Person.Person p
inner join HumanResources.Employee hre
on p.BusinessEntityID = hre.BusinessEntityID
inner join HumanResources.EmployeePayHistory hist
on p.BusinessEntityID = hist.BusinessEntityID
order by PercentofMaxRate desc
```

## PARTITION BY [9]

- PARTITION BY - compute aggregate totals for group within our data, still retaining row-level details
- PARTITION BY - assigns each row of your query output to a group, without collapsing your data into fewer rows as with GROUP BY
- Instead of groups being assigned based on distinct values of ALL the non-aggregated columns of our data, we need to specify the columns this groups will be based on.

-SQL Server allows you to sort the result set based on the ordinal positions of columns that appear in the select list.
- https://stackoverflow.com/questions/57126965/order-by-1-2-3-4

```sql 
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

-- Sum of line totals via OVER with PARTITION BY

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
```

## PARTITION BY - Exercises [10]

```sql
-- PARTITION BY - Exercises

-- Exercise 1
-- Create a query with the following columns:
-- "Name" from the Production.Product table, which can be alised as "ProductName"
-- "ListPrice" from the Production.Product table
-- "Name" from the Production.ProductSubcategory table, which can be alised as "ProductSubcategory" *
-- "Name" from the Production.ProductCategory table, which can be alised as "ProductCategory" **
-- *Join Production.ProductSubcategory to Production.Product on "ProductSubcategoryID"
-- **Join Production.ProductCategory to ProductSubcategory on "ProductCategoryID"
-- All the tables can be inner joined, and you do not need to apply any criteria.

select 
	p.Name as ProductName,
	ListPrice,
	psub.Name as ProductSubcategory,
	pcat.Name as ProductCategory
from Production.Product p
inner join Production.ProductSubcategory psub
on p.ProductSubcategoryID = psub.ProductSubcategoryID
inner join Production.ProductCategory pcat
on psub.ProductCategoryID = pcat.ProductCategoryID
order by ProductName desc
--ProductName	ListPrice	ProductSubcategory	ProductCategory
--Women's Tights, S	74.99	Tights	Clothing
--Women's Tights, M	74.99	Tights	Clothing
--Women's Tights, L	74.99	Tights	Clothing
--Women's Mountain Shorts, S	69.99	Shorts	Clothing
--Women's Mountain Shorts, M	69.99	Shorts	Clothing

-- Exercise 2
-- Enhance your query from Exercise 1 by adding a derived column called
-- "AvgPriceByCategory " that returns the average ListPrice for the product category in each given row.

select AVG(ListPrice) from Production.Product -- 438.6662

select 
	p.Name as ProductName,
	ListPrice,
	psub.Name as ProductSubcategory,
	pcat.Name as ProductCategory,
	-- AvgPriceByCategory = AVG(ListPrice) OVER() -- 438.6662 (if left join), 744.5952 (if inner join) So this is average for all!
	AvgPriceByCategory = AVG(ListPrice) OVER(PARTITION BY pcat.Name) -- average ListPrice for the  ***product category*** in each given row. -- Serednij po palat$
from Production.Product p
inner join Production.ProductSubcategory psub
on p.ProductSubcategoryID = psub.ProductSubcategoryID
inner join Production.ProductCategory pcat
on psub.ProductCategoryID = pcat.ProductCategoryID
order by ProductName desc
--Women's Mountain Shorts, M	69.99	Shorts	Clothing	50.9914
--Women's Mountain Shorts, L	69.99	Shorts	Clothing	50.9914
--Water Bottle - 30 oz.	4.99	Bottles and Cages	Accessories	34.3489
--Touring-Panniers, Large	125.00	Panniers		Accessories	34.3489
--Touring-3000 Yellow, 62	742.35	Touring Bikes	Bikes	1586.737
--Touring-3000 Yellow, 58	742.35	Touring Bikes	Bikes	1586.737

-- Exercise 3
-- Enhance your query from Exercise 2 by adding a derived column called
-- "AvgPriceByCategoryAndSubcategory" that returns the average ListPrice for the product category AND subcategory in each given row.

select 
	p.Name as ProductName,
	ListPrice,
	psub.Name as ProductSubcategory,
	pcat.Name as ProductCategory,
	AvgPriceByCategory = AVG(ListPrice) OVER(PARTITION BY pcat.Name),
	AvgPriceByCategoryAndSubcategory = AVG(ListPrice) OVER(PARTITION BY pcat.Name, psub.Name)
from Production.Product p
inner join Production.ProductSubcategory psub
on p.ProductSubcategoryID = psub.ProductSubcategoryID
inner join Production.ProductCategory pcat
on psub.ProductCategoryID = pcat.ProductCategoryID
order by ProductName desc
--ProductName	ListPrice	ProductSubcategory	ProductCategory	AvgPriceByCategory	AvgPriceByCategoryAndSubcategory
--Women's Tights, S	74.99	Tights	Clothing	50.9914	74.99
--Women's Tights, M	74.99	Tights	Clothing	50.9914	74.99
--Women's Tights, L	74.99	Tights	Clothing	50.9914	74.99
--Women's Mountain Shorts, S	69.99	Shorts	Clothing	50.9914	64.2757
--Women's Mountain Shorts, M	69.99	Shorts	Clothing	50.9914	64.2757
--Women's Mountain Shorts, L	69.99	Shorts	Clothing	50.9914	64.2757

-- Exercise 4:
-- Enhance your query from Exercise 3 by adding a derived column called
-- "ProductVsCategoryDelta" that returns the result of the following calculation:
-- A product's list price, MINUS the average ListPrice for that product's category.
select 
	p.Name as ProductName,
	ListPrice,
	psub.Name as ProductSubcategory,
	pcat.Name as ProductCategory,
	AvgPriceByCategory = AVG(ListPrice) OVER(PARTITION BY pcat.Name),
	AvgPriceByCategoryAndSubcategory = AVG(ListPrice) OVER(PARTITION BY pcat.Name, psub.Name),
	ProductVsCategoryDelta = ListPrice - (AVG(ListPrice) OVER(PARTITION BY pcat.Name))
from Production.Product p
inner join Production.ProductSubcategory psub
on p.ProductSubcategoryID = psub.ProductSubcategoryID
inner join Production.ProductCategory pcat
on psub.ProductCategoryID = pcat.ProductCategoryID
order by ProductName desc
--ProductName	ListPrice	ProductSubcategory	ProductCategory	AvgPriceByCategory	AvgPriceByCategoryAndSubcategory	ProductVsCategoryDelta
--Women's Tights, M	74.99	Tights	Clothing	50.9914	74.99	23.9986
--Women's Tights, L	74.99	Tights	Clothing	50.9914	74.99	23.9986
--Women's Mountain Shorts, S	69.99	Shorts	Clothing	50.9914	64.2757	18.9986
--Women's Mountain Shorts, M	69.99	Shorts	Clothing	50.9914	64.2757	18.9986
```

## ROW_NUMBER [11]

```sql
use AdventureWorks2019

select 
	ProductID,
	sod.SalesOrderID,
	SalesOrderDetailID,
	OrderQty,
	LineTotal = SUM(LineTotal) OVER (PARTITION BY sod.SalesOrderID)
	-- Ranking?
from Sales.SalesOrderDetail sod
order by SalesOrderID;

select 
	ProductID,
	SalesOrderID,
	SalesOrderDetailID,
	OrderQty,
	LineTotal,
	ProductIDLineTotal = SUM(LineTotal) OVER (PARTITION BY SalesOrderID),
	Ranking = ROW_NUMBER() OVER (PARTITION BY SalesOrderID ) -- Error Msg 4112 The function 'ROW_NUMBER' must have an OVER clause with ORDER BY.
from Sales.SalesOrderDetail
order by SalesOrderID

select 
	ProductID,
	SalesOrderID,
	SalesOrderDetailID,
	OrderQty,
	LineTotal,
	ProductIDLineTotal = SUM(LineTotal) OVER (PARTITION BY SalesOrderID),
	Ranking = ROW_NUMBER() OVER (PARTITION BY SalesOrderID ORDER BY [LineTotal]) -- No comma!
from Sales.SalesOrderDetail
order by SalesOrderID
--ProductID	SalesOrderID	SalesOrderDetailID	OrderQty	LineTotal	ProductIDLineTotal	Ranking
--712	43659	11	2	10.373000	20565.620600	1
--716	43659	9	1	28.840400	20565.620600	2
--709	43659	10	6	34.200000	20565.620600	3
--711	43659	12	4	80.746000	20565.620600	4
--714	43659	8	3	86.521200	20565.620600	5
--776	43659	1	1	2024.994000	20565.620600	6
--778	43659	3	1	2024.994000	20565.620600	7
--771	43659	4	1	2039.994000	20565.620600	8
--772	43659	5	1	2039.994000	20565.620600	9
--774	43659	7	1	2039.994000	20565.620600	10
--773	43659	6	2	4079.988000	20565.620600	11
--777	43659	2	3	6074.982000	20565.620600	12
--762	43660	13	1	419.458900	1294.252900		1


-- Descending ORDER BY [LineTotal] DESC
-- Ranks are the same: 1,2,3...
select 
	ProductID,
	SalesOrderID,
	SalesOrderDetailID,
	OrderQty,
	LineTotal,
	ProductIDLineTotal = SUM(LineTotal) OVER (PARTITION BY SalesOrderID),
	Ranking = ROW_NUMBER() OVER (PARTITION BY SalesOrderID ORDER BY [LineTotal] DESC) -- No comma!
from Sales.SalesOrderDetail
order by SalesOrderID

--ProductID	SalesOrderID	SalesOrderDetailID	OrderQty	LineTotal	ProductIDLineTotal	Ranking
--777	43659	2	3	6074.982000	20565.620600	1
--773	43659	6	2	4079.988000	20565.620600	2
--774	43659	7	1	2039.994000	20565.620600	3
--771	43659	4	1	2039.994000	20565.620600	4
--772	43659	5	1	2039.994000	20565.620600	5
--778	43659	3	1	2024.994000	20565.620600	6
--776	43659	1	1	2024.994000	20565.620600	7
--714	43659	8	3	86.521200	20565.620600	8
--711	43659	12	4	80.746000	20565.620600	9
--709	43659	10	6	34.200000	20565.620600	10
--716	43659	9	1	28.840400	20565.620600	11
--712	43659	11	2	10.373000	20565.620600	12
--758	43660	14	1	874.794000	1294.252900		1

-- It is also possible to rank without partitioning:
select 
	ProductID,
	SalesOrderID,
	SalesOrderDetailID,
	OrderQty,
	LineTotal,
	ProductIDLineTotal = SUM(LineTotal) OVER (PARTITION BY SalesOrderID),
	Ranking = ROW_NUMBER() OVER (ORDER BY [LineTotal] DESC) -- No comma!
from Sales.SalesOrderDetail
order by Ranking

--ProductID	SalesOrderID	SalesOrderDetailID	OrderQty	LineTotal	ProductIDLineTotal	Ranking
--954	55282	55439	26	27893.619000	160378.391334	1
--772	43884	916	14	27055.760424	115696.331324	2
--969	51131	36827	21	26159.208075	163930.394292	3
--...
--...
--873	51108	36210	1	1.374000	24474.481558	121315
--873	51809	41488	1	1.374000	43997.560350	121316
--873	51157	37522	1	1.374000	50576.573953	121317

--Ranking will increase 121316,121317,...
-- Even if the values are identical 1.374, 1.374
```

## ROW_NUMBER - Exercises [12]

```sql
-- ROW_NUMBER - Exercises

-- Exercise 1
-- Create a query with the following columns (feel free to borrow your code from Exercise 1 of the PARTITION BY exercises):
-- 'Name' from the Production.Product table, which can be alised as 'ProductName'
-- 'ListPrice' from the Production.Product table
-- 'Name' from the Production.ProductSubcategory table, which can be alised as 'ProductSubcategory'*
-- 'Name' from the Production.Category table, which can be alised as 'ProductCategory'**
-- *Join Production.ProductSubcategory to Production.Product on 'ProductSubcategoryID'
-- **Join Production.ProductCategory to ProductSubcategory on 'ProductCategoryID'
-- All the tables can be inner joined, and you do not need to apply any criteria.

select 
	p.Name as ProductName,
	prod.ListPrice,
	psub.Name as ProductSubcategory,
	pcat.Name as ProductCategory
from Production.Product p
join Production.Product prod
	on prod.ProductID = p.ProductID
join Production.ProductSubcategory psub
	on psub.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pcat
	on pcat.ProductCategoryID = psub.ProductCategoryID

-- Exercise 2
-- Enhance your query from Exercise 1 by adding a derived column called
-- "Price Rank " that ranks all records in the dataset by ListPrice, in descending order.
-- That is to say, the product with the most expensive price should have a rank of 1,
-- and the product with the least expensive price should have a rank equal to the number of records in the dataset.


select 
	p.Name as ProductName,
	prod.ListPrice,
	psub.Name as ProductSubcategory,
	pcat.Name as ProductCategory,
	 PriceRank = ROW_NUMBER() OVER (ORDER BY prod.ListPrice DESC) -- !
from Production.Product p
join Production.Product prod
	on prod.ProductID = p.ProductID
join Production.ProductSubcategory psub
	on psub.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pcat
	on pcat.ProductCategoryID = psub.ProductCategoryID

-- Exercise 3
-- Enhance your query from Exercise 2 by adding a derived column called
-- "Category Price Rank" that ranks all products by ListPrice ' within each category - in descending order. 
-- In other words, every product within a given category should be ranked relative to other products in the same category.

select 
	p.Name as ProductName,
	prod.ListPrice,
	psub.Name as ProductSubcategory,
	pcat.Name as ProductCategory,
	 PriceRank = ROW_NUMBER() OVER (ORDER BY prod.ListPrice DESC), -- !
	 CategoryPriceRank = ROW_NUMBER() OVER (PARTITION BY pcat.Name ORDER BY prod.ListPrice DESC) -- No comma!
from Production.Product p
join Production.Product prod
	on prod.ProductID = p.ProductID
join Production.ProductSubcategory psub
	on psub.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pcat
	on pcat.ProductCategoryID = psub.ProductCategoryID

-- Exercise 4
-- Enhance your query from Exercise 3 by adding a derived column called
-- "Top 5 Price In Category" that returns the string 'Yes' if a product has one of the top 5 list prices in its product category, and 'No' if it does not.
-- You can try incorporating your logic from Exercise 3 into a CASE statement to make this work.
-- Resources for this lecture

select 
	p.Name as ProductName,
	prod.ListPrice,
	psub.Name as ProductSubcategory,
	pcat.Name as ProductCategory,
	 PriceRank = ROW_NUMBER() OVER (ORDER BY prod.ListPrice DESC), -- !
	 CategoryPriceRank = ROW_NUMBER() OVER (PARTITION BY pcat.Name ORDER BY prod.ListPrice DESC),
	 Top5PriceInCategory = 
		 CASE
			WHEN ROW_NUMBER() OVER (PARTITION BY pcat.Name ORDER BY prod.ListPrice DESC) <= 5 THEN 'True'
			ELSE 'False'
		 END
from Production.Product p
join Production.Product prod
	on prod.ProductID = p.ProductID
join Production.ProductSubcategory psub
	on psub.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pcat
	on pcat.ProductCategoryID = psub.ProductCategoryID

--ProductName	ListPrice	ProductSubcategory	ProductCategory	PriceRank	CategoryPriceRank	Top5PriceInCategory
--All-Purpose Bike Stand	159.00	Bike Stands	Accessories	192	1	True
--Touring-Panniers, Large	125.00	Panniers	Accessories	194	2	True
--Hitch Rack - 4-Bike	120.00	Bike Racks	Accessories	200	3	True
--Hydration Pack - 70 oz.	54.99	Hydration Packs	Accessories	234	4	True
--Headlights - Weatherproof	44.99	Lights	Accessories	248	5	True
--HL Mountain Tire	35.00	Tires and Tubes	Accessories	259	6	False
--Headlights - Dual-Beam	34.99	Lights	Accessories	260	7	False
--Sport-100 Helmet, Blue	34.99	Helmets	Accessories	261	8	False
--Sport-100 Helmet, Red	34.99	Helmets	Accessories	262	9	False
--Sport-100 Helmet, Black	34.99	Helmets	Accessories	263	10	False
--HL Road Tire	32.60	Tires and Tubes	Accessories	265	11	False
--ML Mountain Tire	29.99	Tires and Tubes	Accessories	266	12	False
```

## RANK and DENSE_RANK [13]

```sql
-- Ranking ALL records by line total - no groups

select 
	SalesOrderID,
	SalesOrderDetailID,
	LineTotal,
	Ranking = ROW_NUMBER() OVER(PARTITION BY SalesOrderId ORDER BY LineTotal DESC)
from Sales.SalesOrderDetail
order by SalesOrderID, LineTotal desc

--SalesOrderID	SalesOrderDetailID	LineTotal	Ranking
--43659	2	6074.982000	1
--43659	6	4079.988000	2
--43659	7	2039.994000	3  -???
--43659	4	2039.994000	4  -???
--43659	5	2039.994000	5  -???

select 
	SalesOrderID,
	SalesOrderDetailID,
	LineTotal,
	Ranking = ROW_NUMBER() OVER(PARTITION BY SalesOrderId ORDER BY LineTotal DESC),
	RankingWithRank = RANK() OVER(PARTITION BY SalesOrderId ORDER BY LineTotal DESC)
from Sales.SalesOrderDetail
order by SalesOrderID, LineTotal desc

--SalesOrderID	SalesOrderDetailID	LineTotal	Ranking	RankingWithRank
--43659	2	6074.982000	1	1
--43659	6	4079.988000	2	2
--43659	7	2039.994000	 3	 3  <--- SAME RANK
--43659	4	2039.994000	 4	 3
--43659	5	2039.994000	 5	 3
--43659	3	2024.994000	6	6  <--- BUT NOTE - RANK jumps to overall position in a partition group
--43659	1	2024.994000	7	6
--43659	8	86.521200	8	8  <--- RANK jumps to overall position in a partition group

-- But if you don't want RANK jumps:

select 
	SalesOrderID,
	SalesOrderDetailID,
	LineTotal,
	Ranking = ROW_NUMBER() OVER(PARTITION BY SalesOrderId ORDER BY LineTotal DESC),
	RankingWithRank = RANK() OVER(PARTITION BY SalesOrderId ORDER BY LineTotal DESC),
	RankingWithDenseRank = DENSE_RANK() OVER(PARTITION BY SalesOrderId ORDER BY LineTotal DESC)
from Sales.SalesOrderDetail
order by SalesOrderID, LineTotal desc

--SalesOrderID	SalesOrderDetailID	LineTotal	Ranking	RankingWithRank	RankingWithDenseRank
--43659	2	6074.982000	1	1	1
--43659	6	4079.988000	2	2	2
--43659	7	2039.994000	3	3	3
--43659	4	2039.994000	4	3	3
--43659	5	2039.994000	5	3	3
--43659	3	2024.994000	6	6	4  -<--- DENSE_RANK() - no jumps
--43659	1	2024.994000	7	6	4
--43659	8	86.521200	8	8	5
--43659	12	80.746000	9	9	6
--43659	10	34.200000	10	10	7
--43659	9	28.840400	11	11	8
--43659	11	10.373000	12	12	9
```

- trying to pick up exactly one record from one partition group 
- either first or last
  - use ROW_NUMBER

## RANK and DENSE_RANK - Exercises [14]

```sql
-- RANK and DENSE_RANK - Exercises

-- Exercise 1
-- Using your solution query to Exercise 4 from the ROW_NUMBER exercises as a staring point,
--  add a derived column called “Category Price Rank With Rank” that uses the RANK function to rank all products by ListPrice 
-- – within each category - in descending order. 
-- Observe the differences between the “Category Price Rank” and “Category Price Rank With Rank” fields.

select 
	p.Name as ProductName,
	prod.ListPrice,
	psub.Name as ProductSubcategory,
	pcat.Name as ProductCategory,
	PriceRank = ROW_NUMBER() OVER (ORDER BY prod.ListPrice DESC),
	Top5PriceInCategory = CASE WHEN ROW_NUMBER() OVER (PARTITION BY pcat.Name ORDER BY prod.ListPrice DESC) <= 5 THEN 'True' ELSE 'False' END,
	
	CategoryPriceRank = ROW_NUMBER() OVER (PARTITION BY pcat.Name ORDER BY prod.ListPrice DESC),
	CategoryPriceRankWithRank = RANK() OVER (PARTITION BY pcat.Name ORDER BY prod.ListPrice DESC)

from Production.Product p
join Production.Product prod
	on prod.ProductID = p.ProductID
join Production.ProductSubcategory psub
	on psub.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pcat
	on pcat.ProductCategoryID = psub.ProductCategoryID

--ProductName	ListPrice	ProductSubcategory	ProductCategory	PriceRank	Top5PriceInCategory	CategoryPriceRank	CategoryPriceRankWithRank
--All-Purpose Bike Stand	159.00	Bike Stands	Accessories	192	True	1	1
--Touring-Panniers, Large	125.00	Panniers	Accessories	194	True	2	2
--Hitch Rack - 4-Bike	120.00	Bike Racks	Accessories	200	True	3	3
--Hydration Pack - 70 oz.	54.99	Hydration Packs	Accessories	234	True	4	4
--Headlights - Weatherproof	44.99	Lights	Accessories	248	True	5	5
--HL Mountain Tire	35.00	Tires and Tubes	Accessories	259	False	6	6
--Headlights - Dual-Beam	34.99	Lights	Accessories	260	False	7	7     <----------
--Sport-100 Helmet, Blue	34.99	Helmets	Accessories	261	False	8	7
--Sport-100 Helmet, Red	34.99	Helmets	Accessories	262	False		9	7
--Sport-100 Helmet, Black	34.99	Helmets	Accessories	263	False	10	7
--HL Road Tire	32.60	Tires and Tubes	Accessories	265	False		11	11     <----------

-- Exercise 2
-- Modify your query from Exercise 2 by adding a derived column called "Category Price Rank With Dense Rank"
--  that that uses the DENSE_RANK function to rank all products by ListPrice
--   – within each category - in descending order. 
--   Observe the differences among the “Category Price Rank”, “Category Price Rank With Rank”, and “Category Price Rank With Dense Rank” fields.

select 
	p.Name as ProductName,
	prod.ListPrice,
	psub.Name as ProductSubcategory,
	pcat.Name as ProductCategory,
	PriceRank = ROW_NUMBER() OVER (ORDER BY prod.ListPrice DESC),
	Top5PriceInCategory = CASE WHEN ROW_NUMBER() OVER (PARTITION BY pcat.Name ORDER BY prod.ListPrice DESC) <= 5 THEN 'True' ELSE 'False' END,
	
	CategoryPriceRank = ROW_NUMBER() OVER (PARTITION BY pcat.Name ORDER BY prod.ListPrice DESC),
	CategoryPriceRankWithRank = RANK() OVER (PARTITION BY pcat.Name ORDER BY prod.ListPrice DESC),
	CategoryPriceRankWithDenseRank = DENSE_RANK() OVER (PARTITION BY pcat.Name ORDER BY prod.ListPrice DESC)

from Production.Product p
join Production.Product prod
	on prod.ProductID = p.ProductID
join Production.ProductSubcategory psub
	on psub.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pcat
	on pcat.ProductCategoryID = psub.ProductCategoryID

--CategoryPriceRank	CategoryPriceRankWithRank	CategoryPriceRankWithDenseRank
--1	1	1
--2	2	2
--3	3	3
--4	4	4
--5	5	5
--6	6	6
--7	7	7
--8	7	7
--9	7	7
--10	7	7
--11	11	8   <==== no jump
--12	12	9
--13	13	10

-- Exercise 3
-- Examine the code you wrote to define the “Top 5 Price In Category” field back in the ROW_NUMBER exercises. 
-- Now that you understand the differences among ROW_NUMBER, RANK, and DENSE_RANK, 
-- consider which of these functions would be most appropriate to return a true top 5 products by price, 
-- assuming we want to see the top 5 distinct prices AND we want “ties” (by price) to all share the same rank.

-- return a true top 5 products by price, 
-- assuming we want to see the top 5 distinct prices AND we want “ties” (by price) to all share the same rank.
-- ?? or vals are distinct ??

select 
	p.Name as ProductName,
	prod.ListPrice,
	psub.Name as ProductSubcategory,
	pcat.Name as ProductCategory,
	PriceRank = ROW_NUMBER() OVER (ORDER BY prod.ListPrice DESC),
	rn = RANK() OVER (PARTITION BY pcat.Name ORDER BY prod.ListPrice DESC),
	Top5PriceInCategory = 
	CASE 
		WHEN DENSE_RANK() OVER (PARTITION BY pcat.Name ORDER BY prod.ListPrice DESC) <= 5 
			THEN 'True' 
		ELSE 'False' 
	END

from Production.Product p
join Production.Product prod
	on prod.ProductID = p.ProductID
join Production.ProductSubcategory psub
	on psub.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pcat
	on pcat.ProductCategoryID = psub.ProductCategoryID
```

## LEAD and LAG [15]

- Grab values from subsequent or previous records relative to the position of the "current" record in our data
- Useful, compare value in a current column to the next or previous value in the same column - but side-by-side, in the same row
- Very common problem in real world analytic scenarios.

```sql
SELECT Name, Gender, Salary, 
    LEAD(Salary, 2) OVER (ORDER BY Salary) AS Lead_2,
    LAG(Salary, 1, -1) OVER (ORDER BY Salary) AS Lag_1
FROM Employees

--Name	Gender	Salary	Lead_2	Lag_1
--Mark	Male	1000	3000	-1     <- default -1 is set
--John	Male	2000	4000	1000
--Pam	Female	3000	5000	2000
--Sara	Female	4000	6000	3000
--Todd	Male	5000	7000	4000
--Mary	Female	6000	8000	5000
--Ben	Male	7000	9000	6000
--Jodi	Female	8000	9500	7000
--Tom	Male	9000	NULL	8000
--Ron	Male	9500	NULL	9000

-- Lead and Lag functions example WITH partitions : Notice that in this example,
-- Lead and Lag functions return default value if the number of rows to lead or lag goes beyond first row or last row in the partition. 

SELECT Name, Gender, Salary, 
    LEAD(Salary, 2, -1) OVER (PARTITION By Gender ORDER BY Salary) AS Lead_2,
    LAG(Salary, 1, -1) OVER (PARTITION By Gender ORDER BY Salary) AS Lag_1
FROM Employees

--Name	Gender	Salary	Lead_2	Lag_1
--Pam	Female	3000	6000	-1
--Sara	Female	4000	8000	3000
--Mary	Female	6000	-1		4000
--Jodi	Female	8000	-1		6000
--Mark	Male	1000	5000	-1
--John	Male	2000	7000	1000
--Todd	Male	5000	9000	2000
--Ben	Male	7000	9500	5000
--Tom	Male	9000	-1		7000
--Ron	Male	9500	-1		9000
```

## LEAD and LAG - Exercises [16]

```sql
-- LEAD and LAG - Exercises

-- Exercise 1
-- Create a query with the following columns:
-- 'PurchaseOrderID' from the Purchasing.PurchaseOrderHeader table
-- 'OrderDate' from the Purchasing.PurchaseOrderHeader table
-- 'TotalDue' from the Purchasing.PurchaseOrderHeader table
-- 'Name' from the Purchasing.Vendor table, which can be aliased as 'VendorName'*
-- *Join Purchasing.Vendor to Purchasing.PurchaseOrderHeader on BusinessEntityID = VendorID
-- Apply the following criteria to the query:
--  Order must have taken place on or after 2013
-- TotalDue must be greater than $500

select PurchaseOrderID
	,OrderDate
	,TotalDue
	,vendor.Name as VendorName
from Purchasing.PurchaseOrderHeader oh
join Purchasing.Vendor vendor
on oh.VendorID = vendor.BusinessEntityID
where OrderDate >= '2013-01-01 00:00:00.000' and TotalDue > 500

-- Exercise 2
-- Modify your query from Exercise 1 by adding a derived column called
-- "PrevOrderFromVendorAmt", that returns the 'previous' TotalDue value (relative to the current row) 
-- within the group of all orders with the same vendor ID. We are defining 'previous' based on order date.

select EmployeeID, PurchaseOrderID
	,OrderDate
	,TotalDue
	,vendor.Name as VendorName
	,PrevOrderFromVendorAmt = LAG(TotalDue) OVER(ORDER BY OrderDate)
from Purchasing.PurchaseOrderHeader oh
join Purchasing.Vendor vendor
on oh.VendorID = vendor.BusinessEntityID
where OrderDate >= '2013-01-01 00:00:00.000' and TotalDue > 500
--order by OrderDate

--PurchaseOrderID	OrderDate	TotalDue	VendorName				PrevOrderFromVendorAmt
--282	2013-02-08 00:00:00.000	31160.2541	International Bicycles	NULL
--283	2013-02-08 00:00:00.000	4103.2241	International Sport Assoc.	31160.2541
--284	2013-02-08 00:00:00.000	48485.6873	Jackson Authority		4103.2241
--285	2013-02-08 00:00:00.000	3292.0934	Trey Research			48485.6873
--286	2013-02-08 00:00:00.000	6311.1799	Lakewood Bicycle		3292.0934
--291	2013-02-13 00:00:00.000	48485.6873	Mitchell Sports			6311.1799

-- Exercise 3
-- Modify your query from Exercise 2 by adding a derived column called
-- "NextOrderByEmployeeVendor", that returns the 'next' vendor name (the 'name' field from Purchasing.Vendor) 
-- within the group of all orders that have the same EmployeeID value in Purchasing.PurchaseOrderHeader. 
-- Similar to the last exercise, we are defining 'next' based on order date.

select EmployeeID, PurchaseOrderID
	,OrderDate
	,TotalDue
	,vendor.Name as VendorName
	,PrevOrderFromVendorAmt = LAG(TotalDue) OVER(ORDER BY OrderDate)
	,NextOrderByEmployeeVendor = LEAD(vendor.Name) OVER (PARTITION BY EmployeeID ORDER BY OrderDate) 
from Purchasing.PurchaseOrderHeader oh
join Purchasing.Vendor vendor
on oh.VendorID = vendor.BusinessEntityID
where OrderDate >= '2013-01-01 00:00:00.000' and TotalDue > 500

-- Exercise 4
-- Modify your query from Exercise 3 by adding a derived column called "Next2OrderByEmployeeVendor" that returns,
-- within the group of all orders that have the same EmployeeID, the vendor name offset TWO orders into the 'future' relative to the order in the current row.
-- The code should be very similar to Exercise 3, but with an extra argument passed to the Window Function used.

select EmployeeID, PurchaseOrderID
	,OrderDate
	,TotalDue
	,vendor.Name as VendorName
	,PrevOrderFromVendorAmt = LAG(TotalDue) OVER(ORDER BY OrderDate)
	,NextOrderByEmployeeVendor = LEAD(vendor.Name) OVER (PARTITION BY EmployeeID ORDER BY OrderDate)
	,Next2OrderByEmployeeVendor = LEAD(vendor.Name, 2) OVER(PARTITION BY EmployeeID ORDER BY vendor.Name)
from Purchasing.PurchaseOrderHeader oh
join Purchasing.Vendor vendor
on oh.VendorID = vendor.BusinessEntityID
where OrderDate >= '2013-01-01 00:00:00.000' and TotalDue > 500

--EmployeeID	PurchaseOrderID	OrderDate	TotalDue	VendorName	PrevOrderFromVendorAmt	NextOrderByEmployeeVendor	Next2OrderByEmployeeVendor
--250	1957	2014-02-11 00:00:00.000	858.353		Advanced Bicycles		28212.0589	Lakewood Bicycle			Allenson Cycles
--250	3222	2014-06-06 00:00:00.000	9776.2665	Allenson Cycles			555.9106	Greenwood Athletic Company	American Bikes
--250	3933	2014-07-30 00:00:00.000	9776.2665	Allenson Cycles			28212.0589	Continental Pro Cycles		Anderson's Custom Bikes
--250	321		2013-04-25 00:00:00.000	22539.0165	American Bikes			9776.2665	Vista Road Bikes			Anderson's Custom Bikes
--250	3857	2014-07-26 00:00:00.000	16164.0229	Anderson's Custom Bikes	22539.0165	Allenson Cycles				Aurora Bike Center
--250	3304	2014-06-13 00:00:00.000	16164.0229	Anderson's Custom Bikes	22539.0165	Compete, Inc.				Beaumont Bikes
--250	765		2013-09-01 00:00:00.000	2370.704	Aurora Bike Center		36852.4406	Electronic Bike	Repair & Supplies	Bergeron Off-Roads
--250	1333	2013-12-04 00:00:00.000	1685.3792	Beaumont Bikes			622.741		Federal Sport				Bicycle Specialists
--250	685		2013-08-25 00:00:00.000	2675.3392	Bergeron Off-Roads		27995.0921	Vista Road Bikes			Bicycle Specialists
--250	2204	2014-03-05 00:00:00.000	38281.8686	Bicycle Specialists		553.8221	Custom Frames, Inc.			Bike Satellite Inc.
--250	2757	2014-04-28 00:00:00.000	38281.8686	Bicycle Specialists		540.4212	West Junction Cycles		Bike Satellite Inc.
```

## Introducing Subqueries [17]

- One step isn't enough
- Multiple steps
- Need smaller more manageable pieces
- SQL gives us uther better techniques for many-steps analysis


```sql
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

```

## Introducing Subqueries - Exercises [18]

```sql
-- Introducing Sub-queries - Exercises

-- Exercise 1
-- Write a query that displays the three most expensive orders, per vendor ID, from the Purchasing.PurchaseOrderHeader table.
-- There should ONLY be three records per Vendor ID, even if some of the total amounts due are identical. 
-- "Most expensive" is defined by the amount in the "TotalDue" field.
-- Include the following fields in your output:
-- PurchaseOrderID
-- VendorID
-- OrderDate
-- TaxAmt
-- Freight
-- TotalDue
-- Hints:
-- You will first need to define a field that assigns a unique rank to every purchase order, within each group of like vendor IDs.
-- You'll probably want to use a Window Function with PARTITION BY and ORDER BY to do this.
-- The last step will be to apply the appropriate criteria to the field you created with your Window Function.

select * from 
(
select 
    PurchaseOrderID
    ,VendorID
    ,OrderDate
    ,TaxAmt
    ,Freight
    ,TotalDue
	,TotalDueRank = ROW_NUMBER() OVER(PARTITION BY VendorId ORDER BY TotalDue)
from Purchasing.PurchaseOrderHeader
) RankedVendor
where TotalDueRank BETWEEN 1 and 3

--PurchaseOrderID	VendorID	OrderDate	TaxAmt		Freight		TotalDue	TotalDueRank
--1885	1492	2014-02-05 00:00:00.000		8.8855		2.7767		122.7312	1
--2675	1492	2014-04-21 00:00:00.000		8.8855		2.7767		122.7312	2
--3465	1492	2014-06-26 00:00:00.000		8.8855		2.7767		122.7312	3
--319	1494	2013-04-24 00:00:00.000		707.784		221.1825	9776.2665	1
--398	1494	2013-06-25 00:00:00.000		707.784		221.1825	9776.2665	2
--507	1494	2013-08-11 00:00:00.000		707.784		221.1825	9776.2665	3
--3695	1496	2014-07-14 00:00:00.000		8.9233		2.7885		123.2533	1
--2905	1496	2014-05-13 00:00:00.000		8.9233		2.7885		123.2533	2
--2115	1496	2014-02-26 00:00:00.000		8.9233		2.7885		123.2533	3
--1316	1498	2013-12-02 00:00:00.000		2116.422	661.3819	29233.0789	1
--1395	1498	2013-12-11 00:00:00.000		2116.422	661.3819	29233.0789	2
--1158	1498	2013-11-12 00:00:00.000		2116.422	661.3819	29233.0789	3

-- Exercise 2
-- Modify your query from the first problem, such that the top three purchase order amounts are returned, 
-- regardless of how many records are returned per Vendor Id.
-- In other words, if there are multiple orders with the same total due amount, 
-- **all** should be returned as long as the total due amount for these orders is one of the top three.
-- Ultimately, you should see three distinct total due amounts (i.e., the top three) for each group of like Vendor Ids. 
-- However, there could be multiple records for each of these amounts.
-- Hint: Think carefully about how the different ranking functions (ROW_NUMBER, RANK, and DENSE_RANK) work,
-- and which one might be best suited to help you here.

--Exercise 2 Solution:

SELECT 
	PurchaseOrderID,
	VendorID,
	OrderDate,
	TaxAmt,
	Freight,
	TotalDue,
	PurchaseOrderRank = DENSE_RANK() OVER(PARTITION BY VendorID ORDER BY TotalDue DESC) -- Added to check the rank
FROM (
	SELECT 
		PurchaseOrderID,
		VendorID,
		OrderDate,
		TaxAmt,
		Freight,
		TotalDue,
		PurchaseOrderRank = DENSE_RANK() OVER(PARTITION BY VendorID ORDER BY TotalDue DESC)

	FROM Purchasing.PurchaseOrderHeader
) X

WHERE PurchaseOrderRank <= 3
```

## Scalar Subqueries [19]

Scalar - Returns single value

It is possible to use scalar in WHERE clause

```sql
SELECT
	AVG(ListPrice)
FROM AdventureWorks2019.Production.Product

--Example 2: Scalar subqueries in the SELECT and WHERE clauses

SELECT 
	   ProductID
      ,[Name]
      ,StandardCost
      ,ListPrice
	  ,AvgListPrice = (SELECT AVG(ListPrice) FROM AdventureWorks2019.Production.Product)
	  ,AvgListPriceDiff = ListPrice - (SELECT AVG(ListPrice) FROM AdventureWorks2019.Production.Product)
FROM AdventureWorks2019.Production.Product
WHERE ListPrice > (SELECT AVG(ListPrice) FROM AdventureWorks2019.Production.Product) 
-- Possible to use scalar in WHERE clause
ORDER BY ListPrice ASC
```

## Scalar Subqueries - Exercises [20]

## Correlated Subqueries [21]
## Correlated Subqueries - Exercises [22]
## EXISTS [23]
## EXISTS - Exercises [24]
## FOR XML PATH With STUFF [25]
## FOR XML PATH With STUFF - Exercises [26]
## PIVOT - Part 1 [27]
## PIVOT - Part 2 [28]
## PIVOT - Exercises [29]
## CTEs - Part 1 [30]
## CTEs - Part 2 [31]
## CTEs - Exercise [32]
## Recursive CTEs [33]
## Recursive CTEs - Exercises [34]
## Temp Tables - Part 1 [35]
## Temp Tables - Part 2 [36]
## Temp Tables - Exercises [37]
## CREATE and INSERT [38]
## CREATE and INSERT - Exercise [39]
## TRUNCATE - Part 1 [40]
## TRUNCATE - Part 2 [41]
## TRUNCATE - Exercise [42]
## UPDATE - Part 1 [43]
## UPDATE - Part 2 [44]
## UPDATE - Exercise [45]
## DELETE [46]
## Optimizing With UPDATE - Part 1 [47]
## Optimizing With UPDATE - Part 2 [48]
## Optimizing With UPDATE - Exercise [49]
## An Improved EXISTS With UPDATE [50]
## An Improved EXISTS With UPDATE - Exercise [51]
## Introducing Indexes [52]
## Optimizing With Indexes - Example [53]
## Optimizing With Indexes - Exercise [54]
## Lookup Tables - Part 1 [55]
## Lookup Tables - Part 2 [56]
## Lookup Tables - Exercises [57]
## Variables - Part 1 [58]
## Variables - Exercise 1 [59]
## Variables - Part 2 [60]
## Variables - Exercise 2 [61]
## Introducing User Defined Functions [62]
## NOTE TO STUDENTS [63]
## Making Functions Flexible With Parameters [64]
## User Defined Functions - Exercises [65]
## Stored Procedures [66]
## Stored Procedures - Exercise [67]
## Control Flow With IF Statements [68]
## Control Flow With IF Statements - Exercise [69]
## Using Multiple IF Statements [70]
## Using Multiple IF Statements - Exercise [71]
## Dynamic SQL - Part 1 [72]
## Dynamic SQL - Part 2 [73]
## Dynamic SQL - Exercises [74]
