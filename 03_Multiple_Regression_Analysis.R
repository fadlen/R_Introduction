##### Chapter 03: Mutiple Regression Analysis: Estimation
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