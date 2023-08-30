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