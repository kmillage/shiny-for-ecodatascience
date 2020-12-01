#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# shiny::runApp("02-layouts", display.mode = "showcase")

### ----------------------------------
### Initialize app -------------------
### ----------------------------------

library(tidyverse)
library(shiny)
library(shinyjs)
library(shinydashboard)
library(shinyWidgets)

library(lubridate)

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
    
    dashboardPage(skin = "black",
                  
                  ### Header ---------------------
                  dashboardHeader(
                      
                      # Title
                      title = "Motor Trend Car Road Tests",
                      
                      # emLab logo
                      tags$li(
                          class = "dropdown",
                          a(href = 'http://emlab.msi.ucsb.edu/',
                            img(src = 'emlab_logo_horizontal_b.png', title = "emLab", height = "30px"), 
                            style = "padding-top:10px; padding-bottom:10px;"
                          ) # /a
                      ) # /tags$li
                      
                  ), # /dashboardHeader
                  
                  ### Sidebar menu ----------------------
                  dashboardSidebar(
                      
                      # Width of sidebar menu
                      width = "250px",
                      
                      # Want it collapsed by default?
                      collapsed = F,
                      
                      # Menu container
                      sidebarMenu(
                          
                          # Variable name for selected menuItem
                          id = "menu-items",
                          
                          ### Tab 1 menu link ---
                          menuItem("Boxes!", 
                                   tabName = "tab-1", 
                                   selected = TRUE),
                          
                          ### Tab 2 menu link ---
                          menuItem("shinyjs", 
                                   tabName = "tab-2", 
                                   selected = FALSE),
                          
                          ### Tab 3 menu link ---
                          menuItem("Pretty Widgets",
                                   tabName = "tab-3",
                                   selected = FALSE)
                          
                      ) # /sidebarMenu
                  ), #/dashboardSidebar
                  
                  ### Main panel content ----------------------
                  dashboardBody(
                      
                      # Tabs
                      tabItems(
                          
                          ### Tab 1 content ---
                          tabItem(tabName = "tab-1",
                                  Tab1()
                          ),
                          
                          ### Tab 2 content ---
                          tabItem(tabName = "tab-2",
                                  Tab2()
                          ),
                          
                          ### Tab 3 content ---
                          tabItem(tabName = "tab-3",
                                  Tab3()
                          )
                          
                      ) # /tabItems
                      
                  ) # /dashboardBody
                  
    ) # /dashboardPage
) # /shinyUI
