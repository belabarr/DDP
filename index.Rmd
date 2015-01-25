---
title       : CSV Quick Plot 
subtitle    : Data Products
author      : beldevere
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
- Histogram and Correlation plot is initially thought of but other plots like scatter, boxplots and others can be considered
- The tool uses Shiny
- Due to limited time, full functionality is limited currently, additional functionalities will be added progressively
- Functional widgets are provided for demonstration for now.

---
## Entry Fields 
### Input File 
- File input dialog is currently provided
- Once file is selected, data will be loaded 

### Plot Type Selection
- Drop-down list is provided, histogram and correlation is currently listed
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
        fileInput('infile', 'Choose file to upload',
                  accept = c(
                      'text/csv',
                      'text/comma-separated-values',
                      'text/tab-separated-values',
                      'text/plain',
                      '.csv',
                      '.tsv'
                  )
        ),
        selectInput("plotType", label = "Select Plot Type",
             c("Histogram" = "hist",
               "Correlation" = "corr")),
                dateInput("date", "Date:"),  
        submitButton("Submit")
    ),
    mainPanel(
        h3('Output Information'),
        h4('File entered'),
        verbatimTextOutput("ofile"),
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
```
