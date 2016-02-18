
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(tidyr)


## ui.R

shinyUI(pageWithSidebar(
  
  headerPanel('k-means store clustering'),
  
  sidebarPanel(
    checkboxGroupInput('variables', 'Variables:', names(select(data, -LOCATION_ID))),
    numericInput('clusters', 'Cluster count', 3, min = 1, max = 9)
  ),
  
  mainPanel(
    plotOutput('plot1'),
    tableOutput('table1'),
    div(tableOutput('table2'), style = "font-size:70%")
    
  )
))
