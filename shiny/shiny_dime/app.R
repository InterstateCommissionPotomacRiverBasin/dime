library(shiny)
library(shinydashboard)
library(leaflet)
source("modules/module_leaflet.R")
# UI---------------------------------------------------------------------------
ui <- dashboardPage(
  dashboardHeader(title = "DIME: Beta"),
  dashboardSidebar(
    sidebarMenu(
    menuItem("Map", tabName = "map", icon = icon("globe")),
    menuItem("Table", tabName = "table", icon = icon("table")),
    menuItem("Figures", tabName = "figures", icon = icon("image")),
    menuItem("Test", icon = icon("upload"),
             sliderInput("inputTest2", "Input test 2", min=0, max=10, value=5,
                         width = '95%')
    ),
    div(tags$a(img(src = "logo.png",
                   height = "90%",
                   width = "90%"),
               href = "https://www.potomacriver.org",
               target = "_blank"), style = "text-align: center;")
     )
  ),
  ## Body content
  dashboardBody(
    fillPage(
    tabItems(
      
        # First tab content
        tabItem(tabName = "map",
                fluidRow(
                  column(width = 12,
                tabBox(
                  width = 12, height = "650px",
                  tabPanel("Tab1", leaflet_output("leaflet")),
                  tabPanel("Tab2", "Tab content 2")
                )),
                column(width = 12,
                box("test", width = 12)
                )
      )
      
              
                       
      ),
      
      # Second tab content
      tabItem(tabName = "table"),
      tabItem(tabName = "figures")
    )
  )
))

# Server-----------------------------------------------------------------------
server <- function(input, output, session) {
  callModule(leaflet_plot, "leaflet")
}

# Run the application 
shinyApp(ui = ui, server = server)

