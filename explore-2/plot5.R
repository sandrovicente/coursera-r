# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008? 

source("loader.R")

motorv.scc.index <-grep("Motor", SCC$Short.Name) # this selects Motor Vehicles and Motorcycles in the short description.
                                                 # It is assumed that Motorcycles also are Motor Vehicles
    
baltimore.em <- NEI[NEI$fips == "24510",] # only data for Baltimore

motorv.nei.index <- baltimore.em$SCC %in% SCC[motorv.scc.index,1] # data referring to motor vehicles type

motorv.nei <- baltimore.em[motorv.nei.index,]

motorv.emissions <- sapply(split(motorv.nei$Emissions, motorv.nei$year), sum) # sum grouping by year

png("plot5.png", width=480, height=480, units="px")

plot(attributes(motorv.emissions)[[1]], motorv.emissions, main="Total emissions from Motor Vehicle-related sources in Baltimore", xlab="years", ylab="PM2.5 (tons)")
lines(attributes(motorv.emissions)[[1]], motorv.emissions)

dev.off()