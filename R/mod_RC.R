#' RC UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_RC_ui <- function(id){
  ns <- NS(id)
  tagList(
    dataTableOutput(ns("test"))
  )
}

#' RC Server Functions
#'
#' @noRd
mod_RC_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    sample <- DiGGer::rcDiGGer(12, 3,12, 3,4)
    output$test <- renderDataTable(sample$dlist)
  })
}

## To be copied in the UI
# mod_RC_ui("RC_1")

## To be copied in the server
# mod_RC_server("RC_1")
