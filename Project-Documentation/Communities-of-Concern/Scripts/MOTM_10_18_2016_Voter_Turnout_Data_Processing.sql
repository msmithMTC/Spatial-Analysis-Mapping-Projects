/****** Script for SelectTopNRows command from SSMS  ******/
--=======================================================================
/*
The purpose of this script is to process data related to the October 2018 
Map of the Month
Created on: 10-16-18
Created by: Joshua Croff
*/
--=======================================================================

--=======================================================================
/*
Group select 2016 election year and group by year, state, county, 
FIPS, office, and total votes and create new table
*/
--=======================================================================

SELECT
[year]
,[state]
,[state_po]
,[county]
,[FIPS]
,[office]
,[totalvotes]
INTO COUNTYPRES_2016_TOTAL_VOTES
FROM [Analysis].[dbo].[COUNTYPRES_2000_2016]
WHERE YEAR = 2016
GROUP BY
[year]
,[state]
,[state_po]
,[county]
,[FIPS]
,[office]
,[totalvotes]

--=======================================================================
/*
Add column to COUNTYPRES_2016_TOTAL_VOTES to create 5-digit FIPS code 
for counties 
*/
--=======================================================================

ALTER TABLE [Analysis].[dbo].[COUNTYPRES_2016_TOTAL_VOTES]
ADD FIPS_5 varchar(10) 

--=======================================================================
/*
Update column within COUNTYPRES_2016_TOTAL_VOTES table to 
create 5-digit FIPS code for counties. For FIPS < 5, concat 0 to begginning 
of code. Otherwise, do nothing. 
*/
--=======================================================================

UPDATE [Analysis].[dbo].[COUNTYPRES_2016_TOTAL_VOTES]
SET [FIPS_5] = (CASE WHEN LEN(FIPS) < 5 THEN ('0' + CAST(FIPS AS varchar(5))) ELSE CAST(FIPS AS varchar(5)) END) 

--=======================================================================
/*
Update FIPS_5 column to reflect changes to FIPS codes for Oglala Lakota,
South Dakota & Bedford, Virginia
*/
--=======================================================================

UPDATE [Analysis].[dbo].[COUNTYPRES_2016_TOTAL_VOTES]
SET [FIPS_5] = 46102
WHERE [FIPS] = 46113

UPDATE [Analysis].[dbo].[COUNTYPRES_2016_TOTAL_VOTES]
SET [FIPS_5] = 51019
WHERE [FIPS] = 51515

--=======================================================================
/*
Create new table of County Population estimates, only including 
Counties and not state data.  
*/
--=======================================================================

SELECT
[STATE]
,[COUNTY]
,[STNAME]
,[CTYNAME]
,[CENSUS2010POP]
,[POPESTIMATE2016]
INTO COUNTY_POPULATION_TOTAL_EST_2016
FROM [Analysis].[dbo].[CO_EST2016_ALLDATA]
WHERE COUNTY != 0

--=======================================================================
/*
Add column to COUNTY_POPULATION_TOTAL_EST_2016 for FIPS  
*/
--=======================================================================

ALTER TABLE [Analysis].[dbo].[COUNTY_POPULATION_TOTAL_EST_2016]
ADD 
	--FIPS varchar(5)
	STATE_FIPS varchar(2),
	COUNTY_FIPS varchar(3) 

--=======================================================================
/*
Update STATE_FIPS and COUNTY_FIPS column   
*/
--=======================================================================

UPDATE [Analysis].[dbo].[COUNTY_POPULATION_TOTAL_EST_2016]
SET 
	[STATE_FIPS] = (CASE WHEN LEN(STATE) < 2 THEN ('0' + CAST(STATE AS varchar(2))) ELSE CAST(STATE AS varchar(2)) END),
	[COUNTY_FIPS] = (CASE WHEN LEN(COUNTY) < 2 THEN ('00' + CAST(COUNTY AS varchar(3))) WHEN LEN(COUNTY) < 3 THEN ('0' + CAST(COUNTY AS varchar(3))) ELSE CAST(COUNTY AS varchar(3)) END)

--=======================================================================
/*
Update FIPS column   
*/
--=======================================================================

UPDATE [Analysis].[dbo].[COUNTY_POPULATION_TOTAL_EST_2016]
SET [FIPS] = STATE_FIPS + COUNTY_FIPS


--=======================================================================
/*
Create new table which joins U.S. County Population estimates with 
2016 total votes table and calculates the percentage of voter turnout
(votes / population est   
*/
--=======================================================================

select * 
from [dbo].[COUNTYPRES_2016_TOTAL_VOTES] t1
join [Analysis].[dbo].[COUNTY_POPULATION_TOTAL_EST_2016] t2
on t1.FIPS_5 = t2.FIPS
WHERE t2.CTYNAME is null

SELECT * 
FROM [Analysis].[dbo].[COUNTY_POPULATION_TOTAL_EST_2016]
WHERE STNAME LIKE 'Virginia'

select * 
from [dbo].[COUNTYPRES_2016_TOTAL_VOTES]
where FIPS_5 = 01027