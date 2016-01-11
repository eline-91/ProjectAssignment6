downloadFile_unzip <- function(url_file, dest_name, directory) {
	setwd(directory)
	download.file(url = url_file, destfile = dest_name, method = 'wget')
	unzip(dest_name)
	setwd('..')
}