---
title: Minimum distance to COVID-19 testing facilities
summary: A map series analyzing how COVID-19 testing centers are distributed across Minnesota  
tags:
- Metropolitan Council
- health
- cartography
- covid
- transportation
- ggplot2
date: "2020-07-15T00:00:00Z"

# Optional external URL for project (replaces project detail page).
external_link: ""

image:
  # caption: Photo by rawpixel on Unsplash
  focal_point: Smart

links:
# - icon: desktop
#   icon_pack: fa
#   name: Live App
#   url: https://metrotransitmn.shinyapps.io/twin-cities-rent-trends/
url_code: ""
url_pdf: ""
url_slides: ""
url_video: ""


---

{{% callout warning %}}
The maps in this series were last updated July 15, 2020. Since then, the state has opened additional testing locations and implemented new testing options, including [no cost home testing](https://www.health.state.mn.us/diseases/coronavirus/testsites/athome.html). For the most recent information regarding COVID-19 testing in Minnesota, please see the [Minnesota Department of Health website](https://www.health.state.mn.us/diseases/coronavirus/testsites/index.html).  
{{% /callout %}}

The COVID-19 response effort requires all hands on deck, and my team at the Metropolitan Council has been working with folks at the State of Minnesota to help answer transportation-related questions. In summer 2020, we got a request for analyzing how COVID-19 testing centers are distributed across the state so as to inform where more resources may be needed. I created a series of maps visualizing the nearest distance (by travel duration/network distance and linear distance) between random points across the state and COVID-19 testing facilities. I created maps for the entire state, as well as specific regions across the state. 


## Method   

I designated all federally qualified health centers in Minnesota as testing centers. Many of these health centers were already in the testing center dataset but might have slight variations in the site name or address. To keep things simple, I appended the federally qualified health centers to the testing center dataset.

Both distance and estimated duration were calculated using the same method. I generated a 0.5 square mile hexagon grid over the entire state and then chose a random point within each hex. I calculated the network distance and estimated travel duration from the point to the three nearest (by linear distance) testing centers. Rather than calculating distance from all 300+ testing centers, I narrowed it down to just the three nearest to reduce computing time. Of those three nearest centers, I found the shortest possible distance in miles and shortest possible travel duration in minutes and applied that to the entire hexagon. 

Distance and estimated duration were calculated using Open Source Routing Machine (OSRM), a well-established open source project which utilizes OpenStreetMap (OSM) road network data. OSM is crowd-sourced but has proven very reliable and accurate in academic studies and is used for a variety of applications across public and private sectors, including several projects at the Council. OSRM is cited as “Copyright © Project OSRM contributors”. 

Note that this is an estimated general travel duration that does not consider congestion at different times of day, days of the week, weather conditions, roadway conditions, and other factors that affect travel time. 


## Minnesota region-specific maps  

{{< gallery album="png" >}}

