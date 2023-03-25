library(tidyverse)
library(tidycensus)
library(leaflet)
library(sf)
library(tigris)
library(leaflet.extras)
library(leaflet.providers)
library(htmlwidgets)
library(htmltools)


my_states <- c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY")

my_vars <- c(population = "B01003_001")

# Get the total population and total number of housing units for each census tract
tracts <- get_acs(geography = "tract",
                  variables = my_vars,
                  state = "CA",
                  survey = "acs5",
                  year = 2021,
                  geometry = TRUE) 
# %>% erase_water(year=2020)

floodmap_tracts <- left_join(tracts,flood_tract_chart,by=c("GEOID"="fips"))

bins <- c(0, 20, 40, 50, 80, 100)
floodpal <- colorBin("BuPu", domain = floodmap_tracts$pct_major, bins = bins)

floodmap <- leaflet(floodmap_tracts) %>%
  setView(-116, 43.5, zoom = 5) %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(weight = 0.4, smoothFactor = 0.1, fillOpacity = 0.6,
              color = ~floodpal(pct_major)) %>%
  addLegend(opacity = 0.6,
            values = floodmap_tracts$pct_major, 
            pal = floodpal,
            position = "bottomleft")
floodmap

heatmap_tracts <- left_join(tracts,heat_tract_chart,by=c("GEOID"="fips"))

bins <- c(0, 5, 25, 50, 60, 70, 80, 90, 100)
heatpal <- colorBin("BuPu", domain = heatmap_tracts$pct_major, bins = bins)

heatmap <- leaflet(heatmap_tracts) %>%
  setView(-116, 43.5, zoom = 5) %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addProviderTiles(providers$Stamen.TonerLines) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(weight = 0, smoothFactor = 0.05, fillOpacity = 0.7,
              color = ~heatpal(pct_major)) %>%
  addLegend(opacity = 0.7,
            values = heatmap_tracts$pct_major, 
            pal = heatpal,
            position = "bottomleft")
heatmap

windmap_tracts <- left_join(tracts,wind_tract_chart,by=c("GEOID"="fips"))

bins <- c(0, 5, 25, 50, 60, 70, 80, 90, 100)
windpal <- colorBin("BuPu", domain = windmap_tracts$pct_major, bins = bins)

windmap <- leaflet(windmap_tracts) %>%
  setView(-116, 43.5, zoom = 5) %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addProviderTiles(providers$Stamen.TonerLines) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(weight = 0, smoothFactor = 0.05, fillOpacity = 0.7,
              color = ~windpal(pct_major)) %>%
  addLegend(opacity = 0.7,
            values = windmap_tracts$pct_major, 
            pal = heatpal,
            position = "bottomleft")
windmap



library(tidycensus)

my_vars <- c(population = "B01003_001")

# Get the total population and total number of housing units for each census tract
zips <- get_acs(geography = "zip code tabulation area",
                variables = my_vars,
                survey = "acs5",
                year = 2021,
                geometry = TRUE)

firemap_zips <- left_join(zips,fire_zip_chart,by=c("GEOID"="fips"))

qpal <- colorBin("Blues", firemap_zips$pct_major, 5)

firemap <- leaflet(firemap_zips) %>%
  setView(-116, 43.5, zoom = 5) %>% 
  addProviderTiles(providers$Esri.WorldTerrain) %>%
  addProviderTiles(providers$Stamen.TonerLines) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(stroke = FALSE, smoothFactor = 0.2, fillOpacity = 1,
              color = ~qpal(pct_major))
firemap

floodmap_zips <- left_join(zips,flood_zip_chart,by=c("GEOID"="fips"))

qpal <- colorBin("viridis", floodmap_zips$pct_major, 5)

floodmap <- leaflet(floodmap_zips) %>%
  setView(-108, 43.5, zoom = 5) %>% 
  addProviderTiles(providers$Esri.WorldTerrain) %>%
  addProviderTiles(providers$Stamen.TonerLines) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(weight=0.8, smoothFactor = 0.2, fillOpacity = 0.6,
              color = ~qpal(pct_major))
floodmap


heatmap_zips <- left_join(zips,heat_zip_chart,by=c("GEOID"="fips"))

qpal <- colorBin("BuPu", heatmap_zips$pct_major, 5)

heatmap <- leaflet(heatmap_zips) %>%
  setView(-108, 43.5, zoom = 5) %>% 
  addProviderTiles(providers$Esri.WorldTerrain) %>%
  addProviderTiles(providers$Stamen.TonerLines) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(weight=0.8, smoothFactor = 0.2, fillOpacity = 0.6,
              color = ~qpal(pct_major))
heatmap

windmap_zips <- left_join(zips,wind_zip_chart,by=c("GEOID"="fips"))

qpal <- colorBin("BuPu", windmap_zips$pct_major, 10)

windmap <- leaflet(windmap_zips) %>%
  setView(-108, 43.5, zoom = 5) %>% 
  addProviderTiles(providers$Esri.WorldTerrain) %>%
  addProviderTiles(providers$Stamen.TonerLines) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(weight=0.8, smoothFactor = 0.2, fillOpacity = 0.6,
              color = ~qpal(pct_major)) %>%
  addLegend(opacity = 0.7,
            values = windmap_zips$pct_major, 
            pal = qpal,
            position = "bottomleft")
windmap





# Get the total population and total number of housing units for each census tract
counties <- get_acs(geography = "county",
                    variables = my_vars,
                    survey = "acs5",
                    output = 'wide',
                    year = 2021,
                    geometry = TRUE)
counties <- st_simplify(counties, dTolerance = 300)



qpal <- colorBin("viridis", counties$populationE, 9)

countymap <- leaflet() %>%
  setView(-95.93, 41.2, zoom = 4) %>% 
  addProviderTiles(providers$Esri.WorldTerrain) %>%
  addProviderTiles(providers$Stamen.TonerLines) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(data = counties, weight=0.5, smoothFactor = 0.2, fillOpacity = 0.7,
              color = ~qpal(populationE))
countymap

firemap_counties <- left_join(counties,fire_county_chart,by=c("GEOID"="fips"))

qpal <- colorBin("viridis", firemap_counties$pct_major, 10)

firemap <- leaflet() %>%
  setView(-95.93, 41.2, zoom = 4) %>% 
  addProviderTiles(providers$Esri.WorldTerrain) %>%
  addProviderTiles(providers$Stamen.TonerLines) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(data = firemap_counties, weight=0.5, smoothFactor = 0.2, fillOpacity = 0.7,
              color = ~qpal(pct_major)) %>%
  addLegend(opacity = 0.7,
            values = firemap_counties$pct_major, 
            pal = qpal,
            position = "bottomleft")
firemap



heatmap_counties <- left_join(counties,heat_county_chart,by=c("GEOID"="fips"))

qpal <- colorBin("viridis", heatmap_counties$pct_major, 10)

heatmap <- leaflet() %>%
  setView(-95.93, 41.2, zoom = 4) %>% 
  addProviderTiles(providers$Esri.WorldTerrain) %>%
  addProviderTiles(providers$Stamen.TonerLines) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(data = heatmap_counties, weight=0.8, smoothFactor = 0.3, fillOpacity = 0.7,
              color = ~qpal(pct_major)) %>%
  addLegend(opacity = 0.7,
            values = heatmap_counties$pct_major, 
            pal = qpal,
            position = "bottomleft")
heatmap



floodmap_counties <- left_join(counties,flood_county_chart,by=c("GEOID"="fips"))

qpal <- colorBin("viridis", floodmap_counties$pct_major, 10)

floodmap <- leaflet() %>%
  setView(-95.93, 41.2, zoom = 4) %>% 
  addProviderTiles(providers$Esri.WorldTerrain) %>%
  addProviderTiles(providers$Stamen.TonerLines) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(data = floodmap_counties, weight=0.8, smoothFactor = 0.2, fillOpacity = 0.7,
              color = ~qpal(pct_major)) %>%
  addLegend(opacity = 0.7,
            values = floodmap_counties$pct_major, 
            pal = qpal,
            position = "bottomleft")
floodmap

windmap_counties <- left_join(counties,wind_county_chart,by=c("GEOID"="fips"))

qpal <- colorBin("viridis", windmap_counties$pct_major, 10)

windmap <- leaflet(options = leafletOptions(zoomControl = FALSE, zoomSnap = 0.5, zoomDelta=0.5)) %>%
  htmlwidgets::onRender("function(el, x) {
L.control.zoom({ position: 'topright' }).addTo(this)
}") %>%
  setView(-95.93, 41.2, zoom = 4) %>% 
  addProviderTiles(providers$Esri.WorldTerrain) %>%
  addProviderTiles(providers$Stamen.TonerLines) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(data = windmap_counties, weight=0.8, smoothFactor = 0.2, fillOpacity = 0.7,
              color = ~qpal(pct_major)) %>%
  addLegend(opacity = 0.7,
            values = windmap_counties$pct_major, 
            pal = qpal,
            position = "bottomleft") %>% 
  addSearchOSM(options = searchOptions(collapsed=FALSE, minLength = 3, zoom=13, position="topleft", autoCollapse = T)) %>%
  onRender("function(el, x) {
        $('input.search-input')[0].placeholder = 'Search street, place or zip code'
        }") 
windmap






