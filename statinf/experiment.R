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
ggplot(DF.ALL, aes(x=values)) + geom_histogram(binwidth=.1, aes(y= ..density..)) + xlim(0, 35)
