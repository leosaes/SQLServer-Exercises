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
      ,JobTitle = ISNULL(F.JobTitle,'None')
      ,[JobCategory] = CASE
                       WHEN F.JobTitle LIKE '%Manager%' 
                       OR F.JobTitle LIKE '%President%' OR  F.JobTitle LIKE '%Manager%'
                       OR F.JobTitle LIKE '%Executive%' THEN 'Management'
                       WHEN F.JobTitle LIKE '%Engineer%' THEN 'Engineering'
                       WHEN F.JobTitle LIKE '%Production%' THEN 'Production'
                       WHEN F.JobTitle LIKE '%Marketing%' THEN 'Marketing'
                       WHEN F.JobTitle IS NULL THEN 'NA'
                       WHEN F.JobTitle IN ('Recruiter','Benefits Specialist','Human Resources Administrative Assistant') THEN 'Human Resources'
                       ELSE 'Other'
                       END
  FROM [Person].[Person] A
  LEFT JOIN  HumanResources.Employee F
  ON A.BusinessEntityID = F.BusinessEntityID
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
