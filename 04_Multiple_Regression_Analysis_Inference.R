##### Chapter 04: Multiple Regression Analysis: Inference
# Nachbau der im "Heiss 2016: Using R for introductory econometrics" abgebildeten Skripte und Codes. #

#### Script 4.1 "Example-4-3" ####
library(foreign)
gpa1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/gpa1.dta")

# Store results under "sumres" and display full table:
(sumres <- summary( lm(colGPA ~ hsGPA+ACT+skipped, data= gpa1)))

# Manually confirm the formulas: Extract coefficients and SE
regtable <- sumres$coefficients
bhat <- regtable[,1]
se <- regtable[,2]

# Reproduce t statistics
(tstat <- bhat / se )

# Reproduce p value:
(pval <- 2* pt(-abs(tstat), 137))



#### Script 4.2 "Example-4-1" ####
library(foreign)
wage1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/wage1.dta")

# OLS regression:
summary( lm(log(wage) ~ educ+exper+tenure, data=wage1) )



#### Script 4.3 "Example-4-8" ####
library(foreign)
rdchem <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/rdchem.dta")

# OLS regression:
myres <- lm(log(rd) ~ log(sales)+profmarg, data=rdchem)

# Regression output:
summary(myres)

# 95% CI:
confint(myres)

# 99% CI:
confint(myres, level = 0.99)



#### Script 4.4 "F-Test-MLB" ####
library(foreign)
m1b1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/mlb1.dta")

# Unrestricted OLS regression:
res.ur <- lm(log(salary) ~ years+gamesyr+bavg+hrunsyr+rbisyr, data = m1b1)

# Restricted OLS regression:
res.r <- lm(log(salary) ~ years+gamesyr, data = m1b1)

# R2:
(r2.ur <- summary(res.ur)$r.squared)
(r2.r <- summary(res.r)$r.squared)

# F statistic:
(F <- (r2.ur-r2.r) / (1-r2.ur) * 347/3)

# p-value = 1-cdf of the appropriate F distribution:
1-pf(F, 3,347)



#### Script 4.5 "F-Test-MLB-auto" ####
library(foreign)
m1b1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/mlb1.dta")

# Unrestricted OLS regression:
res.ur <- lm(log(salary) ~ years+gamesyr+bavg+hrunsyr+rbisyr, data = m1b1)

# Load package "car" (!!see comments in 3.9!!)
library(car)

# F-Test
myH0 <- c("bavg", "hrunsyr", "rbisyr")
linearHypothesis(res.ur,myH0)



#### Script 4.6 "F-Test-MLB-auto2" ####
library(foreign)
m1b1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/mlb1.dta")

# Unrestricted OLS regression:
res.ur <- lm(log(salary) ~ years+gamesyr+bavg+hrunsyr+rbisyr, data = m1b1)

# Load package "car" (!!see comments in 3.9!!)
library(car)

# F-Test
myH0 <- c("bavg", "hrunsyr=2*rbisyr")
linearHypothesis(res.ur,myH0)



#### Script 4.7 "F-Test-MLB-auto3" ####
library(foreign)
m1b1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/mlb1.dta")

# Unrestricted OLS regression:
res.ur <- lm(log(salary) ~ years+gamesyr+bavg+hrunsyr+rbisyr, data = m1b1)

# Load package "car" (!!see comments in 3.9!!)
library(car)

myH0 <- matchCoefs(res.ur,"yr")
myH0

# F-Test
linearHypothesis(res.ur,myH0)


#### Script 4.8 "Example-4-10" ####
library(foreign)
meap93 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/meap93.dta")

# define new variable within data frame:
meap93$b_s <- meap93$benefits / meap93$salary

# Estimate three different models
model1 <- lm(log(salary) ~ b_s, data = meap93)
model2 <- lm(log(salary) ~ b_s+log(enroll)+log(staff), data= meap93)
model3 <- lm(log(salary) ~ b_s+log(enroll)+log(staff)+droprate+gradrate, data= meap93)

# Load package and display table of results:
# if it doesn't work, be sure that you have installed the package "stargazer"!
# install.packages("stargazer")

library(stargazer)
stargazer(list(model1,model2,model3), type="text", keep.stat=c("n", "rsq"))

