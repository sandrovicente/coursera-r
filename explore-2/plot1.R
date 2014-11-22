source("loader.R")

total.emissions <- sapply(split(NEI$Emissions, NEI$year), sum) # calculate total aggregating year
# Totals are stored in a vector. A vector of attributes is also generated for the corresponding years.
# The attribute vector is accessed using 'attributes(total.emissions)[[1]]'

png("plot1.png", width=480, height=480, units="px")

plot(attributes(total.emissions)[[1]], total.emissions, main="Total emissions of PM2.5 in US", ylab="PM2.5 (tons)", xlab="years")
lines(attributes(total.emissions)[[1]], total.emissions)

dev.off()
