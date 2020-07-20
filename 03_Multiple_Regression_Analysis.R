##### Chapter 03: Multiple Regression Analysis: Estimation
# Nachbau der im "Heiss 2016: Using R for introductory econometrics" abgebildeten Skripte und Codes. #

#### Script 3.1 "Example-3-1" ####
library(foreign)
gpa1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/gpa1.dta")

# Just obtain parameter estimates:
lm(colGPA ~ hsGPA+ACT, data = gpa1)

# Store results under "GPAres" and display full table:
GPAres <- lm(colGPA ~ hsGPA+ACT, data = gpa1)
summary(GPAres)



#### Script 3.2 "Example-3-2" ####
library(foreign)
wage1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/wage1.dta")

# OLS regression:
summary( lm(log(wage) ~ educ+exper+tenure, data=wage1) )



#### Script 3.3 "Example-3-3" ####
library(foreign)
d401k <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/401k.dta")

# OLS regression:
summary(lm(prate ~ mrate+age, data=d401k))



#### Script 3.4 "Example-3-4" ####
library(foreign)
crime1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/crime1.dta")

# Model without avgsen:
summary( lm(narr86 ~ pcnv+ptime86+qemp86, data=crime1) )

# Model with avgsen:
summary( lm(narr86 ~ pcnv+avgsen+ptime86+qemp86, data=crime1) )



#### Script 3.5 "Example-3-5" ####
library(foreign)
wage1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/wage1.dta")

# OLS regression:
summary( lm(log(wage) ~ educ, data=wage1) )



#### Script 3.6 "OLS-Matrices" ####
library(foreign)
gpa1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/gpa1.dta")

# Determine sample size & no. of regressors:
n <- nrow(gpa1) 
k <- 2

# extract y:
y <- gpa1$colGPA

# extract X & add a column of ones:
X <- cbind(1, gpa1$hsGPA, gpa1$ACT)

# display firt rows of X:
head(X)

# Parameter estimates:
(bhat <- solve( t(X)%*%X ) %*% t(X)%*%y )

# Residuals, estimated variance of u and SER:
uhat <- y - X %*% bhat

sigsqhat <- as.numeric(t (uhat) %*% uhat / (n-k-1))

(SER <- sqrt(sigsqhat))

# Estimated variance of the parameter estimators and SE:
Vbetahat <- sigsqhat * solve( t(X)%*%X)

(se <- sqrt( diag(Vbetahat) ) )



#### Script 3.7 "Omitted-Vars" ####
library(foreign)
gpa1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/gpa1.dta")

# Parameter estimates for full and simple model:
beta.hat <- coef( lm(colGPA ~ ACT+hsGPA, data=gpa1))
beta.hat

# Relation between regressors:
delta.tilde <- coef(lm(hsGPA ~ ACT, data=gpa1))
delta.tilde

# Omitted variables formula for beta1.tilde:
beta.hat["ACT"] + beta.hat["hsGPA"]*delta.tilde["ACT"]

# Actual regression with hsGPA omitted:
lm(colGPA ~ ACT, data = gpa1)



#### Script 3.8 "MLR-SE" ####
library(foreign)
gpa1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/gpa1.dta")

# FUll estimation results including automatic SE:
res <- lm(colGPA ~ hsGPA+ACT, data=gpa1)
summary(res)

# Extract SER (instead of calculation via residuals)
(SER <- summary(res)$sigma )

# regressing hsGPA on ACT for calculation of R2 & VIF:
( R2.hsGPA <- summary(lm(hsGPA~ACT, data = gpa1))$r.squared)
(VIF.hsGPA <- 1/(1-R2.hsGPA))

# manual calculation of SE of hsGPA coefficient:
n <- nobs(res)
(SE.hsGPA <- 1/sqrt(n-1) * SER/sd(gpa1$hsGPA) * sqrt(VIF.hsGPA))



#### Script 3.9 "MLR-VIF" ####
library(foreign)
wage1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/wage1.dta")

# OLS regression:
lmres <- lm(log(wage) ~ educ+exper+tenure, data=wage1)

# Regression output:
summary(lmres)

# Load package "car" (has to be installed):
# "pbkrtest" wird für die Installation von "car" benötigt
# Update your R before install the packages!
library(car)

# Automatically calculate VIF:
vif(lmres)
