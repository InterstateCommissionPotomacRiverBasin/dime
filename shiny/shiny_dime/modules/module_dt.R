# Module UI function
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
  DT::datatable(data.df,
                class = 'cell-border stripe',
                filter = 'top',
                options = list(
                  scrollX = TRUE,
                  pageLength = 8,
                  autoWidth = TRUE
                )
                )
})
}
