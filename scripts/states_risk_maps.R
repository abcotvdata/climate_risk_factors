# library(tidyverse)
library(leaflet)
library(leaflet.extras)
library(leaflet.providers)
library(htmlwidgets)
library(htmltools)
library(MetBrewer)

# Set color scale across all maps
colors = met.brewer(name="Tam", n=10)
# Set bins across all maps
bins <- c(0, 5, 25, 50, 60, 70, 80, 90, 100)


## FLOOD MAP 
# Set pal for colors
floodpal <- colorBin(c(colors), domain = floodmap_states$pct_major, bins = bins)
# Create leaflet map
map_flood_states <- leaflet(options = leafletOptions(zoomControl = FALSE, zoomSnap = 0.5, zoomDelta=0.5)) %>%
  htmlwidgets::onRender("function(el, x) {
L.control.zoom({ position: 'topright' }).addTo(this)
}") %>%
#  setView(-118.2, 33.89, zoom = 9) %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(data = floodmap_states, weight = 0.4, smoothFactor = 0.1, fillOpacity = 0.6,
              color = ~floodpal(pct_major)) %>%
  addLegend(opacity = 0.6,
            values = floodmap_states$pct_major, 
            pal = floodpal,
            position = "bottomleft") %>% 
  addSearchOSM(options = searchOptions(collapsed=FALSE, minLength = 3, zoom=13, position="topleft")) %>%
  onRender("function(el, x) {
        $('input.search-input')[0].placeholder = 'Search street, place or zip code'
        }")

# map_flood_states
# rm(map_flood_states)

## HEAT MAP 
# Set pal for colors
heatpal <- colorBin(c(colors), domain = heatmap_states$pct_major, bins = bins)
# Create leaflet map
map_heat_states <- leaflet(options = leafletOptions(zoomControl = FALSE, zoomSnap = 0.5, zoomDelta=0.5)) %>%
  htmlwidgets::onRender("function(el, x) {
L.control.zoom({ position: 'topright' }).addTo(this)
}") %>%
#  setView(-118.2, 33.89, zoom = 9) %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addProviderTiles(providers$Stamen.TonerLines) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(data = heatmap_states, weight = 0, smoothFactor = 0.05, fillOpacity = 0.7,
              color = ~heatpal(pct_major)) %>%
  addLegend(opacity = 0.7,
            values = heatmap_states$pct_major, 
            pal = heatpal,
            position = "bottomleft") %>% 
  addSearchOSM(options = searchOptions(collapsed=FALSE, minLength = 3, zoom=13, position="topleft")) %>%
  onRender("function(el, x) {
        $('input.search-input')[1].placeholder = 'Search street, place or zip code'
        }") 

# map_heat_states
# rm(map_heat_states)

## WIND MAP 
# Set pal for colors
windpal <- colorBin(c(colors), domain = windmap_states$pct_major, bins = bins)
# Create leaflet map
map_wind_states <- leaflet(options = leafletOptions(zoomControl = FALSE, zoomSnap = 0.5, zoomDelta=0.5)) %>%
  htmlwidgets::onRender("function(el, x) {
L.control.zoom({ position: 'topright' }).addTo(this)
}") %>%
#  setView(-118.2, 33.89, zoom = 9) %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addProviderTiles(providers$Stamen.TonerLines) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(data = windmap_states, weight = 0, smoothFactor = 0.05, fillOpacity = 0.7,
              color = ~windpal(pct_major)) %>%
  addLegend(opacity = 0.7,
            values = windmap_states$pct_major, 
            pal = heatpal,
            position = "bottomleft") %>% 
  addSearchOSM(options = searchOptions(collapsed=FALSE, minLength = 3, zoom=13, position="topleft")) %>%
  onRender("function(el, x) {
        $('input.search-input')[2].placeholder = 'Search street, place or zip code'
        }") 

# map_wind_states
# rm(map_wind_states)

## FIRE MAP 
# Set pal for colors
firepal <- colorBin(c(colors), domain = firemap_states$pct_major, bins = bins)
# Create leaflet map
map_fire_states <- leaflet(options = leafletOptions(zoomControl = FALSE, zoomSnap = 0.5, zoomDelta=0.5)) %>%
  htmlwidgets::onRender("function(el, x) {
L.control.zoom({ position: 'topright' }).addTo(this)
}") %>%
#  setView(-118.2, 33.89, zoom = 9) %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addProviderTiles(providers$Stamen.TonerLines) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(data = firemap_states, weight = 0, smoothFactor = 0.05, fillOpacity = 0.7,
              color = ~firepal(pct_major)) %>%
  addLegend(opacity = 0.7,
            values = firemap_states$pct_major, 
            pal = firepal,
            position = "bottomleft") %>% 
  addSearchOSM(options = searchOptions(collapsed=FALSE, minLength = 3, zoom=13, position="topleft")) %>%
  onRender("function(el, x) {
        $('input.search-input')[3].placeholder = 'Search street, place or zip code'
        }")

# map_fire_states
# rm(map_fire_states)

