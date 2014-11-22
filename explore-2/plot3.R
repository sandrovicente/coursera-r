# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

source("loader.R")

baltimore.em <- NEI[NEI$fips == "24510",] # select rows corresponding to Baltimore

total.emissions <- with(baltimore.em, aggregate(baltimore.em$Emissions, by=list(type, year), FUN=sum))
# aggregate totals of emissions by type and year

names(total.emissions)<- c("type","year","total.emission")  # rename columns of aggregate to facilitate next steps

library(ggplot2)

# Use facets to facilitate comparisons across source types
pl <- qplot(year, total.emission, data=total.emissions, facets= . ~ type, ylab="PM2.5 (tons)", main="Total Emissions in Baltmore per source and year") + geom_line()

png("plot3.png", width=640, height=480, units="px")
    
print(pl)

dev.off()