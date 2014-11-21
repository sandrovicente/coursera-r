# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

source("loader.R")

baltimore.em <- NEI[NEI$fips == "24510",]

total.emissions <- sapply(split(baltimore.em$Emissions, baltimore.em$year), sum)

png("plot2.png", width=480, height=480, units="px")

plot(attributes(total.emissions)[[1]], total.emissions, main="Total emissions in Baltimore", ylab="PM2.5 (tons)", xlab="years")
lines(attributes(total.emissions)[[1]], total.emissions)

dev.off()