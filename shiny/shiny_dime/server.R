server <- function(input, output, session) {
  
  callModule(leaflet_plot, "leaflet", potomac.df)
  callModule(dt_table, "dt", potomac.df)
  
}