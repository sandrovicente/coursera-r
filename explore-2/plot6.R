
source("loader.R")

motorv.scc.index <-grep("Motor", SCC$Short.Name)
    
baltimore.em <- NEI[NEI$fips == "24510",]
losangeles.em <- NEI[NEI$fips == "06037",]

motorv.balt.index <- baltimore.em$SCC %in% SCC[motorv.scc.index,1]
motorv.losa.index <- losangeles.em$SCC %in% SCC[motorv.scc.index,1]

motorv.balt <- baltimore.em[motorv.balt.index,]
motorv.losa <- losangeles.em[motorv.losa.index,]

motorv.balt.emissions <- sapply(split(motorv.balt$Emissions, motorv.balt$year), sum)
motorv.losa.emissions <- sapply(split(motorv.losa$Emissions, motorv.losa$year), sum)

png("plot6.png", width=480, height=480, units="px")

plot(attributes(motorv.losa.emissions)[[1]], motorv.losa.emissions, main="Total emissions from Motor Vehicle-related sources", xlab="years", ylab="PM2.5 (tons)", ylim=c(0,100))
lines(attributes(motorv.balt.emissions)[[1]], motorv.balt.emissions, col="blue")
lines(attributes(motorv.losa.emissions)[[1]], motorv.losa.emissions, col="green")

legend("topleft", c("Los Angeles", "Baltimore"), lty = 1, col = c("green", "blue"))

dev.off()