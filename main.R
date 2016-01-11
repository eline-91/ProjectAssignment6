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
source('R/make_selection.R')
type_railroad <- "industrial"
subset_rails <- make_selection(railways, type, type_railroad)
spplot(subset_rails)
writer_names_df <- subset(writers_df, Name =="Jane")