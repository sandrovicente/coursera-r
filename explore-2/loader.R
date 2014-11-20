# Location where to get data and the estimated amount to read

DATA.ROOT <- "C:\\tmp\\data\\exdata-data-NEI_data"
SEPARATOR <- "\\"  # windows separator

loader <- function(file, NEI.file, SCC.file) {
	NEI.full.path  <- paste(DATA.ROOT, NEI.file, sep=SEPARATOR)
	SCC.full.path <- paste(DATA.ROOT, SCC.file, sep=SEPARATOR)

	NEI <<- readRDS(NEI.full.path)
	SCC <<- readRDS(SCC.full.path)
}

if (exists("NEI") && exists("SCC") && dim(NEI)[1] >= 6000000) { 
  message("Data exists: Using cached")
} else {
  message("Loading all data")
  loader(DATA.ROOT, "summarySCC_PM25.rds", "Source_Classification_Code.rds")
}
