---
title: Regional Parks and the American Community Survey
summary: Progressing toward a more equitable use of regional parks
tags:
- Metropolitan Council
- parks
- shiny
- golem
- interactive
- visualization

date: "2021-02-05T00:00:00Z"

# Optional external URL for project (replaces project detail page).
external_link: ""

image:
  # caption: Photo by rawpixel on Unsplash
  focal_point: Smart

links:
- icon: desktop
  icon_pack: fa
  name: Live App
  url: https://metrotransitmn.shinyapps.io/regional-parks-acs/
url_code: "https://github.com/Metropolitan-Council/regionalparks.acs"
url_pdf: ""
url_slides: ""
url_video: ""
---

## Background

In May 2019, I completed an R Shiny app visualizing regional parks and trails in context with American Community Survey (ACS) demographic data. The project's first iteration was built as a mini-app to be used in workshop sessions with regional parks implementing agencies. Later, I re-structured the backend to follow the [`{golem}`](https://github.com/ThinkR-open/golem) framework


> Regional Parks and the American Community Survey is a mini-app designed for use by Regional Parks implementing agencies to assist in their progressing toward a more equitable use of regional parks. The app complements the Regional Parks Equity Toolkit, a set of questions and a process to clarify how regional park projects are advancing equity. The app facilitates direct examination of regional parks and trails system and the demographic characteristics of the census tracts surrounding them.


After I transitioned to my split between Community Development (CD) and Metropolitan Transportation Services (MTS) divisions, another team member took the project on. I supported that person in building skills in `{shiny}` and [`{golem}`](https://github.com/ThinkR-open/golem) and used GitHub to manage app enhancements and document workflow. 

Now, the app boasts a sophisticated modeling component, estimating the demographic characteristics of populations within a given distance, or buffer, from the park or trail. 


## Screenshots  



