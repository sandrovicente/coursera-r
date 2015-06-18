library(dplyr)
library(ggplot2)

data(mtcars)

# “Is an automatic or manual transmission better for MPG”
# "Quantify the MPG difference between automatic and manual transmissions"

# am - transmission: 0= automatic, 1= manual

# Did the student interpret the coefficients correctly?

# Did the student do some exploratory data analyses?

# Did the student fit multiple models and detail their strategy for model selection?

# Did the student answer the questions of interest or detail why the question(s) is (are) not answerable?

# Did the student do a residual plot and some diagnostics?

# Did the student quantify the uncertainty in their conclusions and/or perform an inference correctly?

# Was the report brief (about 2 pages long) for the main body of the report and no longer than 5 with supporting appendix of figures?


# charts of few measurements (non factors) against mpg
par(mfrow=c(3,3))
with(mtcars, plot(disp, mpg, pch=19, col=am+1))
with(mtcars, plot(hp, mpg, pch=19, col=am+1)) # good
with(mtcars, plot(drat, mpg, pch=19, col=am+1))
with(mtcars, plot(wt, mpg, pch=19, col=am+1))
with(mtcars, plot(qsec, mpg, pch=19, col=am+1)) # good
with(mtcars, plot(gear, mpg, pch=19, col=am+1))
with(mtcars, plot(carb, mpg, pch=19, col=am+1))
with(mtcars, plot(cyl, mpg, pch=19, col=am+1))

with(mtcars, plot(am, mpg, pch=19, col=am+1))

with(mtcars, plot(am, vs, pch=19, col=am+1))

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

fit_qsec_hp2 <- lm(mpg ~ qsec * hp + am, data=mtcars)

anova(fit_qsec, fit2_qsec, fit_qsec_hp, fit_qsec_hp2)

mpg0 <- mtcars[mtcars$am==0, "mpg"]
mpg1 <- mtcars[mtcars$am==1, "mpg"]

mean(mpg0)
sd(mpg0)/sqrt(length(mpg0))

mean(mpg1)
sd(mpg1)/sqrt(length(mpg1))

t.test(mpg0, mpg1, paired=F)

fit_wt <- lm(mpg ~ wt, data=mtcars)
fit2_wt <- lm(mpg ~ wt + factor(am), data=mtcars)
anova(fit_wt, fit2_wt)$Pr[2]

###--

# gear not included - not data covering both am = 0 and 1 for 3 and 5 gears
# vs - not included 

vars <- c("cyl", "disp", "hp", "drat", "wt", "qsec", "gear", "carb" )
for (v in vars) {
    a<-anova(lm(as.formula(paste("mpg ", v, sep="~")), data=mtcars),
             lm(as.formula(paste("mpg ~ factor(am) ", v, sep="+")), data=mtcars))
    if (a$Pr[2] < 0.05) {
        print(v); print(a$Pr[2])
    }
}


vars <- c("cyl", "disp", "hp", "drat", "wt", "qsec", "gear", "carb" )
for (v in vars) {
    a<-anova(lm(as.formula(paste("mpg ", v, sep="~")), data=mtcars),
             lm(as.formula(paste("mpg ~ factor(am) ", v, sep=":")), data=mtcars))
    if (a$Pr[2] < 0.05) {
        #print(v); print(a$Pr[2])
        print(a)
    }
}
