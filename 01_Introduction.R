##### Chapter 01: Introduction 
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
