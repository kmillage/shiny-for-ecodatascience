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

### -----------------------------------
### User Interface (UI) ---------------
### -----------------------------------

# Define UI for a basic application
shinyUI(fluidPage(

    # Application title
    titlePanel("Shiny App #1: The Basics"),

    # Sidebar layout
    sidebarLayout(
        
        # Sidebar panel 
        sidebarPanel(
            
            # Slider widget
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Main panel 
        mainPanel(
            
            # Plot output
            plotOutput("distPlot")
        )
    )
))
