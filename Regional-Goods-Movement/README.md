# Northern California Megaregion Goods Movement Analysis & Mapping 

The Goods Movement program at MTC provides a regional, coordinating framework from which funding and planning priorities are developed. The current planning framework is the San Francisco Goods Movement Plan, adopted in 2016, which prioritizes sustainable, global competitiveness in freight. The primary strategies for realizing this goal are through increasing capacity at the Port of Oakland, increasing access to industrial land region-wide, improving efficiency and emissions of urban deliveries, and reducing adverse impacts of freight movement along the highway and rail corridors.

### Contents 

[Problem Statement](#problem-statement)

[Data Sources](#data-sources) 

[Methodology](#methodology) 

[Expected Outcomes](#expected-outcomes)

[Results](#results) 

## Problem Statement

The purpose of this project is to analyze business, transportation, and demographic data for the 22 County Northern California Megaregion, which will inform the works of planners and decision makers supporting the MTC Goods Movement program. 

[Asana Project](https://app.asana.com/0/353588576094175/353588576094186)  

## Data Sources 
- [California Business Data: Esri;Infogroup 2016](https://mtcdrive.app.box.com/folder/11272654765)
  - *Datasets are licensed and therefore not to be distributed publicly*
- [FMMP Urban 2014](http://www.conservation.ca.gov/dlrp/fmmp)


## Analysis Parameters

As part of this analysis process, we mapped NAICS 2 digit, 3 digit, and 4 digit codes to what we've defined as Supply Chain Roles. Similarly, we mapped NAICS 2 digit, 3 digit, and 4 digit codes to what we've defined as Goods Movement - Related Industries and Occuplations. Following are tables which group NAICS codes into classes.

**Goods Movement - Related Industries and Occupations**

| Description                                                | NAICS 2- Digit | NAICS 3- Digit | NAICS 4- Digit |
|------------------------------------------------------------|----------------|----------------|----------------|
| **Core Goods Movement Industries**                         |                |                |                |
| Air Transportation                                         |                | 481            |                |
| Rail Transportation                                        |                | 482            |                |
| Water Transportation                                       |                | 483            |                |
| Truck Transportation                                       |                | 484            |                |
| Support Activities for Transportation                      |                | 488            |                |
| Postal Serivce                                             |                | 491            |                |
| Couriers and Messengers                                    |                | 492            |                |
| Warehousing and Storage                                    |                | 493            |                |
| Pipeline Transportation                                    |                | 486            |                |
| Merchant Wholesalers, Durable Goods                        |                | 423            |                |
| Merchant Wholesalers, Nondurable Goods                     |                | 424            |                |
| Wholesale Electronic Markets and Agents and Brokers        |                | 425            |                |
| Waste Collections                                          |                |                | 5621           |
|                                                            |                |                |                |
| **Freight-Dependent Industries**                           |                |                |                |
| Agriculture, Forestry, Fishing and Hunting                 | 11             |                |                |
| Mining, Quarrying, and Oil and Gas Extraction              | 21             |                |                |
| Construction                                               | 23             |                |                |
| Manufaturing                                               | 31-33          |                |                |
| Retail Trade                                               | 44-45          |                |                |
| Administrative and Support and Waste Mgmt. and Remediation | 56             |                |                |
| Waste Disposal                                             |                |                | 5622           |
| Waste Remediation                                          |                |                | 5629           |

**Supply Chain Roles and NAICs Classifications**

| Production |               | Transportation |                                       | Distribution |                             | Retail |        | Waste |                   |
|------------|---------------|----------------|---------------------------------------|--------------|-----------------------------|--------|--------|-------|-------------------|
| NAICS      | Sector        | NAICS          | Sector                                | NAICS        | Sector                      | NAICS  | Sector | NAICS | Sector            |
| 11         | Ag. Forestry  | 481            | Air Transportation                    | 423          | Durable Goods Wholesale     | 44     | Retail | 5621  | Waste Collection  |
| 21         | Mining        | 482            | Rail Transportation                   | 424          | Non-Durable Goods Wholesale | 45     | Retail | 5622  | Waste Disposal    |
| 23         | Construction  | 483            | Water Transportation                  | 425          | Wholesale Agents & Brokers  |        |        | 5629  | Waste Remediation |
| 31         | Manufacturing | 484            | Truck Transportation                  | 493          | Warehousing and Storage     |        |        |       |                   |
| 32         | Manufacturing | 486            | Pipeline Transportation               |              |                             |        |        |       |                   |
| 33         | Manufacturing | 488            | Support Activities for Transportation |              |                             |        |        |       |                   |
|            |               | 491            | Postal Service                        |              |                             |        |        |       |                   |
|            |               | 492            | Couriers and Messengers               |              |                             |        |        |       |                   |


## Methodology 

### Summary

1. Create Northern California Megaregion Businesses FC

    [Create Northern California Megaregion Business FC Script](https://github.com/BayAreaMetro/Spatial-Analysis-Mapping-Projects/blob/master/Regional-Goods-Movement/scripts/Python/Create_Northern_CA_Megaregion_Businesses_2016_FC.py)

2. Create Nothern California Megaregion Employment Density Feature Classes
  
3. Employment Summary by Goods Movement Class / Supply Chain Class 

    [Create Megaregion Employment Summaries](https://github.com/BayAreaMetro/Spatial-Analysis-Mapping-Projects/blob/master/Regional-Goods-Movement/scripts/Python/Create_Megaregion_Employment_Summaries.py)

### Detailed 

**Create Northern California Megaregion Business FC** 

Script:

- [Create Northern California Megaregion Business FC Script](https://github.com/BayAreaMetro/Spatial-Analysis-Mapping-Projects/blob/master/Regional-Goods-Movement/scripts/Python/Create_Northern_CA_Megaregion_Businesses_2016_FC.py)

Input:

- [California Business Data](#data-sources)
- [Northern California Megaregion Counties](#feature-classes--csvs)

Output: 

- [GMS 2016 North CA Megaregion Businesses](#feature-classes--csvs)

Output Data Dictionary: 
Four fields were added to the original [GMS_2016_CA_Businesses](#feature-classes--csvs) feature class; the full domain of each field is summarized in the table below:

|Field Name     |Values              |
|---------------|--------------------|
|County         |Alameda, Contra Costa, El Dorado, Marin, Merced, Monterey, Napa, Placer, Sacramento, San,Benito, San Francisco, San Joaquin, San Mateo, Santa Clara, Santa Cruz, Solano, Sonoma, Stanislaus, Sutter, Yolo, Yuba|
|Region         |Bay Area, Monterey Bay Area, Northern San Joaquin Valley, Sacramento Area|
|Goods_Mvmt_Class |1, 2, 3 See: [NAICS Mapping to Goods Movement Classes](https://github.com/BayAreaMetro/Spatial-Analysis-Mapping-Projects/blob/master/Regional-Goods-Movement/data/NAICS_Mapping_to_Goods_Mvmt_Classes.csv)|
|Supply_Chain_Class |1, 2, 3, 4, 5, 6 See: [NAICS Mapping to Supply Chain Classes](https://github.com/BayAreaMetro/Spatial-Analysis-Mapping-Projects/blob/master/Regional-Goods-Movement/data/NAICS_Mapping_to_Supply_Chain_Classes.csv)|

**Create Northern Claifornia Mega Region Employment Density Feature Classes**

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

**Employment Summary by Goods Movement Class / Supply Chain Class**

Script: 

[Create_megaregion_Employment_Summaries](https://github.com/BayAreaMetro/Spatial-Analysis-Mapping-Projects/blob/master/Regional-Goods-Movement/scripts/Python/Create_Megaregion_Employment_Summaries.py)

Input: 

- [GMS 2016 North CA Megaregion Businesses](#feature-classes--csvs)

Output: 

- [2016_Megaregion_Emp_Tot_By_GM_Class.csv](#feature-classes--csvs)
- [2016_Megaregion_Emp_Tot_By_SC_Class.csv](#feature-classes--csvs)

## Results 

### Tools

- [NC_Megaregion_Goods_Movement_Study FGDB](https://mtcdrive.box.com/s/42gm26ycxtjw5cv9vb9gbqkox047nxyc)

### Maps, Charts, and Graphics

- [Illustrator Files](https://mtcdrive.box.com/s/b151mezv55a729tq920m7rkv8mges133)
- [Image Files (PDFs/PNGs)](https://mtcdrive.box.com/s/8q04bnteu8ss988fet7utfr2iqhamwek)

### Feature Classes & CSVs

- [NC_Megaregion_Goods_Movement_Study FGDB](https://mtcdrive.box.com/s/42gm26ycxtjw5cv9vb9gbqkox047nxyc)
- [2016_Megaregion_Emp_Tot_By_GM_Class.csv](https://github.com/BayAreaMetro/Spatial-Analysis-Mapping-Projects/blob/master/Regional-Goods-Movement/data/2016_Megaregion_Emp_Tot_By_GM_Class.csv)
- [2016_Megaregion_Emp_Tot_By_SC_Class.csv](https://github.com/BayAreaMetro/Spatial-Analysis-Mapping-Projects/blob/master/Regional-Goods-Movement/data/2016_Megaregion_Emp_Tot_By_SC_Class.csv)