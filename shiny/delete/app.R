library(shiny)
library(shinydashboard)
library(leaflet)
library(DT)

dt_output <- function(id) {
  # Create a namespace function using the provided id
  ns <- NS(id)
  
  tagList(
    shinycssloaders::withSpinner(
      DT::dataTableOutput(ns("dt_table")),
      type = 6
    )
  )
  
}

# Module Server function
dt_table <- function(input, output, session, data.df) {
  
  output$dt_table <- DT::renderDataTable({
    validate(need(data.df, "data.df not found"))
    DT::datatable(head(data.df),
                  class = 'cell-border stripe',
                  filter = 'top',
                  options = list(
                    pageLength = 5, autoWidth = TRUE
                  )
    )
  })
}
# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Old Faithful Geyser Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        dt_output("dt")
        #DT::dataTableOutput("dt_table")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  callModule(dt_table, "dt", potomac.df)
  # output$dt_table <- DT::renderDataTable({
  #   DT::datatable(head(iris),
  #                 class = 'cell-border stripe',
  #                 filter = 'top',
  #                 options = list(
  #                   pageLength = 5, autoWidth = TRUE
  #                 )
  #   )
  # })
}

# Run the application 
shinyApp(ui = ui, server = server)

