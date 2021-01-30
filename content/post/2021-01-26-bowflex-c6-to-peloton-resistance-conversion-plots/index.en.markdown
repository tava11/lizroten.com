---
title: Bowflex C6 to Peloton resistance conversion plot
author: Liz Roten
date: '2021-01-26'
slug: bowflex-c6-to-peloton-resistance-conversion-plots
categories: 
  - tutorial
tags:
  - ggplot2
  - peloton
  - personal
subtitle: 'Accepting my spin bike obsession'
summary: ''
authors: [admin]
lastmod: '2021-01-26T19:48:04-06:00'
featured: no
image:
  caption: ''
  focal_point: Top
  preview_only: no
projects: []
---



Around the holidays, my partner and I decided to bring a stationary exercise bike into our home. After many pros and cons lists, we opted for the [Bowflex C6](https://www.bowflex.com/bikes/c6/100894.html). I decided to try out this whole [Peloton](https://www.onepeloton.com/) thing, and quickly found that the resistance adjustments are not equivalent between the Peloton bike and the C6. Thankfully, there is a wonderful [subreddit](https://www.reddit.com/r/SchwinnIC4_BowflexC6/) just for this model! The folks there directed me to this [conversion chart](https://www.reddit.com/r/pelotoncycle/wiki/index/resistancechart), which then led me to a [3D-printed plate](https://www.etsy.com/listing/940670883/schwinn-ic4-exercise-bike-resistance?ref=hp_opfy-3&frs=1&bes=1) to keep on my handlebars. 


As I kept going along in my classes, all I could think was "What does this look like on a plot? What is the distribution?" Here is the result. 


```r

## load packages
library(dplyr)
library(tidyr)
library(ggplot2)

## theme and Peloton(c) red
source("theme.R")
pelo_red <- "#df1c2f"
```


Create data table.  


```r
conv_table <- tibble(C6 = c(0, 5, 9, 17, 25, 33, 49, 100),
       Peloton = c(0, 25, 30, 35, 40, 45, 50, 100),
       Difficulty = seq(from = 0, to = 10, length.out = 8 ))

conv_table_long <- conv_table %>% 
  gather(C6, Peloton, key = "Bike", value = "Resistance")
```

Make the plot.    


```r
plot <- ggplot(data = conv_table_long) +
  geom_smooth(mapping = aes(x = Difficulty,
                            y = Resistance,
                            color = Bike),
              se = FALSE) + 
  scale_color_manual(values = c("white",
                                pelo_red),
                     labels = c("Bowflex C6",
                                "Peloton")) +
  scale_x_continuous(n.breaks = 3,
                     labels = c("Easy",
                                "Hard",
                                "Impossible")) +
  labs(title = "Spin bike resistance",
       subtitle = "Peloton vs. Bowflex C6",
       x = "Difficulty",
       caption = "@LizRoten 2021 | Data r/pelotoncycle") +
  my_theme  
```
Display plot


```r
plot
```


![Final plot](featured.png)




