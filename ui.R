library(ggiraph)
library(htmltools)
library(shiny)

shinyUI(fluidPage(
  tags$head(
    tags$style(
      HTML(
        "#DataTables_Table_0_length {
          float: right
        }
        #DataTables_Table_0_filter {
          float: left
        }
        "
      ))),
  titlePanel("Vowel explorer"),
  fluidRow(column(
    width = 12,
    includeScript(path = "set_search_val.js"),
    #h1("Vowel explorer"),
    h5("Click a point to listen to the audio"),
    uiOutput("selpoint")
  )),
  fluidRow(column(width = 12,
                  girafeOutput("plot"))),
  fluidRow(column(width = 10,
                  DT::dataTableOutput("dt")))
))