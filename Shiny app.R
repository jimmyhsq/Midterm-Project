setwd("/Users/shuoqihuang/Desktop/615\ Midterm\ Project/Shuoqi\ Huang\ Midterm\ Project/Midterm-Project")
library(tidyverse)
library(magrittr)
data <- read.csv("data.csv")

con <- "China"

sub_data <- data %>% filter(indicatorID == "Agricultural_land_%" & country == con)
sub_data %<>% select(date, value)
ggplot(sub_data) + geom_line(aes(y=value,x=date))

f <- function(x){
  con = x
  
  sub_data <-  data %>% filter(indicatorID == "Agricultural_land_%" & country == con)
  sub_data %<>% select(date, value)
  ggplot(sub_data) + geom_line(aes(y=value,x=date)) + 
    labs(x = "year", y = "Percent", title = "Change of Percent of Agricultural Land")
}


library(shiny)

ui <- fluidPage(
  
  titlePanel("Percent of Agricultural Land"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("con", "Select a Country", unique(data$country))
    ),
    
    mainPanel(
      plotOutput("Plot")
    )
  )
)


server <- function(input, output, session) {
  
  output$Plot = renderPlot({
    f(input$con)
  })
}

shinyApp(ui = ui, server = server)

