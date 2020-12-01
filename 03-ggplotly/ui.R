#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
#
# shiny::runApp("03-ggplotly", display.mode = "showcase")

### ----------------------------------
### Initialize app -------------------
### ----------------------------------

library(tidyverse)
library(shiny)
library(shinydashboard)
library(plotly)
library(scales)
library(countrycode)

# Source file that loads/wrangles data and text
source("00_initialize_app.R")

# The content for each tab is stored in a separate file. Source all .R files in the current directory that start with "ui_":
sapply(list.files(
    pattern = "^ui_.*\\.R$",
    path = ".",
    full.names = TRUE
),
source)

### -----------------------------------
### User Interface (UI) ---------------
### -----------------------------------

# Define UI for application that draws a histogram
shinyUI(
    
    dashboardPage(skin = "red",
                  
                  ### Header ---------------------
                  dashboardHeader(
                      
                      # Title
                      title = "FAO Capture Production",
                      
                      # emLab logo
                      tags$li(
                          class = "dropdown",
                          a(href = 'http://emlab.msi.ucsb.edu/',
                            img(src = 'emlab_logo_horizontal_w.png', title = "emLab", height = "30px"), 
                            style = "padding-top:10px; padding-bottom:10px;"
                          ) # /a
                      ) # /tags$li
                      
                  ), # /dashboardHeader
                  
                  ### Sidebar menu ----------------------
                  dashboardSidebar(
                      
                      # Disable sidebar
                      disable = T,
                      
                      # Menu container
                      sidebarMenu(
                          
                          # Variable name for selected menuItem
                          id = "menu-items",
                          
                          ### Tab 1 menu link ---
                          menuItem("tab 1", 
                                   tabName = "tab-1", 
                                   selected = TRUE)
                          
                      ) # /sidebarMenu
                  ), #/dashboardSidebar
                  
                  ### Main panel content ----------------------
                  dashboardBody(
                      
                      # Tabs
                      tabItems(
                          
                          ### Tab 1 content ---
                          tabItem(tabName = "tab-1",
                                  Tab1(country_choices)
                          )
                          
                      ) # /tabItems
                      
                  ) # /dashboardBody
                  
    ) # /dashboardPage
) # /shinyUI
 