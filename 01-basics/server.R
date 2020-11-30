#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# To run this application, click the "Run App" button above, or type the following into the console: runApp("01-basics", display.mode = "showcase")

### ----------------------------------
### Initialize app -------------------
### ----------------------------------

library(shiny)
library(tidyverse)

dat <- iris

variable_choices <- colnames(dat)[1:4]
names(variable_choices) <- str_replace(colnames(dat), "\\.", " ")[1:4]

species_choices <- unique(dat$Species)

### ----------------------------------
### Server-------------------
### ----------------------------------

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    ### Tab 1 - Simple ---------
    
    # Simple distribution plot
    output$simple_dist_plot <- renderPlot({
        
        plot_dat <- dat %>%
            dplyr::filter(Species == input$simple_species)
        
        ggplot(plot_dat)+
            aes_string(y = input$simple_variable)+
            geom_histogram(stat = "bin", binwidth = 0.25)+
            coord_flip()+
            theme_bw()
        
    })
    
    ### Tab 2 - More Complicated --------
    
    # Container for filtered data
    filtered_dat <- reactiveValues()
    
    # Update filtered data when selected species changes
    observe({
        
        filtered_dat$more <- dat %>%
            dplyr::filter(Species %in% input$more_species)

    })
    
    # More complicated distribution plot (all selected species together)
    output$more_dist_plot <- renderPlot({
        
        ggplot(filtered_dat$more)+
            aes_string(y = input$more_variable)+
            geom_histogram(stat = "bin", binwidth = 0.25)+
            coord_flip()+
            theme_bw()
        
    })
    
    # More complicated facet plot (all selected species have their own facet)
    output$more_facet_plot <- renderPlot({
        
        req(nrow(filtered_dat$more) > 0)
        
        ggplot(filtered_dat$more)+
            aes_string(y = input$more_variable, fill = "Species")+
            geom_histogram(stat = "bin", binwidth = 0.25)+
            coord_flip()+
            theme_bw()+
            facet_wrap(~Species, ncol = 1)+
            theme(legend.position = "none")
        
    })
    
    ### Tab 3 - Most Complicated --------
    
    # We are again going to use the same filtered data for multiple plots - let's just use the reactive values object we already defined. However, this time we only want to refilter our data when the button is pushed.
    observeEvent(input$most_button, {
        
        filtered_dat$most <- dat %>%
            dplyr::filter(Species %in% input$most_species)
        
    })
    
    # We want our second widget to be conditional on the first so that only species selected on the first are choices on the second. Thus we'll need the choices on our second widget to become reactive. We also need to make sure it doesn't try to update if no species are selected - this will result in an error. 
    observe({

        updated_species <- unique(filtered_dat$most$Species)

        req(length(updated_species) > 0)
        
        updateRadioButtons(session,
                           "most_species_highlight",
                           choices = updated_species,
                           inline = T)

    })
    
    # More complicated distribution plot (all selected species together)
    output$most_dist_plot <- renderPlot({
        
        req(nrow(filtered_dat$most) > 0)
        req(input$most_variable)

        ggplot(filtered_dat$most)+
            aes_string(y = input$most_variable)+
            geom_histogram(stat = "bin", binwidth = 0.25)+
            coord_flip()+
            theme_bw()+
            labs(y = "")
        
    })
    
    # More complicated feature plot
    output$most_highlight_plot <- renderPlot({
        
        req(nrow(filtered_dat$most) > 0)
        req(input$most_variable)
        req(input$most_color)
        
        lab_name <- switch(input$most_variable,
                           "Sepal.Length" = list("Sepal Length (mm)"),
                           "Sepal.Width" = list("Sepal Width (mm)"),
                           "Petal.Length" = list("Petal Length (mm)"),
                           "Petal.Width" = list("Petal Width (mm)"))
        
        ggplot(filtered_dat$most)+
            aes_string(x = "Species", y = input$most_variable)+
            geom_boxplot()+
            geom_boxplot(data = filtered_dat$most %>% dplyr::filter(Species == input$most_species_highlight),
                         fill = input$most_color)+
            coord_flip()+
            theme_bw()+
            labs(y = lab_name[[1]])
        
    })
    
    
})
