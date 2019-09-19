# San Francisco Bay Region Parcels (2019) 

Blah, blah, blah stuff describing the general project.

### Contents 

[Problem Statement](#problem-statement)

[Data Sources](#data-sources) 

[Analysis Parameters](#analysis-parameters)

[Methodology](#methodology)

[Expected Outcomes](#expected-outcomes)

[Results](#results) 

## Problem Statement

The purpose of this project is to create a 2019 parcel feature set for the San Francisco Bay Region. . 


## Data Sources 
All datasets downloaded on August 26, 2019

| County | Download Location | Source Data Date |
| --- | --- | --- |
| Alameda County | [Alameda County Data Sharing Initiative](https://data.acgov.org/Geospatial-Data/Alameda-County-Parcel-Boundaries/2m43-xsic) | 23 Apr 2019 |
| Contra Costa County | [Contra Costa County public, web data directory](https://gis.cccounty.us/Downloads/Assessor/) | Mar 2019 |
| Marin County | [Marin GeoHub](https://gisopendata.marincounty.org/datasets/MarinCounty::parcel) | 23 Aug 2019 |
| Napa County | [Napa County GIS Data Catalog](http://gis.napa.ca.gov/giscatalog/catalog_xml.asp) | 03 Jul 2019 |
| San Francisco | [DataSF](https://data.sfgov.org/Geographic-Locations-and-Boundaries/Parcels-Active-and-Retired/acdm-wktn) | 25 Aug 2019 |
| San Mateo County | [County of San Mateo Information Services - GIS Data Download](https://isd.smcgov.org/gis-data-download) | 26 Aug 2019 |
| Santa Clara County | [County of Santa Clara Open Data Portal](https://data.sccgov.org/Government/Parcels/6p99-rtwk) | 26 Aug 2019 |
| Solano County | Solano GeoHub - [Parcels 2019](http://geohub-doitgis.opendata.arcgis.com/datasets/parcels2018-2) and [Parcels 2018](http://geohub-doitgis.opendata.arcgis.com/datasets/parcels2018) | 07 Aug 2019 and 20 Jul 2018 |
| Sonoma County | [County of Sonoma public, web data directory](https://links.sonoma-county.org/nlhrCoQbqzY/) | 20 Aug 2019 |


## Analysis Parameters

As part of this analysis process, we mapped NAICS 2 digit, 3 digit, and 4 digit codes to what we've defined as Supply Chain Roles. Similarly, we mapped NAICS 2 digit, 3 digit, and 4 digit codes to what we've defined as Goods Movement - Related Industries and Occuplations. Following are tables which group NAICS codes into classes.


## Methodology 

1. [Create Northern California Megaregion Businesses FC](#create-northern-california-megaregion-business-fc)

   - [Create Northern California Megaregion Business FC Script](https://github.com/BayAreaMetro/Spatial-Analysis-Mapping-Projects/blob/master/Regional-Goods-Movement/scripts/Python/Create_Northern_CA_Megaregion_Businesses_2016_FC.py)

2. [Create Nothern California Megaregion Employment Density Feature Classes](#create-northern-claifornia-mega-region-employment-density-feature-classes)
  
3. [Employment Summary by Goods Movement Class / Supply Chain Class](#employment-summary-by-goods-movement-class--supply-chain-class) 

   [Create Megaregion Employment Summaries](https://github.com/BayAreaMetro/Spatial-Analysis-Mapping-Projects/blob/master/Regional-Goods-Movement/scripts/Python/Create_Megaregion_Employment_Summaries.py)

4. Unemployment Rate 

   In 2015, 10% of California residents in the labor force were unemployed. Areas where more than 10% of residents in the labor force are unemployed is considered a moderate to high share. 

   [2015 ACS Unemployment Data - California](https://github.com/BayAreaMetro/Spatial-Analysis-Mapping-Projects/blob/master/Regional-Goods-Movement/data/ACS_15_5YR_B23025_with_ann.csv)

5. Workers without a College Degree

   In 2015, 64% of workers in California did not have a Bachelor's Degree or higher. Areas where more than 60% of workers do not have a college Degree is considered a moderate to high share. 

   [2015 ACS Educational Attainment and Employment Status Data - California](https://github.com/BayAreaMetro/Spatial-Analysis-Mapping-Projects/blob/master/Regional-Goods-Movement/data/ACS_15_5YR_B23006_with_ann.csv)

6. Low Income Workers 

   In 2015, 50% of workers in California made $35,000 or less. Areas where more than 50% of workers make less than $35,000 is considered a moderate to high share. The median income for a worker in California is $31,296 per year. Given the income is grouped into income brackets, the median income fell into the $25,000 to $34,999 range so anything below the top range was considered 'low income'.

   [2015 Earnings and Employment Status Data - California](https://github.com/BayAreaMetro/Spatial-Analysis-Mapping-Projects/blob/master/Regional-Goods-Movement/data/ACS_15_5YR_B08119_with_ann.csv)


#### Create Northern Claifornia Mega Region Employment Density Feature Classes

Two custom tools were created using ArcGIS Pro Model Builder to generate the final output feature class, as well as intermediary feature classes & rasters. The feature class generated highlights employment density within [FMMP Urban and Built Up](http://www.conservation.ca.gov/dlrp/fmmp/mccu/Pages/map_categories.aspx) areas. The toolbox containing the tools is linked below. Assumptions are maintained as defaults within the tools.

***Select By Attribute Create Point Density Raster*** 

Tool: [Select_By_Attr_Create_Point_Density_Raster](#tools) 

![Select by Attr Create Point Density Raster Model](https://github.com/BayAreaMetro/Spatial-Analysis-Mapping-Projects/blob/master/Regional-Goods-Movement/readme_images/Screen%20Shot%202017-05-25%20at%2010.54.57%20AM.png)

Input: 

- [GMS 2016 North CA Megaregion Businesses](#feature-classes--csvs)

Tool Input Values: 

  - Population field: EMPNUM
  - Expressions: 
      - All Industries: ```'Goods_Mvmt_Class IN (1,2,3)'``` 
      - Core Industries: ```'Goods_Mvmt_Class = 1'```
      - Dependent Industries: ```'Goods_Mvmt_Class = 2'```
      - Supported Industries: ```'Goods_Mvmt_Class = 3'```
      - Production: ```'Supply_Chain_Class = 1'```
      - Transportation: ```'Supply_Chain_Class = 2'``` 
      - Distribution: ```'Supply_Chain_Class = 3'```
      - Retail: ```'Supply_Chain_Class = 4'```
      - Waste: ```'Supply_Chain_Class = 5'```
  - Output Cell Size: 20
  - Mask: [NC_Mega_Region_FMMP_Urban_2014_SF (Polygon)](#feature-classes--csvs)
    - Built - up areas

Tool Assumptions: 

![Point Density Inputs](https://github.com/BayAreaMetro/regional-goods-movement/blob/master/Northern-California-Megaregion-Employment-Density-Maps/readme_images/Screen%20Shot%202017-06-08%20at%2010.12.04%20AM.png)

Output: 

This process created 9 output rasters, each following a patterned naming convention followed by the goods movement or supply chain class to to disambiguate each feature. Examples of that convention are provided below. These are intermediate features, which will were reclassified and converted from raster to polygon in the following process. To see the name of each output, follow the respective links below.    

  - [NC_Megaregion_Emp_Density_GoodsMvmtClass (Raster)](#feature-classes--csvs)
  - [NC_Megaregion_Emp_Density_SupplyChainClass (Raster)](#feature-classes--csvs)

***Reclassify Convert Raster to Polygon***

Tool: [Reclassify_Convert_Raster_to_Polygon](#tools)

![Reclassify Convert Raster to Polygon](https://github.com/BayAreaMetro/Spatial-Analysis-Mapping-Projects/blob/master/Regional-Goods-Movement/readme_images/Screen%20Shot%202017-05-25%20at%2010.57.25%20AM.png)

Input: 

This process was not integrated into the last process as each of the input rasters to the process needed to be classified seperately. Reclassification tables were created for each reclass feature and are referenced below. the 9 output rasters created from the previous process were input into this tool, each following a patterend naming convention followed by the goods movement or supply chain class. 

- [NC_Megaregion_Emp_Density_GoodsMvmtClass (Raster)](#feature-classes--csvs)
- [NC_Megaregion_Emp_Density_SupplyChainClass (Raster)](#feature-classes--csvs)

Tool Input Values: 

Each raster was reclassified, creating classes by standard deviation values. Those values were stored in tables for reference each following a pattered naming convention followed by the goods movement or supply chain class to disambiguate each feature.
Examples of that convention are provided below.

- [Reclass_Table_GoodsMvmtClass](#feature-classes--csvs)
- [Reclass_Table_SupplyChainClass](#feature-classes--csvs)

Output: 

This process created 9 output vector feature classes, each following a patterned naming convention followed by the goods movement or supply chain class and 'rc' or reclassifed to to disambiguate each feature. Examples of that convention are provided below. 

- [NC_Mega_Region_Emp_Density_GoodsMvmtClass_RC (Raster)](#feature-classes--csvs)
- [NC_Mega_Region_Emp_Density_SupplyChainClass_RC (Raster)](#feature-classes--csvs) 

#### Employment Summary by Goods Movement Class / Supply Chain Class

Script: 

[Create_megaregion_Employment_Summaries](https://github.com/BayAreaMetro/Spatial-Analysis-Mapping-Projects/blob/master/Regional-Goods-Movement/scripts/Python/Create_Megaregion_Employment_Summaries.py)

Input: 

- [GMS 2016 North CA Megaregion Businesses](#feature-classes--csvs)

Output: 

- [2016_Megaregion_Emp_Tot_By_GM_Class.csv](#feature-classes--csvs)
- [2016_Megaregion_Emp_Tot_By_SC_Class.csv](#feature-classes--csvs)

## Results 
All end products on sites limited to Metropolitan Transportation Commission staff (requires login)

#### Socrata
- [San Francisco Bay Region Parcels (2019)](https://data.bayareametro.gov/Cadastral/Parcels-2019/kah7-2qc6)

#### ArcGIS Online
- [Alameda County Parcels (2019)]()
- [Contra Costa County Parcels (2019)]()
- [Marin County Parcels (2019)]()
- [Napa County Parcels (2019)]()
- [San Francisco Parcels (2019)]()
- [San Mateo County Parcels (2019)]()
- [Santa Clara County Parcels (2019)]()
- [Solano County Parcels (2019)]()
- [Sonoma County Parcels (2019)]()
