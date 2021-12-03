

use Northwind
GO 

/*1*/
SELECT City AS CityhaveBoth
FROM dbo.Customers
UNION
SELECT City
FROM dbo.Employees


/*2a*/
SELECT City
FROM (SELECT City
FROM Employees)
WHERE Employees.City <> Customers.City



/*2b*/
SELECT City AS CityhaveBoth
FROM dbo.Customers
MINUS
SELECT City
FROM dbo.Employees


/*3*/
SELECT p.ProductID, od.OrderID, COUNT(od.Quantity) AS TotalProduct
FROM dbo.Products p, dbo.[Order Details] od
GROUP BY p.ProductID, od.OrderID


/*4*/
SELECT c.City, COUNT(od.Quantity) AS CityQuant
FROM Customers c, Orders o, [Order Details] od
GROUP BY c.City


/*5a*/
SELECT c.City, COUNT(c.CustomerID) count_c
FROM Customers c 
GROUP BY c.City
HAVING COUNT(c.CustomerID) >= 2


/*5b*/
SELECT dt1.City
FROM 
(SELECT COUNT(CustomerID) FROM Customers) dt1
WHERE COUNT(dt1.CustomerID) >= 2


/*6*/
SELECT c.City, COUNT(p.ProductID) ProductCount
FROM Customers c LEFT JOIN Orders o 
ON c.CustomerId = o.CustomerId
LEFT JOIN [Order Details] od ON od.OrderID = o.OrderID
LEFT JOIN Products p ON p.ProductID = od.ProductID
GROUP BY c.City
HAVING COUNT(p.ProductID) >= 2


/*7*/
SELECT c.CustomerID, c.ContactName
FROM Customers c JOIN Orders o ON c.CustomerId = o.CustomerId
WHERE c.City <> o.ShipCity

/*8*/

SELECT dt.ProductID, dt.ShipCIty, dt.NumOfOrders, dt.RNK
FROM
(SELECT p.ProductID, o.ShipCIty, COUNT(o.OrderID) AS NumOfOrders, RANK() OVER(PARTITION BY o.ShipCIty ORDER BY COUNT(o.OrderId) DESC) RNK
FROM Products p INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
LEFT JOIN Orders o ON o.OrderID = od.OrderID
GROUP BY p.ProductID,  o.ShipCIty) dt
WHERE dt.RNK <= 5

/*9a*/

/*9b*/
SELECT DISTINCT e.City 
FROM Employees e, Orders o
WHERE o.ShipCity <> e.City


/*10, one city, the most orders, the most total quantity of products*/
SELECT e.City, dt2.NumOfQuant, dt1.NumOfOrder
FROM Employees e LEFT JOIN (
SELECT EmployeeID, OrderID, COUNT(o.OrderId) NumOfOrder FROM Orders o GROUP BY EmployeeID, OrderID
) dt1 ON e.EmployeeID = dt1.EmployeeID
LEFT JOIN (
SELECT od.OrderId, COUNT(od.Quantity) NumOfQuant FROM [Order Details] od GROUP BY OrderID) dt2
ON dt2.OrderID = dt1.OrderID
ORDER BY 2 DESC,3 DESC


WITH OrderCountCTE
AS
(
SELECT CustomerID, COUNT(OrderID) NumOfOrder FROM Orders o GROUP BY CustomerID
)
SELECT c.ContactName, c.City, cte.NumOfOrder
FROM Customers c LEFT JOIN OrderCountCTE cte ON c.CustomerID = cte.CustomerID


/*11 Use DISTINCT*/
SELECT DISTINCT e.City, dt2.NumOfQuant, dt1.NumOfOrder
FROM Employees e LEFT JOIN (
SELECT EmployeeID, OrderID, COUNT(o.OrderId) NumOfOrder FROM Orders o GROUP BY EmployeeID, OrderID
) dt1 ON e.EmployeeID = dt1.EmployeeID
LEFT JOIN (
SELECT od.OrderId, COUNT(od.Quantity) NumOfQuant FROM [Order Details] od GROUP BY OrderID) dt2
ON dt2.OrderID = dt1.OrderID
ORDER BY 2 DESC,3 DESC



/*12*/
CREATE VIEW EMPdept1(
Employee(empid integer, mgrid integer, deptid integer, salary money)
Dept(deptid integer, deptname varchar(20))
)
