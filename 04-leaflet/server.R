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

    ### Action button: Show global subsidies map controls (and show "close" button) ---------------
    observeEvent(input$expand_panel_button, {
        
        # show panel
        shinyjs::showElement(id = "map_control_panel")
        shinyjs::showElement(id = "hide_arrow_panel")
        shinyjs::hideElement(id = "expand_arrow_panel")
        
    })
    
    ### Action button: Hide global subsidies map controls (and show "expand" button) -------------------
    observeEvent(input$hide_panel_button, {
        
        # show panel
        shinyjs::hideElement(id = "map_control_panel")
        shinyjs::hideElement(id = "hide_arrow_panel")
        shinyjs::showElement(id = "expand_arrow_panel")
        
    })
    
    output$map <- renderLeaflet({
        
        req(length(input$subsidy_types) > 0)
        
        # Data
        map_dat <- subsidy_dat %>% 
            dplyr::filter(variable == "subsidies_Sumaila") %>%
            dplyr::filter(type %in% input$subsidy_types) %>%
            dplyr::filter(!is.na(value) & value > 0) %>%
            group_by(iso3, display_name, category, category_name, type, type_name, data_type) %>%
            summarize(value = sum(value, na.rm = T)) %>%
            group_by(iso3, display_name) %>%
            mutate(included_types = paste0(type_name[type_name != "Total"], collapse = ";</br>"),
                   included_subsidy_types = paste0(type_name[type_name != "Total"], collapse = ", ")) %>%
            ungroup() %>%
            group_by(iso3, display_name, included_types, included_subsidy_types) %>%
            summarize(value = sum(value, na.rm = T)) %>%
            ungroup()
        
        req(nrow(map_dat > 0))
        
        # Join to shapefiles
        map_dat_shp <- world_eu %>%
            dplyr::filter(!admin_iso3 %in% eu_countries[eu_countries != "EU"]) %>%
            left_join(map_dat, by = c("admin_iso3" = "iso3")) %>%
            na.omit()
        
        # Hover text for world polygons
        map_text_shp <- paste0(
            "<b>", "State: ", "</b>",  map_dat_shp$display_name,
            "</br>",
            "<b>", "Estimated Fisheries Subsidies (2018 $USD):", "</b>", " $", format(round(map_dat_shp$value, 0), big.mark = ","),
            "</br>",
            "<b>", "Matching Subsidy Type(s): ", "</b>", map_dat_shp$included_types
        ) %>%
            lapply(htmltools::HTML)
        
        # Join to points for small island nations
        map_dat_points <- world_small_countries %>%
            dplyr::select(sov_iso3, admin_iso3, area_km, center) %>%
            left_join(map_dat, by = c("admin_iso3" = "iso3")) %>%
            na.omit()
        st_geometry(map_dat_points) <- map_dat_points$center
        
        # Hover text for points
        map_text_points <- paste0(
            "<b>", "State: ", "</b>",  map_dat_points$display_name,
            "</br>",
            "<b>", "Estimated Fisheries Subsidies (2018 $USD):", "</b>", " $", format(round(map_dat_points$value, 0), big.mark = ","),
            "</br>",
            "<b>", "Matching Subsidy Type(s): ", "</b>", map_dat_points$included_types
        ) %>%
            lapply(htmltools::HTML)

        # Define colors
        map_pal <- colorNumeric(palette = "plasma",
                                                 reverse = F,
                                                 log10(c(100, 10e9)))
        
        # Dummy palette for legend
        map_pal_rev <- colorNumeric(palette = "plasma",
                                    reverse = T,
                                    log10(c(100, 10e9)))
        
        # Map
        leaflet('map', options = leafletOptions(minZoom = 3, maxZoom = 5, zoomControl = TRUE)) %>% 
            addProviderTiles("CartoDB.VoyagerNoLabels") %>% 
            addCircles(data = map_dat_points,
                       color = ~map_pal(log10(value)),
                       fillOpacity = 1,
                       stroke = "white",
                       weight = 2,
                       radius = 200000,
                       highlight = highlightOptions(weight = 5,
                                                    color = "#666",
                                                    fillOpacity = 1,
                                                    bringToFront = FALSE),
                       label = map_text_points,
                       labelOptions = labelOptions(style = list("font-weight" = "normal",
                                                                padding = "3px 8px"),
                                                   textsize = "13px",
                                                   direction = "auto")) %>%
            addPolygons(data = map_dat_shp, 
                        fillColor = ~map_pal(log10(value)),
                        fillOpacity = 1,
                        color= "white",
                        weight = 0.3,
                        highlight = highlightOptions(weight = 5,
                                                     color = "#666",
                                                     fillOpacity = 1,
                                                     bringToFront = FALSE),
                        label = map_text_shp,
                        labelOptions = labelOptions(style = list("font-weight" = "normal",
                                                                 padding = "3px 8px"),
                                                    textsize = "13px",
                                                    direction = "auto")) %>%
            setView(0,20, zoom = 3) %>%
            addLegend("bottomright", 
                      pal = map_pal_rev,
                      values = log10(c(100, 10e9)),
                      labels = round(log10(c(100, 10e9)), 0),
                      title = "Est. Fisheries Subsidies",
                      opacity = 1,
                      labFormat = labelFormat(prefix = "$",
                                              transform = function(x) sort(10^(x), decreasing = T)
                      )
            )

    })

})
