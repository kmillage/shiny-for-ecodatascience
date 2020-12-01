### ----------------------------------------------
### ----------------------------------------------
### This script contains the UI for tab 2
### ----------------------------------------------
### ----------------------------------------------

Tab2 <- function(){
  
  fluidPage(
    
    # In order to use shinyjs functionality, this line must be included somewhere in the UI
    useShinyjs(),
    
    # page style
    style = "padding-bottom: 40px;",
    
    # Some widgets
    column(12, align = "center",
             
           selectizeInput("w_select_car",
                          label = "Select a Car",
                          choices = dat$Name,
                          width = "100%")
    ),
      
    tags$div(id = "advanced",
             
             fluidRow(
               
               column(6, align = "center",
                        
                        selectInput("filter_cyl",
                                    "Filter by Number of Cylinders",
                                    choices = unique(dat$cyl))
                        
               ),
               
               column(6, align = "center",
                        
                        sliderInput("filter_mpg",
                                    "Filter by MPG",
                                    min = min(dat$mpg),
                                    max = max(dat$mpg),
                                    value = c(17, 30))
                        
               )
             )
               
      ),
    
    column(12, align = "right",
           
           a(id = "toggle_advanced", "Show/hide advanced options")
           
    ),
    
    tags$br(),
    tags$br(),
    
    tags$i("These widgets don't actually do anything in this app - They're here just to give you an example of how shinyjs could be used.")
    
  )
  
}