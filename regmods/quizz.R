
> fit <-lm(mpg ~ wt, mtcars)
> mean(mtcars$wt)
[1] 3.21725
> fit$coefficients
(Intercept)          wt 
37.285126   -5.344472 
> b0 <- fit$coefficients[1]
> b1 <- fit$coefficients[2]
> b0
(Intercept) 
37.28513 
> b1
wt 
-5.344472 
> b1*wt + b0
Error: object 'wt' not found
> mw <- mean(mtcars$wt)
> b1*mw + b0
wt 
20.09062 
> plot(mpg ~ wt, mtcars)
> points(mpg$wt, predict(fit), col="red")
Error in points(mpg$wt, predict(fit), col = "red") : 
    object 'mpg' not found
> points(mtcars$wt, predict(fit), col="red")
> lines(mtcars$wt, predict(fit), col="red")
> b0 + c(-1,1)*qt(0.975,df=fit$df)*b1
[1] 48.19999 26.37026



x <- mtcars$wt*1000
y <- mtcars$mpg
n <- length(x)
beta1 <- cor(y, x) * sd(y) / sd(x)
beta0 <- mean(y) - beta1 * mean(x)
e <- y - beta0 - beta1 * x
sigma <- sqrt(sum(e^2) / (n-2))
ssx <- sum((x - mean(x))^2)
seBeta0 <- (1 / n + mean(x) ^ 2 / ssx) ^ .5 * sigma
seBeta1 <- sigma / sqrt(ssx)
tBeta0 <- beta0 / seBeta0; tBeta1 <- beta1 / seBeta1
pBeta0 <- 2 * pt(abs(tBeta0), df = n - 2, lower.tail = FALSE)
pBeta1 <- 2 * pt(abs(tBeta1), df = n - 2, lower.tail = FALSE)
coefTable <- rbind(c(beta0, seBeta0, tBeta0, pBeta0), c(beta1, seBeta1, tBeta1, pBeta1))
colnames(coefTable) <- c("Estimate", "Std. Error", "t value", "P(>|t|)")
rownames(coefTable) <- c("(Intercept)", "x")

plot(x, y, frame=FALSE,xlab="Weight (lbs)",ylab="Mpg",pch=21,col="black", bg="lightblue", cex=2)
abline(fit, lwd = 2)
xVals <- seq(min(x), max(x), by = .01)
yVals <- beta0 + beta1 * xVals
se1 <- sigma * sqrt(1 / n + (xVals - mean(x))^2/ssx)
se2 <- sigma * sqrt(1 + 1 / n + (xVals - mean(x))^2/ssx)
lines(xVals, yVals + 2 * se1)
lines(xVals, yVals - 2 * se1)
lines(xVals, yVals + 2 * se2)
lines(xVals, yVals - 2 * se2)

fit <- lm(y ~ x)

nw = 3000 # new weight lbs
lines(x, predict(fit), col="red")

## calculate prediction (95%)
beta1*nw + beta0 + c(-1,+1)*qt(0.975, df=fit$df)*sigma*sqrt(1+1/n+(nw-mean(x))^2/ssx)

sumCoef <- summary(fit)$coefficients
int_lib <- sumCoef[2,1] + c(-1, 1) * qt(.975, df = fit$df) * sumCoef[2, 2]

#short ton
int_lib*2000

#-------- quizz 3!

#You can specify this distinction in R:
confounding_fit <- lm(y ~ x + w)
interacting_fit <- lm(y ~ x * w) #, which is equivalent to lm(y ~ x + w + x:w)
interactions_only_fit <- lm(y ~ x:w)


data(mtcars)
x1 <- mtcars$cyl
x2 <- mtcars$wt
y <- mtcars$mpg
plot(x1, y, col="blue")
points(x2,y, col="green")

fit1 <- lm(y ~ x1)
fit2 <- lm(y ~ x2)

lines(x1,fit1$fitted,col="blue")
lines(x2,fit2$fitted,col="green")

summary(lm(mpg ~ ., data=mtcars))
fit3 <- lm(mpg ~ wt + cyl, data=mtcars)
fit3$coef[3]*(8-4)

fit4 <- lm(mpg ~ factor(cyl)+ wt-1, data=mtcars)
fit5 <- lm(mpg - wt ~ factor(cyl) + wt -1, data=mtcars)

fit4$coefficients[3] + fit4$coefficients[4] 
fit5$coefficients[3] + fit4$coefficients[4]

# interactions

fit2 <- lm(mpg ~ wt, data=mtcars)
fit3 <- lm(mpg ~ wt + cyl, data=mtcars) ## invalid. It determines for the level only!

plot(mtcars$wt, mtcars$mpg)
points(mtcars$wt, mtcars$mpg, pch=19, col=(mtcars$cyl)) 
abline(fit2,col="green")

fit7 <- update(fit4, mpg ~ factor(cyl)+wt+factor(cyl)*wt-1)
anova(fit4,fit7)

# Q2 - The wording is tricky, pay close attention

fit3 <- lm(mpg ~ factor(cyl) - 1, data=mtcars)
fit4 <- lm(mpg ~ factor(cyl) + wt -1, data=mtcars) ## invalid. It determines for the level only!!

summary(fit3)$coefficients
summary(fit4)$coefficients

f <- function(c4, c6, c8, fit) { s <- summary(fit)$coefficients; c4*s[1,1] + c6*s[2,1] + c8*s[3,1]}

c(f(1,0,0,fit3)-f(0,1,0,fit3), f(0,1,0,fit3)-f(0,0,1,fit3)) 
c(f(1,0,0,fit4)-f(0,1,0,fit4), f(0,1,0,fit4)-f(0,0,1,fit4))

## Q4 - The wording is even trickier... I really didn't get what was expected here....

fit7<- lm(mpg ~ I(wt) + factor(cyl)-1, data = mtcars)
fit8 <- lm(mpg ~ I(wt * 0.5) + factor(cyl)-1, data = mtcars)

summary(fit7)$coefficients
summary(fit8)$coefficients
f <- function(w, fit) { w* summary(fit)$coefficients[1,1]}

f(1, fit7)
f(1, fit8)
# num cylinders don't cause impact
# duplo impact in wt for fit8 => half change 

####

x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)

fit <- lm(y ~ x)

round(hatvalues(fit)[1 : 5], 3)
dfbetas(fit)

###

n <- 500; x <- seq(0, 4 * pi, length = n); y <- sin(x) + rnorm(n, sd = .3)
knots <- seq(0, 8 * pi, length = 20); 
splineTerms <- sapply(knots, function(knot) (x > knot) * (x - knot))
xMat <- cbind(1, x, splineTerms)
yhat <- predict(lm(y ~ xMat - 1))
plot(x, y, frame = FALSE, pch = 21, bg = "lightblue", cex = 2)
lines(x, yhat, col = "red", lwd = 2)

notes4 <- c(261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25)
t <- seq(0, 2, by = .001); n <- length(t)
c4 <- sin(2 * pi * notes4[1] * t); e4 <- sin(2 * pi * notes4[3] * t); 
g4 <- sin(2 * pi * notes4[5] * t)
chord <- c4 + e4 + g4 + rnorm(n, 0, 0.3)
x <- sapply(notes4, function(freq) sin(2 * pi * freq * t))
fit <- lm(chord ~ x - 1)
plot(c(0, 9), c(0, 1.5), xlab = "Note", ylab = "Coef^2", axes = FALSE, frame = TRUE, type = "n")
axis(2)
axis(1, at = 1 : 8, labels = c("c4", "d4", "e4", "f4", "g4", "a4", "b4", "c5"))
for (i in 1 : 8) abline(v = i, lwd = 3, col = grey(.8))
lines(c(0, 1 : 8, 9), c(0, coef(fit)^2, 0), type = "l", lwd = 3, col = "red")

# q4.1

library(MASS) 
y <- ifelse(shuttle$use == "auto",1,0)
x <- shuttle$wind #ifelse(shuttle$wind == "head", 1, 0)
log <- glm(y ~ x-1, family="binomial")
log$coefficients
or = exp(log$coeff)
# head / tail
head = or[1]
tail = or[2]

## q4.2

x2 <- shuttle$magn

log2 <- glm(y ~ x + x2 -1, family="binomial")
log2$coeff
or2 = exp(log2$coeff)

# q4.3

y2 <- ifelse(y == 1, 0, 1)
log3 <- glm(y2 ~ x -1, family="binomial")
log3$coeff

# q4.4

data(InsectSprays)
y <- InsectSprays$count
x <- InsectSprays$spray
log4 <- glm(y ~ x -1, family="poisson")
rate <- exp(log4$coeff)
rate[1]/rate[2]

plot(x,y, pch=19, col="darkgray")

# q4.6

x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
plot(x,y)

knots <- c(0)
x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
t <- sapply(knots, function(knot) (x > knot) * (x - knot)) 
xMat <- cbind(1,x,t)
fit <- lm(y~xMat)
yhat <- predict(fit)
lines(x, yhat, col = "red", lwd = 2)
 
