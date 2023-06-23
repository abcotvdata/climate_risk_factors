library(tidyverse)

# Import the basic tables for each type of risk factor BY COUNTY
# From the raw data provided by First Street Foundation via AWS

fire_city <- read_csv("raw_data/fire_v1.1_summary_fsf_fire_cousub_summary.csv")
heat_city <- read_csv("raw_data/heat_v1.1_summary_fsf_heat_cousub_summary.csv")
flood_city <- read_csv("raw_data/flood_v2.1_summary_fsf_flood_cousub_summary.csv")
wind_city <- read_csv("raw_data/wind_v1.0_summary_fsf_wind_cousub_summary.csv")

# Create simpler table of number/share of properties above major/severe levels
fire_city_chart <- fire_city %>%
  mutate(pct_major = round((fire_city$count_firefactor5+
                              fire_city$count_firefactor6+
                              fire_city$count_firefactor7+
                              fire_city$count_firefactor8+
                              fire_city$count_firefactor9+
                              fire_city$count_firefactor10)/
                             fire_city$count_property*100,1),
         pct_severe = round((fire_city$count_firefactor7+
                               fire_city$count_firefactor8+
                               fire_city$count_firefactor9+
                               fire_city$count_firefactor10)/
                              fire_city$count_property*100,1),
         number_major = fire_city$count_firefactor5+
           fire_city$count_firefactor6+
           fire_city$count_firefactor7+
           fire_city$count_firefactor8+
           fire_city$count_firefactor9+
           fire_city$count_firefactor10,
         number_severe = fire_city$count_firefactor7+
           fire_city$count_firefactor8+
           fire_city$count_firefactor9+
           fire_city$count_firefactor10) %>%
  select(1,2,3,14,15,16,17)

# Create simpler table of number/share of properties above major/severe levels
flood_city_chart <- flood_city %>%
  mutate(pct_major = round((flood_city$count_floodfactor5+
                              flood_city$count_floodfactor6+
                              flood_city$count_floodfactor7+
                              flood_city$count_floodfactor8+
                              flood_city$count_floodfactor9+
                              flood_city$count_floodfactor10)/
                             flood_city$count_property*100,1),
         pct_severe = round((flood_city$count_floodfactor7+
                               flood_city$count_floodfactor8+
                               flood_city$count_floodfactor9+
                               flood_city$count_floodfactor10)/
                              flood_city$count_property*100,1),
         number_major = flood_city$count_floodfactor5+
           flood_city$count_floodfactor6+
           flood_city$count_floodfactor7+
           flood_city$count_floodfactor8+
           flood_city$count_floodfactor9+
           flood_city$count_floodfactor10,
         number_severe = flood_city$count_floodfactor7+
           flood_city$count_floodfactor8+
           flood_city$count_floodfactor9+
           flood_city$count_floodfactor10) %>%
  select(1,2,3,14,15,16,17)

# Create simpler table of number/share of properties above major/severe levels
heat_city_chart <- heat_city %>%
  mutate(pct_major = round((heat_city$count_heatfactor5+
                              heat_city$count_heatfactor6+
                              heat_city$count_heatfactor7+
                              heat_city$count_heatfactor8+
                              heat_city$count_heatfactor9+
                              heat_city$count_heatfactor10)/
                             heat_city$count_property*100,1),
         pct_severe = round((heat_city$count_heatfactor7+
                               heat_city$count_heatfactor8+
                               heat_city$count_heatfactor9+
                               heat_city$count_heatfactor10)/
                              heat_city$count_property*100,1),
         number_major = heat_city$count_heatfactor5+
           heat_city$count_heatfactor6+
           heat_city$count_heatfactor7+
           heat_city$count_heatfactor8+
           heat_city$count_heatfactor9+
           heat_city$count_heatfactor10,
         number_severe = heat_city$count_heatfactor7+
           heat_city$count_heatfactor8+
           heat_city$count_heatfactor9+
           heat_city$count_heatfactor10) %>%
  select(1,2,3,14,15,16,17)

# Create simpler table of number/share of properties above major/severe levels
wind_city_chart <- wind_city %>%
  mutate(pct_major = round((wind_city$count_windfactor5+
                              wind_city$count_windfactor6+
                              wind_city$count_windfactor7+
                              wind_city$count_windfactor8+
                              wind_city$count_windfactor9+
                              wind_city$count_windfactor10)/
                             wind_city$count_property*100,1),
         pct_severe = round((wind_city$count_windfactor7+
                               wind_city$count_windfactor8+
                               wind_city$count_windfactor9+
                               wind_city$count_windfactor10)/
                              wind_city$count_property*100,1),
         number_major = wind_city$count_windfactor5+
           wind_city$count_windfactor6+
           wind_city$count_windfactor7+
           wind_city$count_windfactor8+
           wind_city$count_windfactor9+
           wind_city$count_windfactor10,
         number_severe = wind_city$count_windfactor7+
           wind_city$count_windfactor8+
           wind_city$count_windfactor9+
           wind_city$count_windfactor10) %>%
  select(1,2,3,14,15,16,17)

# Output csv files of counties tables
flood_city_chart %>% write_csv("data_tables/flood_city_chart.csv")
heat_city_chart %>% write_csv("data_tables/heat_city_chart.csv")
fire_city_chart %>% write_csv("data_tables/fire_city_chart.csv")
wind_city_chart %>% write_csv("data_tables/wind_city_chart.csv")

# Join with census/tiger tract map files
floodmap_cities <- left_join(cities,flood_city_chart,by=c("geoid"="fips"))
heatmap_cities <- left_join(cities,heat_city_chart,by=c("geoid"="fips"))
firemap_cities <- left_join(cities,fire_city_chart,by=c("geoid"="fips"))
windmap_cities <- left_join(cities,wind_city_chart,by=c("geoid"="fips"))

# Output geojsons to directory for use in production interactive
floodmap_cities %>% st_write("data_geojson/city_flood_risk.geojson")
heatmap_cities %>% st_write("data_geojson/city_heat_risk.geojson")
firemap_cities %>% st_write("data_geojson/city_fire_risk.geojson")
windmap_cities %>% st_write("data_geojson/city_wind_risk.geojson")
windmap_cities %>% select(1,2,11) %>% st_write("data_geojson/cities.geojson")






