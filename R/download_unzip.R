downloadFile_unzip <- function(url_file, dest_name, directory) {
	# downloads files in the url to a given directory, under the given dest_name
	setwd(directory)
	download.file(url = url_file, destfile = dest_name, method = 'wget')
	unzip(dest_name)
	setwd('..')
}