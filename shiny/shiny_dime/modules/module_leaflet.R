# Module UI function
leaflet_output <- function(id) {
  # Create a namespace function using the provided id
  ns <- NS(id)
  
  tagList(
    leaflet::leafletOutput(ns("mymap"), height = 600, width = "100%")
    )
  
}

# Module Server function
leaflet_plot <- function(input, output, session) {
  output$mymap <- leaflet::renderLeaflet({
    icprb.map <- "https://api.mapbox.com/styles/v1/skaisericprb/citvqu6qb002p2jo1ig5hnvtk/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoic2thaXNlcmljcHJiIiwiYSI6ImNpa2U3cGN1dDAwMnl1cm0yMW94bWNxbDEifQ.pEG_X7fqCAowSN8Xr6rX8g"
    leaflet::leaflet(options = leaflet::leafletOptions(maxBoundsViscosity = 1)) %>%
      leaflet::addTiles(urlTemplate = icprb.map, options = leaflet::tileOptions(minZoom = 7, maxZoom = 18)) %>%
      leaflet::setMaxBounds(lng1 = -81, lat1 = 38.5, lng2 = -75, lat2 = 39.5) %>%
      leaflet::setView(-78.110291, lat = 39.029230, zoom = 8)
  }) # End output$MAP
}