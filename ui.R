## ui.R
# author: Bel Abarrientos
# purpose: DDP Project 
# date: 24 January 2015

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
