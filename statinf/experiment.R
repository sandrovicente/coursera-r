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
tg$supp <- factor(tg$supp)


# http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html
# http://www.cookbook-r.com/Graphs/index.html


#####
library(datasets)
library(ggplot2)
library(plyr)

calc_interval <- function(x, conf) {
    quantile <- 1-(1-conf)/2
    n <- length(x)
    sdn <- sd(x)/sqrt(n)
    m <- mean(x)
    interval <- (m+c(-1,1)*qnorm(quantile)*sdn)    
    list(quantile=quantile, n=n, sd=sdn, m=m, interval=interval)
} 

confidence <- 0.95 

# function to calculate normal densities given data frame containg "type", "m" mean and "sd" sample's standard deviation
calc_normal <- function(nt) {
    ddply(norm.type, "type", function(df) {
        data.frame( 
            predicted = len.x,
            density = dnorm(len.x, mean=df$m, sd=df$sd)
        )
    })
}

data.supp <- data.frame()
for (supp in levels(tg$supp)) {
    x <- tg[tg$supp==supp,"len"]
    l <- calc_interval(x, confidence)
    data.supp <- rbind(data.supp, data.frame(x=x, type=supp))
    print(sprintf("Supplement: %s, mean: %f, sd: %f, size: %d, range:[%f, %f]", supp, l$m, l$sd, l$n, l$interval[1], l$interval[2]))
}

t.test(subset(data.supp, type=="OJ")$x, subset(data.supp, type="VC")$x)

data.type <- data.frame()  # dataframe containg data per type (i.e. per dose)
norm.type <- data.frame()  # dataframe containg summarized for normal distribution per type (i.e. per dose)
for (dose in levels(tg$dose)) {
    x <- tg[tg$dose==dose,"len"]
    ds <- data.frame(x=x, type=dose)  
    data.type <- rbind(data.type, ds)
    
    l <- calc_interval(x, confidence)
    norm.type <- rbind(norm.type, data.frame(m=l$m, sd=l$sd, type=dose)) # data for normal distribution of sample
    
    print(sprintf("Dosage: %s mg, mean: %f, sd: %f, size: %d, range:[%f, %f]", dose, l$m, l$sd, l$n, l$interval[1], l$interval[2]))
}

apply(combn(levels(data.type$type),2, simplify=T), 2, function(t) {c(t, t.test(x ~ type, data=subset(data.type, type %in% t))$conf)})


# Calculate normal values for reference 
len.min <- min(tg$len) # minimum length
len.max <- max(tg$len) # maximum legth
len.x <- seq(len.min, len.max, length=100) # range of lengths from min to max 

normaldens <- calc_normal(norm.type) # normal densities for the corresponding types

# plot histogram and corresponding normal distributions in separated frames
ggplot(data.type, aes(x=x, fill=type)) +  geom_histogram(alpha = 0.5, aes(y = ..density..), position = 'identity') +
    geom_line(data=normaldens, aes(x = predicted, y=density)) +
    facet_wrap(~ type, ncol=3)

# plot histogram and normal distributions altogether
ggplot(data.type, aes(x=x, fill=type)) +  geom_histogram(alpha = 0.5, aes(y = ..density..), position = 'identity') +
    geom_line(data=normaldens, aes(x=predicted, y=density, color=type)) 


data.type <- data.frame()  # reset dataframe containg data per type (i.e. per dose and supp)
norm.type <- data.frame()  # reset dataframe containg summarized for normal distribution per type (i.e. per dose and supp)
for (dose in levels(tg$dose)) {
    for (supp in levels(tg$supp)) {
        x <- tg[tg$supp==supp & tg$dose==dose,"len"] # filter supp and dose
        l <- calc_interval(x, confidence)
        
        ds <- data.frame(x=x, type=paste(supp,dose,sep="-")) # type defined as composition supp "-" dose
        data.type <- rbind(data.type, ds)
        norm.type <- rbind(norm.type, data.frame(m=l$m, sd=l$sd, type=paste(supp,dose,sep="-"))) # type defined as composition supp "-" dose
        
        print(sprintf("Supplement:%s, Dosage: %s mg, mean: %f, sd: %f, size: %d, range:[%f, %f]", supp, dose, l$m, l$sd, l$n, l$interval[1], l$interval[2]))
    }
}

d <- subset(data.type, type %in% c("OJ-1", "OJ-2")); t.test( x ~ type, data=d)
t.test(x ~ type, data=subset(data.type, type %in% c("OJ-1", "VC-2")))

apply(combn(levels(data.type$type),2, simplify=T), 2, function(t) {t.test(x ~ type, data=subset(data.type, type %in% t))})


apply(combn(levels(data.type$type),2, simplify=T), 2, function(t) {
    conf <- t.test(x ~ type, data=subset(data.type, type %in% t))$conf
    c(t, conf, ifelse(conf[1]*conf[2]>0,"OK","UNCONFIRMED"))
})