---
title: Minimum distance to COVID-19 testing facilities
summary: 
tags:
- Metropolitan Council
- health
- cartography
- covid
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




## Method   

I designated all federally qualified health centers in Minnesota as testing centers. Many of these health centers were already in the testing center dataset but might have slight variations in the site name or address. To keep things simple, I appended the federally qualified health centers to the testing center dataset.

Both distance and estimated duration were calculated using the same method. I generated a 0.5 square mile hexagon grid over the entire state and then chose a random point within each hex. I calculated the network distance and estimated travel duration from the point to the three nearest (by linear distance) testing centers. Rather than calculating distance from all 300+ testing centers, I narrowed it down to just the three nearest to reduce computing time. Of those three nearest centers, I found the shortest possible distance in miles and shortest possible travel duration in minutes and applied that to the entire hexagon. 

Distance and estimated duration were calculated using Open Source Routing Machine (OSRM), a well-established open source project which utilizes OpenStreetMap (OSM) road network data. OSM is crowd-sourced but has proven very reliable and accurate in academic studies and is used for a variety of applications across public and private sectors, including several projects at the Council. OSRM is cited as “Copyright © Project OSRM contributors”. You can see the full license for OSRM here. 

The first zipped folder contains the network-based distance in miles analysis we discussed last week. To distinguish the methods used between these maps and the ones sent previously, I used a different color palette; the color changes from purple to white to orange as distance increases. I have included state-wide PDFs for the map and distance distribution, in addition to regional maps in PDF and PNG formats. 

The second zipped folder contains the same network analysis but displays the estimated travel duration to the nearest testing center or federally qualified health center. The color palette goes from green to white to pink as duration increases. Again, I have included state-wide PDFs for the map and duration distribution, in addition to regional maps in PDF and PNG formats. Note that this is an estimated general travel duration that does not consider congestion at different times of day, days of the week, weather conditions, roadway conditions, and other factors that affect travel time. 


## Minnesota region-specific maps  

{{< gallery album="png" >}}

