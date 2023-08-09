library(tidyverse)
library(stringr)
library(sf)

# Import the basic tables for each type of risk factor BY ZIP
# From the raw data provided by First Street Foundation via AWS

fire_zip <- read_csv("raw_data/fire_v2.0_summary_fsf_fire_zcta_summary.csv", 
                     col_types = cols(fips = col_character()))

heat_zip <- read_csv("raw_data/heat_v1.1_summary_fsf_heat_zcta_summary.csv",
                     col_types = cols(fips = col_character()))

flood_zip <- read_csv("raw_data/flood_v3.0_summary_fsf_flood_zcta_summary.csv", 
                      col_types = cols(fips = col_character()))

wind_zip <- read_csv("raw_data/wind_v1.0_summary_fsf_wind_zcta_summary.csv", 
                      col_types = cols(fips = col_character()))

# Padding strings to replace missing leading zeros in some zips
wind_zip$fips <- str_pad(wind_zip$fips, width=5, side="left", use_width= T, pad = "0")
heat_zip$fips <- str_pad(heat_zip$fips, width=5, side="left", use_width= T, pad = "0")
flood_zip$fips <- str_pad(flood_zip$fips, width=5, side="left", use_width= T, pad = "0")
fire_zip$fips <- str_pad(fire_zip$fips, width=5, side="left", use_width= T, pad = "0")


# Create simpler table of number/share of properties above major/severe levels
fire_zip_chart <- fire_zip %>%
  mutate(pct_major = round((fire_zip$count_firefactor5+
                              fire_zip$count_firefactor6+
                              fire_zip$count_firefactor7+
                              fire_zip$count_firefactor8+
                              fire_zip$count_firefactor9+
                              fire_zip$count_firefactor10)/
                             fire_zip$count_property*100,1),
         pct_severe = round((fire_zip$count_firefactor7+
                               fire_zip$count_firefactor8+
                               fire_zip$count_firefactor9+
                               fire_zip$count_firefactor10)/
                              fire_zip$count_property*100,1),
         number_major = fire_zip$count_firefactor5+
           fire_zip$count_firefactor6+
           fire_zip$count_firefactor7+
           fire_zip$count_firefactor8+
           fire_zip$count_firefactor9+
           fire_zip$count_firefactor10,
         number_severe = fire_zip$count_firefactor7+
           fire_zip$count_firefactor8+
           fire_zip$count_firefactor9+
           fire_zip$count_firefactor10) %>%
  select(1,2,13,14,15,16)


# Create simpler table of number/share of properties above major/severe levels
flood_zip_chart <- flood_zip %>%
  mutate(pct_major = round((flood_zip$count_floodfactor5+
                              flood_zip$count_floodfactor6+
                              flood_zip$count_floodfactor7+
                              flood_zip$count_floodfactor8+
                              flood_zip$count_floodfactor9+
                              flood_zip$count_floodfactor10)/
                             flood_zip$count_property*100,1),
         pct_severe = round((flood_zip$count_floodfactor7+
                               flood_zip$count_floodfactor8+
                               flood_zip$count_floodfactor9+
                               flood_zip$count_floodfactor10)/
                              flood_zip$count_property*100,1),
         number_major = flood_zip$count_floodfactor5+
           flood_zip$count_floodfactor6+
           flood_zip$count_floodfactor7+
           flood_zip$count_floodfactor8+
           flood_zip$count_floodfactor9+
           flood_zip$count_floodfactor10,
         number_severe = flood_zip$count_floodfactor7+
           flood_zip$count_floodfactor8+
           flood_zip$count_floodfactor9+
           flood_zip$count_floodfactor10) %>%
  select(1,2,13,14,15,16)


# Create simpler table of number/share of properties above major/severe levels
heat_zip_chart <- heat_zip %>%
  mutate(pct_major = round((heat_zip$count_heatfactor5+
                              heat_zip$count_heatfactor6+
                              heat_zip$count_heatfactor7+
                              heat_zip$count_heatfactor8+
                              heat_zip$count_heatfactor9+
                              heat_zip$count_heatfactor10)/
                             heat_zip$count_property*100,1),
         pct_severe = round((heat_zip$count_heatfactor7+
                               heat_zip$count_heatfactor8+
                               heat_zip$count_heatfactor9+
                               heat_zip$count_heatfactor10)/
                              heat_zip$count_property*100,1),
         number_major = heat_zip$count_heatfactor5+
           heat_zip$count_heatfactor6+
           heat_zip$count_heatfactor7+
           heat_zip$count_heatfactor8+
           heat_zip$count_heatfactor9+
           heat_zip$count_heatfactor10,
         number_severe = heat_zip$count_heatfactor7+
           heat_zip$count_heatfactor8+
           heat_zip$count_heatfactor9+
           heat_zip$count_heatfactor10) %>%
  select(1,2,13,14,15,16)


# Create simpler table of number/share of properties above major/severe levels
wind_zip_chart <- wind_zip %>%
  mutate(pct_major = round((wind_zip$count_windfactor5+
                              wind_zip$count_windfactor6+
                              wind_zip$count_windfactor7+
                              wind_zip$count_windfactor8+
                              wind_zip$count_windfactor9+
                              wind_zip$count_windfactor10)/
                             wind_zip$count_property*100,1),
         pct_severe = round((wind_zip$count_windfactor7+
                               wind_zip$count_windfactor8+
                               wind_zip$count_windfactor9+
                               wind_zip$count_windfactor10)/
                              wind_zip$count_property*100,1),
         number_major = wind_zip$count_windfactor5+
           wind_zip$count_windfactor6+
           wind_zip$count_windfactor7+
           wind_zip$count_windfactor8+
           wind_zip$count_windfactor9+
           wind_zip$count_windfactor10,
         number_severe = wind_zip$count_windfactor7+
           wind_zip$count_windfactor8+
           wind_zip$count_windfactor9+
           wind_zip$count_windfactor10) %>%
  select(1,2,13,14,15,16)

# Output csv files of tract tables
flood_zip_chart %>% write_csv("data_tables/flood_zip_chart.csv")
heat_zip_chart %>% write_csv("data_tables/heat_zip_chart.csv")
fire_zip_chart %>% write_csv("data_tables/fire_zip_chart.csv")
wind_zip_chart %>% write_csv("data_tables/wind_zip_chart.csv")

# Join with census/tiger tract map files
floodmap_zips <- left_join(zips,flood_zip_chart,by=c("geoid"="fips"))
heatmap_zips <- left_join(zips,heat_zip_chart,by=c("geoid"="fips"))
firemap_zips <- left_join(zips,fire_zip_chart,by=c("geoid"="fips"))
windmap_zips <- left_join(zips,wind_zip_chart,by=c("geoid"="fips"))

# Output geojsons to directory for use in production interactive
floodmap_zips %>% st_write("data_geojson/zips_flood_risk.geojson")
heatmap_zips %>% st_write("data_geojson/zips_heat_risk.geojson")
firemap_zips %>% st_write("data_geojson/zips_fire_risk.geojson")
windmap_zips %>% st_write("data_geojson/zips_wind_risk.geojson")
windmap_zips %>% select(1,9) %>% st_write("data_geojson/all_zips.geojson")

#statefips <- states$geoid

#for (i in statefips) {
#  state_filter <- windmap_zips %>% filter(state == i)
#  state_filter_code <- i
#  state_filter %>% st_write(paste0("data_geojson/windzips_",state_filter_code,".geojson"))
#}

#for (i in statefips) {
#  state_filter <- heatmap_zips %>% filter(state == i)
#  state_filter_code <- i
#  state_filter %>% st_write(paste0("data_geojson/heatzips_",state_filter_code,".geojson"))
#}


#for (i in statefips) {
#  state_filter <- firemap_zips %>% filter(state == i)
#  state_filter_code <- i
#  state_filter %>% st_write(paste0("data_geojson/firezips_",state_filter_code,".geojson"))
#}

#for (i in statefips) {
#  state_filter <- floodmap_zips %>% filter(state == i)
#  state_filter_code <- i
#  state_filter %>% st_write(paste0("data_geojson/floodzips_",state_filter_code,".geojson"))
#}


