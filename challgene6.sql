SELECT A.SalesOrderID,
	   [OrderTotal] = FORMAT(SUM(A.LineTotal),'c'),
	   ProductList = STRING_AGG(B.[Name],',')

	   FROM Sales.SalesOrderDetail A
	   INNER JOIN Production.[Product] B
		ON A.ProductID = B.ProductID
		
		GROUP BY A.SalesOrderID

		HAVING SUM(A.LineTotal) > 5000