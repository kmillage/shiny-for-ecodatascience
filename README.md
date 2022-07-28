# Shiny for EcoDataScience

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
The slides for my presentation to EcoDataScience on February 16, 2021 are [here](https://www.katmillage.com/blog/misc-files/shiny_for_ecodatascience.html#1).

This goal of this talk is to provide a *short* introduction to Shiny for R, and then to highlight some supplemental packages that I have found to helpful for building effective interactive applications. 

This workshop will be roughly divided into four parts: 

1. The Basics: Brief review of essential Shiny functions and some tips to make your reactive programming more efficient;

2. Appearance & Organization (`shinydashboard` + more): Keeping things organized;

3. (gg)`plotly`: Making your (already awesome) `ggplot` figures more awesome;

4. `leaflet`: Interactive maps! 


Within each section, I'll start with a few slides of explanation, and then turn to a small Shiny app to demonstrate. 
