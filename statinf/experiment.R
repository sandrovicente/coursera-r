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


for (supp in levels(tg$supp)) {
        print(dose)
        print(supp)
        dose.supp <- tg[tg$supp==supp,"len"]
        print(calc_interval(dose.supp, confidence))
}

# http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html
# http://www.cookbook-r.com/Graphs/index.html

library(dplyr)

g <- ggplot(tg, aes(x=len)) 

d2 <- tg %>% filter(dose=="2") %>% select(len)
d1 <- tg %>% filter(dose=="1") %>% select(len)
d1_2 <- tg %>% filter(dose=="0.5") %>% select(len)

#####
library(datasets)
library(ggplot2)
library(plyr)

calc_interval <- function(x, conf) {
    quantile <- 1-(1-conf)/2
    n <- length(x)
    sd <- sd(x)
    m <- mean(x)
    interval <- (m+c(-1,1)*qnorm(quantile)*sd/sqrt(n))    
    list(quantile=quantile, n=n, sd=sd, m=m, interval=interval)
} 

tg <- ToothGrowth
tg$dose <- factor(tg$dose)
tg$supp <- factor(tg$supp)

len.min <- min(tg$len)
len.max <- max(tg$len)
len.x <- seq(len.min, len.max, length=100)

confidence <- 0.95

## data for dosage

data.type <- data.frame()
norm.type <- data.frame()
for (dose in levels(tg$dose)) {
    x <- tg[tg$dose==dose,"len"]
    ds <- data.frame(x=x, type=dose)
    data.type <- rbind(data.type, ds)
    
    l <- calc_interval(x, confidence)
    norm.type <- rbind(norm.type, data.frame(m=l$m, sd=l$sd, type=dose))
}

calc_normal <- function(nt) {
    ddply(norm.type, "type", function(df) {
        data.frame( 
            predicted = len.x,
            density = dnorm(len.x, mean=df$m, sd=df$sd)
        )
    })
}

normaldens <- calc_normal(norm.type)

ggplot(data.type, aes(x=x, fill=type)) +  geom_histogram(alpha = 0.5, aes(y = ..density..), position = 'identity') +
    geom_line(data=normaldens, aes(x = predicted, y=density)) +
    facet_wrap(~ type, ncol=3)

ggplot(data.type, aes(x=x, fill=type)) +  geom_histogram(alpha = 0.5, aes(y = ..density..), position = 'identity') +
    geom_line(data=normaldens, aes(x=predicted, y=density, color=type))


## data for all combinations

data.type <- data.frame()
norm.type <- data.frame()
for (supp in levels(tg$supp)) {
    for (dose in levels(tg$dose)) {
        x <- tg[tg$supp==supp & tg$dose==dose,"len"]
        l <- calc_interval(x, confidence)
        
        ds <- data.frame(x=x, type=paste(supp,dose,sep="-"))
        data.type <- rbind(data.type, ds)
        norm.type <- rbind(norm.type, data.frame(m=l$m, sd=l$sd, type=paste(supp,dose,sep="-")))
    }
}

normaldens <- calc_normal(norm.type)

ggplot(data.type, aes(x=x, fill=type)) +  geom_histogram(alpha = 0.5, aes(y = ..density..), position = 'identity') +
    geom_line(data=normaldens, aes(x = predicted, y=density)) +
    facet_wrap(~ type, ncol=3)

ggplot(data.type, aes(x=x, fill=type)) +  geom_histogram(alpha = 0.5, aes(y = ..density..), position = 'identity') +
    geom_line(data=normaldens, aes(x=predicted, y=density, color=type)) 

