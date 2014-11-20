
source("loader.R")

motorv.scc.index <-grep("Motor Vehicle", SCC$Short.Name)
    
baltimore.em <- NEI[NEI$fips == "24510",]
losangeles.em <- NEI[NEI$fips == "06037",]

motorv.balt.index <- baltimore.em$SCC %in% SCC[motorv.scc.index,1]
motorv.losa.index <- losangeles.em$SCC %in% SCC[motorv.scc.index,1]

motorv.balt <- baltimore.em[motorv.balt.index,]
motorv.losa <- losangeles.em[motorv.losa.index,]

motorv.balt.emissions <- sapply(split(motorv.balt$Emissions, motorv.balt$year), sum)
motorv.losa.emissions <- sapply(split(motorv.losa$Emissions, motorv.losa$year), sum)

plot(attributes(motorv.losa.emissions)[[1]], motorv.losa.emissions, main="Total emissions of PM2.5 from Motor Vehicle-related sources in Baltimore", xlab="years", ylim=c(0,70))
lines(attributes(motorv.balt.emissions)[[1]], motorv.balt.emissions, col="blue")
lines(attributes(motorv.losa.emissions)[[1]], motorv.losa.emissions, col="green")
