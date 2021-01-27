
library(showtext)
showtext_auto()
file <- sysfonts::font_files()

font_add("Agency FB", "AGENCYR.TTF")
font_add("LeelawadeeUI-Semilight", "LeelUIsl.ttf")
font_add("Lato", "Lato-Regular.ttf")
font_add("Open Sans Light", "OpenSans-Light.ttf")
font_add("Open Sans Light Italic", "OpenSans-LightItalic.ttf")
font_add("PT Sans", "PTSans-Regular.ttf")
font_add("PT Serif", "PTSerif-Regular.ttf")

## font sizes --------------------------------------------
size_header <- 14* 3.4
size_axis_title <- 12 * 3.4
size_legend_title <- 12* 3.4
size_axis_text <- 8* 3.4
size_legend_text <- 8* 3.4
size_caption <- 6* 3.4


## font classes -----------------------------------------
font_title <- "Lato"
font_legend <- "Open Sans Light"

## color -------------------------------------------------

## theme  -----------------------------------------
my_theme <- theme_minimal() +
  theme(
    # text = element_text(color = "white"),
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
    ### axis and strip text ------------------------------
    strip.text = element_text(size = size_axis_text),
    axis.title = element_text(size = size_axis_title),
    axis.text = element_text(size = size_axis_text),
    plot.margin = unit(c(.5, .5, .2, .5), "cm"),
    ## legend text ----------------------------------------
    legend.position = "right",
    legend.text = element_text(
      family = font_legend,
      size = size_legend_text,
      color = "white"
    )
  )

line_color <- "#843A4B"
