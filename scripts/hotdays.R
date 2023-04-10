library(tidyverse)
library(tidycensus)
library(leaflet)
library(readxl)


hotdays_zips <- read_excel("heat-press-export-full.xlsx", 
                                     sheet = "zcta-level")

hotdays_zips <- hotdays_zips %>%
  select(1,2:5,11,12,25,26) %>%
  write_csv("hotdays_zips.csv")

hotdays_zips <- left_join(zips,hotdays_zips,by=c("GEOID"="geoid (zcta)"))

qpal <- colorBin("BuPu", hotdays_zips$change_days_above_100, 5)

hotdaysmap <- leaflet(hotdays_zips) %>%
  setView(-116, 43.5, zoom = 5) %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addProviderTiles(providers$Stamen.TonerLabels) %>%
  addPolygons(stroke = FALSE, smoothFactor = 0.1, fillOpacity = 0.6,
              color = ~qpal(change_days_above_100)) %>%
  addLegend(opacity = 0.6,
            values = hotdays_zips$change_days_above_100, 
            pal = qpal,
            position = "bottomleft")
hotdaysmap



hotdays_zips_cali <- hotdays_zips %>%
  filter(state_abbr =="ca") %>%
  select(1,2:5,11,12,25,26) %>%
  write_csv("hotdays_zips_cali.csv")

hotdays_zips_ny <- hotdays_zips %>%
  filter(state_abbr == "ny" | state_abbr == "nj") %>%
  select(1,2:5,11,12,25,26) %>%
  write_csv("hotdays_zips_nynj.csv")

hotdays_zips_phi <- hotdays_zips %>%
  filter(state_abbr == "pa" | state_abbr == "nj" | state_abbr == "de") %>%
  select(1,2:5,11,12,25,26) %>%
  write_csv("hotdays_zips_philly.csv")

hotdays_zips_hou <- hotdays_zips %>%
  filter(state_abbr == "tx") %>%
  select(1,2:5,11,12,25,26) %>%
  write_csv("hotdays_zips_tx.csv")

hotdays_zips_chi <- hotdays_zips %>%
  filter(state_abbr == "il") %>%
  select(1,2:5,11,12,25,26) %>%
  write_csv("hotdays_zips_il.csv")
