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