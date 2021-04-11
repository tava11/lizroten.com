---
title: Housing Density in US Cities
author: Liz Roten
date: '2020-02-15'
slug: housing-density-in-us-cities
categories:
  - tutorial
tags:
  - ggplot2
  - tutorial
  - spatial
  - maps
  - sf
  - R Markdown
subtitle: ''
summary: ''
disable_codefolding: true
toc: true
authors: []
lastmod: '2021-01-24T15:19:50-06:00'
featured: yes
image:
  caption: ''
  focal_point: Top
  preview_only: no
projects: []
---

<script src="{{< blogdown/postref >}}index.en_files/htmlwidgets/htmlwidgets.js"></script>
<script src="{{< blogdown/postref >}}index.en_files/jquery/jquery.min.js"></script>
<link href="{{< blogdown/postref >}}index.en_files/datatables-css/datatables-crosstalk.css" rel="stylesheet" />
<script src="{{< blogdown/postref >}}index.en_files/datatables-binding/datatables.js"></script>
<link href="{{< blogdown/postref >}}index.en_files/dt-core/css/jquery.dataTables.min.css" rel="stylesheet" />
<link href="{{< blogdown/postref >}}index.en_files/dt-core/css/jquery.dataTables.extra.css" rel="stylesheet" />
<script src="{{< blogdown/postref >}}index.en_files/dt-core/js/jquery.dataTables.min.js"></script>
<link href="{{< blogdown/postref >}}index.en_files/crosstalk/css/crosstalk.css" rel="stylesheet" />
<script src="{{< blogdown/postref >}}index.en_files/crosstalk/js/crosstalk.min.js"></script>

Since I got back from \#rstudioconf, I’ve started to warm up to the idea of sharing my code, even if it isn’t perfect. There may be typos, the blog post may be short, but sharing my work is beneficial for the greater \#rstats community, and supports open-source data science.

So this belated post is inspired by [Cities Start to Question an American Ideal: A House With a Yard on Every Lot](https://www.nytimes.com/interactive/2019/06/18/upshot/cities-across-america-question-single-family-zoning.html), in which the NY Times examines residential zoning patterns in different cities. Residential areas are split into two categories, single-family detached homes and all other housing such as townhomes, duplexes, and apartments. This is especially relevant given the current housing shortage across the US.

## Import data

First, lets import our packages.

``` r
# spatial packages 
library(sf)
library(geojsonsf)
library(rgdal)
library(lwgeom)

# data cleaning
library(dplyr)
library(janitor)
library(fuzzyjoin)
library(stringr)

# plotting
library(ggplot2)
library(showtext)
library(DT)
```

Next, lets import our data. `read_sf()` is super useful here, because it will read in an `sf` object from a link to the spatial file we want. In this case, the link comes from each city’s open data portal

When you go to the data portal and find the dataset you want, right click the link to download the GeoJSON and copy the link. Then, paste it into `read_sf()` and you’re good to go! Say goodbye to massive data folders!

For this post, I’ve chosen (somewhat randomly) [Pittsburgh, PA](https://data.wprdc.org/dataset/zoning1), [Austin, TX](https://data.austintexas.gov/Locations-and-Maps/Land-Use-Inventory-Detailed/fj9m-h5qy), and [Boston, MA](https://data.boston.gov/dataset/zoning-subdistricts).

``` r
pitts <- read_sf("http://pghgis-pittsburghpa.opendata.arcgis.com/datasets/e67592c2904b497b83ccf876fced7979_0.geojson")

boston <- read_sf("http://bostonopendata-boston.opendata.arcgis.com/datasets/b601516d0af44d1c9c7695571a7dca80_0.geojson?outSR={%22latestWkid%22:2249,%22wkid%22:102686}")

austin <- read_sf("https://data.austintexas.gov/api/geospatial/5rzy-nm5e?method=export&format=GeoJSON")
```

Here is the styling I’m using on the maps.

``` r
showtext_auto()

font_add("Lato", "Lato-Regular.ttf")
font_add("Open Sans Light", "OpenSans-Light.ttf")
font_add("PT Sans", "PTSans-Regular.ttf")
font_add("PT Serif", "PTSerif-Regular.ttf")


## font sizes --------------------------------------------
size_header <- 14*3.4
size_subtitle <- 12*3.4
size_axis_title <- 12*3.4
size_legend_title <- 12*3.4
size_axis_text <- 8*3.4
size_legend_text <- 8*3.4
size_caption <- 6*3.4

## color -------------------------------------------------
background_color <- "#ffffff"

blue <- "#66b2a9"
pink <- "#dd2292"

my_colors <- c(
  "#9BABBF",
  "#8C694A",
  "#6C733C",
  "#D9B991"
)
## theme function -----------------------------------------
my_theme <- function(...) {
  theme_void() +
    theme(
      ### plot and panel-----------------------------------
      plot.background = element_rect(
        fill = background_color,
        linetype = 0,
        colour = NA
      ),
      panel.background = element_rect(
        fill = background_color,
        linetype = 0,
        color = NA
      ),
      panel.grid = element_blank(),
      plot.margin = margin(rep(10, 4), unit = "pt"),
      panel.border = element_blank(),
      ### title and caption -------------------------------
      title = element_text(family = "PT Serif",
                           size = size_header),
      plot.caption = element_text(size = size_caption),
      # plot.caption.position = "plot",
      ### axis and strip text ------------------------------
      strip.text = element_blank(),
      axis.title = element_text(size = size_axis_title),
      axis.text = element_blank(),
      ## legend text ----------------------------------------
      legend.text = element_text(
        family = "Open Sans Light",
        size = size_legend_text
      )
      # legend.position = "bottom"
    )
}
```

## Investigate cities

### Pittsburgh

So, what are our column names?

``` r
names(pitts)
```

    ##  [1] "objectid"         "area"             "perimeter"        "zoning_"         
    ##  [5] "zoning_id"        "zon_new"          "shape_leng"       "correctionlabel" 
    ##  [9] "full_zoning_type" "legendtype"       "municode"         "status"          
    ## [13] "created_user"     "created_date"     "last_edited_user" "last_edited_date"
    ## [17] "Shape__Area"      "Shape__Length"    "geometry"

We are most interested in the “legendtype” column.

``` r
unique(pitts$legendtype)
```

    ##  [1] "Parks"                            "Local Neighborhood Commercial "  
    ##  [3] "Highway Commercial"               "Single-Unit Detached Residential"
    ##  [5] "Urban Industrial"                 "Planned Unit Development"        
    ##  [7] "Neighborhood Industrial"          "Two-Unit Residential"            
    ##  [9] "Multi-Unit Residential"           "Hillside  "                      
    ## [11] "Single-Unit Attached Residential" "Mount Oliver Borough"            
    ## [13] "Three-Unit Residential"           "General Industrial  "            
    ## [15] "Oakland Public Realm"             "Specially Planned"               
    ## [17] "Golden Triangle "                 "Neighborhood Office"             
    ## [19] "Educational/Medical Institution"  "Urban Neighborhood Commercial"   
    ## [21] "Grandview Public Realm"           "Uptown Public Realm"             
    ## [23] "Riverfront"

These are useful descriptions! We will re-code them into three categories: single-family detached, not single-family detached, and non-residential.

``` r
pitts_clean <- pitts %>% 
  rowwise() %>% 
  mutate(zone_simple = if(legendtype %in% c("Single-Unit Attached Residential",
                                            "Two-Unit Residential", 
                                            "Three-Unit Residential",
                                            "Multi-Unit Residential")){
    zone_simple = "non_sfd"
  } else if (legendtype == "Single-Unit Detached Residential"){
    zone_simple = "sfd"
  } else {
    zone_simple = "non_res"
  }) %>% 
  st_as_sf()
```

Now for the map!

For the caption, we can take advantage of the “last\_edited\_date” column and automatically put in the correct date!

``` r
ggplot() +
  geom_sf(data = pitts_clean,
          aes(fill = zone_simple),
          color = "#C8C8C8",
          size = 0.2,
          alpha = 0.5) +
  labs(title = "Pittsburgh",
       subtitle = "Residential zoning",
       fill = "",
       caption = paste("@LizRoten | City of Pittsburgh,",
                       lubridate::year(pitts_clean$last_edited_date))) + 
  my_theme() +
  scale_fill_manual(values = c("whitesmoke", blue, pink),
                    labels = c("Non-residential",
                               "Non-single family",
                               "Single family")) 
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/unnamed-chunk-7-1.png" width="672" />

This map looks like its missing something, so I’m going to add in [hydrology features.](https://data.wprdc.org/dataset/allegheny-county-hydrology-areas)

``` r
# import "Allegheny County Hydrology Areas" 

pitt_water <- read_sf("http://openac-alcogis.opendata.arcgis.com/datasets/9ff3941e47f74c609057cb60f4992852_0.geojson") %>% 
  sf::st_make_valid() %>% 
  st_intersection(sf::st_make_valid(pitts)) # instersect with city limits
```

``` r
ggplot() +
  geom_sf(data = pitts_clean,
          aes(fill = zone_simple),
          color = "#C8C8C8",
          size = 0.2,
          alpha = 0.5) +
  labs(title = "Pittsburgh",
       subtitle = "Residential zoning",
       fill = "",
       caption = paste("@LizRoten | City of Pittsburgh,",
                       format(pitts_clean$last_edited_date, "%Y"))) + 
  my_theme() +
  scale_fill_manual(values = c("whitesmoke", blue, pink),
                    labels = c("Non-residential",
                               "Non-single family",
                               "Single family")) +
  geom_sf(data = pitt_water,
          fill = "lightblue", 
          color = "NA")
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/unnamed-chunk-9-1.png" width="672" />

### Austin

Lets look at the column names for Austin.

``` r
names(austin)
```

    ##  [1] "created_by"    "shape_area"    "created_date"  "zoning_ztype" 
    ##  [5] "objectid"      "shape_length"  "modified_by"   "modified_date"
    ##  [9] "zoning_id"     "geometry"

Next, we can look at “zoning\_ztype.”

``` r
head(unique(austin$zoning_ztype))
```

    ## [1] "SF-2-CO"  "SF-3-NP"  "MF-2-NP"  "PUD"      "GR"       "CS-MU-NP"

YIKES. Looks like we need a data dictionary.

I would love to say that I elegantly extracted the zoning codes from the [city’s website](http://www.austintexas.gov/page/zoning-districts), but I ended up copying the HTML table to Excel and manipulating the columns from there. The text-to-columns tool is very useful fo instances like this. I also added codes “SF-4” and “MF,” which weren’t explicitly provided.

``` r
austin_desc <- read.csv("data/zoning_descriptions.csv") %>% 
  clean_names()

DT::datatable(austin_desc, rownames = FALSE)
```

<div id="htmlwidget-1" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-1">{"x":{"filter":"none","data":[["LA","SF-4B","MF-1","MF-4","MH","MF-2","GO","GR","DMU","CS-1","MI","DR","PUD","NBG","MF-5","SF-6","MF-3","MF-6","MF","NO","CR","L","W/LO","CH","LI","AV","P","ERC","SF-2","RR","SF-3","SF-5","SF-1","SF-4","LO","LR","CBD","CS","IP","R&amp;D","AG","TOD","TND","CO","NCCD","CVC","PDA","WO","MU","CURE","CDZ","CAZ","PSZ","DPZ","DCZ","SF-4A"],["Lake Austin Residence   ","Single Family Residence - Condominium ","Multi-Family Residence - Limited Density ","Multi-Family Residence - Moderate-High Density ","Mobile Home Residence   ","Multi-Family Residence - Low Density ","General Office    ","Community Commercial    ","Downtown Mixed Use   ","Commercial-Liquor Sales    ","Major Industry    ","Development Reserve    ","Planned Unit Development   ","North Burnet/Gateway District   ","Multi-Family Residence - High Density ","Townhouse &amp; Condominium Residence  ","Multi-Family Residence - Medium Density ","Multi-Family Residence - Highest Density ","Multifamily Residence","Neighborhood Office    ","Commercial Recreation    ","Lake Commercial    ","Warehouse Limited Office   ","Commercial Highway    ","Limited Industrial Services   ","Aviation Services    ","Public     ","East Riverside Corridor   ","Single Family Residence - Standard Lot","Rural Residence    ","Family Residence    ","Urban Family Residence   ","Single Family Residence - Large Lot","Single Family Residence","Limited Office    ","Neighborhood Commercial    ","Central Business District   ","General Commercial Services   ","Industrial Park    ","Research and Development   ","Agricultural     ","Transit-Oriented Development    ","Traditional Neighborhood District   ","Conditional overlay","Neighborhood Conservation Combining District ","Capitol View Corridor Combining District ","Planned Development Area Combining District","Waterfront Overlay Combining District","Mixed Use","Central Urban Redevelopment","Capitol Dominance Combining District","Congress Avenue Combining District","Sixth/Pecan Street Combining District","Downtown Parks Combining District","Downtown Creeks Combining District","Single Family Residence - Small Lot"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>code<\/th>\n      <th>description<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

We are going to break up Austin into two separate datasets: one with residential zones, and the other with non-residential zones.

We will join our spatial data with the code descriptions using “zoning\_ztype,” then add a column for residential zoning type using `str_detect()`.

``` r
austin_w_desc <- left_join(austin, 
                           austin_desc,
                           by = c("zoning_ztype" = "code"))

austin_coded <- austin_w_desc %>% 
  group_by(objectid) %>% 
  mutate(residence_zone = # detect key character sequences and add 
           case_when(stringr::str_detect(zoning_ztype, "SF") ~ "Single family",
                     stringr::str_detect(zoning_ztype, "MH") ~ "Non-single family",
                     stringr::str_detect(zoning_ztype, "MF") ~ "Non-single family",
                     stringr::str_detect(zoning_ztype, "LA") ~ "Non-single family",
                     stringr::str_detect(zoning_ztype, "RR") ~ "Non-single family",
                     TRUE ~ "Non-residential"))
```

Now, lets map it! I adjusted the fill color for non-residential zones because the scale is much smaller than Pittsburgh.

``` r
ggplot()  +
  geom_sf(data = austin_coded,
          mapping = aes(fill = residence_zone),
          color = NA,
          alpha = 0.5) +
  scale_fill_manual(values = c("snow3", blue, pink),
                    labels = c("Non-residential",
                               "Non-single family",
                               "Single family")) +
  labs(title = "Austin",
       subtitle = "Residential zoning",
       fill = "",
       caption = paste("@LizRoten | City of Austin,",
                       format(austin_coded$modified_date, "%Y"))) +
  my_theme()
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/unnamed-chunk-14-1.png" width="672" />

### Boston

Lets check our column names.

``` r
names(boston) 
```

    ##  [1] "OBJECTID"         "ZONE_"            "DISTRICT"         "MAPNO"           
    ##  [5] "ARTICLE"          "SUBDISTRIC"       "Unique_Code"      "FAR"             
    ##  [9] "Shape_STArea__"   "Shape_STLength__" "Zone_Desc"        "geometry"

And then the “Zone\_Desc” column.

``` r
head(unique(boston$Zone_Desc))
```

    ## [1] "Community Commercial"          "Waterfront Manufacturing"     
    ## [3] "Restricted Manufacturing"      "Neighborhood Development Area"
    ## [5] "Local Industrial"              "Waterfront Commercial"

HA! Sweet, sweet human-readable descriptions!

To make things a little easier, we can break out the entire dataset into residential and non-residential groups, and then `rbind()` them back together.

``` r
boston_res <- boston %>% 
  filter(SUBDISTRIC == "Residential") %>% 
  rowwise() %>% 
  mutate(category = if(Zone_Desc == "One-Family Residential"){
    category = "Single Family"
  } else {
    category = "Non-single family"
  }) %>% 
  st_as_sf()
```

Now create the non-residential and bind the two back together.

``` r
boston_non_res <- boston %>% 
  filter(SUBDISTRIC != "Residential", 
         SUBDISTRIC != "Open Space", # remove primarily water features
         DISTRICT != "Boston Harbor",
         DISTRICT != "Harborpark: Dorchester Bay/Neponset River Waterfront") %>% 
  mutate(category = "Non-residential")


boston_all <- rbind(boston_res, boston_non_res)
```

Finally, map!

``` r
ggplot()  +
  geom_sf(data = boston_all,
          mapping = aes(fill = category),
          color = "#c8c8c8",
          size = 0.1, 
          alpha = 0.5) +
  scale_fill_manual(values = c("snow3", blue, pink),
                    labels = c("Non-residential",
                               "Non-single family",
                               "Single family")) +
  labs(title = "Boston",
       subtitle = "Residential zoning",
       fill = "",
       caption = "@LizRoten | City of Boston, 2020") +
  my_theme()
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/unnamed-chunk-19-1.png" width="672" />
