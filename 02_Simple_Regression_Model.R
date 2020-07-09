##### Chapter 02: The Simple Regression Model 
# Nachbau der im "Heiss 2016: Using R for introductory econometrics" abgebildeten Skripte und Codes. #

#### Script 2.1 "Example-2-3" ####
require(foreign)
ceosal1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/ceosal1.dta")
attach(ceosal1)

# ingredients to the OLS formulas
cov(roe, salary)
var(roe)
mean(salary)

# manual calculation of OLS coeffients
( b1hat <- cov(roe, salary)/var(roe) )
( b0hat <- mean(salary) - b1hat*mean(roe) )

# "detach" the data frame
detach(ceosal1)



#### Script 2.2 "Example-2-3-2" ####
require(foreign)
ceosal1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/ceosal1.dta")

# OLS regression
lm(salary ~ roe, data=ceosal1)



#### Script 2.3 "Example-2-3-3" ####
library(foreign)
ceosal1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/ceosal1.dta")

# OLS regression
CEOregres <- lm(salary ~ roe, data = ceosal1)

# Scatter plot (restrict y axis limits)
plot(ceosal1$roe, ceosal1$salary, ylim=c(0,4000))

# Add OLS regression line
abline(CEOregres)



#### Script 2.4 "Example-2-4" ####
library(foreign)
wage1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/wage1.dta")

# OLS regression
lm(wage ~ edu, data=wage1)



#### Script 2.5 "Example-2-5" ####
require(foreign)
vote1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/vote1.dta")

# OLS regression (parentheses for immediate output):
(VOTEres <- lm(voteA ~ shareA, data = vote1))

# scatter plot with regression line:
plot(vote1$shareA, vote1$voteA)
abline(VOTEres)



#### Script 2.6 "Example-2-6" ####
require(foreign)
ceosal1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/ceosal1.dta")

# extract variables as vectors
sal <- ceosal1$salary
roe <- ceosal1$roe

# regression with vectors
CEOregres <- lm(sal ~ roe)

# obtain predicted values and residuals
sal.hat <- fitted(CEOregres)
u.hat <- resid(CEOregres)

# Wooldridge, Table 2.2
cbind(roe, sal, sal.hat, u.hat)[1:15,]



#### Script 2.7 "Example-2-7" ####
library(foreign)
wage1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/wage1.dta")
WAGEregres <- lm(wage ~ educ, data = wage1)

# obtain coefficients, predicted values and residuals
b.hat <- coef(WAGEregres)
wage.hat <- fitted(WAGEregres)
u.hat <- resid(WAGEregres)

# Confirm property (1):
mean(u.hat)

# Confirm property (2):
cor(wage1$educ, u.hat)

# Confirm property (3):
mean(wage1$wage)

b.hat[1] + b.hat[2] * mean(wage1$educ)



#### Script 2.8 "Example-2-8" ####
library(foreign)
ceosal1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/ceosal1.dta")
CEOregres <- lm(salary ~ roe, data=ceosal1)

# Calculate predicted values & residuals:
sa1.hat <- fitted(CEOregres)
u.hat <- resid(CEOregres)

# Calculate R^2 in the three different ways:
sa1 <- ceosal1$salary
var(sa1.hat) / var(sa1)
1- var(u.hat) / var(sa1)
cor(sa1, sa1.hat)^2



#### Script 2.9 "Example-2-9" ####
library(foreign)
vote1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/vote1.dta")
(VOTEres <- lm(voteA ~ shareA, data = vote1))

# Summary of the regression results
summary(VOTEres)

# Calculate R^2 manually:
var(fitted(VOTEres)) / var(vote1$voteA)



#### Script 2.10 "Example-2-10" ####
require(foreign)
wage1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/wage1.dta")

# Estimate log-level model
lm(log(wage) ~ educ, data=wage1)



#### Script 2.11 "Example-2-11" ####
library(foreign)
ceosal1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/ceosal1.dta")

# Estimate log-log model
lm( log(salary) ~ log(sales), data=ceosal1)



#### Script 2.12 "SLR-Origin-Const" ####
library(foreign)
ceosal1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/ceosal1.dta")

# Usual OLS regression:
(reg1 <- lm(salary ~ roe, data=ceosal1))

# Regression without intercept (through origin):
(reg2 <- lm(salary ~ 0 + roe, data=ceosal1))

# Regression without slope (on a constant):
(reg3 <- lm(salary ~ 1 , data=ceosal1))

# average y:
mean(ceosal1$salary)

# Scatter Plot with all 3 regression lines
plot(ceosal1$roe, ceosal1$salary, ylim=c(0,4000))
abline(reg1, lwd=2, lty=1)
abline(reg2, lwd=2, lty=2)
abline(reg3, lwd=2, lty=3)
legend("topleft", c("full", "through origin", "const only"), lwd=2, lty=1:3)


#### Script 2.13 "Example-2-12" ####
library(foreign)
meap93 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/meap93.dta")

# Estimate the model and save the results as "results":
results <- lm(math10 ~ lnchprg, data = meap93)

# Number of obs.
(n <- nobs(results))

# SER:
(SER <- sd(resid(results)) * sqrt((n-1)/(n-2)))

# SE of b0hat % b1hat, resprectively:
SER/ sd(meap93$lnchprg) / sqrt(n-1) * sqrt(mean(meap93$lnchprg^2))
SER/ sd(meap93$lnchprg) / sqrt(n-1)

# Automatic calculations:
summary(results)



#### Script 2.14 "SLR-Sim-Sample" ####
# Set the random seed:
set.seed(1234567)

# set sample size:
n <- 1000

# set true parameters: betas and sd of u
b0 <-1; b1 <-0.5; su <-2

# Draw a sample of size n:
x <- rnorm(n, 4,1)
u <- rnorm(n,0,su)
y <- b0 + b1*x + u

# estimate parameters by OLS:
(olsres <- lm(y~x))

# features of the sample for the variance formula:
mean(x^2)
sum((x-mean(x))^2)

# Graph:
plot(x,y, col="gray", xlim=c(0,8))
abline(b0,b1, lwd=2)
abline(olsres, col="gray", lwd=2)
legend("topleft", c("pop. regr. fct.", "OLS regr. fct."), lwd=2, col=c("black","gray"))



#### Script 2.16 "SLR-Sim-Model-Condx" ####
# Set the random seed:
set.seed(1235467)

# set sample size and number of simulations:
n<- 1000; r <-10000

# set true parameters: betas and sd of u:
b0 <- 1; b1 <- 0.5; su <- 2

# initialize b0hat and b1hat to store results later:
b0hat <- numeric(r)
b1hat <- numeric(r)

# Draw a sample of x, fixed over replications:
x <- rnorm(n, 4, 1)

# repeat r times:
for (j in 1:r) {
  u <- rnorm(n,0,su)
  y <- b0 + b1*x + u
  
  bhat <- coefficients( lm(y~x) )
  b0hat[j] <- bhat["(Intercept)"]
  b1hat[j] <- bhat["x"]
}



#### Script 2.17 "SLR-Sim-Results" ####
# MC estimate of the expected values:
mean(b0hat)
mean(b1hat)

# MC estimate of the variances:
var(b0hat)
var(b1hat)

# Initialize empty plot
plot(NULL, xlim=c(0,8), ylim = c(0,6), xlab = "x", ylab = "y")

t <- 10
# add OLS regression lines
for(j in 1:t) {
  abline(b0hat[j], b1hat[j], col="gray")
}
  
# add population regression line:
abline(b0,b1,lwd=2)

# add legend:
legend("topleft", c("Population", "OLS regressions"), lwd=c(2,1), col = c("black", "gray"))



#### Script 2.19 "SLR-Sim-Results-Vio1SLR4" ####
# Set the random seed:
set.seed(1235467)

# set sample size and number of simulations:
n<- 1000; r <-10000

# set true parameters: betas and sd of u:
b0 <- 1; b1 <- 0.5; su <- 2

# initialize b0hat and b1hat to store results later:
b0hat <- numeric(r)
b1hat <- numeric(r)

# Draw a sample of x, fixed over replications:
x <- rnorm(n, 4, 1)

# repeat r times:
for (j in 1:r) {
  u <- rnorm(n,(x-4)/5,su)
  y <- b0 + b1*x + u
  
  bhat <- coefficients( lm(y~x) )
  b0hat[j] <- bhat["(Intercept)"]
  b1hat[j] <- bhat["x"]
}

# MC estimate of the expected values:
mean(b0hat)
mean(b1hat)

# MC estimate of the variances:
var(b0hat)
var(b1hat)



#### Script 2.21 " SLR-Sim-Results-Vio1SLR5" ####
# MC estimate of the expected values:
# Set the random seed:
set.seed(1235467)

# set sample size and number of simulations:
n<- 1000; r <-10000

# set true parameters: betas and sd of u:
b0 <- 1; b1 <- 0.5; varu <- 4/exp(4.5) * exp(x)


# initialize b0hat and b1hat to store results later:
b0hat <- numeric(r)
b1hat <- numeric(r)

# Draw a sample of x, fixed over replications:
x <- rnorm(n, 4, 1)


# repeat r times:
for (j in 1:r) {
  u <- rnorm(n,0,sqrt(varu))
  y <- b0 + b1*x + u
  
  bhat <- coefficients( lm(y~x) )
  b0hat[j] <- bhat["(Intercept)"]
  b1hat[j] <- bhat["x"]
}




mean(b0hat)
mean(b1hat)

# MC estimate of the variances:
var(b0hat)
var(b1hat)
