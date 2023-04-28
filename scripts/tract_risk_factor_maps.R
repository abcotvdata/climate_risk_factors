library(tidyverse)
library(tidycensus)
library(leaflet)
library(sf)
library(tigris)
library(leaflet.extras)
library(leaflet.providers)
library(htmlwidgets)
library(htmltools)
library(MetBrewer)

colors = met.brewer(name="Tam", n=10)

my_states <- c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY")

my_vars <- c(population = "B01003_001")

# Get the total population and total number of housing units for each census tract
tracts <- get_acs(geography = "tract",
                  variables = my_vars,
                  state = my_states,
                  survey = "acs5",
                  year = 2021,
                  geometry = TRUE) 
# %>% erase_water(year=2020)


floodmap_tracts <- left_join(tracts,flood_tract_chart,by=c("GEOID"="fips"))

bins <- c(0, 5, 25, 50, 60, 70, 80, 90, 100)
floodpal <- colorBin(c(colors), domain = floodmap_tracts$pct_major, bins = bins)

floodmap_local <- leaflet(options = leafletOptions(zoomControl = FALSE, zoomSnap = 0.5, zoomDelta=0.5)) %>%
  htmlwidgets::onRender("function(el, x) {
L.control.zoom({ position: 'topright' }).addTo(this)
}") %>%
  setView(-118.2, 33.89, zoom = 9) %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(data = floodmap_tracts, weight = 0.4, smoothFactor = 0.1, fillOpacity = 0.6,
              color = ~floodpal(pct_major)) %>%
  addLegend(opacity = 0.6,
            values = floodmap_tracts$pct_major, 
            pal = floodpal,
            position = "bottomleft") %>% 
  addSearchOSM(options = searchOptions(collapsed=FALSE, minLength = 3, zoom=13, position="topleft")) %>%
  onRender("function(el, x) {
        $('input.search-input')[0].placeholder = 'Search street, place or zip code'
        }") 

heatmap_tracts <- left_join(tracts,heat_tract_chart,by=c("GEOID"="fips"))

bins <- c(0, 5, 25, 50, 60, 70, 80, 90, 100)
heatpal <- colorBin(c(colors), domain = heatmap_tracts$pct_major, bins = bins)

heatmap_local <- leaflet(options = leafletOptions(zoomControl = FALSE, zoomSnap = 0.5, zoomDelta=0.5)) %>%
  htmlwidgets::onRender("function(el, x) {
L.control.zoom({ position: 'topright' }).addTo(this)
}") %>%
  setView(-118.2, 33.89, zoom = 9) %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addProviderTiles(providers$Stamen.TonerLines) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(data = heatmap_tracts, weight = 0, smoothFactor = 0.05, fillOpacity = 0.7,
              color = ~heatpal(pct_major)) %>%
  addLegend(opacity = 0.7,
            values = heatmap_tracts$pct_major, 
            pal = heatpal,
            position = "bottomleft") %>% 
  addSearchOSM(options = searchOptions(collapsed=FALSE, minLength = 3, zoom=13, position="topleft")) %>%
  onRender("function(el, x) {
        $('input.search-input')[1].placeholder = 'Search street, place or zip code'
        }") 

windmap_tracts <- left_join(tracts,wind_tract_chart,by=c("GEOID"="fips"))

bins <- c(0, 5, 25, 50, 60, 70, 80, 90, 100)
windpal <- colorBin(c(colors), domain = windmap_tracts$pct_major, bins = bins)

windmap_local <- leaflet(options = leafletOptions(zoomControl = FALSE, zoomSnap = 0.5, zoomDelta=0.5)) %>%
  htmlwidgets::onRender("function(el, x) {
L.control.zoom({ position: 'topright' }).addTo(this)
}") %>%
  setView(-118.2, 33.89, zoom = 9) %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addProviderTiles(providers$Stamen.TonerLines) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(data = windmap_tracts, weight = 0, smoothFactor = 0.05, fillOpacity = 0.7,
              color = ~windpal(pct_major)) %>%
  addLegend(opacity = 0.7,
            values = windmap_tracts$pct_major, 
            pal = heatpal,
            position = "bottomleft") %>% 
  addSearchOSM(options = searchOptions(collapsed=FALSE, minLength = 3, zoom=13, position="topleft")) %>%
  onRender("function(el, x) {
        $('input.search-input')[2].placeholder = 'Search street, place or zip code'
        }") 

firemap_tracts <- left_join(tracts,fire_tract_chart,by=c("GEOID"="fips"))

bins <- c(0, 5, 25, 50, 60, 70, 80, 90, 100)
firepal <- colorBin(c(colors), domain = firemap_tracts$pct_major, bins = bins)

firemap_local <- leaflet(options = leafletOptions(zoomControl = FALSE, zoomSnap = 0.5, zoomDelta=0.5)) %>%
  htmlwidgets::onRender("function(el, x) {
L.control.zoom({ position: 'topright' }).addTo(this)
}") %>%
  setView(-118.2, 33.89, zoom = 9) %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addProviderTiles(providers$Stamen.TonerLines) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(data = firemap_tracts, weight = 0, smoothFactor = 0.05, fillOpacity = 0.7,
              color = ~firepal(pct_major)) %>%
  addLegend(opacity = 0.7,
            values = firemap_tracts$pct_major, 
            pal = firepal,
            position = "bottomleft") %>% 
  addSearchOSM(options = searchOptions(collapsed=FALSE, minLength = 3, zoom=13, position="topleft")) %>%
  onRender("function(el, x) {
        $('input.search-input')[3].placeholder = 'Search street, place or zip code'
        }") 

floodmap_tracts %>% st_simplify(dTolerance = 300) %>% st_write("data_geojson/tract_flood_risk.geojson")
heatmap_tracts %>% st_simplify(dTolerance = 300) %>% st_write("data_geojson/tract_heat_risk.geojson")
firemap_tracts %>% st_simplify(dTolerance = 300) %>% st_write("data_geojson/tract_fire_risk.geojson")
windmap_tracts %>% st_simplify(dTolerance = 300) %>% st_write("data_geojson/tract_wind_risk.geojson")
