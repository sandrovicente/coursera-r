source("loader.R")

total.emissions <- sapply(split(NEI$Emissions, NEI$year), sum)

png("plot1.png", width=480, height=480, units="px")

plot(attributes(total.emissions)[[1]], total.emissions, main="Total emissions of PM2.5 in US", ylab="PM2.5 (tons)", xlab="years")
lines(attributes(total.emissions)[[1]], total.emissions)

dev.off()
