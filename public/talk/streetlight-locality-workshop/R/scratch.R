# Mapping home block groups  

---
  
  # Get block groups for a state  
  
  First, import all block groups in Minnesota.  

```{r, results = "hide"}
library(tigris)

mn_bg <- tigris::block_groups(state = "MN",
                              class = "sf")
```

--
  
  Next, clean and join the StreetLight data

```{r, warning = FALSE}
library(dplyr)
library(ggplot2)

nokomis <- home_block_group_traffic %>% 
  dplyr::filter(zone_name == "Nokomis-Hiawatha",
                day_part == "0: All Day (12am-12am)",
                day_type == "0: All Days (M-Su)") %>% 
  mutate(traffic_value = round(as.numeric(average_daily_zone_traffic_st_l_index)
                               * as.numeric(percent_by_home_location), digits = 0)) %>% 
  inner_join(mn_bg, by = c("block_group_id" = "GEOID")) %>% 
  st_as_sf()
```
---
  
  # Map block groups  
  
  wow  

.left-code[
  
  ```{r, first-plot, fig.show = "hide", out.width = "60%", fig.asp = 0.7, out.height = "60%"}
  ggplot() +
    geom_sf(data = nokomis,
            mapping = aes(fill = NULL))
  ```
  ]

.right-plot[
  ![](`r knitr::fig_chunk("first-plot", "png")`)  
  
  ]
---
  
  # Map prettier block groups  
  
  ```{r, out.width = "60%", fig.asp = 0.7, out.height = "60%"}
ggplot() +
  geom_sf(data = nokomis,
          mapping = aes(fill = traffic_value/1000))
```


---
  
  # Change up style  
  
  
  .pull-left[
    
    ```{r pretty-map, fig.show="hide"}
    ggplot() +
      geom_sf(data = nokomis,
              mapping = aes(fill = traffic_value/1000),
              color = NA) +
      scale_fill_viridis_c(name = "Relative\nvisitation",
                           labels = scales::comma,
                           option = "E") +
      theme_minimal() + 
      labs(title = "Nokomis-Hiawatha Visitor Home Block Groups")
    ```
    
    ]  

.pull-right[
  
  ![](`r knitr::fig_chunk("pretty-map", "png")`)  
  
  ]  

---
  
  # Zoom in on Minneapolis  
  
  ```{r, results = "hide", warning = FALSE}
minneapolis <- tigris::places(state = "MN",
                              class = "sf") %>%
  dplyr::filter(NAME == "Minneapolis") %>% 
  sf::st_transform("+proj=longlat +datum=WGS84") 

nokomis_close <- nokomis %>% 
  sf::st_transform("+proj=longlat +datum=WGS84") %>% 
  sf::st_intersection(minneapolis)

```

---
  
  # Map Minneapolis   
  
  
  look  

.left-code[
  ```{r nokomis-minn, fig.show = "hide"}
  ggplot() +
    geom_sf(data = nokomis_close,
            mapping = aes(fill = traffic_value/1000),
            color = NA) +
    scale_fill_viridis_c(name = "Relative\nvisitation",
                         labels = scales::comma,
                         option = "E") +
    theme_minimal() + 
    theme(
      plot.background = element_rect(fill = "transparent", color = NA),
      panel.background = element_rect(fill = "transparent", color = NA), # bg of the panel
    ) +
    labs(title = "Where do park visitors live?",
         subtitle = "Visitor home block groups for Nokomis-Hiawatha Regional Park")
  ```
  ]    


.right-plot[
  ![](`r knitr::fig_chunk("nokomis-minn", "png")`)  
  ]



---
  
  
