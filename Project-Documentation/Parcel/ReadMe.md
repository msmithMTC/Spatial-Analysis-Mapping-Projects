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

***Process County Feature Sets***
1. [Create Northern California Megaregion Businesses FC](#create-northern-california-megaregion-business-fc)

   - [Create Northern California Megaregion Business FC Script](https://github.com/BayAreaMetro/Spatial-Analysis-Mapping-Projects/blob/master/Regional-Goods-Movement/scripts/Python/Create_Northern_CA_Megaregion_Businesses_2016_FC.py)

2. [Create Nothern California Megaregion Employment Density Feature Classes](#create-northern-claifornia-mega-region-employment-density-feature-classes)
  
3. [Employment Summary by Goods Movement Class / Supply Chain Class](#employment-summary-by-goods-movement-class--supply-chain-class) 


***Assemble Regional Feature Sets***

Blah, blah, blah


## Expected Outcomes
The expectation was there would be blah, blah, blah


## Results 
All end products on sites limited to Metropolitan Transportation Commission staff (require login)

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
