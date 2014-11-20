source("loader.R")

total.emissions <- sapply(split(NEI$Emissions, NEI$year), sum)
plot(attributes(total.emissions)[[1]], total.emissions, main="Total emissions of PM2.5", xlab="years")
lines(attributes(total.emissions)[[1]], total.emissions)
