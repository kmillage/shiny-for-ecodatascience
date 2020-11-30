# Shiny for EcoDataScience

You can view the presentation for this talk [here](https://kmillage.github.io/shiny-for-ecodatascience/presentations/shiny_for_ecodatascience). 

If you want to follow along (or play with the apps contained in this repository), you'll need to have the following packages installed: 

```{r}
# General
library(tidyverse) # data wrangling

# Shiny applications
library(shiny) # interactive applications
library(shinyjs) # javascript functionality for shiny
library(shinydashboard) # dashboard layouts
library(shinyWidgets) # additional widgets

# Maps and plotting
library(leaflet) # interactive maps 
library(plotly) # interactive charts
library(sf) # spatial features
library(rnaturalearth) # maps
library(rnaturalearthdata) # map data
```

This goal of this talk is to provide a *short* introduction to Shiny for R, and then to highlight some of its capabilities that I have found to be most effective for building interactive web applications. 

**The first portion of the talk will provide a short intro on the basics of Shiny, but later sections will assume that you're already somewhat comfortable with Shiny.**

This presentation will be roughtly divided into four parts: 

1. The Basics: Brief review of essential Shiny functions and some tips to make your reactive programming more efficient;

2. `shinydashboard`: Keeping things organized;

3. (gg)`plotly`: Making your (already awesome) `ggplot` figures more awesome;

4. `leaflet`: Interactive maps! 


Within each section, I'll start with a few slides of explaination, and then turn to a small Shiny app to demonstrate. 