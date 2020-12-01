### ----------------------------------------------
### ----------------------------------------------
### This script contains the UI for tab 3
### ----------------------------------------------
### ----------------------------------------------

Tab3 <- function(){
  
  fluidPage(
    
    # page style
    style = "padding-bottom: 40px;",
    
    # Row of switchInputs()
    fluidRow(
      
      h3("switchInput()"),
      
      column(4, align = "center",
             
             switchInput(inputId = "widget_1",
                         label = "Cool Feature",
                         labelWidth = "100px")
             
      ),
      
      column(4, align = "center",
             
             switchInput(inputId = "widget_2",
                         label = "Another Cool Feature",
                         labelWidth = "400px",
                         onStatus = "success", 
                         offStatus = "danger")
             
      ),
      
      column(4, align = "center",
             
             switchInput(inputId = "widget_3",
                         size = "mini")
             
      )
      
    ),
    
    # # Row of materialSwitches()
    # fluidRow(
    #   
    #   h3("materialSwitch()"),
    #   
    #   column(4, align = "center",
    #          
    #          materialSwitch(inputId = "widget_4",
    #                         label = "Update value",
    #                         value = FALSE,
    #                         status = "info")
    #          
    #   ),
    #   
    #   column(4, align = "center",
    #          
    #          materialSwitch(inputId = "widget_5",
    #                         label = "Start Something",
    #                         value = FALSE,
    #                         status = "success")
    #          
    #   ),
    #   
    #   column(4, align = "center",
    #          
    #          materialSwitch(inputId = "widget_6",
    #                         label = "Stop Something",
    #                         value = TRUE,
    #                         status = "danger")
    #          
    #   )
    #   
    # ),
    
    # Row of materialSwitches()
    fluidRow(
      
      h3("radioGroupButtons()"),
      
      column(4, align = "center",
             
             radioGroupButtons(inputId = "widget_7",
                               label = "Pick One",
                               choices = c("A", "B", "C"))
             
      ),
      
      column(4, align = "center",
             
             radioGroupButtons(inputId = "widget_8",
                               label = "Pick Another One",
                               choices = c(`<i class='fa fa-bar-chart'></i>` = "bar", 
                                           `<i class='fa fa-line-chart'></i>` = "line", 
                                           `<i class='fa fa-pie-chart'></i>` = "pie"),
                               justified = TRUE)
             
      ),
      
      column(4, align = "center",
             
             radioGroupButtons(inputId = "widget_8",
                               label = "And One More",
                               choices = c("A", "B", "C", "D"),
                               status = "primary",
                               checkIcon = list(
                                 yes = icon("ok", 
                                            lib = "glyphicon"),
                                 no = icon("remove",
                                           lib = "glyphicon")))
             
      )
      
    ),
    
    tags$br(),
    
    tags$i("These widgets don't actually do anything in this app - They're here just to show you what they look like! For the full array of widgets in the `shinyWidgets` package, go ", tags$a(href = 'http://shinyapps.dreamrs.fr/shinyWidgets/', "here"), ".")
    

  )
  
}