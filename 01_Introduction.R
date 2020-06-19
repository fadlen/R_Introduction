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

