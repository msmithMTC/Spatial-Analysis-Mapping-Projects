/****** Script for SelectTopNRows command from SSMS  ******/

--Add mean walkscore column to parcels table and update with walkscore from walkscore table 

ALTER TABLE 
ADD Mean_Walkscore numeric(38,8)

UPDATE parcels
SET parcels.Mean_Walkscore = walkscore.[MEAN]
FROM [dbo].[PARCELS2010] as parcels
JOIN [dbo].[PARCELS_WALKSCORE_TABLE] as walkscore
ON parcels.[PARCEL_ID] = walkscore.[Parcel_ID_Text]

--Create new table from parcel geometry table, parcel data table, and generalized regional zoning table

SELECT
CAST(parcel_geom.PARCEL_ID AS nvarchar(255)) as Parcel_ID,
city,
HS,
pda_id,
tpa_id,
Mean_Walkscore,
total_residential_units,
shape
into SF_Neighborhood_Analysis_Parcels_06_26_2018
  FROM [dbo].[ZONING_PARCELS_2015_12_21] AS parcel_zoning
  JOIN [dbo].[ZONING_LOOKUP_CSV] as zoning 
  on parcel_zoning.zoning_id = zoning.id
  JOIN [dbo].[PARCELS2010] as parcel_geom
  on parcel_zoning.[geom_id] = parcel_geom.GEOM_ID
  JOIN [dbo].[RUN7224_PARCEL_DATA_2040_CSV] as parcel_data
  on parcel_geom.PARCEL_ID = parcel_data.parcel_id

-- Summarize single family zoned parcels within tpas by jurisdiction and given number of units on parcel

SELECT 
t1.Bay_Area_Jurisdiction,
t1.Single_Family_Parcels,
CAST(t1.Total_Residential_Units AS INT) AS Total_Residential_Units,
t2.Single_Family_Parcels_2_Units,
t3.Single_Family_Parcels_3_Units,
t4.Single_Family_Parcels_4_Units
FROM 
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels,
sum(total_residential_units) as Total_Residential_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE tpa_id != 'NA' and HS = 1
GROUP BY city) t1
LEFT JOIN 
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels_2_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE tpa_id != 'NA' and HS = 1 and total_residential_units = 2
GROUP BY city) t2
on t1.Bay_Area_Jurisdiction = t2.Bay_Area_Jurisdiction
LEFT JOIN 
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels_3_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE tpa_id != 'NA' and HS = 1 and total_residential_units = 3
GROUP BY city) t3
on t1.Bay_Area_Jurisdiction = t3.Bay_Area_Jurisdiction
LEFT JOIN
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels_4_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE tpa_id != 'NA' and HS = 1 and total_residential_units = 4
GROUP BY city) t4
on t1.Bay_Area_Jurisdiction = t4.Bay_Area_Jurisdiction
ORDER BY t1.Bay_Area_Jurisdiction ASC

-- Summarize single family zoned parcels within pdas by jurisdiction and given number of units on parcel

SELECT 
t1.Bay_Area_Jurisdiction,
t1.Single_Family_Parcels,
CAST(t1.Total_Residential_Units AS INT) AS Total_Residential_Units,
t2.Single_Family_Parcels_2_Units,
t3.Single_Family_Parcels_3_Units,
t4.Single_Family_Parcels_4_Units
FROM 
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels,
sum(total_residential_units) as Total_Residential_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE pda_id != 'NA' and HS = 1
GROUP BY city) t1
LEFT JOIN 
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels_2_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE pda_id != 'NA' and HS = 1 and total_residential_units = 2
GROUP BY city) t2
on t1.Bay_Area_Jurisdiction = t2.Bay_Area_Jurisdiction
LEFT JOIN 
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels_3_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE pda_id != 'NA' and HS = 1 and total_residential_units = 3
GROUP BY city) t3
on t1.Bay_Area_Jurisdiction = t3.Bay_Area_Jurisdiction
LEFT JOIN
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels_4_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE pda_id != 'NA' and HS = 1 and total_residential_units = 4
GROUP BY city) t4
on t1.Bay_Area_Jurisdiction = t4.Bay_Area_Jurisdiction
ORDER BY t1.Bay_Area_Jurisdiction ASC

-- Summarize single family zoned parcels within walkable communities by jurisdiction and given number of units on parcel
-- Walkable communities are communities where the average walkscore is >= 70 

SELECT 
t1.Bay_Area_Jurisdiction,
t1.Single_Family_Parcels,
CAST(t1.Total_Residential_Units AS INT) AS Total_Residential_Units,
t2.Single_Family_Parcels_2_Units,
t3.Single_Family_Parcels_3_Units,
t4.Single_Family_Parcels_4_Units
FROM 
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels,
sum(total_residential_units) as Total_Residential_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE Mean_Walkscore >= 70 and HS = 1
GROUP BY city) t1
LEFT JOIN 
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels_2_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE Mean_Walkscore >= 70 and HS = 1 and total_residential_units = 2
GROUP BY city) t2
on t1.Bay_Area_Jurisdiction = t2.Bay_Area_Jurisdiction
LEFT JOIN 
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels_3_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE Mean_Walkscore >= 70 and HS = 1 and total_residential_units = 3
GROUP BY city) t3
on t1.Bay_Area_Jurisdiction = t3.Bay_Area_Jurisdiction
LEFT JOIN
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels_4_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE Mean_Walkscore >= 70 and HS = 1 and total_residential_units = 4
GROUP BY city) t4
on t1.Bay_Area_Jurisdiction = t4.Bay_Area_Jurisdiction
ORDER BY t1.Bay_Area_Jurisdiction ASC

-- Summarize single family zoned parcels within walkable communities, and within TPAs by jurisdiction and given number of units on parcel
-- Walkable communities are communities where the average walkscore is >= 70

SELECT 
t1.Bay_Area_Jurisdiction,
t1.Single_Family_Parcels,
CAST(t1.Total_Residential_Units AS INT) AS Total_Residential_Units,
t2.Single_Family_Parcels_2_Units,
t3.Single_Family_Parcels_3_Units,
t4.Single_Family_Parcels_4_Units
FROM 
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels,
sum(total_residential_units) as Total_Residential_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE tpa_id != 'NA' and HS = 1 and Mean_Walkscore >= 70
GROUP BY city) t1
LEFT JOIN 
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels_2_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE tpa_id != 'NA' and HS = 1 and Mean_Walkscore >= 70 and total_residential_units = 2
GROUP BY city) t2
on t1.Bay_Area_Jurisdiction = t2.Bay_Area_Jurisdiction
LEFT JOIN 
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels_3_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE tpa_id != 'NA' and HS = 1 and Mean_Walkscore >= 70 and total_residential_units = 3
GROUP BY city) t3
on t1.Bay_Area_Jurisdiction = t3.Bay_Area_Jurisdiction
LEFT JOIN
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels_4_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE tpa_id != 'NA' and HS = 1 and Mean_Walkscore >= 70 and total_residential_units = 4
GROUP BY city) t4
on t1.Bay_Area_Jurisdiction = t4.Bay_Area_Jurisdiction
ORDER BY t1.Bay_Area_Jurisdiction ASC

-- Summarize single family zoned parcels within walkable communities, and within PDAs by jurisdiction and given number of units on parcel
-- Walkable communities are communities where the average walkscore is >= 70

SELECT 
t1.Bay_Area_Jurisdiction,
t1.Single_Family_Parcels,
CAST(t1.Total_Residential_Units AS INT) AS Total_Residential_Units,
t2.Single_Family_Parcels_2_Units,
t3.Single_Family_Parcels_3_Units,
t4.Single_Family_Parcels_4_Units
FROM 
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels,
sum(total_residential_units) as Total_Residential_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE pda_id != 'NA' and Mean_Walkscore >= 70 and HS = 1
GROUP BY city) t1
LEFT JOIN 
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels_2_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE pda_id != 'NA' and HS = 1 and Mean_Walkscore >= 70 and total_residential_units = 2
GROUP BY city) t2
on t1.Bay_Area_Jurisdiction = t2.Bay_Area_Jurisdiction
LEFT JOIN 
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels_3_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE pda_id != 'NA' and HS = 1 and Mean_Walkscore >= 70 and total_residential_units = 3
GROUP BY city) t3
on t1.Bay_Area_Jurisdiction = t3.Bay_Area_Jurisdiction
LEFT JOIN
(SELECT 
city as Bay_Area_Jurisdiction,
Count(*) as Single_Family_Parcels_4_Units
FROM [dbo].[SF_Neighborhood_Analysis_Parcels_06_26_2018]
WHERE pda_id != 'NA' and HS = 1 and Mean_Walkscore >= 70 and total_residential_units = 4
GROUP BY city) t4
on t1.Bay_Area_Jurisdiction = t4.Bay_Area_Jurisdiction
ORDER BY t1.Bay_Area_Jurisdiction ASC