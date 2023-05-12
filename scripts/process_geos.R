library(tidyverse)
library(tidycensus)
library(leaflet)
library(sf)
library(tigris)
library(leaflet.extras)
library(leaflet.providers)
library(rmapshaper)


# List of states we're going to use
my_states <- c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY")
# List of variables we're going to use
my_vars <- c(population = "B01003_001")

# Get tract geography and population
tracts <- get_acs(geography = "tract",
                  variables = my_vars,
                  state = my_states,
                  survey = "acs5",
                  year = 2021, 
                  output = "wide",
                  geometry = TRUE) %>%
  janitor::clean_names() %>%
  rename("population"="population_e") %>%
  select(-4) %>%
  st_transform(4326) %>%
  ms_simplify(keep = 0.2, keep_shapes = FALSE)
# original was .4

# Get zip code area geography and population
zips <- get_acs(geography = "zip code tabulation area",
                  variables = my_vars,
                  survey = "acs5",
                  year = 2021,
                  output = "wide",
                  geometry = TRUE) %>%
  janitor::clean_names() %>%
  rename("population"="population_e") %>%
  select(-4) %>%
  st_transform(4326) %>% 
  ms_simplify(keep = 0.2, keep_shapes = FALSE)
# original was 0.5

# Get county geography and population
counties <- get_acs(geography = "county",
                  variables = my_vars,
                  state = my_states,
                  survey = "acs5",
                  year = 2021,
                  output = "wide",
                  geometry = TRUE) %>%
  janitor::clean_names() %>%
  rename("population"="population_e") %>%
  st_transform(4326) %>%
  ms_simplify(keep = 0.5, keep_shapes = FALSE)

# Get state geography and population
states <- get_acs(geography = "state",
                    variables = my_vars,
                    state = my_states,
                    survey = "acs5",
                    year = 2021,
                    output = "wide",
                    geometry = TRUE) %>%
  janitor::clean_names() %>%
  rename("population"="population_e") %>%
  select(-4) %>%
  st_transform(4326)

# testing the simplify
map <- leaflet() %>%
  addProviderTiles(provider = "CartoDB.Positron") %>% 
  addPolygons(data = tracts,
              color = "white",
              weight = 0.3,
              fillColor = "purple")



