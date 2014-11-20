# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008? 

source("loader.R")

motorv.scc.index <-grep("Motor Vehicle", SCC$Short.Name)
    
baltimore.em <- NEI[NEI$fips == "24510",]

motorv.nei.index <- baltimore.em$SCC %in% SCC[motorv.scc.index,1]

motorv.nei <- baltimore.em[motorv.nei.index,]

motorv.emissions <- sapply(split(motorv.nei$Emissions, motorv.nei$year), sum)

plot(attributes(motorv.emissions)[[1]], motorv.emissions, main="Total emissions of PM2.5 from Motor Vehicle-related sources in Baltimore", xlab="years")
lines(attributes(motorv.emissions)[[1]], motorv.emissions)
