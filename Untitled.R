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


fire_state <- read_csv("raw_data/fire_v1.1_summary_fsf_fire_state_summary.csv")

heat_state <- read_csv("raw_data/heat_v1.1_summary_fsf_heat_state_summary.csv")

flood_state <- read_csv("raw_data/flood_v2.1_summary_fsf_flood_state_summary.csv")

wind_state <- read_csv("raw_data/wind_v1.0_summary_fsf_wind_state_summary.csv")

state <- get_acs(geography = "state",
                    variables = my_vars,
                    state = my_states,
                    survey = "acs5",
                    output = 'wide',
                    year = 2021,
                    geometry = TRUE)

fire_state_chart <- fire_state %>%
  mutate(pct_major = round((fire_state$count_firefactor5+
                              fire_state$count_firefactor6+
                              fire_state$count_firefactor7+
                              fire_state$count_firefactor8+
                              fire_state$count_firefactor9+
                              fire_state$count_firefactor10)/
                             fire_state$count_property*100,1),
         pct_severe = round((fire_state$count_firefactor7+
                               fire_state$count_firefactor8+
                               fire_state$count_firefactor9+
                               fire_state$count_firefactor10)/
                              fire_state$count_property*100,1),
         number_major = fire_state$count_firefactor5+
           fire_state$count_firefactor6+
           fire_state$count_firefactor7+
           fire_state$count_firefactor8+
           fire_state$count_firefactor9+
           fire_state$count_firefactor10,
         number_severe = fire_state$count_firefactor7+
           fire_state$count_firefactor8+
           fire_state$count_firefactor9+
           fire_state$count_firefactor10) %>%
  select(1,2,3,13,14,15,16,17)

#fire_state_chart$state <- substr(fire_tract$fips,1,2)
#fire_tract_chart$tract <- substr(fire_tract$fips,3,11)
#fire_tract_chart$county <- substr(fire_tract$fips,1,5)

flood_state_chart <- flood_state %>%
  mutate(pct_major = round((flood_state$count_floodfactor5+
                              flood_state$count_floodfactor6+
                              flood_state$count_floodfactor7+
                              flood_state$count_floodfactor8+
                              flood_state$count_floodfactor9+
                              flood_state$count_floodfactor10)/
                             flood_state$count_property*100,1),
         pct_severe = round((flood_state$count_floodfactor7+
                               flood_state$count_floodfactor8+
                               flood_state$count_floodfactor9+
                               flood_state$count_floodfactor10)/
                              flood_state$count_property*100,1),
         number_major = flood_state$count_floodfactor5+
           flood_state$count_floodfactor6+
           flood_state$count_floodfactor7+
           flood_state$count_floodfactor8+
           flood_state$count_floodfactor9+
           flood_state$count_floodfactor10,
         number_severe = flood_state$count_floodfactor7+
           flood_state$count_floodfactor8+
           flood_state$count_floodfactor9+
           flood_state$count_floodfactor10) %>%
  select(1,2,3,13,14,15,16,17)


#flood_tract_chart$state <- substr(flood_tract$fips,1,2)
#flood_tract_chart$tract <- substr(flood_tract$fips,3,11)
#flood_tract_chart$county <- substr(flood_tract$fips,1,5)

heat_state_chart <- heat_state %>%
  mutate(pct_major = round((heat_state$count_heatfactor5+
                              heat_state$count_heatfactor6+
                              heat_state$count_heatfactor7+
                              heat_state$count_heatfactor8+
                              heat_state$count_heatfactor9+
                              heat_state$count_heatfactor10)/
                             heat_state$count_property*100,1),
         pct_severe = round((heat_state$count_heatfactor7+
                               heat_state$count_heatfactor8+
                               heat_state$count_heatfactor9+
                               heat_state$count_heatfactor10)/
                              heat_state$count_property*100,1),
         number_major = heat_state$count_heatfactor5+
           heat_state$count_heatfactor6+
           heat_state$count_heatfactor7+
           heat_state$count_heatfactor8+
           heat_state$count_heatfactor9+
           heat_state$count_heatfactor10,
         number_severe = heat_state$count_heatfactor7+
           heat_state$count_heatfactor8+
           heat_state$count_heatfactor9+
           heat_state$count_heatfactor10) %>%
  select(1,2,3,13,14,15,16,17)

#heat_tract_chart$state <- substr(heat_tract$fips,1,2)
#heat_tract_chart$tract <- substr(heat_tract$fips,3,11)
#heat_tract_chart$county <- substr(heat_tract$fips,1,5)

wind_state_chart <- wind_state %>%
  mutate(pct_major = round((wind_state$count_windfactor5+
                              wind_state$count_windfactor6+
                              wind_state$count_windfactor7+
                              wind_state$count_windfactor8+
                              wind_state$count_windfactor9+
                              wind_state$count_windfactor10)/
                             wind_state$count_property*100,1),
         pct_severe = round((wind_state$count_windfactor7+
                               wind_state$count_windfactor8+
                               wind_state$count_windfactor9+
                               wind_state$count_windfactor10)/
                              wind_state$count_property*100,1),
         number_major = wind_state$count_windfactor5+
           wind_state$count_windfactor6+
           wind_state$count_windfactor7+
           wind_state$count_windfactor8+
           wind_state$count_windfactor9+
           wind_state$count_windfactor10,
         number_severe = wind_state$count_windfactor7+
           wind_state$count_windfactor8+
           wind_state$count_windfactor9+
           wind_state$count_windfactor10) %>%
  select(1,2,3,13,14,15,16,17)

#wind_state_chart$state <- substr(wind$fips,1,2)
#wind_tract_chart$tract <- substr(wind_tract$fips,3,11)
#wind_tract_chart$county <- substr(wind_tract$fips,1,5)

flood_state_chart %>% write_csv("data_tables/flood_state_chart.csv")
heat_state_chart %>% write_csv("data_tables/heat_state_chart.csv")
fire_state_chart %>% write_csv("data_tables/fire_state_chart.csv")
wind_state_chart %>% write_csv("data_tables/wind_state_chart.csv")

