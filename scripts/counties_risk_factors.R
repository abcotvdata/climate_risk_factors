library(tidyverse)

# Import the basic tables for each type of risk factor BY COUNTY
# From the raw data provided by First Street Foundation via AWS

fire_county <- read_csv("raw_data/fire_v1.1_summary_fsf_fire_county_summary.csv")
heat_county <- read_csv("raw_data/heat_v1.1_summary_fsf_heat_county_summary.csv")
flood_county <- read_csv("raw_data/flood_v2.1_summary_fsf_flood_county_summary.csv")
wind_county <- read_csv("raw_data/wind_v1.0_summary_fsf_wind_county_summary.csv")

# Simpler tables of count and percentage above major/severe levels

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

flood_county_chart %>% write_csv("data_tables/flood_county_chart.csv")
heat_county_chart %>% write_csv("data_tables/heat_county_chart.csv")
fire_county_chart %>% write_csv("data_tables/fire_county_chart.csv")
wind_county_chart %>% write_csv("data_tables/wind_county_chart.csv")

###########
# Data check: verified all counties missing from the county level data also missing from tract-level data
# Some early checks on what counties are missing from FSF data
# missing_flood_counties <- counties %>% filter(!counties$GEOID %in% flood_county_chart$fips)
# missing_heat_counties <- counties %>% filter(!counties$GEOID %in% heat_county_chart$fips)
# missing_fire_counties <- counties %>% filter(!counties$GEOID %in% fire_county_chart$fips)
# missing_wind_counties <- counties %>% filter(!counties$GEOID %in% wind_county_chart$fips)
# By state export
# flood_tract_chart %>% filter(state=="06") %>% write_csv("data_tables/flood_tract_chart.csv")
# heat_tract_chart %>% filter(state=="06") %>% write_csv("data_tables/heat_tract_chart.csv")
# fire_tract_chart %>% filter(state=="06") %>% write_csv("data_tables/fire_tract_chart.csv")
# wind_tract_chart %>% filter(state=="06") %>% write_csv("data_tables/wind_tract_chart.csv")


