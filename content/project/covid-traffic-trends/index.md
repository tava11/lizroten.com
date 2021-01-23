---
title: COVID Traffic Trends
summary: An example of using the in-built project page.
tags:
- Metropolitan Council
date: "2020-05-22T00:00:00Z"

# Optional external URL for project (replaces project detail page).
external_link: ""

image:
  # caption: Photo by rawpixel on Unsplash
  focal_point: Smart

links:
- icon: github
  icon_pack: fab
  name: Code
  url: https://github.com/Metropolitan-Council/loop-sensor-trends/tree/master/covid.traffic.trends
- icon: desktop
  icon_pack: fa
  name: Live App
  url: https://github.com/Metropolitan-Council/loop-sensor-trends/tree/master/covid.traffic.trends
url_code: ""
url_pdf: ""
url_slides: ""
url_video: ""

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
# slides: example
---

In early 2020, the transportation and modeling team at the Metropolitan Council began using traffic data from the Minnesota Department of Transportation (MnDOT) to evaluate the impact of recent physical distancing efforts on regional and statewide travel. I developed an accompanying R Shiny app  with sections for visualizing the model results, downloading tabular data, and explaining the model. Individual items include an interactive plot showing the percent difference from expected traffic levels and an interactive map displaying the change in expected traffic at individual traffic sensors across the Twin Cities metro area and Rochester area. 

I built the app based on the [`{golem}`](https://github.com/ThinkR-open/golem) framework, which builds the app repository as an R package. The result is a robust Shiny app, complete with testing and modularized elements. The app integrates other package I've developed, including [`{council.skeleton}`](https://github.com/Metropolitan-Council/council.skeleton) and [`{councilR}`](https://github.com/Metropolitan-Council/councilR). The first iteration of the app was published within a week of starting on it.  


## Screenshots  

The plot shows the daily relative decrease in freeway travel over time across the Twin Cities metropolitan region after March 1. Points that fall below the zero-line represent decreases in travel relative to typical travel on that day of the year and day of the week. Typical travel is estimated using a statistical analysis of traffic volumes from 2018, 2019, and 2020 prior to March 1.

![This plot shows the daily relative decrease in freeway travel over time across the Twin Cities metropolitan region after March 1. Points that fall below the zero-line represent decreases in travel relative to typical travel on that day of the year and day of the week. Typical travel is estimated using a statistical analysis of traffic volumes from 2018, 2019, and 2020 prior to March 1.](covid_plot.PNG)  


The map shows the decreases in travel at individual traffic monitoring sites across the Twin Cities Metropolitan area. Traffic monitoring is performed by the Minnesota Department of Transportation (MnDOT) using detectors built into the infrastructure of the roads. These detectors are usually used to estimate congestion along Metro area highways.

![The map shows the decreases in travel at individual traffic monitoring sites across the Twin Cities Metropolitan area. Traffic monitoring is performed by the Minnesota Department of Transportation (MnDOT) using detectors built into the infrastructure of the roads. These detectors are usually used to estimate congestion along Metro area highways.](covid_map.PNG)



## Relevent links  

[Official news release](https://metrocouncil.org/Transportation/Planning-2/Transit-Plans,-Studies-Reports/Highways-Roads/COVID-19.aspx)  
[Live app site (updated regularly)](https://metrotransitmn.shinyapps.io/covid-traffic-trends/)  
[GitHub repository](https://github.com/Metropolitan-Council/loop-sensor-trends)
