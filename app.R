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
library(tidyr)
library(magrittr)
library(dplyr)

#Read a dataframe from a CSV file that is present in the same directory
df <- read.csv("Area_in_um-GEFs.csv", na.strings = "")

#Convert to tidy format and remove missing values
df_tidy <- df  %>% gather(Condition, Value) %>% filter(!is.na(Value))


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Shiny Demo"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         checkboxInput("show_table", "Show table?", FALSE),
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
      ),
      
      # Show a plot of the generated distribution and a tabel with statistics
      mainPanel(
         plotOutput("distPlot"),
         
         #Make the table optional
         conditionalPanel(condition="input.show_table == true",
                          tableOutput("data_summary")
         )
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
     
     #Define plotting object
     p <- ggplot(data = df_tidy, aes(x=Value, fill=Condition))

       # generate bins based on input$bins from ui.R
       # use alpha defined by input$alpha from ui.R
       p <- p + geom_histogram(bins = input$bins, alpha=input$alpha)
      
      # draw the histogram with the specified number of bins
      return(p)
   })
   
   #Generate a data frame with summary statistics (per Condition)
   df_summary <- reactive({
     
     df_tidy %>%
       group_by(Condition) %>% 
       summarise(n = n(),
                 mean = mean(Value, na.rm = TRUE),
                 median = median(Value, na.rm = TRUE),
                 sd = sd(Value, na.rm = TRUE)) %>%
       mutate(sem = sd / sqrt(n - 1),
              mean_CI_lo = mean + qt((1-0.95)/2, n - 1) * sem,
              mean_CI_hi = mean - qt((1-0.95)/2, n - 1) * sem)
     
   })
   
   #Take the df_summary dataframe and render it as a Table for output in shiny
   output$data_summary <- renderTable(
       df_summary()
   )
   
}

# Run the application 
shinyApp(ui = ui, server = server)

