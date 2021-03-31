---
title: '3 Years of Mental Health: A quantified-self story'
summary: 'Mapping my travel patterns and mental health from 2015-2017'
author: Liz Roten
date: '2017-10-30'
slug: 3-years-of-mental-health-a-quantified-self-story

categories:
  - cartography
tags:
- arcgis
- ggplot2
- design
- illustrator
- personal
- shiny
subtitle: 'Mapping my travel patterns and mental health from 2015-2017'
lastmod: '2021-01-24T15:10:18-06:00'
featured: yes
image:
  caption: 'Liz Roten, 2021'
  focal_point: Top
  preview_only: no
# projects: ["emoods-blog-post"]
reading_time: false


links:
- icon: file
  icon_pack: fa
  name: PDF
  url: https://lizroten.com/docs/svp_final.pdf
- icon: desktop
  icon_pack: fa
  name: Live App
  url: https://eroten.shinyapps.io/01_shiny/
- icon: external-link-alt
  icon_pack: fa
  name: eMoods Blog Post
  url: https://emoodtracker.com/blog/how-emoods-aided-my-recovery-and-inspired-my-data-science-career
  
url_code: ""
url_pdf: ""
url_slides: ""
url_video: ""
---


{{% callout note %}}
View a higher resolution of this viz {{% staticref "docs/svp_final.pdf" "newtab" %}}here{{% /staticref %}}
{{% /callout %}}


## About the Process   

I use [eMoods](https://emoodtracker.com/) to track my mental health from day to day. For this viz, I used eMoods data, as well as my Google Location History data, to display my life between February 2015 and October 2017. I used ggplot2 in R Studio to generate the radial bar charts on the far rights, and Adobe Illustrator to construct the bar graphs in the bottom left corner. For the heatmaps, I first attempted to use ArcGIS to view data I downloaded from my Google account directly but quickly found that software to be limiting for the goals of this project  I forked and modified [Location History Visualizer](https://locationhistoryvisualizer.com/heatmap/) using JavaScript, HTML, and CSS to use my own color scheme and preferred base map.  I assembled the images in Adobe Illustrator and presented this work for my class.

I worked with geospatial data in formats I was unfamiliar with, such as KML, JSON, and tar.gz zipped files. I also had no prior experience in Adobe Illustrator, JavaScript, HTML, and CSS. This piece not only demonstrates my skill in these areas but also my persistence and commitment to telling my story.

During my Spring 2018 independent project, I also used R Shiny to take a simple, interactive look at the polar coordinate bar graphs. You can see this app on its own [here](https://eroten.shinyapps.io/independentFP) and the updated version [here](https://eroten.shinyapps.io/01_shiny/).  
