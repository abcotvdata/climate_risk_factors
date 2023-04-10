library(tidyverse)

# Import the basic tables for each type of risk factor
# From the raw data provided by First Street Foundation via AWS

fire_zip <- read_csv("raw_data/fire_v1.1_summary_fsf_fire_zcta_summary.csv", 
                     col_types = cols(fips = col_character()))

heat_zip <- read_csv("raw_data/heat_v1.1_summary_fsf_heat_zcta_summary.csv",
                     col_types = cols(fips = col_character()))

flood_zip <- read_csv("raw_data/flood_v2.1_summary_fsf_flood_zcta_summary.csv", 
                      col_types = cols(fips = col_character()))

wind_zip <- read_csv("raw_data/wind_v1.0_summary_fsf_wind_zcta_summary.csv", 
                      col_types = cols(fips = col_character()))

# Create a simple table of zip code percentages above a certain level

fire_zip_chart <- fire_zip %>%
  mutate(pct_major = round((fire_zip$count_firefactor5+
                              fire_zip$count_firefactor6+
                              fire_zip$count_firefactor7+
                              fire_zip$count_firefactor8+
                              fire_zip$count_firefactor9+
                              fire_zip$count_firefactor10)/
                             fire_zip$count_property*100,2),
         pct_severe = round((fire_zip$count_firefactor7+
                               fire_zip$count_firefactor8+
                               fire_zip$count_firefactor9+
                               fire_zip$count_firefactor10)/
                              fire_zip$count_property*100,2)) %>%
  select(1,2,13,14)

flood_zip_chart <- flood_zip %>%
  mutate(pct_major = round((flood_zip$count_floodfactor5+
                              flood_zip$count_floodfactor6+
                              flood_zip$count_floodfactor7+
                              flood_zip$count_floodfactor8+
                              flood_zip$count_floodfactor9+
                              flood_zip$count_floodfactor10)/
                             flood_zip$count_property*100,2),
         pct_severe = round((flood_zip$count_floodfactor7+
                               flood_zip$count_floodfactor8+
                               flood_zip$count_floodfactor9+
                               flood_zip$count_floodfactor10)/
                              flood_zip$count_property*100,2)) %>%
  select(1,2,13,14)

heat_zip_chart <- heat_zip %>%
  mutate(pct_major = round((heat_zip$count_heatfactor5+
                              heat_zip$count_heatfactor6+
                              heat_zip$count_heatfactor7+
                              heat_zip$count_heatfactor8+
                              heat_zip$count_heatfactor9+
                              heat_zip$count_heatfactor10)/
                             heat_zip$count_property*100,2),
         pct_severe = round((heat_zip$count_heatfactor7+
                               heat_zip$count_heatfactor8+
                               heat_zip$count_heatfactor9+
                               heat_zip$count_heatfactor10)/
                              heat_zip$count_property*100,2)) %>%
  select(1,2,13,14)


wind_zip_chart <- wind_zip %>%
  mutate(pct_major = round((wind_zip$count_windfactor5+
                              wind_zip$count_windfactor6+
                              wind_zip$count_windfactor7+
                              wind_zip$count_windfactor8+
                              wind_zip$count_windfactor9+
                              wind_zip$count_windfactor10)/
                             wind_zip$count_property*100,2),
         pct_severe = round((wind_zip$count_windfactor7+
                               wind_zip$count_windfactor8+
                               wind_zip$count_windfactor9+
                               wind_zip$count_windfactor10)/
                              wind_zip$count_property*100,2)) %>%
  select(1,2,13,14)


flood_zip_chart %>% write_csv("data_tables/flood_zip_chart.csv")
heat_zip_chart %>% write_csv("data_tables/heat_zip_chart.csv")
fire_zip_chart %>% write_csv("data_tables/fire_zip_chart.csv")
wind_zip_chart %>% write_csv("data_tables/wind_zip_chart.csv")

