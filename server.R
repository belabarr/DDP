## server.r
# author: Bel Abarrientos
# purpose: DDP Project 
# date: 24 January 2015

library(UsingR)
library(shiny)
library(Hmisc)
library(corrplot)
wd <- getwd()
setwd(wd)

shinyServer(
    function(input, output) {
         
    output$ofile        <- renderPrint({input$infile})
    output$oplotType    <- renderPrint({input$plotType})
    output$odate        <- renderPrint({input$date})
    
    plotdata <- reactive({
        filestr <- input$infile
        read.csv(filestr$name)
            })
            
    output$newHist <- renderPlot({
        hist(plotdata())
    })
    
#   Conditional plot selection is test in progress
#     corrdf <- cor(plotdata)
#     output$newHist <- renderPlot({
#         corrplot(corrdf, method = "circle")
#     })
    
    }
)