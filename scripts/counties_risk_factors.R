library(tidyverse)
library(stringr)
library(sf)

# Import the basic tables for each type of risk factor BY COUNTY
# From the raw data provided by First Street Foundation via AWS

fire_county <- read_csv("raw_data/fire_v2.0_summary_fsf_fire_county_summary.csv")
heat_county <- read_csv("raw_data/heat_v1.1_summary_fsf_heat_county_summary.csv")
flood_county <- read_csv("raw_data/flood_v3.0_summary_fsf_flood_county_summary.csv")
wind_county <- read_csv("raw_data/wind_v1.0_summary_fsf_wind_county_summary.csv")

# Create simpler table of number/share of properties above major/severe levels
fire_county_chart <- fire_county %>%
  mutate(pct_major = round((fire_county$count_firefactor5+
                        fire_county$count_firefactor6+
                        fire_county$count_firefactor7+
                        fire_county$count_firefactor8+
                        fire_county$count_firefactor9+
                        fire_county$count_firefactor10)/
           fire_county$count_property*100,1),
         pct_severe = round((fire_county$count_firefactor7+
                        fire_county$count_firefactor8+
                        fire_county$count_firefactor9+
                        fire_county$count_firefactor10)/
           fire_county$count_property*100,1),
         number_major = fire_county$count_firefactor5+
           fire_county$count_firefactor6+
           fire_county$count_firefactor7+
           fire_county$count_firefactor8+
           fire_county$count_firefactor9+
           fire_county$count_firefactor10,
         number_severe = fire_county$count_firefactor7+
           fire_county$count_firefactor8+
           fire_county$count_firefactor9+
           fire_county$count_firefactor10) %>%
  select(1,2,3,14,15,16,17)

# Create simpler table of number/share of properties above major/severe levels
flood_county_chart <- flood_county %>%
  mutate(pct_major = round((flood_county$count_floodfactor5+
                              flood_county$count_floodfactor6+
                              flood_county$count_floodfactor7+
                              flood_county$count_floodfactor8+
                              flood_county$count_floodfactor9+
                              flood_county$count_floodfactor10)/
                             flood_county$count_property*100,1),
         pct_severe = round((flood_county$count_floodfactor7+
                                flood_county$count_floodfactor8+
                                flood_county$count_floodfactor9+
                                flood_county$count_floodfactor10)/
                               flood_county$count_property*100,1),
         number_major = flood_county$count_floodfactor5+
           flood_county$count_floodfactor6+
           flood_county$count_floodfactor7+
           flood_county$count_floodfactor8+
           flood_county$count_floodfactor9+
           flood_county$count_floodfactor10,
         number_severe = flood_county$count_floodfactor7+
           flood_county$count_floodfactor8+
           flood_county$count_floodfactor9+
           flood_county$count_floodfactor10) %>%
  select(1,2,3,14,15,16,17)

# Create simpler table of number/share of properties above major/severe levels
heat_county_chart <- heat_county %>%
  mutate(pct_major = round((heat_county$count_heatfactor5+
                              heat_county$count_heatfactor6+
                              heat_county$count_heatfactor7+
                              heat_county$count_heatfactor8+
                              heat_county$count_heatfactor9+
                              heat_county$count_heatfactor10)/
                             heat_county$count_property*100,1),
         pct_severe = round((heat_county$count_heatfactor7+
                                heat_county$count_heatfactor8+
                                heat_county$count_heatfactor9+
                                heat_county$count_heatfactor10)/
                               heat_county$count_property*100,1),
         number_major = heat_county$count_heatfactor5+
           heat_county$count_heatfactor6+
           heat_county$count_heatfactor7+
           heat_county$count_heatfactor8+
           heat_county$count_heatfactor9+
           heat_county$count_heatfactor10,
         number_severe = heat_county$count_heatfactor7+
           heat_county$count_heatfactor8+
           heat_county$count_heatfactor9+
           heat_county$count_heatfactor10) %>%
  select(1,2,3,14,15,16,17)

# Create simpler table of number/share of properties above major/severe levels
wind_county_chart <- wind_county %>%
  mutate(pct_major = round((wind_county$count_windfactor5+
                              wind_county$count_windfactor6+
                              wind_county$count_windfactor7+
                              wind_county$count_windfactor8+
                              wind_county$count_windfactor9+
                              wind_county$count_windfactor10)/
                             wind_county$count_property*100,1),
         pct_severe = round((wind_county$count_windfactor7+
                               wind_county$count_windfactor8+
                               wind_county$count_windfactor9+
                               wind_county$count_windfactor10)/
                              wind_county$count_property*100,1),
         number_major = wind_county$count_windfactor5+
           wind_county$count_windfactor6+
           wind_county$count_windfactor7+
           wind_county$count_windfactor8+
           wind_county$count_windfactor9+
           wind_county$count_windfactor10,
         number_severe = wind_county$count_windfactor7+
           wind_county$count_windfactor8+
           wind_county$count_windfactor9+
           wind_county$count_windfactor10) %>%
  select(1,2,3,14,15,16,17)

# Output csv files of counties tables
flood_county_chart %>% write_csv("data_tables/flood_county_chart.csv")
heat_county_chart %>% write_csv("data_tables/heat_county_chart.csv")
fire_county_chart %>% write_csv("data_tables/fire_county_chart.csv")
wind_county_chart %>% write_csv("data_tables/wind_county_chart.csv")

# Join with census/tiger tract map files
floodmap_counties <- left_join(counties,flood_county_chart,by=c("geoid"="fips"))
heatmap_counties <- left_join(counties,heat_county_chart,by=c("geoid"="fips"))
firemap_counties <- left_join(counties,fire_county_chart,by=c("geoid"="fips"))
windmap_counties <- left_join(counties,wind_county_chart,by=c("geoid"="fips"))

# Output geojsons to directory for use in production interactive
floodmap_counties %>% st_write("data_geojson/county_flood_risk.geojson")
heatmap_counties %>% st_write("data_geojson/county_heat_risk.geojson")
firemap_counties %>% st_write("data_geojson/county_fire_risk.geojson")
windmap_counties %>% st_write("data_geojson/county_wind_risk.geojson")
windmap_counties %>% select(1,2,11) %>% st_write("data_geojson/counties.geojson")






