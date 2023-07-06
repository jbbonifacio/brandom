#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    # PAGE #########################################################################
    shinydashboard::dashboardPage(
      skin = "green",
      ##############################################################################
      # HEADER #####################################################################
      shinydashboard::dashboardHeader(title=p("OneRice -",strong("Design")), titleWidth = 275),
      ##############################################################################
      # SIDEBAR ####################################################################
      shinydashboard::dashboardSidebar(
        width = 275,
        tags$head(
          tags$style(HTML(".skin-green .main-sidebar {background-color:  #00A65A !important;}
                      .skin-green .main-sidebar .sidebar .sidebar-menu .active a{background-color: #116530;}
                      .skin-green .main-sidebar .sidebar .sidebar-menu a:hover{background-color: #116530;}
                      .skin-green .sidebar a {color: #FFFFFF;}"))
        ),
        shinydashboard::sidebarMenu(id = "tabs",
                                    shinydashboard::menuItem("Row-Column", tabName = "RC", icon = icon("shuffle"))
        )
      ),
      ##############################################################################
      # BODY #######################################################################
      shinydashboard::dashboardBody(
        shinydashboard::tabItems(
          shinydashboard::tabItem(tabName = "RC", # $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                                  mod_RC_ui("RC_1")
          )
        )
      )
    ) # PAGE END ###################################################################
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "brandom"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
