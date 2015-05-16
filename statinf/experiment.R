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

tg <- ToothGrowth
tg$dose <- factor(tg$dose)

## shows clusters
ggplot(data=tg, aes(x=len, y=dose, group=supp, colour=supp)) +
    geom_point() 

# http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html
# http://www.cookbook-r.com/Graphs/index.html

library(dplyr)

d2 <- tg %>% filter(dose=="2") %>% select(len)
d1 <- tg %>% filter(dose=="1") %>% select(len)
d1_2 <- tg %>% filter(dose=="0.5") %>% select(len)

calc_interval <- function(x, conf) {
    quantile <- 1-(1-conf)/2
    (mean(x)+c(-1,1)*qnorm(quantile)*sd(x)/sqrt(length(x)))    
} 

confidence <- 0.99

d2 <- tg %>% filter(dose=="2") %>% select(len)
d1 <- tg %>% filter(dose=="1") %>% select(len)
d1_2 <- tg %>% filter(dose=="0.5") %>% select(len)

calc_interval(d2$len, confidence)
calc_interval(d1$len, confidence)
calc_interval(d1_2$len, confidence)

doj <- tg %>% filter(supp=="OJ") %>% select(len)
dvc <- tg %>% filter(supp=="VC") %>% select(len)

calc_interval(doj$len, confidence)
calc_interval(dvc$len, confidence)

confidence <- 0.95

d2.oj <- tg %>% filter(dose=="2", supp=="OJ") %>% select(len)
d1.oj <- tg %>% filter(dose=="1" ,supp=="OJ") %>% select(len)
d1_2.oj <- tg %>% filter(dose=="0.5", supp=="OJ") %>% select(len)

calc_interval(d2.oj$len, confidence)
calc_interval(d1.oj$len, confidence)
calc_interval(d1_2.oj$len, confidence)


d2.vc <- tg %>% filter(dose=="2", supp=="VC") %>% select(len)
d1.vc <- tg %>% filter(dose=="1" ,supp=="VC") %>% select(len)
d1_2.vc <- tg %>% filter(dose=="0.5", supp=="VC") %>% select(len)

calc_interval(d2.vc$len, confidence)
calc_interval(d1.vc$len, confidence)
calc_interval(d1_2.vc$len, confidence)
