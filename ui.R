
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinythemes)
library(tidyr)



shinyUI(fluidPage(theme = shinytheme("spacelab"),
  titlePanel("Store Clustering"),
  fluidRow(
    column(2,
      wellPanel(
       h4("Customer Styles"),  
       selectInput('variables', '', names(select(data, -LOCATION_ID)), multiple = TRUE, selected = names(select(data, -LOCATION_ID))),
       numericInput('clusters', 'Cluster count', 3, min = 1, max = 9)
      )
    ),
           
    column(10,
      wellPanel(
        h2("Cluster Profile"),  
        tableOutput('table1')
      )
    )          
  ),
  

  fluidRow(
    wellPanel(
      h2("Plot"),
      selectInput('plotVariables', '', names(select(data, -LOCATION_ID)), multiple = TRUE),
      plotOutput('plot1')
    )
  ),
  
  fluidRow(
    column(2,
     wellPanel()       
    ),
    
    column(10,
      wellPanel(
      h2("Stores"),  
      div(dataTableOutput('table2'), style = "font-size:70%"),
      selectInput("dataset", "Choose a dataset:", choices = c("table1", "table2")),
      downloadButton('downloadData', 'Download')
      )
    )
  )
  
)) 


