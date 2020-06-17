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
diag(3)

# Indexing for extracting elements (still using A from above):
A
A[2,1]
A[,2]
A[,c(1,3)]

#### Script 1.10 "Matrix-Operators" ####
