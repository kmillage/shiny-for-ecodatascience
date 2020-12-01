### ----------------------------------------------
### ----------------------------------------------
### This script contains the UI for tab 1
### ----------------------------------------------
### ----------------------------------------------

Tab1 <- function(country_choices){
  
  fluidPage(
    
    # page style
    style = "padding-bottom: 40px; background-color: #fffff;",
    
    # fluidRow
    column(12, style = "padding-top: 40px;",
           
           plotlyOutput("area_plot",
                        height = "800px")
           
    ),
    
    # Country selection widget
    absolutePanel(top = 60, left = 0, right = 0, 
                  
                  column(12, align = "center",
                         
                         selectizeInput("country_select",
                                        "Select a Country",
                                        choices = country_choices,
                                        width = "50%")
                  )
    )
    
  ) # /fluidPage
  
}