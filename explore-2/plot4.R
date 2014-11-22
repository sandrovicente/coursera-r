# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008? 

source("loader.R")

coal.scc.index <-grep("Coal", SCC$Short.Name) # All Sources containing "Coal" in the short name
coal.nei.index <- NEI$SCC %in% SCC[coal.scc.index,1] # indexes all records referring to the sources involving "Coal"

coal.nei <- NEI[coal.nei.index,] # Obtain records related to sources involving "Coal"

coal.emissions <- sapply(split(coal.nei$Emissions, coal.nei$year), sum) # Calculate total of emissions per year

png("plot4.png", width=480, height=480, units="px")

plot(attributes(coal.emissions)[[1]], coal.emissions, main="Total emissions from Coal-related sources", xlab="years", ylab="PM2.5 (tons)")
lines(attributes(coal.emissions)[[1]], coal.emissions)

dev.off()