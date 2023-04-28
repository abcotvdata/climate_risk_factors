library(tidycensus)
library(sf)
library(tigris)
library(units)

# Get shapefiles
counties <- counties(cb = TRUE)
# Calculate the centroids
counties_centroids <- st_centroid(counties)

# Loop over each tract in the tracts object
for (i in 1:nrow(counties_centroids)) {
  # Set the selected tract
  selected_county <- counties_centroids[i, ]
  
  # Calculate the distance between the selected tract and all other tracts
  distance <- st_distance(selected_county$geometry, counties_centroids$geometry)
  
  # Convert the distance to miles
  distance_miles <- set_units(distance, miles)
  
  # Filter the tracts to include only those within 50 miles of the selected tract
  filtered_counties <- counties_centroids[distance_miles <= 50, ]
  
  # Add the filtered tracts to the results list
  results[[i]] <- filtered_counties
}





# Get the shapefiles for Florida census tracts
tracts <- tracts(cb = TRUE)

# Calculate the centroids
tracts_centroids <- st_centroid(tracts)

# Get the shapefiles for Florida census tracts
zips <- zctas(cb = TRUE)

# Calculate the centroids
zips_centroids <- st_centroid(zips)


