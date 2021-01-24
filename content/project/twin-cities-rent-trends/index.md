---
title: Twin Cities Rent Trends
summary: Visualize rent and vacancy trends for cities, townships, and neighborhoods in the Twin Cities
tags:
- Metropolitan Council
- Housing
- Shiny
date: "2020-10-23T00:00:00Z"

# Optional external URL for project (replaces project detail page).
external_link: ""

image:
  # caption: Photo by rawpixel on Unsplash
  focal_point: Smart

links:
- icon: desktop
  icon_pack: fa
  name: Live App
  url: https://metrotransitmn.shinyapps.io/twin-cities-rent-trends/
url_code: ""
url_pdf: ""
url_slides: ""
url_video: ""
---

*Twin Cities Rent Trends* is a dashboard for analyzing rental housing market trends in the seven-county Twin Cities region. Rent data can be difficult and costly to obtain, and different sources can yield significantly different values. This app allows users to compare each source and view the data at different geographic levels. Users can view rent trends, including absolute rent price, rents adjusted for inflation, and year-over-year percent change. Users can also visualize the relationship between rent and vacancy rates (not available for all data sources).


I built the app based on the [`{golem}`](https://github.com/ThinkR-open/golem) framework, which builds the app repository as an R package. The result is a robust Shiny app, complete with testing and modular elements. The app integrates other package I've developed, including [`{council.skeleton}`](https://github.com/Metropolitan-Council/council.skeleton) and [`{councilR}`](https://github.com/Metropolitan-Council/councilR). 


## Screenshots  

St. Paul rent and vacancy  
![Vacancy map and plots](costar_vacancy.PNG)  

Lynnhurst neighborhood rent  
![Rent map and plots](zillow_neighborhood.PNG)  

Data download page  
![Data download page](data_download.PNG)

