#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Shiny Demo"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         checkboxInput("show_histogram", "Show plot?", FALSE),
         conditionalPanel(condition="input.show_histogram == true",
               sliderInput("bins",
                           "Number of bins:",
                           min = 1,
                           max = 50,
                           value = 30),
               sliderInput("alpha",
                           "Tranparency:",
                           min = 0,
                           max = 1,
                           value = 0.8)
           )
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({

     # Convert data from faithful into dataframe with waiting times     
     geyser_data <- data.frame(waiting=faithful$waiting)
     
     #Define plotting object
     p <- ggplot(data = geyser_data, aes(x=waiting))
     
     #Make the plotting conditional
     if (input$show_histogram) {
       # generate bins based on input$bins from ui.R
       # use alpha defined by input$alpha from ui.R
       p <- p + geom_histogram(bins = input$bins, alpha=input$alpha)
     }
      
      # draw the histogram with the specified number of bins
      return(p)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

