
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(dplyr)

## server.R

palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

shinyServer(function(input, output, session) {
  
  # Combine the selected variables into a new data frame
  clusteringData <- reactive({
    data[, c(input$variables)]
  })
  
  plotData <- reactive({
    data[, c(input$plotVariables)]
  })
  
  clusters <- reactive({
    kmeans(clusteringData(), input$clusters, nstart = 50)
  })
  
  output$plot1 <- renderPlot({
    par(mar = c(5.1, 4.1, 0, 1))
    plot(plotData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })
  
  output$table1 <- renderTable(
    table1 <- data.frame(Stores = clusters()$size, clusters()$centers)
  )
  
  
  output$table2 <- renderDataTable({
    table2 <- inner_join(data.frame(LOCATION_ID=data$LOCATION_ID, CLUSTER = clusters()$cluster), location_dim)
  }
  )
  
  output$downloadData <- downloadHandler(
    filename = function() { paste(input$dataset, '.csv', sep='') },
    content = function(file) {
      write.csv(datasetInput(), file)
    }
  )
  
})



