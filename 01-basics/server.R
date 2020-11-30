#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# To run this application, click the "Run App" button above, or type the following into the console: runApp("01-basics", display.mode = "showcase")
#

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # Distribution plot
    output$dist_plot <- renderPlot({
        
        ggplot(dat)+
            aes_string(y = input$variable)+
            geom_histogram(stat = "bin", bins = input$bins)+
            theme_bw()
        
    })
    
})
