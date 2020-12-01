#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$area_plot <- renderPlotly({
        
        plot_dat <- fao_dat %>%
            dplyr::filter(iso3 == input$country_select)
        
        p <- plot_dat %>%
            ggplot()+
            aes(x = year, y = value/1000, fill = isscaap_group)+
            geom_area()+
            geom_area(aes(text = paste0("<b>","Year: ","</b>", year,
                                        "<br>",
                                        "<b>", "ISSCAAP Group: ", "</b>", isscaap_group,
                                        "<br>",
                                        "<b>", "Capture Production (mt): ", "</b>", format(round(value, 0), big.mark = ","),
                                        "<br>",
                                        "<b>", "% of Annual Total: ", "</b>", round(prop_annual_total *100, 2))))+
            scale_y_continuous(expand = c(0,0),
                               name = "Capture Production (thousand mt)", 
                               labels = function(x) format(x, big.mark = ",", decimal.mark = ".", scientific = FALSE))+
            scale_x_continuous(expand = c(0,0))+
            theme_bw()+
            labs(x = "Year",
                 fill = "")+
            theme(plot.background = element_rect(fill = "#ECF0F5"),
                  legend.background = element_rect(fill = "#ECF0F5"))
        
        # Convert to plotly
        gg <- ggplotly(p, tooltip = "text") %>%
            style(hoveron = "points")
        
        # Create Legend
        leg <- list(font = list(size = 10, color = "#000"),
                    x = 100,
                    y = 1,
                    yanchor = "top")
        
        # Plotly syntax to adjust hover spike lines
        gg <- gg %>%
            layout(xaxis = list(
                showspikes = TRUE,
                spikemode = "across",
                spikedash = "solid",
                spikesnap = 'compare',
                spikethickness = 1,
                hovermode = 'compare'),
                legend = leg)
        
        # Return plot
        gg
        
    })

})
