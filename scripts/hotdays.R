library(tidyverse)
library(tidycensus)
library(leaflet)
library(readxl)
library(rmapshaper)
library(MetBrewer)

hotdays_zips <- read_excel("data/heat-press-export-full.xlsx", 
                                     sheet = "zcta-level")

hotdays_tracts <- read_excel("data/heat-press-export-full.xlsx", 
                           sheet = "tract-level")

hotdays_zips <- hotdays_zips %>%
  select(1,2:5,11,12,25,26) %>%
  filter(!is.na(hotdays_zips$count_prop)) %>%
  write_csv("hotdays_zips.csv")

hotdays_tracts <- hotdays_tracts %>%
  select(1,2:5,11,12,25,26) %>%
  filter(!is.na(hotdays_tracts$count_prop)) %>%
  write_csv("hotdays_tracts.csv")


hotdays_zips <- left_join(zips,hotdays_zips,by=c("geoid"="geoid (zcta)")) %>%
  ms_simplify(keep = 0.1, keep_shapes = FALSE)

hotdays_tracts <- left_join(tracts,hotdays_tracts,by=c("geoid"="geoid (tract)")) %>%
  ms_simplify(keep = 0.05, keep_shapes = FALSE)

# Set color scale across all maps
colors = met.brewer(name="Tam", n=5)
# Set bins across all maps
bins <- c(0, 50, 100, 200, 500, 1000)
# qpal <- colorBin("BuPu", hotdays_zips$change_perc_above_100, 10)
qpal <- colorBin(c(colors), domain = hotdays_zips$change_perc_above_100, bins = bins)

hotdaysmap <- leaflet(hotdays_zips) %>%
  setView(-116, 43.5, zoom = 5) %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(stroke = FALSE, smoothFactor = 0.1, fillOpacity = 0.6,
              color = ~qpal(change_perc_above_100)) %>%
  addLegend(opacity = 0.6,
            values = hotdays_zips$change_perc_above_100, 
            pal = qpal,
            position = "topright")
hotdaysmap

hotdaysmap_tracts <- leaflet(hotdays_tracts) %>%
  setView(-116, 43.5, zoom = 5) %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(stroke = FALSE, smoothFactor = 0.1, fillOpacity = 0.6,
              color = ~qpal(change_perc_above_100)) %>%
  addLegend(opacity = 0.6,
            values = hotdays_tracts$change_perc_above_100, 
            pal = qpal,
            position = "topright")
hotdaysmap_tracts


hotdays_zips_cali <- hotdays_zips %>%
  filter(state_abbr =="ca") %>%
#  select(1,2:5,11,12,25,26) %>%
  write_csv("hotdays_zips_cali.csv")

hotdays_zips_ny <- hotdays_zips %>%
  filter(state_abbr == "ny" | state_abbr == "nj") %>%
#  select(1,2:5,11,12,25,26) %>%
  write_csv("hotdays_zips_nynj.csv")

hotdays_zips_phi <- hotdays_zips %>%
  filter(state_abbr == "pa" | state_abbr == "nj" | state_abbr == "de") %>%
#  select(1,2:5,11,12,25,26) %>%
  write_csv("hotdays_zips_philly.csv")

hotdays_zips_hou <- hotdays_zips %>%
  filter(state_abbr == "tx") %>%
#  select(1,2:5,11,12,25,26) %>%
  write_csv("hotdays_zips_tx.csv")

hotdays_zips_chi <- hotdays_zips %>%
  filter(state_abbr == "il") %>%
#  select(1,2:5,11,12,25,26) %>%
  write_csv("hotdays_zips_il.csv")
