#
# Shiny app #1: Basics
#
# This is the server logic for our basic Shiny app.
#
# To run this application, click the "Run App" button above, or type the following into the console: 
#
# shiny::runApp("02-layout", display.mode = "showcase")
#

shinyServer(function(input, output, session) {
    
    ### ----------------------------------
    ### Tab 1 ----------------------------
    ### ----------------------------------
    
    ### Sample value box with date
    output$value_box_1 <- renderValueBox({
        
        valueBox(
            value = today(),
            subtitle = "Date Last Updated",
            icon = icon("calendar"),
            color = "maroon"
        )
        
    })
    
    ### Sample value box with value
    output$value_box_2 <- renderValueBox({
        
        valueBox(
            value = round(runif(1, min = 456, max = 1256)),
            subtitle = "Cars Tested\n(Actually random, but you get the idea...)",
            icon = icon("car"),
            color = "aqua"
        )
    })
    
    ### Plot 1 
    output$plot_1 <- renderPlot({
        
        ggplot(dat, aes(x = mpg, color = cyl, fill = cyl, group = cyl))+
            geom_density()+
            theme_classic()
        
    })
    
    ### Plot 2 
    output$plot_2 <- renderPlot({
        
        ggplot(dat, aes(x = hp, y = mpg, color = cyl, fill = cyl))+
            geom_point()+
            theme_classic()
        
    })
    
    ### Image Output
    output$car_image <- renderUI({
        
        # All image files we have
        all_img_files <- list.files(path = "./www/cars/", pattern = "*.jpg", full.names = F)
        
        # File name we need
        needed_file_name <- paste0(input$w_select_car, ".jpg")
        
        if(needed_file_name %in% all_img_files){
            
            column(12, align = "center",
                   
                   tags$img(src = paste0('./cars/', needed_file_name), width = "350px")
            )
            
        }else {
            
            tags$b("No picture available")
        }

    })
    
})
