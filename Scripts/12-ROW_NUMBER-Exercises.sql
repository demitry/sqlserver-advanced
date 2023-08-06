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