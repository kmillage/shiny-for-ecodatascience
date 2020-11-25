# Shiny for EcoDataScience

You can view the presentation for this talk here. 

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

**The first portion of the talk will provide a short intro on the basics of Shiny, but I'm going to assume that participants have some knowlege of what Shiny does and why you would want to use it.**

This presentation will be roughtly divided into four parts: 

1. The basics: How to make your reactive programming more efficient

2. Shiny app layouts: Special containers and pretty widgets

3. (gg)plotly: Making your plots interactive

4. Leaflet: Interactive maps! 


Within each section, I'll start with a few slides of explaination, and then turn to a small Shiny app to demonstrate. 