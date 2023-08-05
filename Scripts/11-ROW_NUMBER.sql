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