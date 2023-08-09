library(tidyverse)
library(sf)

# Import the basic tables for each type of risk factor BY STATE
# From the raw data provided by First Street Foundation via AWS

fire_state <- read_csv("raw_data/fire_v2.0_summary_fsf_fire_state_summary.csv") %>% filter(!is.na(count_property))
heat_state <- read_csv("raw_data/heat_v1.1_summary_fsf_heat_state_summary.csv") %>% filter(!is.na(count_property))
flood_state <- read_csv("raw_data/flood_v3.0_summary_fsf_flood_state_summary.csv") %>% filter(!is.na(count_property))
wind_state <- read_csv("raw_data/wind_v1.0_summary_fsf_wind_state_summary.csv") %>% filter(!is.na(count_property))

# Create simpler table of number/share of properties above major/severe levels
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
  select(1,2,3,14,15,16,17)

# Create simpler table of number/share of properties above major/severe levels
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
  select(1,2,3,14,15,16,17)

# Create simpler table of number/share of properties above major/severe levels
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
  select(1,2,3,14,15,16,17)

# Create simpler table of number/share of properties above major/severe levels
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
  select(1,2,3,14,15,16,17)

# Output csv files of counties tables
flood_state_chart %>% write_csv("data_tables/flood_state_chart.csv")
heat_state_chart %>% write_csv("data_tables/heat_state_chart.csv")
fire_state_chart %>% write_csv("data_tables/fire_state_chart.csv")
wind_state_chart %>% write_csv("data_tables/wind_state_chart.csv")

# Join with census/tiger tract map files
windmap_states <- left_join(states,wind_state_chart,by=c("geoid"="fips"))
heatmap_states <- left_join(states,heat_state_chart,by=c("geoid"="fips"))
firemap_states <- left_join(states,fire_state_chart,by=c("geoid"="fips"))
floodmap_states <- left_join(states,flood_state_chart,by=c("geoid"="fips"))

# Output geojsons to directory for use in production interactive
floodmap_states %>% st_write("data_geojson/state_flood_risk.geojson")
heatmap_states %>% st_write("data_geojson/state_heat_risk.geojson")
firemap_states %>% st_write("data_geojson/state_fire_risk.geojson")
windmap_states %>% st_write("data_geojson/state_wind_risk.geojson")



