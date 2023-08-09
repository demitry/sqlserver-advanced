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

**Aggregate Functions** collapse you rows in a groups based on unique values in a columns you inslude in the select statement

vs.

**Window Functions** - allow to retaint all row delails while perfirming the same type of aggregate calculations. sum or count

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

```sqluse AdventureWorks2019

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
--43659	3	2024.994000	6	6  <--- BUT NOTE - RANK jumps to overal position in a partition group
--43659	1	2024.994000	7	6
--43659	8	86.521200	8	8  <--- RANK jumps to overal position in a partition group

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
## LEAD and LAG [15]
## LEAD and LAG - Exercises [16]
## Introducing Subqueries [17]
## Introducing Subqueries - Exercises [18]
## Scalar Subqueries [19]
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
