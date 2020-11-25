#
# Shiny app #1: Basics
#
# This is the server logic for our basic Shiny app.
#
# To run this application, click the "Run App" button above, or type the following into the console: runApp("01-basics", display.mode = "showcase")
#

# Define server logic required to draw a histogram

shinyServer(function(input, output) {

    ### Plot Output - Render plot
    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')

    })

})
