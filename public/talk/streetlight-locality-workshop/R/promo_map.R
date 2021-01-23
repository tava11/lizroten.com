library(sf)
library(RColorBrewer)
library(leaflet)
library(rgdal)
library(dplyr)
library(janitor)
library(ggplot2)
library(tigris)

options()
## data ----
como <- rgdal::readOGR("data/workshop_data/104606_Regional_Parks_Summer_2018_HW_workshop_zone_activity/104606_Regional_Parks_Summer_2018_HW_workshop_zone_activity.shp") %>% 
  st_as_sf() %>% 
  st_transform("+proj=longlat +datum=WGS84") %>% 
  filter(name == "Como") %>% 
  st_simplify()

st_paul <- tigris::places(state = "MN", class = "sf") %>% 
  filter(NAME == "St. Paul") %>% 
  st_transform("+proj=longlat +datum=WGS84") 

mn_block_groups <- tigris::block_groups(state = "MN",
                                        class = "sf")  %>% 
  st_transform("+proj=longlat +datum=WGS84") %>% 
  sf::st_intersection(st_paul)
# filter(COUNTYFP %in% c(#"053",
#                        "123")) #,
#                        # "003",
#                        # "163",
#                        # "037",
#                        # "013",
#                        # "139"))




home_block_group_traffic <- read.csv("data/workshop_data/104606_Regional_Parks_Summer_2018_HW_workshop_home_block_groups_all.csv") %>% janitor::clean_names() %>% 
  filter(zone_name == "Como",
         day_type == "0: All Days (M-Su)",
         day_part == "0: All Day (12am-12am)",
         intersection_type == "Trip End") %>% 
  left_join(mn_block_groups, 
            by = c("block_group_id" = "GEOID")) %>% 
  group_by(block_group_id) %>% 
  mutate(traffic_value = round(as.numeric(average_daily_zone_traffic_st_l_index) * as.numeric(percent_by_home_location), digits = 0)/10) %>% 
  st_as_sf() %>% 
  st_transform("+proj=longlat +datum=WGS84") 

# styling -----

library(showtext)
showtext::showtext_auto()

font_add("Lato", "Lato-Regular.ttf")
font_add("Open Sans Light", "OpenSans-Light.ttf")
font_add("PT Sans", "PTSans-Regular.ttf")
font_add("PT Serif", "PTSerif-Regular.ttf")


## font sizes --------------------------------------------
size_header <- 36
size_subtitle <- 26
size_axis_title <- 24
size_legend_title <- 24
size_axis_text <- 20
size_legend_text <- 20
size_caption <- 14
line_height_size <- 0.4

## color -------------------------------------------------
background_color <- "ghostwhite"

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
      plot.margin = unit(c(.5, .5, .2, .5), "cm"),
      panel.border = element_blank(),
      ### title and caption -------------------------------
      plot.title = element_text(family = "PT Serif",
                                size = size_header),
      plot.subtitle = element_text(family = "PT Serif",
                                   size = size_subtitle),
      plot.caption = element_text(size = size_caption,
                                  hjust = 0,
                                  family = "Open Sans Light",
                                  lineheight = line_height_size,
                                  margin = margin(t = 0.2,
                                                  r = 0.2,
                                                  b = 0.2,
                                                  l = 0.2)),
      ### axis and strip text ------------------------------
      strip.text = element_blank(),
      
      axis.title = element_text(size = size_axis_title,
                                lineheight = line_height_size),
      axis.text = element_blank(),
      ## legend text ----------------------------------------
      legend.text = element_text(
        family = "Open Sans Light",
        lineheight = line_height_size,
        size = size_legend_text
      ),
      legend.title = element_text(
        family = "PT Serif",
        lineheight = line_height_size,
        size = size_legend_title,
        margin = margin(t = 0.2,
                        r = 0.2,
                        b = 0,
                        l = 0.2)
      )
    )
}

# ggplot -----

promo_map <- ggplot() +
  geom_sf(data = home_block_group_traffic,
          color = NA,
          alpha = 0.9,
          mapping = aes(fill = traffic_value/1000)) +
  # geom_sf(como, mapping = aes(fill = NULL),
  #         alpha = 0,
  #         color = "gainsboro") +
  scale_fill_viridis_c(name = "Relative\nvisitation",
                       labels = scales::comma,
                       option = "E") +
  geom_sf(data = como, 
          mapping = aes(fill = NULL),
          color = "white",
          fill = "gray",
          alpha = 0.5) +
  annotate("text",
           label = stringr::str_wrap("Using aggregated location-based services (LBS) 
                                     data, we can visualize areas in St. Paul where park visitors reside.",
                                     width = 40),
           x = -93.08, y = 44.8999, vjust = -0.2, hjust = "center",
           lineheight = line_height_size,
           family = "Open Sans Light",
           size = 8) +
  labs(title = "Where do park visitors live?",
       subtitle = "Visitor home block groups for Como Regional Park",
       caption = stringr::str_wrap("StreetLight Data, Summer 2018,
                                   Sample includes all trips ending in the park.
                                   Liz Roten for Metropolitan Council, 2020-03", 
                                   width = 35),
       x = "",
       y = "") +
  my_theme()

ggsave(promo_map, filename = "img/promo_map.png", type = "cairo",
       dpi = 300)

