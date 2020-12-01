### ----------------------------------------------
### ----------------------------------------------
### This script contains the UI for tab 1
### ----------------------------------------------
### ----------------------------------------------

Tab1 <- function(subsidy_types_sorted_sumaila){
  
  fluidPage(
    
    # Use shiny js
    useShinyjs(),
    
    # page style
    style = "padding-bottom: 40px;",
    
    ### Global subsidies map
    column(12, style = "padding: 0;",
           
           # Leaflet map
           leafletOutput('map', width = "auto", height = "90vh"),
           
           # Button to hide left panel 
           shinyjs::hidden(absolutePanel(id = "hide_arrow_panel",
                                         top = 100,
                                         left = 250, 
                                         
                                         tags$button(id = "hide_panel_button",
                                                     class = "btn action-button",
                                                     icon("caret-left"))
           )),
           
           # Button to open left panel
           absolutePanel(id = "expand_arrow_panel",
                         top = 100,
                         left = 0, 
                         
                         tags$button(id = "expand_panel_button",
                                     class = "btn action-button",
                                     icon("caret-right"))
           ),
           
           # Widget panel
           shinyjs::hidden(absolutePanel(id = "map_control_panel",
                                         top = 100,
                                         left = 0,
                                         width = 250,
                                         style = "background-color: #fff;",
                                         
                                         column(12, style = "padding: 25px;",
                                                
                                                # Subsidy types widget
                                                checkboxGroupInput("subsidy_types",
                                                                   label = "Subsidy Types to Include:",
                                                                   choices = subsidy_types_sorted_sumaila,
                                                                   selected = subsidy_types_sorted_sumaila,
                                                                   width = "100%")
                                         )
           ))
    )
   
  ) # /fluidPage
  
}