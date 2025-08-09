SELECT [OrderID] = A.[PurchaseOrderID]
      ,[OrderDetailID]=A.[PurchaseOrderDetailID]
      ,A.[OrderQty]
      ,A.[UnitPrice]
      ,A.[LineTotal]
      ,B.OrderDate
      ,[OrderSizeCategory] = 
      CASE
      WHEN A.OrderQty > 500 THEN 'Large'
      WHEN A.OrderQty > 50 AND A.OrderQty <=500 THEN 'Medium'
      ELSE 'Small'
      END
      ,[ProductName] = C.[Name]
      ,[Subcategory] = ISNULL(D.[Name],'None')
      ,[Category] = ISNULL(E.[Name],'None')
      ,[OrderType] = 'Purchase'
  FROM [Purchasing].[PurchaseOrderDetail] A
  JOIN [Purchasing].[PurchaseOrderHeader] B
  ON A.[PurchaseOrderID] = B.[PurchaseOrderID]
  JOIN [Production].[Product] C
  ON A.ProductID = C.ProductID
  LEFT JOIN [Production].[ProductSubcategory] D
  ON C.ProductSubcategoryID = D.ProductSubcategoryID
  LEFT JOIN [Production].[ProductCategory] E    
  ON D.ProductCategoryID = E.ProductCategoryID

UNION

SELECT A.[SalesOrderID]
      ,A.[SalesOrderDetailID]
      ,A.[OrderQty]
      ,A.[UnitPrice]
      ,A.[LineTotal]
      ,B.OrderDate
      ,[OrderSizeCategory] = 
      CASE
      WHEN A.OrderQty > 500 THEN 'Large'
      WHEN A.OrderQty > 50 AND A.OrderQty <=500 THEN 'Medium'
      ELSE 'Small'
      END
      ,[ProductName] = C.[Name]
      ,[Subcategory] = ISNULL(D.[Name],'None')
      ,[Category] = ISNULL(E.[Name],'None')
      ,[OrderType] = 'Sale'
  FROM [Sales].[SalesOrderDetail] A
  JOIN [Sales].[SalesOrderHeader] B
  ON A.[SalesOrderID] = B.[SalesOrderID]
  JOIN [Production].[Product] C
  ON A.ProductID = C.ProductID
  LEFT JOIN [Production].[ProductSubcategory] D
  ON C.ProductSubcategoryID = D.ProductSubcategoryID
  LEFT JOIN [Production].[ProductCategory] E    
  ON D.ProductCategoryID = E.ProductCategoryID
  WHERE MONTH(B.OrderDate) = 12
  ORDER BY B.OrderDate DESC