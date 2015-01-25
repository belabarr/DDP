---
title       : CSV Quick Plot 
subtitle    : Data Products
author      : Bel Abarrientos
job         : Coursera Subject - Developing Data Product
logo        : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
url:
    lib: ../../librariesNew
    assets: ../../assets
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
---

## What is CSV Quick Plot?

- CSV Quick Plot provides exploratory plotting for a data file.
- Histogram and Scatterplot is initially thought of but other plots like correlation, boxplots and others can be considered
- The tool uses Shiny
- Due to limited time, full functionality is limited currently, additional functionalities will be added progressively
- Functional widgets are provided for demonstration for now.

---
## Entry Fields 
### Input File 
- Text Input file is currently considered, user has to enter file path and file name
- Select file input function could be used instead (using file system dialog)
- Once file is selected, data will be loaded 

### Plot Type Selection
- Drop-down list is provided, Scatter and histogram is currently listed
- Based on selection, plot will be rendered upon submit

### Date Selection
- Date is provided but no immediate For now use for now
- Date range could be used for data selection

---
![CSVQuickplot](CSVQuickplot.png "CSV Quick Plot Tool")

---

## ui.R
```
library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("CSV Quick Plot"),
    sidebarPanel(
        textInput('fileName', 'Enter file name to load:', ''),
        selectInput("plotType", label = "Select Plot Type",
             c("Histogram" = "hist",
               "Scatter" = "scatter")),
                dateInput("date", "Date:"),  
        submitButton("Submit")
    ),
    mainPanel(
        h3('Output Information'),
        h4('File entered'),
        verbatimTextOutput("ofileName"),
        h4('You selected plot type'),
        verbatimTextOutput("oplotType"),
        h4('You entered'),
        verbatimTextOutput("odate"),
        plotOutput('newHist')
    )
))
```

---
## server.R
```
library(UsingR)
library(shiny)

shinyServer(
    function(input, output) {
     infile <- reactive({input$fileName})
          
     if (is.null(infile)) {
         return(NULL)
         }
    
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
```
