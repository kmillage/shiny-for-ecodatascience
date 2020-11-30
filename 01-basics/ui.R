#
# Shiny app #1: Basics
#
# This is the user-interface for our basic Shiny app.
#
# To run this application, click the "Run App" button above, or type the following into the console: runApp("01-basics", display.mode = "showcase")
#

### ----------------------------------
### Initialize app -------------------
### ----------------------------------

library(shiny)
library(tidyverse)

dat <- iris

variable_choices <- colnames(dat)[1:4]
names(variable_choices) <- str_replace(colnames(dat), "\\.", " ")[1:4]

#species_choices <- unique(dat$Species)

### -----------------------------------
### User Interface (UI) ---------------
### -----------------------------------

# Define UI for application that draws a histogram
shinyUI(navbarPage(
    
    title = "Iris Data",
    
    # First tab
    tabPanel("Simple",
             
             # Sidebar layout
             sidebarLayout(
                 sidebarPanel(
                     
                     # Widget specifying the number of bins
                     sliderInput("simple_bins",
                                 "Number of bins:",
                                 min = 1,
                                 max = 50,
                                 value = 30),
                     
                     # Widget specifying the variable to be plotted
                     selectInput("simple_variable",
                                 "Variable to plot:",
                                 choices = variable_choices,
                                 selected = variable_choices[1])

                 ),
                 
                 # Show a plot of the generated distribution
                 mainPanel(
                     
                     # First plot
                     plotOutput("simple_dist_plot")
                     
                 )
             )
    ), # close first tab
    
    # First tab
    tabPanel("More Complicated",
             
             # Sidebar layout
             sidebarLayout(
                 sidebarPanel(
                     
                     # Widget specifying the number of bins
                     sliderInput("bins",
                                 "Number of bins:",
                                 min = 1,
                                 max = 50,
                                 value = 30),
                     
                     # Widget specifying the variable to be plotted
                     selectInput("variable",
                                 "Variable to plot:",
                                 choices = variable_choices,
                                 selected = variable_choices[1]),
                     
                     # # Button to submit changes
                     # action("button",
                     #        "Update plot")
                     
                 ),
                 
                 # Show a plot of the generated distribution
                 mainPanel(
                     
                     # First plot
                     plotOutput("dist_plot")
                     
                 )
             )
    ), # close first tab
    
    
)
    
    # Application title
    titlePanel("Iris Data"),
    
    # Sidebar with a slider input for number of bins
    
))
