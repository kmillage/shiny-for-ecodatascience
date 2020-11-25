#
# Shiny app #4: Leaflet
#
# This is the user-interface for our final Shiny app.
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

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Shiny App #4: Leaflet"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))
