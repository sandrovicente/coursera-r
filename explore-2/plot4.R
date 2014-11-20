# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008? 

source("loader.R")

coal.scc.index <-grep("Coal", SCC$Short.Name)
coal.nei.index <- NEI$SCC %in% SCC[coal.scc.index,1]

coal.nei <- NEI[coal.nei.index,]

coal.emissions <- sapply(split(coal.nei$Emissions, coal.nei$year), sum)

plot(attributes(coal.emissions)[[1]], coal.emissions, main="Total emissions of PM2.5 from Coal-related sources", xlab="years")
lines(attributes(coal.emissions)[[1]], coal.emissions)
