---
title: Finding the perfect sock pattern with {ravelRy}
author: admin
date: '2020-04-08'
slug: finding-the-perfect-sock-pattern-with-ravelry
categories:
  - tutorial
tags:
  - tidyverse
  - ggplot2
  - ravelry
subtitle: ''
toc: true
summary: "Using Ravelry's API to find just the right sock pattern"
authors: []
lastmod: '2020-10-30T17:47:26-05:00'
featured: no
image:
  caption: ''
  focal_point: Top
  preview_only: no
projects: []
---




I am a knitter. Knitting is a calming, fulfilling practice that keep my hands busy and require *just* enough brain power to keep my mind from wandering too far. Over the past winter, I conquered my fear of making socks, and now I profess that I am a sock knitter. I made socks for Christmas gifts, and churned out four pairs during my evenings, bus commutes, long work meetings, lectures, coffee and tea shop visits (basically everywhere). I'm comfortable with the standard stockinette sock, and I even ventured out into other patterns from Ravelry (_the_ social medium for yarn folks), like [Hermione's Everyday Socks](https://www.ravelry.com/patterns/library/hermiones-everyday-socks) and the [Slip It Simple Socks](https://www.ravelry.com/patterns/library/slip-it-simple-sock).  

But, even as the weather is warming here in Minnesota, working from home means that I don't have a commute and COVID-19 means that I have plenty of spare angst, so I've decided to make a new pair of socks, and work with a new pattern. 

And, just when I was starting to glaze over scrolling through endless Ravelry pages and reviews, I found [ravelRy](https://github.com/walkerkq/ravelRy), an R package that interfaces seamlessly with Ravelry's [API](https://www.ravelry.com/api). And its even on CRAN!  

Lets install, and get going!  


```r
install.packages("ravelRy")
```


```r
library(ravelRy)
library(tidyverse)
```


## Authentication    

As with most APIs, you need to authenticate somehow. I'll use my Ravelry account credentials (you'll need a [free, pro account](https://www.ravelry.com/pro/developer) to access the API).  


```r
ravelRy::ravelry_auth(key = "username")
ravelRy::ravelry_auth(key = "password")
```


## Search for a sock pattern!  

Lets start simple, and just look for the first 20 results for "sock" that are available as a Ravelry download.  


```r
search_result <- search_patterns(
  query = "sock",
  page_size = 20,
  craft = "knitting", # knitting or crochet
  fit = "adult", # adult, baby, etc.
  ravelry_download = TRUE
)

head(search_result)
#> # A tibble: 6 x 7
#>   free       id name      permalink   designer.id designer.name  pattern_sources
#>   <lgl>   <int> <chr>     <chr>             <int> <chr>          <list>         
#> 1 FALSE 1121082 Senbonza~ senbonzaku~       31024 Natalia Vasil~ <df[,59] [2 x ~
#> 2 FALSE 1105021 Curling ~ curling-mi~       32124 Helen Stewart  <df[,59] [2 x ~
#> 3 FALSE 1109817 Pink Lem~ pink-lemon~       72078 Amy Rapp       <df[,59] [2 x ~
#> 4 TRUE   891114 Rye Light rye-light         45502 tincanknits    <df[,59] [3 x ~
#> 5 TRUE   130787 Hermione~ hermiones-~       14789 Erica Lueder   <df[,59] [2 x ~
#> 6 TRUE   580119 Rose Cit~ rose-city-~       82613 Mara Catherin~ <df[,59] [1 x ~
```

The fourth result is even my old friend, "Hermione's Everyday Socks!"


```r
search_result[4, ] # get the fourth row in the table
#> # A tibble: 1 x 7
#>   free      id name      permalink designer.id designer.name pattern_sources   
#>   <lgl>  <int> <chr>     <chr>           <int> <chr>         <list>            
#> 1 TRUE  891114 Rye Light rye-light       45502 tincanknits   <df[,59] [3 x 59]>
```

Lets take a look at the actual pattern from the search results using `get_patterns()`.  


```r
hermione <- get_patterns(ids = search_result[4, ]$id)
str(hermione, max.level = 2)
#> tibble [1 x 50] (S3: tbl_df/tbl/data.frame)
#>  $ comments_count         : int 55
#>  $ created_at             : chr "2019/01/01 08:11:00 -0500"
#>  $ currency               : chr ""
#>  $ difficulty_average     : num 2.42
#>  $ difficulty_count       : int 771
#>  $ downloadable           : logi TRUE
#>  $ favorites_count        : int 14997
#>  $ free                   : logi TRUE
#>  $ gauge                  : num 32
#>  $ gauge_divisor          : int 4
#>  $ gauge_pattern          : chr "stockinette stitch with larger needles"
#>  $ generally_available    : chr "2018/12/01 00:00:00 -0500"
#>  $ id                     : int 891114
#>  $ name                   : chr "Rye Light"
#>  $ pdf_url                : chr ""
#>  $ permalink              : chr "rye-light"
#>  $ price                  : chr ""
#>  $ projects_count         : int 3564
#>  $ published              : chr "2018/12/01"
#>  $ queued_projects_count  : int 2125
#>  $ rating_average         : num 4.81
#>  $ rating_count           : int 797
#>  $ row_gauge              : num 46
#>  $ updated_at             : chr "2020/08/18 17:29:12 -0400"
#>  $ url                    : chr "http://tincanknits.com/pattern-SC-ryelight.html"
#>  $ yardage                : int 120
#>  $ yardage_max            : int 480
#>  $ personal_attributes    : chr ""
#>  $ sizes_available        : chr "Baby (Toddler, Child, Adult S, M, L)"
#>  $ product_id             : int 504649
#>  $ currency_symbol        : chr ""
#>  $ ravelry_download       : logi TRUE
#>  $ download_location      :List of 1
#>  $ pdf_in_library         : logi FALSE
#>  $ volumes_in_library     : chr ""
#>  $ gauge_description      : chr "32 stitches and 46 rows = 4 inches in stockinette stitch with larger needles"
#>  $ yarn_weight_description: chr "Fingering (14 wpi)"
#>  $ yardage_description    : chr "120 - 480 yards"
#>  $ pattern_needle_sizes   :List of 1
#>  $ notes_html             : chr "<hr /><hr />\n<h1 id=\"rye_light__by_tin_can_knits\"><strong>Rye Light</strong> - by Tin Can Knits</h1>\n<hr />"| __truncated__
#>  $ notes                  : chr "--------------------------------------------------------\r\n---------------------------------------------------"| __truncated__
#>  $ packs                  :List of 1
#>  $ printings              :List of 1
#>  $ yarn_weight            :List of 1
#>  $ craft                  :List of 1
#>  $ pattern_categories     :List of 1
#>  $ pattern_attributes     :List of 1
#>  $ pattern_author         :List of 1
#>  $ photos                 :List of 1
#>  $ pattern_type           :List of 1
str(hermione$pattern_attributes)
#> List of 1
#>  $ : tibble [16 x 2] (S3: tbl_df/tbl/data.frame)
#>   ..$ id       : int [1:16] 3 4 7 8 9 10 23 26 64 70 ...
#>   ..$ permalink: chr [1:16] "unisex" "baby" "toddler" "child" ...
```

I thought the Hermione sock was fairly straightforward. What is the average difficulty, on a scale of 1 to 10?  


```r
hermione$difficulty_count # how many reviews rated a difficulty?
#> [1] 771
hermione$difficulty_average # what is the average difficulty?
#> [1] 2.42153
```

Lets find my other sock pattern, Slip It Simple, and see what the difficulty rating is.


```r
slip_it_search <- search_patterns(query = "slip it simple sock")
```

Next, take the `id` column and feed it into  `get_patterns()`.  


```r
slip_it <- get_patterns(ids = slip_it_search$id)
```

What is our difficulty?  


```r
slip_it$difficulty_count
#> [1] 72
slip_it$difficulty_average
#> [1] 2.111111
```
There are fewer reviews, but the difficulty is super low.  

## Refining our search  

We can use the pattern table for `hermione` and `slip_it` to narrow our search further.   


```r
head(search_patterns(
  query = "sock",
  page_size = 20,
  craft = "knitting", # knitting or crochet
  fit = "adult", # adult, baby, etc.
  ravelry_download = TRUE,
  pattern_needle_sizes = 1,
  weight = "fingering", # yarn weight
  type = "sock",
  colors = 1
))
...
#> # A tibble: 6 x 7
#>   free       id name      permalink   designer.id designer.name  pattern_sources
#>   <lgl>   <int> <chr>     <chr>             <int> <chr>          <list>         
#> 1 FALSE 1121082 Senbonza~ senbonzaku~       31024 Natalia Vasil~ <df[,59] [2 x ~
#> 2 FALSE 1105021 Curling ~ curling-mi~       32124 Helen Stewart  <df[,59] [2 x ~
#> 3 FALSE 1109817 Pink Lem~ pink-lemon~       72078 Amy Rapp       <df[,59] [2 x ~
#> 4 TRUE   891114 Rye Light rye-light         45502 tincanknits    <df[,59] [3 x ~
#> 5 TRUE   130787 Hermione~ hermiones-~       14789 Erica Lueder   <df[,59] [2 x ~
...
```

Another trick is to go look at the URL when I am searching on Ravelry itself. This gives me an idea of what search terms I can add to `search_patterns()`.  


```r
refined_search <- search_patterns(
  query = "socks",
  pc = "mid-calf",
  page_size = 100,
  craft = "knitting", # knitting or crochet
  # fit = "adult", # adult, baby, etc.
  ravelry_download = TRUE,
  pattern_needle_sizes = 1,
  weight = "fingering", # yarn weight
  type = "sock",
  colors = 1,
  diff = "3.5%7C8",
  language = "en",
  sort = "projects",
  photo = "yes"
)
```


## Review refined search results  

Now that I've picked out 100 patterns to consider/make fun plots with, lets review them in more detail.  


```r
refined_patterns <- get_patterns(ids = refined_search$id) # this might take a while
```


To start plotting, I will import my theme and [`{dutchmasters}`](https://github.com/EdwinTh/dutchmasters).   


```r
source("my_sock_theme.R")
library(dutchmasters)
ggplot() +
  geom_density(refined_patterns,
    mapping = aes(
      x = comments_count,
      fill = free
    ),
    alpha = 0.7,
    color = "gray"
  ) +
  dutchmasters::scale_fill_dutchmasters(palette = "pearl_earring") +
  labs(
    title = "Pattern Comment Density",
    x = "Comment count",
    y = "Density",
    caption = my_caption
  ) +
  my_theme()
```

<img src="{{< blogdown/postref >}}index_files/figure-html/comment_density-1.png" width="672" />

Next, we'll make a density plot series comparing the average difficulty rating for each pattern attribute (check out [this example](https://github.com/walkerkq/ravelRy/blob/master/man/example_files/example_eda.md) for this plot's inspiration).   



```r
pattern_details_attributes <- refined_patterns %>%
  unnest(cols = "pattern_attributes", names_sep = "_")


top_attributes <- pattern_details_attributes %>%
  filter(difficulty_count >= 20) %>%
  count(pattern_attributes_permalink) %>%
  filter(n >= 20)

attributes_long <- pattern_details_attributes %>%
  filter(pattern_attributes_permalink %in% top_attributes$pattern_attributes_permalink) %>%
  mutate(pattern_attributes_permalink = stringr::str_to_title(pattern_attributes_permalink)) %>% 
  select(id, pattern_attributes_permalink, difficulty_average, rating_average)

plot_diff_by_att <- attributes_long %>%
  ggplot() +
  geom_density(aes(x = difficulty_average),
    fill = dutchmasters::dutchmasters$pearl_earring[4],
    color = "gray",
    outline.type = "full"
  ) +
  facet_grid(reorder(
    pattern_attributes_permalink,
    difficulty_average, median
  ) ~ .,
  switch = "y", scales = "free_y"
  ) +
  scale_x_continuous(limits = c(2, 7)) +
  labs(
    title = "Average difficulty rating by pattern attribute",
    # subtitle = "Sock knitting patterns",
    y = "", x = "Average difficulty",
        caption = my_caption

  ) +
  my_theme() +
  theme(
    panel.spacing.y = unit(0, "lines"),
    panel.grid = element_blank(),
    panel.grid.major.y = element_blank(),
    strip.text.y.left = element_text(angle = 0),
    strip.background = element_rect(fill = NA, color = NA),
    axis.text.y = element_blank())

plot_diff_by_att
```

<img src="{{< blogdown/postref >}}index_files/figure-html/plot_difficulty_by_attribute-1.png" width="768" />



## Narrow down results  

I want to use a pattern with high ratings and a high number of projects. What do these distributions look like?  


```r
library(cowplot)

project_count <- ggplot(data = refined_patterns) +
  geom_density(
    mapping = aes(x = projects_count),
    fill = dutchmasters::dutchmasters$pearl_earring[2],
    alpha = 0.8,
    color = "gray"
  ) +
  scale_x_continuous(labels = scales::comma) +
  labs(
    title = "Project Count",
    x = "Projects",
    y = ""
  ) +
  my_theme()

rating_count <- ggplot(data = refined_patterns) +
  geom_density(
    mapping = aes(x = rating_count),
    fill = dutchmasters::dutchmasters$pearl_earring[3],
    alpha = 0.8,
    color = "gray"
  ) +
  scale_x_continuous(labels = scales::comma) +
  labs(
    title = "Rating Count",
    x = "Ratings",
    y = "",
        caption = my_caption

  ) +
  my_theme()


cowplot::plot_grid(project_count, rating_count)
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-19-1.png" width="672" />

It looks like there is a big drop-off around 1,000 project and 500 ratings.  


```r
project_rating_patterns <- refined_patterns %>%
  filter(
    projects_count >= 1000,
    rating_count >= 500
  )
```

That `filter()` took us from 100 patterns to 11. Progress!  

Now, lets look at the ratings and difficulty. We will also separate these out by availability.


```r
ggplot(project_rating_patterns) +
  geom_point(
    mapping = aes(
      x = difficulty_average,
      y = rating_average,
      color = free
    ),
    size = 4
  ) +
  dutchmasters::scale_color_dutchmasters(palette = "pearl_earring") +
  labs(
    title = "Average Rating and Average Difficulty",
    x = "Average difficulty",
    y = "Average Rating",
    caption = my_caption
  ) +
  my_theme()
```

<img src="{{< blogdown/postref >}}index_files/figure-html/average_rating_avg_difficulty-1.png" width="672" />

Nothing too informative here. What are the top pattern attributes?  


```r
project_rating_patterns %>%
  unnest(cols = "pattern_attributes", names_sep = "_") %>%
  count(pattern_attributes_permalink) %>%
  filter(n > 5) %>%
  arrange(desc(n)) %>%
  ggplot() +
  geom_col(aes(
    x = pattern_attributes_permalink,
    y = n
  ),
  fill = dutchmasters::dutchmasters$pearl_earring[9]
  ) +
  labs(
    title = "Top pattern attributes",
    x = "Pattern attribute",
    y = "",
    caption = my_caption

  ) +
  my_theme()
```

<img src="{{< blogdown/postref >}}index_files/figure-html/top-pattern-attributes-1.png" width="672" />


Another thing that makes patterns easy to follow is if they are downloadable (as opposed to linked to another web page). Lets `filter()` for that, and have a difficulty at least above 4. 


```r
filter(
  project_rating_patterns, downloadable == TRUE,
  difficulty_average >= 4
) %>%
  arrange(-rating_average)
...
#>   comments_count                created_at currency difficulty_average
#> 1              8 2010/10/25 09:23:15 -0400      USD           4.252446
#> 2             27 2007/01/12 00:51:53 -0500      USD           4.903895
#> 3            131 2010/02/11 12:07:46 -0500                    4.434030
#> 4             22 2007/09/07 11:54:33 -0400                    4.520376
#>   difficulty_count downloadable favorites_count  free gauge gauge_divisor
#> 1              511         TRUE            4027 FALSE    32             4
#> 2             2362         TRUE           11155  TRUE     8             1
...
```

## Fetch images  

Now that we only have four left, lets fetch the images!  


```r
photo_links <- filter(
  project_rating_patterns, downloadable == TRUE,
  difficulty_average >= 4
) %>%
  unnest(cols = photos, names_sep = "_") %>%
  filter(photos_sort_order == 4) %>%
  select(id, name, photos_medium_url)
```

Next, we will use [`{imager}`](https://github.com/dahtah/imager) to fetch the data and plot it.  


```r
library(imager)
photo_links$name
#> [1] "Pointelle"   "Firestarter" "Pomatomus"   "Skew"

map(photo_links$photos_medium_url, load.image) %>%
  map(plot, axes = FALSE)
```

<img src="{{< blogdown/postref >}}index_files/figure-html/images-1.png" width="672" /><img src="{{< blogdown/postref >}}index_files/figure-html/images-2.png" width="672" /><img src="{{< blogdown/postref >}}index_files/figure-html/images-3.png" width="672" /><img src="{{< blogdown/postref >}}index_files/figure-html/images-4.png" width="672" />

```
#> [[1]]
#> Image. Width: 425 pix Height: 500 pix Depth: 1 Colour channels: 3 
#> 
#> [[2]]
#> Image. Width: 500 pix Height: 381 pix Depth: 1 Colour channels: 3 
#> 
#> [[3]]
#> Image. Width: 500 pix Height: 500 pix Depth: 1 Colour channels: 3 
#> 
#> [[4]]
#> Image. Width: 348 pix Height: 500 pix Depth: 1 Colour channels: 3
```

## And the winner is....  

[Pomatomus](https://www.ravelry.com/patterns/library/pomatomus)! I mean, look at those gorgeous waves!

![Pomatomus socks from the front](https://images4-f.ravelrycache.com/uploads/GoldenIris/304984815/webp/DSC_0135_medium2.webp#jpg)  

I have a lovely merino/nylon blend by [Sun Valley Fibers](https://www.instagram.com/sunvalleyfibers/) waiting for me. I hope you enjoyed this little journey!   

## Credits  

I followed along [this example](https://github.com/walkerkq/ravelRy/blob/master/man/example_files/example_eda.md) by the ravelRy package author, [Kaylin Pavlik](https://www.kaylinpavlik.com/). I used colors from [Edwin Thoen](https://edwinth.github.io/)'s R package,  [dutchmasters](https://github.com/EdwinTh/dutchmasters).  
