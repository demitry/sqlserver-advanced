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
--43659	3	2024.994000	6	6	4
--43659	1	2024.994000	7	6	4
--43659	8	86.521200	8	8	5
--43659	12	80.746000	9	9	6
--43659	10	34.200000	10	10	7
--43659	9	28.840400	11	11	8
--43659	11	10.373000	12	12	9