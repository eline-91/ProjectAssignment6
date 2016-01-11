# Geetika Rathee & Eline van Elburg
# Januray 11, 2016
# Assignment Lesson 6

# The two urls for the files
url_places <- 'http://www.mapcruzin.com/download-shapefile/netherlands-places-shape.zip'
url_railroad <- 'http://www.mapcruzin.com/download-shapefile/netherlands-railways-shape.zip'

source('R/download_unzip.R')
dest_directory <- 'data' # This folder should already exist in your project and be the folder where you want to put your data

downloadFile_unzip(url_places, 'Netherlands_Places.zip', dest_directory)
downloadFile_unzip(url_railroad, 'Netherlands_Railroad.zip', dest_directory)


