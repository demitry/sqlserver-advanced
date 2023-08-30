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