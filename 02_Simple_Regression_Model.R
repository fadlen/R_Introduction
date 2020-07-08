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

#### Script 2.7 "