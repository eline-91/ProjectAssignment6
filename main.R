# Geetika Rathee & Eline van Elburg
# Januray 11, 2016
# Assignment Lesson 6

# Call needed packages
library(sp)
library(rgdal)
library(rgeos)

# The two urls for the files
url_places <- 'http://www.mapcruzin.com/download-shapefile/netherlands-places-shape.zip'
url_railroad <- 'http://www.mapcruzin.com/download-shapefile/netherlands-railways-shape.zip'

source('R/download_unzip.R')
dest_directory <- 'data' # This folder should already exist in your project and be the folder where you want to put your data
downloadFile_unzip(url_places, 'Netherlands_Places.zip', dest_directory)
downloadFile_unzip(url_railroad, 'Netherlands_Railroad.zip', dest_directory)

# Open the shapefiles just downloaded
dsn_places = file.path("data","places.shp")
dsn_railways = file.path("data","railways.shp")
places <- readOGR(dsn_places, layer = ogrListLayers(dsn_places))
railways <- readOGR(dsn_railways, layer = ogrListLayers(dsn_railways))

# Select the industrial railways
industrial_railways <- subset(railways, type == "industrial")

# Transform to RD_New
prj_string_RD <- CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +towgs84=565.2369,50.0087,465.658,-0.406857330322398,0.350732676542563,-1.8703473836068,4.0812 +units=m +no_defs")
industrial_railways_Tf <- spTransform(industrial_railways, prj_string_RD)
places_Tf <- spTransform(places, prj_string_RD)

# Buffer the "industrial" railways with a buffer of 1000 meters
ind_railw_buffer <- gBuffer(industrial_railways_Tf, byid=TRUE, width=1000)

# Intersect the buffer with the places dataset to get a TRUE/FALSE vector with which cities intersect and which not
intersection <- gIntersects(ind_railw_buffer, places_Tf, byid=TRUE)

# Subset the places dataset with the intersection vector
city <- as.character(places$name[intersection == TRUE])
population <- places$population[intersection == TRUE]

# Plot the buffer, the point, and the name of the city
point <- gIntersection(ind_railw_buffer, places_Tf)
spplot(ind_railw_buffer, zcol="type", main = city, 
			 sp.layout=list("sp.points", point, col="red", pch=19, cex=1.5))

# Name of the city and population
print(paste("Name of the city:", city, "Population:", population))
