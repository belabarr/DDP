## ui.R
# author: Bel Abarrientos
# purpose: DDP Project 
# date: 24 January 2015


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
