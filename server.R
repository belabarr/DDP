## server.r
# author: Bel Abarrientos
# purpose: DDP Project 
# date: 24 January 2015

library(UsingR)
library(shiny)

shinyServer(
    function(input, output) {
     #cat("filename1\n")
     infile <- reactive({input$fileName})
     #cat("filename2\n")
     
     if (is.null(infile)) {
         return(NULL)
         }
     #cat("filename3\n") 
    # plotdata <- read.csv(infile)
    # defaulting to pollution file for now just to ensure thru-and-thru dialog
    plotdata <- read.csv('avgpm25.csv')
        
    output$ofileName <- renderPrint({input$fileName})
    output$oplotType <- renderPrint({input$plotType})
    output$odate <- renderPrint({input$date})
    
    output$newHist <- renderPlot({hist(plotdata)})
    
#   plotType <- reactive({input$plotType})
#   if (plotType == "hist") {
#     output$newHist <- renderPlot({hist(plotdata)})
#    }
#   if (plotType == "scatter") {
#     output$newHist <- renderPlot({with(plotdata, plot(latitude, pm25, col = region))
#                                       abline(h = 12, lwd = 2, lty = 2)
#                                       })
#    }
    }
)