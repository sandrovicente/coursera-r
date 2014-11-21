# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

source("loader.R")

baltimore.em <- NEI[NEI$fips == "24510",]

total.emissions <- with(baltimore.em, aggregate(baltimore.em$Emissions, by=list(type, year), FUN=sum))
names(total.emissions)<- c("type","year","total.emission")

library(ggplot2)

pl <- qplot(year, total.emission, data=total.emissions, facets= . ~ type, ylab="PM2.5 (tons)", main="Total Emissions in Baltmore per source and year") + geom_line()

png("plot3.png", width=640, height=480, units="px")

print(pl)

dev.off()