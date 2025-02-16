---
title: Make a neat header image
author: Liz Roten
date: '2021-03-13'
slug: make-a-neat-header
categories:
  - cartography
tags:
  - cartography
  - parks
  - illustrator
  - ggplot2
subtitle: 'Create an eye-catching website header'
summary: 'Create an eye-catching website header'
authors: []
toc: yes
lastmod: '2021-03-13T17:48:52-06:00'
featured: yes
draft: false
image:
  caption: 'Liz Roten, 2021'
  focal_point: ''
  preview_only: no
projects: ["square-lake-master-plan"]
disable_codefolding: true

---


I made a pretty neat header image for this site using raster data from my [Square Lake Master Plan Update](/project/square-lake-master-plan/) project.  


```r
library(sf)
library(ggplot2)
library(dplyr)
library(Cairo)
```
Download regional park geography from [Minnesota Geospatial Commons](https://gisdata.mn.gov/dataset/us-mn-state-metc-plan-parks-regional).  


```r
## base geometries -------------------------------------------------------------
temp <- tempfile()
download.file("ftp://ftp.gisdata.mn.gov/pub/gdrs/data/pub/us_mn_state_metc/plan_parks_regional/gpkg_plan_parks_regional.zip",
  destfile = temp
)

square_lake <- sf::read_sf(unzip(temp, "plan_parks_regional.gpkg")) %>%
  filter(STATUS == "Existing") %>%
  filter(PARKNAME == "Square Lake") %>%
  group_by(PARKNAME, AGENCY) %>%
  sf::st_union() %>%
  st_as_sf() %>%
  st_transform(4326)

fs::file_delete("plan_parks_regional.gpkg")
```


I refined `contours.RDS` in my previous project. The data come from [MnTOPO](https://www.dnr.state.mn.us/maps/mntopo/index.html), a web application for viewing, printing and downloading high-resolution elevation data for the State of Minnesota that was collected using LiDAR technology. I only needed data from a small area, so I drew a polygon over my study area using MnTOPO.  


```r
# load 3 meter contours over the Square Lake area

contour <- readRDS("contours.RDS") %>%
  st_transform(4326) %>%
  sf::st_crop(xmin = -92.7854633,
              ymin = 45.1497518,
              xmax = -92.8007197,
              ymax = 45.1568488)
```

Generate plot with `{ggplot2}`.  


```r
ggplot() +
  geom_sf(
      data = contour,
      color = "gray75",
      lwd = 0.2
    ) +
  theme_void()
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-5-1.png" width="672" />

Finally, save the plot as a PDF and open it in Adobe Illustrator for modifications.  


```r
Cairo::CairoPDF(file = "contours.pdf", 
                onefile = TRUE, width = 12, height = 10, bg = "transparent")
ggplot() +
  geom_sf(
      data = contour,
      color = "gray75",
      lwd = 0.2
    ) +
  theme_void()
dev.off()

```


I adjusted the background and finessed the positioning so it would display like I wanted it to on my home page. Here is the final product.  


![Header image](contours.png)
