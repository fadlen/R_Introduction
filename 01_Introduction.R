##### Chapter 01: Introduction 
# Nachbau der im "Heiss 2016: Using R for introductory econometrics" abgebildeten Skripte und Codes. #

#### Script 1.1 ####
1+1
5*(4-1)^2
sqrt(log(10))


#### Script 1.3 "Objects" ####

# generate object x
x <- 5

# display and calculate with x
x
x^2

# generate objects

y <- 3
y

z <- y^x
z

# display all defined variables
ls()
exists("x")

# remove
rm(x) # nur x
rm(list = ls()) #alle


#### Script 1.4 "Vectors" ####
# Define a with immediate output through parentheses:
c(1,2,3,4,5,6)

(a <- c(1,2,3,4,5,6))

(b <- a+1)

(c <- a+b)

(d <- b*c)

sqrt(d)

#### Script 1.5 "Vector-Functions" ####

# Define vector
(a <- c(7,2,6,9,4,1,3))

#Basic functions:
sort(a)

length(a)

min(a)

max(a)

sum(a)

prod(a)

#Creating special vectors:
numeric(20)

rep(1,20)

seq(50)

5:15

seq(4,20,2)

# Special types of vectors

cities <- c("New York", "Osnabrueck", "Duesseldorf")
cities
cities

#### Script 1.6 "Logical" ####

# Basic comparisons:
0 == 1
0 < 1

# Logical vectors:
(a <- c(7,2,6,9,4,1,3))

(b <- a<3 | a >=6 )

#### Script 1.7 "Factors" ####

# Orignial ratings:
x <- c(3,2,2,3,1,2,3,2,1,2)
xf <- factor(x, labels=c("bad", "okay", "good")) #the option ordered=TRUE is active

x
xf


#### Script 1.8 "Vector-Indices" ####

# Create a vector "avgs":
avgs <- c(.366, .358, .356, .349, .346)

# Create a string vector of names:
players <- c("Cobb", "Hornsby", "Jackson", "Buchner", "Blacksmith")

# Assign names to vector and display vector:
names(avgs) <- players
avgs

# Indices by number
avgs[4]
avgs[3:5]

# Indices by names
avgs["Buchner"]

# Logical indices:
avgs[ avgs>=0.35]

#### Script 1.9 "Matrices" ####

# Generating matrix A from one vector with all values:
v <- c(2, -4, -1, 5, 7, 0)
(A <- matrix(v, nrow = 2))
A

# Generating matrix A from two vectors corresponding to rows:
row1 <- c(2,-1,7); row2 <- c(-4,5,0)
(A <- rbind(row1, row2))
A

# Generating matrix A from three vectors corresponding to columns:
col1 <- c(2, -4); col2 <- c(-1,5); col3 <- c(7,0)
(A <- cbind(col1, col2, col3))
A

# Giving names to rows and columns:
rownames(A) <- c("Alph", "Bet")
colnames(A) <- c("Alpha", "Betha","Gamma")
A

# Diagonal and identity matrices:
diag( c(4,2,6))
diag(3)  # identity matrix

# Indexing for extracting elements (still using A from above):
A
A[2,1]
A[,2]
A[,c(1,3)]

#### Script 1.10 "Matrix-Operators" ####
A <- matrix(c(2, -4,-1,5,7,0), nrow=2)
B <- matrix(c(2,1,0,3,-1,5), nrow=2)

A
B
A+B

# Transpose:
(C <- t(B))

# Matrix multiplication:
(D <- A %*% C)  

# Inverse:
solve(D)

#### Script 1.11 "Lists" ####

# Generate a list object:
mylist <- list( A=seq(8,36,4), this="that", idm = diag(3))

# Print whole list:
mylist

# Vector of names:
names(mylist)

#Print component "A":
mylist$A

#### Script 1.12 "Data-Frames" ####
# Define one x vector for all:
year <- c(2008,2009,2010,2011,2012,2013)

# Define a matrix of y values:
product1 <- c(0,3,6,9,7,8); product2 <- c(1,2,3,5,9,6); product3 <- c(2,4,4,2,3,2)

sales_mat <- cbind(product1,product2,product3)
sales_mat

rownames(sales_mat) <- year

# The matrix looks like this:
sales_mat

# Create a data frame and display it:
sales <- as.data.frame(sales_mat)
sales

# The Difference between sales_mat and sales is the reports of contents.  #
# In the Global Environment (right, top corner) are sales_mat still a 6x3 #
# double matrix, whereas the content of sales is 6 obs. of 3 variables!   #

#### Script 1.13 "Data-Frame-Vars" ####

# Accessing a single variable:
sales$product1

# Generating a new variable in the dataframe:
sales$totalv1 <- sales$product1 + sales$product2 + sales$product3

# The same but using with:
sales$totalv2 <- with(sales, product1+product2+product3)

# The same using "attach":
attach(sales)
sales$totalv3 <- product1+product2+product3
detach(sales)

# Result:
sales

#### Script 1.14 "Data-Frames-Subsets" ####

# Full data frame:
sales

# Subset: all years in which sales of product 3 were >= 3:
subset(sales, product3>=3)

#### Script 1.15 "RData-Example" ####

# Note: "sales" is defined in Data-Frames, so it has to be run first!
# save data frame as RData file (in the current working directory):
save(sales, file = "oursalesdata.RData")

# remove data frame "sales" from memory:
rm(sales)

# Does variable "sales" exist?:
exists("sales")

# Load data set (in the current working directory):
load("oursalesdata.RData")

# Does variable "sales" exist?:
exists("sales")
sales

# averages of the variables:
colMeans(sales)

#### Script 1.16 "Example-Data" ####

# load package for dealing with Stata files:
library(foreign)

# download data and create data frame "affairs":
affairs <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/affairs.dta")

# first six rows:
head(affairs)

# averages:
colMeans((affairs))

#### Script 1.17 "Plot-Overlays" ####

x<- c(1,3,4,7,8,9)
y<- c(0,3,6,9,7,8)
#plot(x,y)
plot(x,y,type="o")

plot(x,y, main = "Example for an Outliner")
points(8,1)
abline(a=0.31, b=0.97, lty=2, lwd=2)
text(7,2, "outlier", pos=3)
arrows(7,2,8,1, length = 0,15)

#### Script 1.18 "Plot-Matplot" ####

# Define one x vector for all:
year <- c(2008,2009,2010,2011,2012,2013)

# Define a matrix of y values:
product1 <- c(0,3,6,9,7,8)
product2 <- c(1,2,3,5,9,6)
product3 <- c(2,4,4,2,3,2)

sales <- cbind(product1,product2,product3)
sales

# plot
matplot(year, sales, type="b", lwd=c(1,2,3), col = "black")

#### Script 1.19 "Plot-Legend" ####

curve( dnorm(x,0,1), -10, 10, lwd=1, lty=1)
curve( dnorm(x,0,2), add = TRUE, lwd=2, lty=2)
curve( dnorm(x,0,3), add = TRUE, lwd=3, lty=3)
# Add the legend:
legend("topright", c("sigma=1", "sigma=2", "sigma=3"), lwd = 1:3, lty = 1:3)

#### Script 1.20 "Plot-Legend2" ####

curve( dnorm(x,0,1), -10, 10, lwd=1, lty=1)
curve( dnorm(x,0,2), add = TRUE, lwd=2, lty=2)
curve( dnorm(x,0,3), add = TRUE, lwd=3, lty=3)
# Add the legend with GREEk sigma:
legend("topright", expression(sigma==1, sigma==2, sigma==3), lwd = 1:3, lty = 1:3)
# Add the text with the formula, centered at x=6 and y=0.3:
text(6,.3, expression(f(x)==frac(1,sqrt(2*pi)*sigma)*e^(-frac(x^2,2*sigma^2))))


#### Script 1.22 "Descr-Tables" ####

# load data set
library(foreign)
affairs <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/affairs.dta")

# Generate "Factors" to attach labels
haskids <- factor(affairs$kids, labels = c("no", "yes"))
mlab <- c("very unhappy", "unhappy", "average", "happy", "very happy")
marriage <- factor(affairs$ratemarr, labels=mlab)

# Frequencies for having kids
table(haskids)

# Marriage ratings(share):
prop.table(table(marriage))


# Contigency table: counts(display & store in var.)
(countsstab <- table(marriage,haskids))

# Share within "marriage" (i.e. within a row):
prop.table(countsstab, margin = 1)

# Share within "haskids" (i.e. within a column):
prop.table(countsstab, margin = 2)

# Graphics
pie(table(marriage), col = gray(seq(.2,1,.2)))
barplot(table(haskids,marriage), horiz = TRUE, las=1, legend=TRUE, args.legend = c(x="bottomright"), main = "Happiness by Kids")

#### Script 1.23 "Histogram" ####

# Load data:
library(foreign)
ceosal1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/ceosal1.dta")

# Extract ROE to single vector:
ROE <- ceosal1$roe

# Subfigure (a): histogram(counts):
hist(ROE)

# Subfigure (b): histogram (densities, explicit breaks):
hist(ROE, breaks = c(0,5,10,20,30,60))

#### Script 1.24 "KDensity" ####

# Subfigure: kernel density estimate:
plot(density(ROE))

# Subfigure: overlay:
hist(ROE, freq = FALSE, ylim = c(0, .07))
lines(density(ROE), lwd=3)

#### Script 1.25 "Desc-Stats ####

library(foreign)
ceosal1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/ceosal1.dta")

# sample average:
mean(ceosal1$salary)

# sample median:
median(ceosal1$salary)

# standard deviation:
sd(ceosal1$salary)

# summary informations:
summary(ceosal1$salary)

# correlation with ROE:
cor(ceosal1$salary,ceosal1$roe)


#### Script 1.26 "PMF-Example" ####

# Pedestrian approach: 
choose(10,2) * 0.2^2 * 0.8^8

# Built-in function
dbinom(2,10,0.2)

# Values for x: all between 0 and 10:
x <- seq(0,10)

# pmf for all these values:
fx <- dbinom(x,10,0.2)

# Table(matrix) of values:
cbind(x, fx)

# Plot
plot(x, fx, type="h")

## Cumulative Distribution (CDF)

pbinom(3,10, 0.2)

pnorm(1.96) - pnorm(-1.96)

# Using the transformation:
pnorm(2/3) - pnorm(-2/3)

# Working directly with the distribution of X:
pnorm(6,4,3) - pnorm(2,4,3)

1 - pnorm(2,4,3) + pnorm(-2,4,3)

x <- seq(-1,10)
Fx <- pbinom(x, 10, 0.2)
plot(x, Fx, type ="s")
curve(pnorm(x), -4,4)

qnorm(0.975)
rbinom(10,1,0.5)
rnorm(10)

#### Script 1.27 "Random-Numbers" ####

# Sample from a standard normal RV with sample size n=5:
rnorm(5)

# A different sample from the same distribution:
rnorm(5)

# Set the seed of the random number generator and take two samples:
set.seed(6254137)

rnorm(5)
rnorm(5)

# Reset the seed to same value to get the same samples again
set.seed(6254137)

rnorm(5)
rnorm(5)

#### Script 1.28 "Example-C-2" ####

# Manually enter raw data from Wooldridge, Table C.3:
SR87 <- c(10,1,6,.45,1.25,1.3,1.06,3,8.18,1.67,.98,1,.45,5.03,8,9,18,.28,7,3.97)

SR88 <- c(3,1,5,.5,1.54,1.5,.8,2,.67,1.17,.51,.5,.61,6.7,4,7,19,.2,5,3.83)

# Calculate Change (the parentheses just display the results):
(Change <- SR88 - SR87)

# Ingredients to CI formula
(avgCh <- mean (Change))
(n <- length(Change))
(sdCh <- sd(Change))
(se <- sdCh/sqrt(n))
(c <- qt(.975, n-1))

# Confidence intervall:
c(avgCh - c*se, avgCh + c*se)


#### Script 1.29 "Example-C-3" ####

library(foreign)

audit <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/audit.dta")

# Ingredients to CI formula
(avgy <- mean(audit$y))
(n <- length(audit$y))
(sdy <- sd(audit$y))
(se <- sdy/sqrt(n))
(c <- qnorm(.975))

# 95% Confidence interval:
avgy + c * c(-se, +se)

# 99% Confidence interval:
avgy + qnorm(0.995) * c(-se,+se)

#### Script 1.30  "Critical-Values-t" ####

# degrees of freedom = n-1:
df <- 19

# significance levels:
alpha.one.tailed = c (0.1,0.05,0.025,0.01, 0.005, .001)
alpha.two.tailed = alpha.one.tailed * 2

# critical values & table:
CV <- qt(1- alpha.one.tailed, df)

cbind(alpha.one.tailed, alpha.two.tailed, CV)

#### Script 1.31 "Example-C-5" ####
# Note: we reuse variables from Example-C-3.R (Script 1.29). Is has to be run first!
# t statistics for H0: mu=0:
(t <- avgy/se)

# Critical values for t distribution with n-1=240 d.f.:
alpha.one.tailed = c (0.1,0.05,0.025,0.01, 0.005, .001)
CV <- qt(1- alpha.one.tailed, n-1)

cbind(alpha.one.tailed, CV)

#### Script 1.32 "Example-C-6" ####
# Note: Run Script 1.29 First!!! (Example-C-2!)
# t statistics for H0: mu=0:
(t <- avgCh/se)

# p value
(p <- pt(t,n-1))


#### Script 1.33 "Example-C-7" ####
# t statistics for H0: mu=0:
(t <- -4.276816)

# p value
(p <- pt(t,n-1))

#### Script 1.34 "Example-C2-C6" ####
# data for the scrap rates examples:
SR87 <- c(10,1,6,.45,1.25,1.3,1.06,3,8.18,1.67,.98,1,.45,5.03,8,9,18,.28,7,3.97)

SR88 <- c(3,1,5,.5,1.54,1.5,.8,2,.67,1.17,.51,.5,.61,6.7,4,7,19,.2,5,3.83)
Change <- SR88 - SR87

# Example C.2: two-sided CI:
t.test(Change)

# Example C.6: one-sided test:
t.test(Change, alternative = "less")

#### Script 1.35 "Examples-C3-C5-C7" ####
library(foreign)

audit <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/audit.dta")

# Example C.3: two-sided CI
t.test(audit$y)

# Example C.5 & C.7: one-sided test:
t.test(audit$y, alternative = "less")

#### Script 1.36 "Test-Results-List" ####
library(foreign)

audit <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/audit.dta")
# store test results as a list "testres":
testres <- t.test(audit$y)

#print results:
testres

# component names: which results can be accessed?
names(testres)

# p-value
testres$p.value

#### Script 1.37 "Simulate-Estimate" ####
# Set the random seed
set.seed(123456)

# Draw a sample given the population parameters
sample <- rnorm(100,10,2)

# Estimate the population mean with the sample average:
mean(sample)

# Draw a different sample and estimate again:
sample <- rnorm(100,10,2)
mean(sample)

# Draw a third sample and estimate again:
sample <- rnorm(100,10,2)
mean(sample)

#### Script 1.38 "Simulation-Repeated" ####
# Set the random seed:
set.seed(123456)

# initialize ybar to a vector of length r=10000 to later store results:
ybar <- numeric(10000)

# repeat 10000 times:
for(i in 1:10000) {
  # Draw a sample and store the sample mean in pos. i = 1,2, of ybar:
  sample <- rnorm(100,10,2)
  ybar[i] <- mean(sample)
}

#### Script 1.39 "Simulation-Repeated-Results" ####
# The first 20 of 10000 estimates:
ybar[1:20]

# Simulated mean:
mean(ybar)

# Simulated variance:
var(ybar)

# Simulated density:
plot(density(ybar))
curve( dnorm(x,10,sqrt(.04)), add=TRUE,lty=2)


#### Script 1.40 "Simulation-Inference" ####
# Set the random seed:
set.seed(123456)

# initialize vectors to later store results:
CIlower <- numeric(10000); CIupper <- numeric(10000)
pvalue1 <- numeric(10000); pvalue2 <- numeric(10000)

# repeat 10000 times:
for(i in 1:10000) {
  # Draw a sample
  sample <- rnorm(100,10,2)
  # test the (correct) null hypothesis mu=10:
  testres1 <- t.test(sample, mu=10)
  # store CI & p value
  CIlower[i] <- testres1$conf.int[1]
  CIupper[i] <- testres1$conf.int[2]
  pvalue1[i] <- testres1$p.value
  # test the (incorrect) null hypothesis mu=9.5 & store the p value:
  pvalue2[i] <- t.test(sample, mu=9.5)$p.value
}

# Test results as logical value
reject1 <- pvalue1<=0.05; reject2<-pvalue2<=0.05
table(reject1)
table(reject2)
