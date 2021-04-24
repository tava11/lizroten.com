---
title: Square Lake Park Master Plan
summary: Utilizing aggregated LBS data to asses activity patterns within Square Lake Park and estimated visitor home location 
tags:
- Metropolitan Council
- StreetLight Data
- parks
- visualization
- static
- design
- illustrator

date: "2021-02-01T00:00:00Z"

# Optional external URL for project (replaces project detail page).
external_link: ""

image:
  caption: 'Liz Roten for Metropolitan Council, 2021'
  focal_point: Smart

links:
url_code: ""
url_pdf: "https://www.co.washington.mn.us/DocumentCenter/View/42051/Square-Lake-Park-Master-Plan---draft-412?bidId="
url_slides: ""
url_video: ""


# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references `content/slides/example-slides.md`.
#   Otherwise, set `slides = "2020.10.AMPO.StreetlightGHG"`.
slides: ""
featured: true

---

## Summary 

Square Lake Park Special Recreation Feature recently underwent a master plan update. I served on the technical advisory committee (TAC) and conducted a focused analysis estimating annual visitation and visitor activity within the park. I presented findings to Washington County staff and the entire TAC.  

### Overall visitation  

Square Lake Park has just one entrance and is surrounded by relatively low-traffic roads. I drew a gate over the park entrance and estimated the number of vehicles that pass through the gate using [StreetLight Volume](https://www.streetlightdata.com/). Then, I applied a persons-per-vehicle multiplier to estimate the number of visitors. I also used [StreetLight's](https://www.streetlightdata.com/) visitor home location metrics to estimate the spatial distribution of visitors.   

{{< figure src="visitor_home_metrics.PNG" caption="Liz Roten for Metropolitan Council, 2021" >}}


### Activity within the park  

To visualize visitor activity within the park, I generated a hexagon grid and ran [StreetLight](https://www.streetlightdata.com/) analyses for different trip intersection types. 

These maps visualize the activity within Square Lake Park on an average day during operating hours (6am - 10pm) in Summer 2019. Each map shows a grid of hexagons covering Square Lake Park. The hexagons are colored such that darker shades indicate greater activity, and lighter shades indicate lower activity. Each trip intersection type highlights the ways in which visitors enjoy the park. However, activity on Square Lake, such as paddling, boating, or using the fishing pier, is not detected.

{{% callout note %}}
View a higher resolution of this viz {{% staticref "docs/Hex map series.pdf" "newtab" %}}here{{% /staticref %}}
{{% /callout %}}


### StreetLight Data  

Data in this data visualization comes from [StreetLight Data](https://www.streetlightdata.com/), an independent data provider which cleans, processes and assimilates millions of spatial data points from a combination of mobile phone Location-Based Services (LBS) data and GPS data. The data is anonymized, aggregated, and accessed only through specific analyses. 


