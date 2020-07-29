##### Chapter 08: Heteroscedasticity
# Nachbau der im "Heiss 2016: Using R for introductory econometrics" abgebildeten Skripte und Codes. #

#### Script 8.1 "Example-8-2" ####
library(foreign)
gpa3 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/gpa3.dta")

# load packages (which needed to be installed):
library(lmtest); library(car)

# Estimate model (only for spring data):
reg <- lm(cumgpa~ sat+hsperc+tothrs+female+black+white, data = gpa3, subset=(spring==1))

# Usual SE:
coeftest(reg)

# Refined White heteroscedasticity-robust SE:
coeftest(reg, vcov = hccm)



#### Script 8.2 "Example-8-2-cont" ####
# F-Tests using different variance-covariance formulas:
myH0 <- c("black", "white")

# Usual VCOV:
linearHypothesis(reg, myH0)

# Refined White VCOV:
linearHypothesis(reg, myH0, vcov=hccm)

# Classical White VCOV:
linearHypothesis(reg, myH0, vcov = hccm(reg, type="hc0"))



#### Script 8.3 "Example-8-4" ####
library(foreign)
hprice1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/hprice1.dta")

# Estimate model:
reg <- lm(price ~ lotsize+sqrft+bdrms, data = hprice1)
reg

# Automatic BP test:
library(lmtest)

bptest(reg)

# Manual regression of squared residuals:
summary(lm(resid(reg)^2 ~ lotsize+sqrft+bdrms, data = hprice1 ))



#### Script 8.4 "Example-8-5" ####
library(foreign)
hprice1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/hprice1.dta")

# Estimate model:
reg <- lm(log(price) ~ log(lotsize)+log(sqrft)+bdrms, data = hprice1)
reg

# BP test:
library(lmtest)
bptest(reg)

# White test:
bptest(reg, ~fitted(reg) + I(fitted(reg)^2))



#### Script 8.5 "Example-8-6" ####
library(foreign)
d401k <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/401ksubs.dta")

# OLS (onlfy for singles: fsize==1):
lm(nettfa ~ inc + I((age-25)^2) + male + e401k, data = d401k, subset=(fsize==1))

# WLS:
lm(nettfa ~ inc + I((age-25)^2) + male + e401k, weight=1/inc, data = d401k, subset=(fsize==1))



#### Script 8.6 "WLS-Robust" ####
library(foreign)
d401k <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/401ksubs.dta")

# WLS:
wlsreg <- lm(nettfa ~ inc + I((age-25)^2) + male + e401k, weight=1/inc, data = d401k, subset=(fsize==1))

# non-robust results:
library(lmtest); library(car)
coeftest(wlsreg)

# robust results:
coeftest(wlsreg,hccm)



#### Script 8.7 " Example-8-7" ####
library(foreign)
smoke <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/smoke.dta")

# OLS:
olsreg <- lm(cigs ~ log(income) + log(cigpric) + educ + age + I(age^2) + restaurn, data = smoke )
olsreg

# BP-Test:
library(lmtest)
bptest(olsreg)

# FGLS: estimation of the variance function:
logu2 <- log(resid(olsreg)^2)
varreg <- lm(logu2 ~ log(income) + log(cigpric) + educ + age + I(age^2) + restaurn, data = smoke )

# FGLS: WLS:
w <- 1/exp(fitted(varreg))
lm(cigs ~ log(income) + log(cigpric) + educ + age + I(age^2) + restaurn, weight = w, data = smoke )