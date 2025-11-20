-- ============================================================
-- 1. Total sales by month (all years)
-- ============================================================

SELECT strftime('%Y-%m', Orders.OrderDate) AS SalesMonth,
	ROUND(SUM([Order Details].UnitPrice*[Order Details].Quantity),0) AS Revenue
FROM Orders JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
GROUP BY SalesMonth;

-- ============================================================
-- 2. Top 10 customers by revenue (2020)
-- ============================================================

SELECT 	STRFTIME('%Y', Orders.OrderDate) AS sales_year,
	Orders.CustomerID, CompanyName,
	ROUND(SUM([Order Details].UnitPrice*[Order Details].Quantity),0) AS Revenue
FROM Orders JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
	        JOIN Customers ON Customers.CustomerID = Orders.CustomerID
WHERE sales_year LIKE 2020
GROUP BY Orders.CustomerID
ORDER BY Revenue DESC
LIMIT 10;

-- ============================================================
-- 3. Top 20 products by revenue (2020)
-- ============================================================

SELECT Products.ProductID, 
	Products.ProductName, 
	ROUND(SUM([Order Details].UnitPrice*[Order Details].Quantity),2) AS Revenue
FROM Orders JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
	        JOIN products ON [Order Details].ProductID = Products.ProductID
WHERE STRFTIME('%Y', Orders.OrderDate) LIKE 2020
GROUP BY Products.ProductID
ORDER BY Revenue DESC
LIMIT 20;

-- ============================================================
-- 4. Average Time to Ship by Carrier (2020)
-- ============================================================

SELECT Shippers.ShipperID, Shippers.CompanyName, 
	ROUND(AVG(julianday(Orders.OrderDate) - julianday(Orders.ShippedDate)) ,2) AS [Average Days to Despatch],
	ROUND(SUM([Order Details].UnitPrice*[Order Details].Quantity)/1000000,1) AS [SalesRevenue_$m]
FROM Orders JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
	        JOIN Shippers ON ShipperID = ShipVia
WHERE strftime('%Y', Orders.ShippedDate) LIKE 2020
GROUP BY Shippers.ShipperID
ORDER BY ShipperID;

-- ============================================================
-- 5. Employee performance (2020)
-- ============================================================

SELECT Employees.EmployeeID, 
    FirstName || ' ' || LastName AS Name,
	ROUND(SUM([Order Details].UnitPrice*[Order Details].Quantity),0) AS [Employee Sales ($)],
	COUNT(DISTINCT Orders.OrderID) AS [Employee Orders]
FROM Orders JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
	        JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
WHERE STRFTIME('%Y', Orders.OrderDate) LIKE 2020
GROUP BY Employees.EmployeeID
ORDER BY [Employee Sales ($)] DESC;

