library(tidyverse)


# Import the basic tables for each type of risk factor
# From the raw data provided by First Street Foundation via AWS

fire_county <- read_csv("raw_data/fire_v1.1_summary_fsf_fire_county_summary.csv")
fire_tract <- read_csv("raw_data/fire_v1.1_summary_fsf_fire_tract_summary.csv")
fire_zip <- read_csv("raw_data/fire_v1.1_summary_fsf_fire_zcta_summary.csv", 
                     col_types = cols(fips = col_character()))

heat_county <- read_csv("raw_data/heat_v1.1_summary_fsf_heat_county_summary.csv")
heat_tract <- read_csv("raw_data/heat_v1.1_summary_fsf_heat_tract_summary.csv")
heat_zip <- read_csv("raw_data/heat_v1.1_summary_fsf_heat_zcta_summary.csv",
                     col_types = cols(fips = col_character()))

flood_county <- read_csv("raw_data/flood_v2.1_summary_fsf_flood_county_summary.csv")
flood_tract <- read_csv("raw_data/flood_v2.1_summary_fsf_flood_tract_summary.csv")
flood_zip <- read_csv("raw_data/flood_v2.1_summary_fsf_flood_zcta_summary.csv", 
                      col_types = cols(fips = col_character()))

wind_county <- read_csv("raw_data/wind_v1.0_summary_fsf_wind_county_summary.csv")
wind_tract <- read_csv("raw_data/wind_v1.0_summary_fsf_wind_tract_summary.csv")
wind_zip <- read_csv("raw_data/wind_v1.0_summary_fsf_wind_zcta_summary.csv", 
                      col_types = cols(fips = col_character()))

# Create a simple table of county percentages above a certain level

fire_county_chart <- fire_county %>%
  mutate(pct_major = round((fire_county$count_firefactor5+
                        fire_county$count_firefactor6+
                        fire_county$count_firefactor7+
                        fire_county$count_firefactor8+
                        fire_county$count_firefactor9+
                        fire_county$count_firefactor10)/
           fire_county$count_property*100,2),
         pct_severe = round((fire_county$count_firefactor7+
                        fire_county$count_firefactor8+
                        fire_county$count_firefactor9+
                        fire_county$count_firefactor10)/
           fire_county$count_property*100,2)) %>%
  select(1,2,3,14,15)

flood_county_chart <- flood_county %>%
  mutate(pct_major = round((flood_county$count_floodfactor5+
                              flood_county$count_floodfactor6+
                              flood_county$count_floodfactor7+
                              flood_county$count_floodfactor8+
                              flood_county$count_floodfactor9+
                              flood_county$count_floodfactor10)/
                             flood_county$count_property*100,2),
         pct_severe = round((flood_county$count_floodfactor7+
                                flood_county$count_floodfactor8+
                                flood_county$count_floodfactor9+
                                flood_county$count_floodfactor10)/
                               flood_county$count_property*100,2)) %>%
  select(1,2,3,14,15)

heat_county_chart <- heat_county %>%
  mutate(pct_major = round((heat_county$count_heatfactor5+
                              heat_county$count_heatfactor6+
                              heat_county$count_heatfactor7+
                              heat_county$count_heatfactor8+
                              heat_county$count_heatfactor9+
                              heat_county$count_heatfactor10)/
                             heat_county$count_property*100,2),
         pct_severe = round((heat_county$count_heatfactor7+
                                heat_county$count_heatfactor8+
                                heat_county$count_heatfactor9+
                                heat_county$count_heatfactor10)/
                               heat_county$count_property*100,2)) %>%
  select(1,2,3,14,15)

wind_county_chart <- wind_county %>%
  mutate(pct_major = round((wind_county$count_windfactor5+
                              wind_county$count_windfactor6+
                              wind_county$count_windfactor7+
                              wind_county$count_windfactor8+
                              wind_county$count_windfactor9+
                              wind_county$count_windfactor10)/
                             wind_county$count_property*100,2),
         pct_severe = round((wind_county$count_windfactor7+
                               wind_county$count_windfactor8+
                               wind_county$count_windfactor9+
                               wind_county$count_windfactor10)/
                              wind_county$count_property*100,2)) %>%
  select(1,2,3,14,15)


flood_county_chart %>% write_csv("data_tables/flood_county_chart.csv")
heat_county_chart %>% write_csv("data_tables/heat_county_chart.csv")
fire_county_chart %>% write_csv("data_tables/fire_county_chart.csv")
wind_county_chart %>% write_csv("data_tables/wind_county_chart.csv")


# BY CENSUS TRACT
# Create a simple table of county percentages above a certain level

fire_tract_chart <- fire_tract %>%
  mutate(pct_major = round((fire_tract$count_firefactor5+
                              fire_tract$count_firefactor6+
                              fire_tract$count_firefactor7+
                              fire_tract$count_firefactor8+
                              fire_tract$count_firefactor9+
                              fire_tract$count_firefactor10)/
                             fire_tract$count_property*100,2),
         pct_severe = round((fire_tract$count_firefactor7+
                               fire_tract$count_firefactor8+
                               fire_tract$count_firefactor9+
                               fire_tract$count_firefactor10)/
                              fire_tract$count_property*100,2)) %>%
  select(1,2,13,14)

fire_tract_chart$state <- substr(fire_tract$fips,1,2)
fire_tract_chart$tract <- substr(fire_tract$fips,3,11)

flood_tract_chart <- flood_tract %>%
  mutate(pct_major = round((flood_tract$count_floodfactor5+
                              flood_tract$count_floodfactor6+
                              flood_tract$count_floodfactor7+
                              flood_tract$count_floodfactor8+
                              flood_tract$count_floodfactor9+
                              flood_tract$count_floodfactor10)/
                             flood_tract$count_property*100,2),
         pct_severe = round((flood_tract$count_floodfactor7+
                               flood_tract$count_floodfactor8+
                               flood_tract$count_floodfactor9+
                               flood_tract$count_floodfactor10)/
                              flood_tract$count_property*100,2)) %>%
  select(1,2,13,14)

flood_tract_chart$state <- substr(flood_tract$fips,1,2)
flood_tract_chart$tract <- substr(flood_tract$fips,3,11)

heat_tract_chart <- heat_tract %>%
  mutate(pct_major = round((heat_tract$count_heatfactor5+
                              heat_tract$count_heatfactor6+
                              heat_tract$count_heatfactor7+
                              heat_tract$count_heatfactor8+
                              heat_tract$count_heatfactor9+
                              heat_tract$count_heatfactor10)/
                             heat_tract$count_property*100,2),
         pct_severe = round((heat_tract$count_heatfactor7+
                               heat_tract$count_heatfactor8+
                               heat_tract$count_heatfactor9+
                               heat_tract$count_heatfactor10)/
                              heat_tract$count_property*100,2)) %>%
  select(1,2,13,14)

heat_tract_chart$state <- substr(heat_tract$fips,1,2)
heat_tract_chart$tract <- substr(heat_tract$fips,3,11)


wind_tract_chart <- wind_tract %>%
  mutate(pct_major = round((wind_tract$count_windfactor5+
                              wind_tract$count_windfactor6+
                              wind_tract$count_windfactor7+
                              wind_tract$count_windfactor8+
                              wind_tract$count_windfactor9+
                              wind_tract$count_windfactor10)/
                             wind_tract$count_property*100,2),
         pct_severe = round((wind_tract$count_windfactor7+
                               wind_tract$count_windfactor8+
                               wind_tract$count_windfactor9+
                               wind_tract$count_windfactor10)/
                              wind_tract$count_property*100,2)) %>%
  select(1,2,13,14)

wind_tract_chart$state <- substr(wind_tract$fips,1,2)
wind_tract_chart$tract <- substr(wind_tract$fips,3,11)

flood_tract_chart %>% write_csv("data_tables/flood_tract_chart.csv")
heat_tract_chart %>% write_csv("data_tables/heat_tract_chart.csv")
fire_tract_chart %>% write_csv("data_tables/fire_tract_chart.csv")
wind_tract_chart %>% write_csv("data_tables/wind_tract_chart.csv")

# By state export
flood_tract_chart %>% filter(state=="06") %>% write_csv("data_tables/flood_tract_chart.csv")
heat_tract_chart %>% filter(state=="06") %>% write_csv("data_tables/heat_tract_chart.csv")
fire_tract_chart %>% filter(state=="06") %>% write_csv("data_tables/fire_tract_chart.csv")
wind_tract_chart %>% filter(state=="06") %>% write_csv("data_tables/wind_tract_chart.csv")


# BY ZIP
# Create a simple table of county percentages above a certain level

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

