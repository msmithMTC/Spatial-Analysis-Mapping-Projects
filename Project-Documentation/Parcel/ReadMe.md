# San Francisco Bay Region Parcels (2019) 

Parcels form the base unit of much of the analysis performed by the Metropolitan Transportation Commission (MTC) Regional Planning Program (RPP), specifically the Data & Visualization and Modeling groups.


### Contents 

[Problem Statement](#problem-statement)

[Data Sources](#data-sources) 

[Analysis Parameters](#analysis-parameters)

[Methodology](#methodology)

[Expected Outcomes](#expected-outcomes)

[Results](#results) 


## Problem Statement
The purpose of this project is to create 2019 parcel feature sets for the San Francisco Bay Region and each of its nine counties. 


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

As part of the development of these feature sets, the number of parcel attributes was kept to a minimum. The final attribute tables have the following fields:
  + **joinid** - Identification value for joining external tables to parcel features
  
  + **fipco** - Federal Information Processing Standards (FIPS) code for the county containing the parcel
  
  + **jurisdict** - Incorporated jurisdiction, or unincorporated area, containing the parcel
  
  + **apn** - Unformatted Assessor's Parcel Number (APN)
  
  + **apn_frm** - Formatted APN
  
  + **acres** - Parcel size in gross acres
  
  + **wtrprcl** - Identifies whether parcel is on land or in water (this field is only included in the regional feature set on Socrata)

The APN fields are the only attribute fields included from the source data. The values in these fields were not altered from the source data. The exception is where APN values could be calculated from one or more columns in the source table without modifying the numbers, if the source column had leading zeros there were leading zeros in the calculated value, if leading zeros were not provided, there are none in the calculated value.

  + If the attribute table only provided formatted APNs, then values were calculated for the unformatted APN column by removing the connection character from the formatted column
  
  + If the attribute table included multiple fields that cleanly separated the APN components, then values for the formatted APN column were calculated by joining them together with the connecting character added between the components


## Methodology 

***Feature Preparation***

__Contra Costa__ - The source feature set of parcel polygons did not include APN values for the parcels. The only attibute was a join value. As a result, a parcel point feature set also needed to be downloaded. The point feature set contained the APN, and other attributes, for the parcel polygons. As there were more points than polygons, this seemed to be done to prevent the inclusion of stacked polygons in the polygon feature set. Since Contra Costa County was the only county to do this. County data preparation was:
  + Join parcel points to parcel polygons using the XXXXXXXXX field
  + Export new polygon feature set
  + Delete duplicate join field

__San Francisco__ - The source feature set of San Francisco parcels included both active and inactive parcels. County data preparation was:
  + Select parcels with a value of 1 in the active_ret field. Available values were 1 - active and 0 - retired
  + Export selected parcels as new feature set

__Solano__ - The parcel feature set released in 2019 had hundreds of missing parcels. To address this, the 2018 release was also downloaded so a, mostly (both versions had missing parcels), complete parcel coverage for the county could be created. County data preparation was:
  + Erase areas in 2018 release using features from the 2019 release
  + Run Repair Geometry tool on remaining areas from 2018 release with OGC and Delete Features with Null Geometry parameters selected
  + Merge remaining areas from 2018 release with the 2019 release
  + Calculate APNs from each release into a single field. One of the releases had two APN fields, both of which were incomplete. However, each parcel had an APN if the fields were combined
  + Run Dissolve tool, using the new, complete APN field, to create a new multipart feature set



***Process County Feature Sets***

For each county:
1. Run Repair Geometry tool with OGC and Delete Features with Null Geometry parameters selected

2. Check projection of source feature set. Projection used at MTC is GCS WGS 1984:
>  + If feature set needs to be projected, have Project tool create output feature set in working file geodatabase
>    + Alameda County was projected from WGS 1984 Web Mercator Auxiliary Sphere without transformation as it is, technically, the same as GCS WGS 1984
>    + Contra Costa County was projected from NAD 1983 StatePlane California III FIPS 0403 Feet using the NAD_1983_HARN_To_WGS_1984_2 transformation
>    + Marin County was projected from NAD 1983 HARN StatePlane California III FIPS 0403 (US Feet) using the NAD_1983_HARN_To_WGS_1984_2 transformation
>    + Napa County was projected from NAD 1983 HARN StatePlane California II FIPS 0402 Feet using the WGS_1984_(ITRF00)_To_NAD_1983 transformation
>
>  + If feature set does not need to be projected, export features to working file geodatabase
  
3. Delete unnecessary fields from attribute table 


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
