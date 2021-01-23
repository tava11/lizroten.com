
library(showtext)
showtext_auto()
file <- sysfonts::font_files()

font_add("Agency FB", "AGENCYR.TTF")
font_add("LeelawadeeUI-Semilight", "LeelUIsl.ttf")

## font sizes --------------------------------------------
size_header <- 14* 3.4
size_axis_title <- 12 * 3.4
size_legend_title <- 12* 3.4
size_axis_text <- 8* 3.4
size_legend_text <- 8* 3.4
size_caption <- 6* 3.4


## color -------------------------------------------------

## theme function -----------------------------------------
my_theme <- theme_void() +
  theme(
    plot.background = element_rect(fill = "black",
                                   linetype = 0,
                                   color = NA),
    panel.background = element_rect(
      fill = "black",
      linetype = 0,
      color = NA
    ),
    plot.title = element_text(family = "Agency FB",
                              color = "white",
                              size = size_header),
    plot.caption = element_text(
      family = "LeelawadeeUI-Semilight",
      color = "white",
      size = size_caption
    ),
    plot.subtitle = element_text(
      color = "white"
    ),
    plot.margin = unit(c(.5, .5, .2, .5), "cm"),
  )

line_color <- "#843A4B"
