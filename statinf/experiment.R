## Generate samples 
nosim <- 1000 # number simulations
n <- 40
lambda <- 0.2 

m.dist <- 1/lambda
sd.dist <- 1/lambda

ALL <- rexp(nosim*n, lambda)
MEAN <- matrix(ALL, nosim)

means <- apply(MEAN, 1, mean)

m.all <- mean(ALL)
m.means <- mean(means)

sd.all <- sd(ALL)
sd.n <- sd.all/sqrt(n)
sd.means <- sd(means)

library(ggplot2)

DF <- data.frame(x=means)
ggplot(DF, aes(x=x)) + geom_histogram(alpha=0.3,binwidth=.1, aes(y= ..density..)) + stat_function(fun=dnorm, args=list(mean=m.means, sd=sd.means)) 

DF.ALL <- data.frame(values=ALL)
ggplot(DF.ALL, aes(x=values)) + geom_histogram(binwidth=.1, aes(y= ..density..)) + xlim(0, 35) + geom_vline(aes(xintercept=5), colour="red")

##############

library(datasets)

summary(ToothGrowth)

## shows clusters
ggplot(data=tg, aes(x=len, y=dose, group=supp, colour=supp)) +
    geom_point() 

# pre analysis on data

tg <- ToothGrowth
tg$dose <- factor(tg$dose)
tg$supp.dose <- factor(tg$)

calc_interval <- function(x, conf) {
    quantile <- 1-(1-conf)/2
    (mean(x)+c(-1,1)*qnorm(quantile)*sd(x)/sqrt(length(x)))    
} 

confidence <- 0.95

for (supp in levels(tg$supp)) {
    for (dose in levels(tg$dose)) {
        print(dose)
        print(supp)
        dose.supp <- tg[tg$supp==supp & tg$dose==dose,"len"]
        print(calc_interval(dose.supp, confidence))
    }
}

# http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html
# http://www.cookbook-r.com/Graphs/index.html

library(dplyr)

d2 <- tg %>% filter(dose=="2") %>% select(len)
d1 <- tg %>% filter(dose=="1") %>% select(len)
d1_2 <- tg %>% filter(dose=="0.5") %>% select(len)

calc_interval2 <- function(x, conf) {
    quantile <- 1-(1-conf)/2
    sd <- sd(x)/sqrt(length(x))
    m <- mean(x)
    interval <- (mean(x)+c(-1,1)*qnorm(quantile)*sd(x)/sqrt(length(x)))    
    list(quantile=quantile, sd=sd, m=m, interval=interval)
} 

colours <- c("green", "blue", "magenta", "red", "orange", "black")
g <- ggplot(tg, aes(x=len))
i <- 1
for (supp in levels(tg$supp)) {
    x <- tg[tg$supp==supp,"len"]
    l <- calc_interval2(x, confidence)
    g <- g + stat_function(fun=dnorm, args=list(mean=l$m, sd=l$sd), colour=colours[i])
    i <- i + 1
}
g


for (supp in levels(tg$supp)) {
    for (dose in levels(tg$dose)) {
        x <- tg[tg$supp==supp & tg$dose==dose,"len"]
        l <- calc_interval2(x, confidence)
        g <- g + stat_function(fun=dnorm, args=list(mean=l$m, sd=l$sd), colour=colours[i])
        i <- i + 1
    }
}
g

