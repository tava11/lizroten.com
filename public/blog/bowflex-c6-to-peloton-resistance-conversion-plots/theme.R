
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
font_add("Martel ExtraBold", "Martel-ExtraBold.ttf")
font_add("Martel Regular", "Martel-Regular.ttf")


## font sizes --------------------------------------------
size_header <- 18* 3.4
size_axis_title <- 14 * 3.4
size_subtitle <- 16 * 3.4
size_legend_title <- 12* 3.4
size_axis_text <- 11* 3.4
size_legend_text <- 11* 3.4
size_caption <- 7* 3.4


## font classes -----------------------------------------
font_title <- "Martel ExtraBold"
font_legend <- "Open Sans Light"
font_default <- "Open Sans Light"
font_subtitle <- "Martel Regular"

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
    plot.title.position = "plot",
    plot.title = element_text(family = font_title,
                              color = "white",
                              size = size_header,
                              margin = margin(rep(5,4), unit = "pt")
                              ),
    plot.caption = element_text(
      family = font_default,
      color = "white",
      size = size_caption
    ),
    plot.caption.position = "plot",
    plot.subtitle = element_text(
      color = "white",
      size = size_subtitle,
      family = font_subtitle,
      margin = margin(5, 5, b = 20, 5, unit = "pt"),
    ),
    ### axis and strip text ------------------------------
    strip.text = element_text(size = size_axis_text),
    axis.title = element_text(size = size_axis_title),
    axis.text = element_text(size = size_axis_text,
                             color = "white"),
    axis.title.x = element_text(size = size_axis_title,
                                family = font_default,
                                color = "white",
                                margin = margin(t = 0.5,0,0,0, unit = "line")),
    # axis.text.x = element_blank(),
    plot.margin = unit(c(.5, .5, .2, .5), "cm"),
    ## legend text ----------------------------------------
    legend.position = "right",
    legend.text = element_text(
      family = font_legend,
      size = size_legend_text,
      color = "white"
    ),
    ### grid ---------------------------------------------
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major = element_line(color = "snow3"),
    panel.grid.minor = element_blank()
  )

my_theme2 <- theme_minimal() +
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
    plot.title.position = "plot",
    plot.title = element_text(family = font_title,
                              color = "white",
                              size = size_header,
                              margin = margin(rep(5,4), unit = "pt")
    ),
    plot.caption = element_text(
      family = font_default,
      color = "white",
      size = size_caption
    ),
    plot.caption.position = "plot",
    plot.subtitle = element_text(
      color = "white",
      size = size_subtitle,
      family = font_subtitle,
      margin = margin(5, 5, b = 20, 5, unit = "pt"),
    ),
    ### axis and strip text ------------------------------
    strip.text = element_text(size = size_axis_text),
    axis.title = element_text(size = size_axis_title),
    axis.text = element_text(size = size_axis_text,
                             color = "white"),
    axis.title.x = element_text(size = size_axis_title,
                                family = font_default,
                                color = "white",
                                margin = margin(0,0,0,0, unit = "line")),
    axis.title.y = element_text(size = size_axis_title,
                                family = font_default,
                                color = "white"),

    # axis.text.x = element_blank(),
    plot.margin = unit(c(.5, .5, .2, .5), "cm"),
    ## legend text ----------------------------------------
    legend.position = "right",
    legend.text = element_text(
      family = font_legend,
      size = size_legend_text,
      color = "white"
    ),
    ### grid ---------------------------------------------
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major = element_line(color = "snow3"),
    panel.grid.minor = element_blank()
  )

