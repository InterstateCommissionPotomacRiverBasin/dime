# Module UI function
leaflet_output <- function(id) {
  # Create a namespace function using the provided id
  ns <- NS(id)
  
  tagList(
    shinycssloaders::withSpinner(
    leaflet::leafletOutput(ns("mymap"), height = 600, width = "100%"),
    type = 6
    )
    )
  
}

# Module Server function
leaflet_plot <- function(input, output, session, data.df) {
  
  output$mymap <- leaflet::renderLeaflet({
    req(data.df)
    icprb.map <- "https://api.mapbox.com/styles/v1/skaisericprb/citvqu6qb002p2jo1ig5hnvtk/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoic2thaXNlcmljcHJiIiwiYSI6ImNpa2U3cGN1dDAwMnl1cm0yMW94bWNxbDEifQ.pEG_X7fqCAowSN8Xr6rX8g"
    leaflet::leaflet(options = leaflet::leafletOptions(maxBoundsViscosity = 1)) %>%
      #leaflet::addTiles(urlTemplate = icprb.map, options = leaflet::tileOptions(minZoom = 7, maxZoom = 18)) %>%
      leaflet::addTiles() %>% 
      leaflet::addMarkers(~LongitudeMeasure, ~LatitudeMeasure, data = data.df,
                          popup = ~as.character(MonitoringLocationName),
                          label = ~as.character(MonitoringLocationName),
                          clusterOptions = leaflet::markerClusterOptions(
                            spiderLegPolylineOptions = list(weight = 4, color = "#222", opacity = 0.5))) %>%
      leaflet::setMaxBounds(lng1 = -81, lat1 = 38.5, lng2 = -75, lat2 = 39.5) %>%
      leaflet::setView(-78.110291, lat = 39.029230, zoom = 8)
  }) # End output$MAP
}