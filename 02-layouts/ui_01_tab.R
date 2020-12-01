### ----------------------------------------------
### ----------------------------------------------
### This script contains the UI for tab 1
### ----------------------------------------------
### ----------------------------------------------

Tab1 <- function(){
  
  fluidPage(
    
    # page style
    style = "padding-bottom: 40px;",
    
    # Row of value boxes 
    fluidRow(
      
      # Value Box 1
      valueBoxOutput("value_box_1"),
      
      # Value Box 2
      valueBoxOutput("value_box_2"),
      
      # Box with widget
      box(width = 4,
          height = 100,
          solidHeader = T,
          selectizeInput("w_select_car",
                         label = "Select a Car: ",
                         choices = dat$Name, 
                         width = "100%")
      )

    ),
    
    # Plot in a dashboard box
    fluidRow(
      
      box(width = 12,
          solidHeader = T,
          title = "Horsepower vs. MPG",
          height = 300,
          
          plotOutput("plot_2", height = 250)
      )
      
    ),
    
   # Plot in a plain "material" box
   fluidRow(
     
     # plot
     box(width = 6,
         height = 300,
         status = "warning",
         title = "MPG by Number of Cylinders",
         
         plotOutput("plot_1", height = 250)
         
     ),
     
     # widgets
     box(width = 6,
         height = 300,
         title = "Picture",
         background = "black",
         
         uiOutput("car_image", width = "auto")
     )

   )
   
  ) # /fluidPage
  
}