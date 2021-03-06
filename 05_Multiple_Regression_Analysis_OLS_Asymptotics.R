##### Chapter 05: Multiple Regression Analysis: OLS Asymptotics
# Nachbau der im "Heiss 2016: Using R for introductory econometrics" abgebildeten Skripte und Codes. #

#### Script 5.1 "Sim-Asy-OLS-norm" ####
# Set the random seed:
set.seed(1234567)

# set true parameters: intercept & slope:
b0<-1; b1<-0.5

# initialize b1hat to store 10000 results:
b1hat <- numeric(10000)

# Draw a sample of x, fixed over replications:
x <- rnorm(n,4,1)

# repeat r times:
for(j in 1:10000) {
  # Draw a sample of u (std. normal):
  u <- rnorm(n)
  # Draw a sample of y:
  y <- b0 + b1*x + u
  # regress y on x and store slope estimate at position j:
  bhat <- coef( lm(y~x))
  b1hat[j] <- bhat["x"]
}




#### Script 5.3 "Sim-Asy-OLS-uncond" ####
# Set the random seed:
set.seed(1234567)

# set true parameters: intercept & slope:
b0<-1; b1<-0.5

# initialize b1hat to store 10000 results:
b1hat <- numeric(10000)

# repeat r times:
for(j in 1:10000) {
  # Draw a sample of x, varying over replications:
  x <- rnorm(n,4,1)
  # Draw a sample of u (std. normal):
  u <- rnorm(n)
  # Draw a sample of y:
  y <- b0 + b1*x + u
  # regress y on x and store slope estimate at position j:
  bhat <- coef( lm(y~x))
  b1hat[j] <- bhat["x"]
}



#### Script 5.4 "Example-5-3" ####
library(foreign)
crime1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/crime1.dta")

# 1. Estimate restricted model:
restr <- lm(narr86 ~ pcnv+ptime86+qemp86, data = crime1)

# 2. Regression of residuals from restricted model:
utilde <- resid(restr)
LMreg <- lm(utilde ~ pcnv+ptime86+qemp86+avgsen+tottime, data = crime1)

# R-squared:
(r2 <- summary(LMreg)$r.squared)

# 3. Calculation of LM test statistic:
LM <- r2 * nobs(LMreg)
LM

# 4 Critical value from chi-squared distribution, alpha=10%:
qchisq(1-0.10,2)

# Alternative to critical value: p value
1-pchisq(LM, 2)

# Alternative: automatic F test:
library(car)
unrestr <- lm(narr86 ~ pcnv+ptime86+qemp86+avgsen+tottime, data = crime1)
linearHypothesis(unrestr, c("avgsen=0","tottime=0"))


