library(tidyverse)
library(stringr)
library(sf)

# Import the basic tables for each type of risk factor by TRACT
# From the raw data provided by First Street Foundation via AWS

fire_tract <- read_csv("raw_data/fire_v2.0_summary_fsf_fire_tract_summary.csv") %>% filter(!is.na(count_property))
heat_tract <- read_csv("raw_data/heat_v1.1_summary_fsf_heat_tract_summary.csv") %>% filter(!is.na(count_property))
flood_tract <- read_csv("raw_data/flood_v3.0_summary_fsf_flood_tract_summary.csv") %>% filter(!is.na(count_property))
wind_tract <- read_csv("raw_data/wind_v1.0_summary_fsf_wind_tract_summary.csv") %>% filter(!is.na(count_property))


# Create simpler table of number/share of properties above major/severe levels
fire_tract_chart <- fire_tract %>%
  mutate(pct_major = round((fire_tract$count_firefactor5+
                              fire_tract$count_firefactor6+
                              fire_tract$count_firefactor7+
                              fire_tract$count_firefactor8+
                              fire_tract$count_firefactor9+
                              fire_tract$count_firefactor10)/
                             fire_tract$count_property*100,1),
         pct_severe = round((fire_tract$count_firefactor7+
                               fire_tract$count_firefactor8+
                               fire_tract$count_firefactor9+
                               fire_tract$count_firefactor10)/
                              fire_tract$count_property*100,1),
         number_major = fire_tract$count_firefactor5+
                              fire_tract$count_firefactor6+
                              fire_tract$count_firefactor7+
                              fire_tract$count_firefactor8+
                              fire_tract$count_firefactor9+
                              fire_tract$count_firefactor10,
         number_severe = fire_tract$count_firefactor7+
                               fire_tract$count_firefactor8+
                               fire_tract$count_firefactor9+
                               fire_tract$count_firefactor10) %>%
  select(1,2,13,14,15,16)

fire_tract_chart$state <- substr(fire_tract$fips,1,2)
fire_tract_chart$tract <- substr(fire_tract$fips,3,11)
fire_tract_chart$county <- substr(fire_tract$fips,1,5)




# Create simpler table of number/share of properties above major/severe levels
flood_tract_chart <- flood_tract %>%
  mutate(pct_major = round((flood_tract$count_floodfactor5+
                              flood_tract$count_floodfactor6+
                              flood_tract$count_floodfactor7+
                              flood_tract$count_floodfactor8+
                              flood_tract$count_floodfactor9+
                              flood_tract$count_floodfactor10)/
                             flood_tract$count_property*100,1),
         pct_severe = round((flood_tract$count_floodfactor7+
                               flood_tract$count_floodfactor8+
                               flood_tract$count_floodfactor9+
                               flood_tract$count_floodfactor10)/
                              flood_tract$count_property*100,1),
         number_major = flood_tract$count_floodfactor5+
           flood_tract$count_floodfactor6+
           flood_tract$count_floodfactor7+
           flood_tract$count_floodfactor8+
           flood_tract$count_floodfactor9+
           flood_tract$count_floodfactor10,
         number_severe = flood_tract$count_floodfactor7+
           flood_tract$count_floodfactor8+
           flood_tract$count_floodfactor9+
           flood_tract$count_floodfactor10) %>%
  select(1,2,13,14,15,16)


flood_tract_chart$state <- substr(flood_tract$fips,1,2)
flood_tract_chart$tract <- substr(flood_tract$fips,3,11)
flood_tract_chart$county <- substr(flood_tract$fips,1,5)

# Create simpler table of number/share of properties above major/severe levels
heat_tract_chart <- heat_tract %>%
  mutate(pct_major = round((heat_tract$count_heatfactor5+
                              heat_tract$count_heatfactor6+
                              heat_tract$count_heatfactor7+
                              heat_tract$count_heatfactor8+
                              heat_tract$count_heatfactor9+
                              heat_tract$count_heatfactor10)/
                             heat_tract$count_property*100,1),
         pct_severe = round((heat_tract$count_heatfactor7+
                               heat_tract$count_heatfactor8+
                               heat_tract$count_heatfactor9+
                               heat_tract$count_heatfactor10)/
                              heat_tract$count_property*100,1),
         number_major = heat_tract$count_heatfactor5+
           heat_tract$count_heatfactor6+
           heat_tract$count_heatfactor7+
           heat_tract$count_heatfactor8+
           heat_tract$count_heatfactor9+
           heat_tract$count_heatfactor10,
         number_severe = heat_tract$count_heatfactor7+
           heat_tract$count_heatfactor8+
           heat_tract$count_heatfactor9+
           heat_tract$count_heatfactor10) %>%
  select(1,2,13,14,15,16)

heat_tract_chart$state <- substr(heat_tract$fips,1,2)
heat_tract_chart$tract <- substr(heat_tract$fips,3,11)
heat_tract_chart$county <- substr(heat_tract$fips,1,5)

# Create simpler table of number/share of properties above major/severe levels
wind_tract_chart <- wind_tract %>%
  mutate(pct_major = round((wind_tract$count_windfactor5+
                              wind_tract$count_windfactor6+
                              wind_tract$count_windfactor7+
                              wind_tract$count_windfactor8+
                              wind_tract$count_windfactor9+
                              wind_tract$count_windfactor10)/
                             wind_tract$count_property*100,1),
         pct_severe = round((wind_tract$count_windfactor7+
                               wind_tract$count_windfactor8+
                               wind_tract$count_windfactor9+
                               wind_tract$count_windfactor10)/
                              wind_tract$count_property*100,1),
         number_major = wind_tract$count_windfactor5+
           wind_tract$count_windfactor6+
           wind_tract$count_windfactor7+
           wind_tract$count_windfactor8+
           wind_tract$count_windfactor9+
           wind_tract$count_windfactor10,
         number_severe = wind_tract$count_windfactor7+
           wind_tract$count_windfactor8+
           wind_tract$count_windfactor9+
           wind_tract$count_windfactor10) %>%
  select(1,2,13,14,15,16)

wind_tract_chart$state <- substr(wind_tract$fips,1,2)
wind_tract_chart$tract <- substr(wind_tract$fips,3,11)
wind_tract_chart$county <- substr(wind_tract$fips,1,5)

# Output csv files of tract tables
flood_tract_chart %>% write_csv("data_tables/flood_tract_chart.csv")
heat_tract_chart %>% write_csv("data_tables/heat_tract_chart.csv")
fire_tract_chart %>% write_csv("data_tables/fire_tract_chart.csv")
wind_tract_chart %>% write_csv("data_tables/wind_tract_chart.csv")

# Join with census/tiger tract map files
floodmap_tracts <- left_join(tracts,flood_tract_chart,by=c("geoid"="fips"))
heatmap_tracts <- left_join(tracts,heat_tract_chart,by=c("geoid"="fips"))
firemap_tracts <- left_join(tracts,fire_tract_chart,by=c("geoid"="fips"))
windmap_tracts <- left_join(tracts,wind_tract_chart,by=c("geoid"="fips"))

# Output geojsons to directory for use in production interactive
floodmap_tracts %>% st_write("data_geojson/tract_flood_risk.geojson")
heatmap_tracts %>% st_write("data_geojson/tract_heat_risk.geojson")
firemap_tracts %>% st_write("data_geojson/tract_fire_risk.geojson")
windmap_tracts %>% st_write("data_geojson/tract_wind_risk.geojson")


# Test loop writer to build tracts/risk data by state for interactive

# Output geojsons to directory for use in production interactive
#floodmap_tracts %>% st_write("data_geojson/tract_flood_risk.geojson")
#heatmap_tracts %>% st_write("data_geojson/tract_heat_risk.geojson")
#firemap_tracts %>% st_write("data_geojson/tract_fire_risk.geojson")
#windmap_tracts %>% st_write("data_geojson/tract_wind_risk.geojson")

#state_df <- data.frame(abbreviation = state.abb, name = state.name)
#state_df[nrow(state_df) + 1,] <- c("DC", "District of Columbia")
statefips <- states$geoid

for (i in statefips) {
  state_filter <- windmap_tracts %>% filter(state == i)
  state_filter_code <- i
  state_filter %>% st_write(paste0("data_geojson/windtracts_",state_filter_code,".geojson"))
  }

for (i in statefips) {
  state_filter <- heatmap_tracts %>% filter(state == i)
  state_filter_code <- i
  state_filter %>% st_write(paste0("data_geojson/heattracts_",state_filter_code,".geojson"))
}


for (i in statefips) {
  state_filter <- firemap_tracts %>% filter(state == i)
  state_filter_code <- i
  state_filter %>% st_write(paste0("data_geojson/firetracts_",state_filter_code,".geojson"))
}

for (i in statefips) {
  state_filter <- floodmap_tracts %>% filter(state == i)
  state_filter_code <- i
  state_filter %>% st_write(paste0("data_geojson/floodtracts_",state_filter_code,".geojson"))
}
