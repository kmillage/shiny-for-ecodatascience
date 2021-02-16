#
# Shiny app #1: Basics
#
# This is the user-interface for our basic Shiny app.
#
# shiny::runApp("01-basics", display.mode = "showcase")
#

### ----------------------------------
### Initialize app -------------------
### ----------------------------------

library(shiny)
library(tidyverse)

dat <- iris

variable_choices <- colnames(dat)[1:4]
names(variable_choices) <- str_replace(colnames(dat), "\\.", " ")[1:4]

species_choices <- unique(dat$Species)

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
                     
                     # Widget specifying the species to be included on the plot
                     selectInput("simple_species",
                                 "Species:",
                                 choices = species_choices,
                                 selected = species_choices[1],
                                 multiple = F),
                     
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
    
    # Second tab
    tabPanel("More Complicated",
             
             # Sidebar layout
             sidebarLayout(
                 sidebarPanel(
                     
                     # Widget specifying the species to be included on the plot
                     selectInput("more_species",
                                 "Select all species to include:",
                                 choices = species_choices,
                                 selected = species_choices[1],
                                 multiple = T),
                     
                     # Widget specifying the variable to be plotted
                     selectInput("more_variable",
                                 "Variable:",
                                 choices = variable_choices,
                                 selected = variable_choices[1])
                 ),
                 
                 # Show a plot of the generated distribution
                 mainPanel(
                     
                     # First plot
                     plotOutput("more_dist_plot", height = "300px"),
                     
                     # Second plot
                     plotOutput("more_facet_plot", height = "600px")
                     
                 )
             )
    ), # close second tab
    
    # Third tab
    tabPanel("Most Complicated",
             
             # Sidebar layout
             sidebarLayout(
                 sidebarPanel(
                     
                     # Widget - species to be included on the plot
                     selectInput("most_species",
                                 "Select all species to include:",
                                 choices = species_choices,
                                 selected = species_choices[1],
                                 multiple = T),
                     
                     # Button to submit changes
                     actionButton("most_button",
                                  "Submit Selections")

                 ),
                 
                 # Show a plot of the generated distribution
                 mainPanel(
                     
                     # Conditonal panel - at least one species must be selected selected
                     conditionalPanel("input.most_button > 0",
                                      
                                      # Plot widgets
                                      fluidRow(
                                          
                                          column(4, align = "center",
                                
                                                 # Widget specifying the variable to be plotted
                                                 selectInput("most_variable",
                                                             "Variable to plot:",
                                                             choices = variable_choices,
                                                             selected = variable_choices[1]),

                                          ),
                                          
                                          column(4, align = "center",
                                                 
                                                 # Widget - species to highlight
                                                 radioButtons("most_species_highlight",
                                                              "Species to highlight:",
                                                              choices = species_choices[1],
                                                              inline = T)
                                                 
                                          ),
                                          
                                          column(4, align = "center",
                                
                                                 # Widget specifying the highlight color on the bottom plot
                                                 selectInput("most_color",
                                                             "Highlight color:",
                                                             choices = c("green", "blue", "orange", "pink"),
                                                             selected = "green"),
                                
                                                 
                                          )
                         
                                      ) # close fluidRow
                     ), # close conditionalPanel
                     
                     # First plot
                     plotOutput("most_dist_plot"),
                     
                     # Second plot
                     plotOutput("most_highlight_plot")
                     
                 )
             )
    ) # close third tab
    
))
