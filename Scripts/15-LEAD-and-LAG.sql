-- select * from Sales.SalesOrderHeader

select SalesOrderID, OrderDate, CustomerID, TotalDue from Sales.SalesOrderHeader order by SalesOrderID

-- NEXT
select 
	SalesOrderID
	,OrderDate
	,CustomerID
	,TotalDue
	,NextTotalDue = LEAD(TotalDue, 1) OVER(ORDER BY SalesOrderID) -- what is next?
from Sales.SalesOrderHeader 
order by SalesOrderID

--SalesOrderID	OrderDate	CustomerID	TotalDue	NextTotalDue
--43659	2011-05-31 00:00:00.000	29825	23153.2339	1457.3288
--43660	2011-05-31 00:00:00.000	29672	1457.3288	36865.8012
--43661	2011-05-31 00:00:00.000	29734	36865.8012	32474.9324
--43662	2011-05-31 00:00:00.000	29994	32474.9324	472.3108

select 
	SalesOrderID
	,OrderDate
	,CustomerID
	,TotalDue
	,NextTotalDue = LEAD(TotalDue, 1) OVER(ORDER BY SalesOrderID)
	,PreviosTotalDue = LAG(TotalDue, 1) OVER(ORDER BY SalesOrderID)
from Sales.SalesOrderHeader 
order by SalesOrderID

--SalesOrderID	OrderDate	CustomerID	TotalDue	NextTotalDue	PreviosTotalDue
--43659	2011-05-31 00:00:00.000	29825	23153.2339	1457.3288	NULL
--43660	2011-05-31 00:00:00.000	29672	1457.3288	36865.8012	23153.2339
--43661	2011-05-31 00:00:00.000	29734	36865.8012	32474.9324	1457.3288
--43662	2011-05-31 00:00:00.000	29994	32474.9324	472.3108	36865.8012
--43663	2011-05-31 00:00:00.000	29565	472.3108	27510.4109	32474.9324
--43664	2011-05-31 00:00:00.000	29898	27510.4109	16158.6961	472.3108

-- Lead looks forward,
-- Lag looks backward.
-- You can sort but you should not
-- Of you sort desc -> Lead and lag will work

select 
	SalesOrderID
	,OrderDate
	,CustomerID
	,TotalDue
	,NextTotalDue = LEAD(TotalDue, 3) OVER(ORDER BY SalesOrderID)
	,PreviosTotalDue = LAG(TotalDue, 3) OVER(ORDER BY SalesOrderID)
from Sales.SalesOrderHeader 
order by SalesOrderID

--SalesOrderID	OrderDate	CustomerID	TotalDue	NextTotalDue	PreviosTotalDue
--43659	2011-05-31 00:00:00.000	29825	23153.2339	32474.9324	NULL
--43660	2011-05-31 00:00:00.000	29672	1457.3288	472.3108	NULL
--43661	2011-05-31 00:00:00.000	29734	36865.8012	27510.4109	NULL
--43662	2011-05-31 00:00:00.000	29994	32474.9324	16158.6961	23153.2339
--43663	2011-05-31 00:00:00.000	29565	472.3108	5694.8564	1457.3288
--43664	2011-05-31 00:00:00.000	29898	27510.4109	6876.3649	36865.8012
--...
--75117	2014-06-30 00:00:00.000	18178	32.5754		93.8808	23.7465
--75118	2014-06-30 00:00:00.000	13671	149.4292	82.8529	88.9194
--75119	2014-06-30 00:00:00.000	11981	46.7194		34.2219	5.514
--75120	2014-06-30 00:00:00.000	18749	93.8808		209.9169 32.5754
--75121	2014-06-30 00:00:00.000	15251	82.8529		NULL	149.4292
--75122	2014-06-30 00:00:00.000	15868	34.2219		NULL	46.7194
--75123	2014-06-30 00:00:00.000	18759	209.9169	NULL	93.8808
--Using PARTITION with LEAD and LAG

SELECT
       SalesOrderID
      ,OrderDate
      ,CustomerID
      ,TotalDue
	  ,NextTotalDue = LEAD(TotalDue, 1) OVER(PARTITION BY CustomerID ORDER BY SalesOrderID)
	  ,PrevTotalDue = LAG(TotalDue, 1) OVER(PARTITION BY CustomerID ORDER BY SalesOrderID)
FROM AdventureWorks2019.Sales.SalesOrderHeader
ORDER BY CustomerID, SalesOrderID

--SalesOrderID	OrderDate	CustomerID	TotalDue	NextTotalDue	PrevTotalDue
--43793	2011-06-21 00:00:00.000	11000	3756.989	2587.8769	NULL
--51522	2013-06-20 00:00:00.000	11000	2587.8769	2770.2682	3756.989
--57418	2013-10-03 00:00:00.000	11000	2770.2682	NULL		2587.8769
--43767	2011-06-17 00:00:00.000	11001	3729.364	2674.0227	NULL
--51493	2013-06-18 00:00:00.000	11001	2674.0227	650.8008	3729.364
--72773	2014-05-12 00:00:00.000	11001	650.8008	NULL		2674.0227
--43736	2011-06-09 00:00:00.000	11002	3756.989	2535.964	NULL
--51238	2013-06-02 00:00:00.000	11002	2535.964	2673.0613	3756.989
--53237	2013-07-26 00:00:00.000	11002	2673.0613	NULL		2535.964
--43701	2011-05-31 00:00:00.000	11003	3756.989	2562.4508	NULL
--51315	2013-06-07 00:00:00.000	11003	2562.4508	2674.4757	3756.989
--57783	2013-10-10 00:00:00.000	11003	2674.4757	NULL		2562.4508
--43810	2011-06-25 00:00:00.000	11004	3756.989	2626.5408	NULL


-- https://www.youtube.com/watch?v=l_Zn5sdkamM&ab_channel=kudvenkat
--SQL Script to create the Employees table

Create Table Employees
(
 Id int primary key,
 Name nvarchar(50),
 Gender nvarchar(10),
 Salary int
)
Go

Insert Into Employees Values (1, 'Mark', 'Male', 1000)
Insert Into Employees Values (2, 'John', 'Male', 2000)
Insert Into Employees Values (3, 'Pam', 'Female', 3000)
Insert Into Employees Values (4, 'Sara', 'Female', 4000)
Insert Into Employees Values (5, 'Todd', 'Male', 5000)
Insert Into Employees Values (6, 'Mary', 'Female', 6000)
Insert Into Employees Values (7, 'Ben', 'Male', 7000)
Insert Into Employees Values (8, 'Jodi', 'Female', 8000)
Insert Into Employees Values (9, 'Tom', 'Male', 9000)
Insert Into Employees Values (10, 'Ron', 'Male', 9500)
Go

-- Lead and Lag functions example WITHOUT partitions : This example Leads 2 rows and Lags 1 row from the current row. 
-- When you are on the first row, LEAD(Salary, 2, -1) allows you to move forward 2 rows and retrieve the salary from the 3rd row.
-- When you are on the first row, LAG(Salary, 1, -1) allows us to move backward 1 row. Since there no rows beyond row 1, Lag function in this case returns the default value -1.
-- When you are on the last row, LEAD(Salary, 2, -1) allows you to move forward 2 rows. Since there no rows beyond the last row 1, Lead function in this case returns the default value -1.
-- When you are on the last row, LAG(Salary, 1, -1) allows us to move backward 1 row and retrieve the salary from the previous row.

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