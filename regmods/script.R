library(dplyr)
library(ggplot2)

data(mtcars)

# “Is an automatic or manual transmission better for MPG”
# "Quantify the MPG difference between automatic and manual transmissions"

# am - transmission: 0= automatic, 1= manual

# charts of few measurements (non factors) against mpg
par(mfrow=c(2,3))
with(mtcars, plot(disp, mpg, pch=19, col=am+1))
with(mtcars, plot(hp, mpg, pch=19, col=am+1)) # good
with(mtcars, plot(drat, mpg, pch=19, col=am+1))
with(mtcars, plot(wt, mpg, pch=19, col=am+1))
with(mtcars, plot(qsec, mpg, pch=19, col=am+1)) # good
with(mtcars, plot(am, mpg, pch=19, col=am+1))
legend("topright", pch = 19, col = c(0,1)+1, legend = c("Auto", "Man"))

# didn't get this chart yet...
par(mfrow=c(2,2)) 
fit<-lm(mpg ~ .,data=mtcars);plot(fit)

library(car)
vif(fit)

# coparision of measurements with highest t-value
fit_hp <- lm(mpg ~ hp, data=mtcars)
fit2_hp <- lm(mpg ~ hp + am, data=mtcars)
anova(fit_hp, fit2_hp) # good

fit_qsec <- lm(mpg ~ qsec, data=mtcars)
fit2_qsec <- lm(mpg ~ qsec + am, data=mtcars)
anova(fit_qsec, fit2_qsec) # good

fit_qsec_hp <- lm(mpg ~ qsec + hp + am, data=mtcars )

anova(fit_qsec, fit2_qsec, fit_qsec_hp)

mpg0 <- mtcars[mtcars$am==0, "mpg"]
mpg1 <- mtcars[mtcars$am==1, "mpg"]

mean(mpg0)
sd(mpg0)/sqrt(length(mpg0))

mean(mpg1)
sd(mpg1)/sqrt(length(mpg1))

