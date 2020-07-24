##### Chapter 06: Multiple Regression Analysis: Further Issues
# Nachbau der im "Heiss 2016: Using R for introductory econometrics" abgebildeten Skripte und Codes. #

#### Script 6.1 "Data-Scaling" ####
library(foreign)
bwght <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/bwght.dta")

# Basic model:
lm(bwght ~ cigs+faminc,data=bwght)

# Weight in pounds, manual way:
bwght$bwghtlbs <- bwght$bwght/16
lm(bwghtlbs ~ cigs+faminc,data=bwght)

# Weight in pounds, direct way:
lm(I(bwght/16) ~ cigs+faminc, data=bwght)

# Packs of cigarettes:
lm(bwght ~ I(cigs/20)+faminc,data=bwght)



#### Script 6.2 "Example-6-1" ####
# Just if all variables are standardized!
library(foreign)
hprice2 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/hprice2.dta")

# Estimate model with standardize variables:
lm(scale(price) ~ 0+scale(nox)+scale(crime)+scale(rooms)+scale(dist)+scale(stratio), data=hprice2)



#### Script 6.3 "Formula-Logarithm" ####
library(foreign)
hprice2 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/hprice2.dta")

# Estimate model with logs (partially logarithmic):
lm(log(price)~log(nox)+rooms, data=hprice2)



#### Script 6.4 "Example-6-2" ####
library(foreign)
hprice2 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/hprice2.dta")

res<- lm(log(price)~log(nox)+log(dist)+rooms+I(rooms^2)+stratio, data=hprice2)
summary(res)



#### Script 6.5 "Example-6-3" ####
library(foreign)
attend <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/attend.dta")

# Estimate model with interaction effect:
(myres <-lm(stndfnl~atndrte*priGPA+ACT+I(priGPA^2)+I(ACT^2), data=attend))

# Estimate for partial effect at priGPA=2.59:
b <- coef(myres)
b["atndrte"] + 2.59*b["atndrte:priGPA"]

# Test partial effect for priGPA=2.59:
library(car)
linearHypothesis(myres, c("atndrte+2.59*atndrte:priGPA"))



#### Script 6.6 "Example-6-5" ####
library(foreign)
gpa2 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/gpa2.dta")

# Regress and report coefficients:
reg <- lm(colgpa~sat+hsperc+hsize+I(hsize^2), data=gpa2)
reg

# Generate data set containing the regressor values for predictions:
cvalues <- data.frame(sat=1200, hsperc=30, hsize=5)

# Point estimate of prediction:
predict(reg, cvalues)

# Point estimate and 95% confidence interval:
predict(reg, cvalues,interval = "confidence")

# Define three sets of regressor variables:
cvalues <- data.frame(sat=c(1200,900,1400), hsperc=c(30,20,5), hsize=c(5,3,1))
cvalues

# Point estimates and 99% confidence intervals for these:
predict(reg, cvalues, interval = "confidence", level = 0.99)



#### Script 6.7 "Example-6-6" ####
library(foreign)
gpa2 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/gpa2.dta")

# Regress:
reg <- lm(colgpa~sat+hsperc+hsize+I(hsize^2), data=gpa2)
reg

# Define three sets of regressor variables:
cvalues <- data.frame(sat=c(1200,900,1400), hsperc=c(30,20,5), hsize=c(5,3,1))
cvalues

# Point estimate and 95% prediction intervals for these:
predict(reg, cvalues,interval = "prediction")



#### Script 6.8 "Effects-Manual" ####
# Repeating the regression from Example 6.2 (Script 6.4!!!)
library(foreign)
hprice2 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/hprice2.dta")

res<- lm(log(price)~log(nox)+log(dist)+rooms+I(rooms^2)+stratio, data=hprice2)

# Predictions: Values of the regressors:
# rooms = 4-8, all others at the sample mean:
X <- data.frame(rooms=seq(4,8), nox=5.5498, dist=3.7958, stratio=18.4593)

# Calculate predictions and confidence interval:
pred <- predict(res, X, interval = "confidence")

# Table of regressor values, predictions and CI:
cbind(X, pred)

# Plot:
matplot(X$rooms, pred, type="l", lty=c(1,2,2))



#### Script 6.9 "Effects-Automatic" ####
# Repeating the regression from Example 6.2 (Script 6.4!!!)
library(foreign)
hprice2 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/hprice2.dta")

res<- lm(log(price)~log(nox)+log(dist)+rooms+I(rooms^2)+stratio, data=hprice2)

# Automatic effects plot using the package "effects"
library(effects)
plot(effect("rooms", res))