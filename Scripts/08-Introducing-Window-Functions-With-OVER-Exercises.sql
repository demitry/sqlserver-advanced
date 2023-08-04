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


