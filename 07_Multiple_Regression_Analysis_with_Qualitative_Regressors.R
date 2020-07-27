##### Chapter 07: Multiple Regression Analysis with Qualitative Regressors
# Nachbau der im "Heiss 2016: Using R for introductory econometrics" abgebildeten Skripte und Codes. #

#### Script 7.1 "Example-7-1" ####
library(foreign)
wage1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/wage1.dta")

lm(wage ~ female+educ+exper+tenure, data=wage1)




#### Script 7.2 "Example-7-6" ####
library(foreign)
wage1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/wage1.dta")

lm(log(wage) ~ married*female+educ+exper+I(exper^2)+tenure+I(tenure^2), data=wage1)




#### Script 7.3 "Example-7-1-logical" ####
library(foreign)
wage1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/wage1.dta")

# replace "female" with logical variable:
wage1$female <- as.logical(wage1$female)

table(wage1$female)

# regression with logical variable:
lm(wage ~ female+educ+exper+tenure, data=wage1)




#### Script 7.4 "Regr-Factors" ####
# install.packages("AER")
data(CPS1985, package = "AER")

# Table of categories and frequencies for two factors variables:
table(CPS1985$gender)

# Directly using factor variables in regression formula:
lm(log(wage) ~ education+experience+gender+occupation, data = CPS1985)

# Manually redefine the reference category:
CPS1985$gender <- relevel(CPS1985$gender,"female")
CPS1985$occupation <- relevel(CPS1985$occupation, "management")

# Rerun regression:
lm(log(wage) ~ education+experience+gender+occupation, data = CPS1985)



#### Script 7.5 "Example-7-8" ####
library(foreign)
lawsch85 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/lawsch85.dta")

# Define cut points for the rank:
cutpts <- c(0,10,25,40,60,100,175)

# Create factor variable containing ranges for the rank:
lawsch85$rankcat <- cut(lawsch85$rank, cutpts)

# Display frequencies:
table(lawsch85$rankcat)

# Choose reference category:
lawsch85$rankcat <- relevel(lawsch85$rankcat, "(100,175]" )

# Run regression:
lm(log(salary) ~ rankcat+LSAT+GPA+log(libvol)+log(cost), data=lawsch85)




#### Script 7.6 "Dummy-Interact" ####
library(foreign)
gpa3 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/gpa3.dta")

# Model with full interactions with female dummy (only for spring data)
reg <- lm(cumgpa ~ female*(sat+hsperc+tothrs), data=gpa3, subset=(spring==1))
summary(reg)

# F-Test from package "car". H0: the interaction coefficients are zero:
# matchCoefs(...) selects all coeffs with names containing "female"
library(car)
linearHypothesis(reg, matchCoefs(reg, "female"))



#### Script 7.7 "Dummy-Interact-Sep" ####
library(foreign)
gpa3 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/gpa3.dta")

# Estimate model for males (& spring data)
lm(cumgpa~ sat+hsperc+tothrs, data = gpa3, subset=(spring==1&female==0))

# Estimate model for females (& spring data)
lm(cumgpa~ sat+hsperc+tothrs, data = gpa3, subset=(spring==1&female==1))