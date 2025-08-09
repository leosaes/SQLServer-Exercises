SELECT A.[BusinessEntityID]
      ,A.[PersonType]
      ,[FullName] = CASE
                    WHEN A.[MiddleName] IS NULL THEN CONCAT_WS(' ',A.[FirstName],A.[LastName])
                    ELSE CONCAT_WS(' ',A.[FirstName],A.[MiddleName],A.[LastName])
                    END
      ,[Address] = C.AddressLine1
      ,C.City
      ,C.PostalCode
      ,[State] = D.[Name]
      ,[Country] = E.[Name]
  FROM [Person].[Person] A
  JOIN [Person].[BusinessEntityAddress] B
  ON A.BusinessEntityID = B.BusinessEntityID
  JOIN [Person].[Address] C
  ON B.AddressID = C.AddressID
  JOIN [Person].[StateProvince] D
  ON C.StateProvinceID = D.StateProvinceID
  JOIN [Person].[CountryRegion] E
  ON D.[CountryRegionCode] = E.CountryRegionCode
  WHERE A.PersonType = 'SP'
  OR (LEFT(C.PostalCode,1)='9' AND (LEN(C.PostalCode) = 5 AND E.[Name] = 'United States'))
