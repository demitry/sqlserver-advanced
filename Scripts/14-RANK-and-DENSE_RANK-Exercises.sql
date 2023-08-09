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