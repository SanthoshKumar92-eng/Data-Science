setwd("D:/Data Science/R")
getwd()

#
# getwd()
# Data Types - Numeric, Integer, Complex, Logical, Character
# Integer Data
s = 5
s
# Numeric Data
d = 19.7
d
z = 21.3
y = as.integer(z)
y
# as.integer function
a = as.integer(d)
a
#squarerroot(-1) = i iota
# Complex Data Type
f = 5 + 7i
f
# here i represents iota and iota = sqrt(-1)
sqrt(-1)
# Logical Data Type
x = 5
x
y = 11
y
x > y
y > x
s = "t"
s
a = 'v'
a
# Character Data Type
q = "Queen of England - Her Majesty Elizabeth!!"
q
# Help in R
help()
help()
help.start()
# Data Structure : In R, Data can be organized in - Vectors, Matrix, List,
# Data Frames and Factors
# Vectors in R
# Vector is of two types : Atomic Vector and Lists.
# Atomic Vectors can have Data of - Numeric (Integer, Double), Character and Logical Types
typeof(q)
typeof(d)
typeof(f)
# Create a Vecotr
# <-, =
# c() <- Combine function
e <- c(13,17,19,23,29.7,31.2)
e
f <- c(13,17,19,23,29,31)
f
x <- c("Delhi","Mumbai","Kolkata","Chennai")
x
a <-c(TRUE,FALSE,TRUE,TRUE)
a
#Arithmetic operator "+"
v <- c( 2,5.5,6)
t <- c(8, 3, 4)
v+t
#Arithmetic operator "-" Subtracts second vector from the first
v <- c( 2,9.7,23,27)
t <- c(8, 3, 4,37)
print(v-t)
a = v-t
v<- c(2,5.5,6)
t<- c(8,3,4)
print(a)
t-v
# Code of Thirupathi
v<- c(2,5.5,6)
t<- c(8,3,4)
q<- c(2,5.5,6)
p<- c(8,3,4)
print(q-p)
q<- c(2,5.5,6) ; p<- c(8,3,4) ; print(q-p)
#Arithmetic operator "*" Multiplies both vectors
v <- c( 2,5.5,6,9,10,90)
t <- c(8, 3, 4,7.6,56,100)
print(v*t)
v*t
t*v
#Arithmetic operator "/" Divide the first vector with the second
f <- c( 2,5.5,6,40,80)
g <- c(8, 3, 4,30,90)
print(f/g)
g/v
#Arithmetic operator "%%" Give the remainder of the first vector with the second
v <- c( 2,5.5,6)
t <- c(8, 3, 4)
print(v%%t)
#Arithmetic operator "%/%" The result of division of first vector with second (quotient)
#quotient only
v <- c( 2,5.5,6)
t <- c(8, 3, 4)
print(v%/%t)
#Arithmetic operator "^" The first vector raised to the exponent of second vector
v <- c( 2,5.5,6,5,7,9)
t <- c(8, 3, 4,2,3,4)
print(v^t)
# Relational operator ">" , Checks if each element of the first vector is
#greater than the corresponding element of the second vector
v <- c(2,5.5,6,9,17,90)
t <- c(8,2.5,14,9,100,10)
print(v>t)
t>v
# Relational operator "<", Checks if each element of the first vector is less
#than the corresponding element of the second vector.
v <- c(2,5.5,6,9)
t <- c(8,2.5,14,9)
print(v < t)
t<v
# Relational operator "==", Checks if each element of the first vector is
#equal to the corresponding element of the second vector.
v <- c(2,5.5,6,9)
t <- c(8,2.5,14,9)
print(v == t)
# = "Assignment Operator"
s = c(6)
s
a = c(8)
# == "Comparision Operator"
# / and %/% are same
# Relational operator "<=", Checks if each element of the first vector is less than or equal
#to the corresponding element of the second vector.
v <- c(2,5.5,6,9)
t <- c(8,2.5,14,9)
print(v<=t)
# Relational operator ">=", Checks if each element of the first vector is
#greater than or equal to the corresponding element of the second vector.
v <- c(2,5.5,6,9)
t <- c(8,2.5,14,9)
print(v>=t)
# Relational operator "!=", checks if each element of the first vector is unequal
#to the corresponding element of the second vector.
v <- c(2,5.5,6,9)
t <- c(8,2.5,14,9)
print(v!=t)
# input ( 1, 0) -> Gate - OR Gate / AND Gate / Not Gate
# Or Gate
# x y  O/p
# 0 0   0
# 0 1   1
# 1 0   1
# 1 1   1
#
# AND Gate
# x y  O/p
# 0 0   0
# 0 1   0
# 1 0   0
# 1 1   1
# x  o/p
# 0   1
# 1   0
# Logical operator "&", It is called Element-wise Logical "AND" operator.
#It combines each element of the first vector with the corresponding element
#of the second vector and gives a output TRUE if both the elements are TRUE.
z = 1:6
z
(z > 2) & (z < 5)
z[5]
z[(z>2) & (z<5)]
z = 3:10
z
(z > 5) & (z < 8)
z[5]
z[(z > 5) & (z < 8)]
#The longer form evaluates left to right examining only the first element of
# each vector,so the result will
#give only one element
z = 1:6
z
(z > 2) && (z < 5)
z[(z>2) && (z<5)]
z = 3:10
z
(z > 2) && (z < 5)
z[(z>2) && (z<5)]
# Logical operator "|", It is called Element-wise Logical "OR" operator.
#It combines each element of the first vector with the corresponding element
#of the second vector and gives a output TRUE if both the elements are TRUE.
z = 1:6
z
(z > 2) | (z < 5)
z[(z>2) | (z<5)]
#The longer form evaluates left to right examining only the first element of each vector,so the result will
#give only one element
z = 1:6
(z > 2) || (z < 5)
#Assignment Operators. These operators are used to assign values to vectors.
#"<???", "=", "<<???" are called Left Assignment
v1 <- c(3,1)
print(v1)
v1 = c(3,1)
print(v1)
# v1 <<- c(3,1)
# print(v1)
#
# #"???>", "???>>" are called Right Assignment
# c(3,1) ???> v1
# print(v1)
#
# c(3,1) ???>> v1
# print(v1)
#operator "%in%" is used to identify if an element belongs to a vector
v1 <- 8
v2 <- 12
v3 <- 20
t <- 1:10
print(v1 %in% t)
print(v2 %in% t)
print(v3 %in% t)
#R if...else Statement
#In this article, you will learn to create if, if else and nested if else statement in R programming.
#Decision making is an important part of programming.
#This can be achieved in R programming using the conditional if...else statement.
x <- 5
if(x > 0){
  print("Positive number")
}
#if...else statement
x <- -5
if(x > 0){
  print("Non-negative number")
} else {
  print("Negative number")
}
#The above conditional can also be written in a single line as follows.
if(x > 0) print("Non-negative number") else print("Negative number")
#Nested if...else statement
#We can nest as many if...else statement as we want as follows.
#Only one statement will get executed depending upon the test_expressions.
x <- -7
if (x < 0) {
  print("Negative number")
} else if (x > 0) {
  print("Positive number")
} else {
  print("Zero")
}

x = 0
if (x%%2==0) {
  print("even number")
} else {
  print("odd number")
}

# switch statement
#syntax is :: switch (statement, list)
#Here, the statement is evaluated and based on this value, the
# corresponding item in the list is returned.
switch(2,"red","green","blue","orange")
switch(4,"red","green","blue","orange")
#If the numeric value is out of range (greater than the number of items in the
# list or smaller than 1),
#then, NULL is returned
x <- switch(4,"red","green","blue")
x
x <- switch(0,"red","green","blue")
x
#The result of the statement can be a string as well.
#In this case, the matching named item's value is returned.
switch("color", "color" = "red", "shape" = "square", "length" = 5)
switch("length", "color" = "red", "shape" = "square", "length" = 5)
#Loops in R
#Loops are used in programming to repeat a specific block of code.
#In this article, you will learn to create a for loop in R programming.
#"For" loop
#Below is an example to count the number of even numbers in a vector.
x <- c(2,5,3,9,8,11,6)
count <- 0
for (val in x) {
  if(val %% 2 == 0)  count = count+1
}
print(count)
#In the above example, the loop iterates 7 times as the vector x has 7 elements.
#In each iteration, val takes on the value of corresponding element of x.
#We have used a counter to count the number of even numbers in x. We can see that x contains 3 even numbers.
# "While" loop
#In R programming, while loops are used to loop until a specific condition is met.
i <- 1
i
while (i < 6) {
  print(i)
  i = i+1
}
#In the above example, i is initially initialized to 1.
#Here, the test_expression is i < 6 which evaluates to TRUE since 1 is less than 6.
#So, the body of the loop is entered and i is printed and incremented.
#Incrementing i is important as this will eventually meet the exit condition.
#Failing to do so will result into an infinite loop.
#In the next iteration, the value of i is 2 and the loop continues.
#This will continue until i takes the value 6. The condition 6 < 6 will give FALSE and the while loop
#finally exits.
#While loop
#A repeat loop is used to iterate over a block of code multiple number of times.
#There is no condition check in repeat loop to exit the loop.
#We must ourselves put a condition explicitly inside the body of the loop
#and use the break statement to exit the loop. Failing to do so will result into an infinite loop.
x <- 1
repeat {
  print(x)
  x = x+1
  if (x == 6){
    break
  }
}
###########################################################################
# Accessing vector elements
# [] - Referencing
# {} - IF or Loop Statements
# () - Function or combining elements, condition
vec <- c("a","b","c","d","e","f")
vec[1]
vec[c(2,4)]
# Duplicate Referencing
vec[c(2,2)]
# Reale nos. silently truncated to integers
vec[c(2.1,5.1)]
vec[-c(2.1,5.1)]
v <- c("a","b","c")
v[-c(1.2,2.6)]
# Using Zero
vec[0]
# Using Blank
vec[]
# Using Negative Number
# Skip 4th Element
vec[-4]
# Skip 2nd and 4 th element
vec[-c(2,4)]
# Use of Logical Operators
vec[c(TRUE, TRUE, FALSE, FALSE)] ; #a, b,c,d,e,f
# OR
vec[c(T,T,F,F)]
# Using Condition
z <- 0:10
z[z<4]
z[z>=6]
z[z!=5]
z[z<0]
#---------------------------------------------
# matrix
v <- c(1,2,3,4)
foo <- matrix(v, nrow = 2, ncol = 2)
foo
foo <- matrix(v, ncol = 2, nrow = 2)
foo
foo <- matrix(v, nrow = 2, ncol = 2, byrow = TRUE)
foo
foo <- matrix(v, nrow = 2, ncol = 2, byrow = FALSE)
foo
#accessing matrix elements
mat <- matrix (c(1:4),nrow = 2, ncol = 2)
mat
#access first row in the matrix
mat[1,]
#access second row in the matrix
mat[2,]
#access first column in the matrix
mat[,1]
#access second column in the matrix
mat[,2]
mat[1,2]
mat[]
v <- c(1:15)
m <- matrix(c(1:15), nrow = 5, ncol = 4)
m
m <- matrix(c(1:15), nrow = 5, ncol = 3)
m
m <- matrix(c(1:15), nrow = 5, ncol = 2)
m
#Arithmatic Operations on Matrices
m1 <- matrix(c(1:9), nrow = 3 )
m1
m2 <- matrix(c(12:20), nrow = 3)
m2
m1 + m2
m1 - m2
m1 * m2
m1 / m2
#---------------------------------------------------------------
## Arrays can have more than 2 dimensions
#Arrays are the R data objects which can store data in more than two dimensions
#For example ??? If we create an array of dimension (2, 3, 4)
#then it creates 4 rectangular matrices each with 2 rows and 3 columns
#The following example creates an array of two 3x3 matrices each with 3 rows and 3 columns.
# Create two vectors of different lengths.
vector1 <- c(5,9,3)
vector2 <- c(10,11,12,13,14,15)
# Take these vectors as input to the array.
result <- array(c(vector1,vector2),dim = c(3,3,2))
result
result <- array(c(vector1,vector2),dim = c(3,3,3))
result
result <- array(c(vector1,vector2),dim = c(2,3,5))
result
#accessing array elements
# Create two vectors of different lengths.
vector3 <- c(5,9,3)
vector4 <- c(10,11,12,13,14,15)
vresult <- array(c(vector3,vector4),dim = c(3,3,2))
vresult
# Print the third row of the second matrix of the array.
vresult[3,,2]
# Print the element in the 1st row and 3rd column of the 1st matrix.
vresult[1,3,1]
# Debug
result <- array(c(vector1,vector2),dim = c(3,3,2))
result
result <- array(c(vector1,vector2),dim = c(3,3,3))
result
result <- array(c(vector1,vector2),dim = c(2,3,5))
result
result[3,,2]
#---------------------------------------------------
#Create a dataframe
emp_id <- c (1:5)
emp_name <- c("Rick","Dan","Michelle","Ryan","Gary")
salary <- c(623.3,515.2,611.0,729.0,843.25)
emp.data <- data.frame(emp_id, emp_name, salary)
emp.data
# you can also view the newly created object in tabular format in Environment pane
# Elements of data frames
emp.data$emp_id
emp.data$emp_name
emp.data$salary
#---------------------------------------------------------------------
#Factors
#Factors are the data objects which are used to categorize the data
# and store it as levels.
#They can store both strings and integers. They are useful in the columns which have a
#limited number of unique values. Like "Male, "Female" and True, False etc.
#They are useful in data analysis for statistical modeling
gender <- c("Male" , "Female" , "Female" , "Male")
status <- c("Poor" , "Improved", "Excellent" , "Poor" , "Excellent")
gender
status
factor_gender <- factor(gender)
factor_gender
factor_status <- factor(status)
factor_status
fg <- as.factor(gender)
fg
# Create a vector as input.
data <- c("East","West","East","North","North","East","West","West","West","East","North")
data
is.factor(data) #checks variable for factor or not
# Apply the factor function.
factor_data <- factor(data) 
factor_data
factor_data <- as.factor(data) 
factor_data
#as.factor  or   factor  both same.
factor_data
is.factor(factor_data)
#-----------------------------------------------------------------
#creating a list
# Create a list containing strings, numbers, vectors and a logical values.
list_data <- list("Red", "Green", c(21,32,11), TRUE, 51.23, 119.1)
list_data
#--------------------------------------------------------
# Importing .txt file
setwd("D:/SL Instructor/Data Science with R")
restaurant<-read.table("Restaurant.txt", header = TRUE)
restaurant
#Importing an excel file
# install a package called gdata. This package is used to read excel files into R
install.packages("xlsx")
# Load the library into R workspace.
library("xlsx")
# Read the first worksheet in the file input.xlsx.
data <- read.xlsx("import.xlsx", sheetIndex = 1)
data
install.packages("readxl")
# Loading
library("readxl")
# xls files
my_data <- read_excel("LR _excel.xls")
my_data
# xlsx files
my_data2 <- read_excel("import.xlsx")
my_data2
#---------------------------------------------
# Exporting files
#-------------
#append function
#append() function adds elements to a vector
x <- c(1:5)
x
y <- append(x, 100)
y
y <- append(x, 100, after=2)
y

#--------------------------
#c() combines values into a vector
x <- c(1,2,3,4)
x
#-------------------------
# identical function is the safe and reliable way to test whether
# two objects are exactly equal.
identical(1,1)
identical(1,2)
#---------------------------
#length() function gets or sets the length of an R object
#Get vector length:
x <- c(1,2,5,4,6,1,22,1)
length(x)
#Set vector length:
length(x) <- 4
x
#---------------------------
# ls function lists objects in the working environment
ls()
#---------------------------
#range() function get a vector of the minimum and maximum values
x <- c(1,2.3,2,3,4,8,12,43,-4,-1)
r <- range(x)
r
#------------------------------
# rep() function replicates the values in x.
x <- rep(1:5)
x
#Repeat 1 -5 two times
x <- rep(1:5,2)
x
#------------------------------
#rev() function reverses an R object
x <- c("green","red","yellow")

x
y <- rev(x)
y
x <- c(1:10)
x
y <- rev(x)

y
#--------------------------------
#seq() function generates a sequence of numbers.
#Generate a sequence from -6 to 7:
x <- seq(-6,7)
x
#Generate a sequence from -6 to 7 with steps of 2
x <- seq(-6,7,by=2)
x
#---------------------------------
#unique() function removes duplicated elements/rows from a vector, data frame or array
x <- c(2:8,4:10)
x
unique(x)
#--------------------------------
# tolower() function converter string to its lower case.
x <- c("Green", "Red", "Black")
tolower(x)
#--------------------------------
#toupper() function converts a string to its upper case.
x <- c("Green", "Red", "Black")
toupper(x)
#----------------------------------
#The grep() function are used for searching for matches
str <- c("Regular", "expression", "examples of R language")
x <- grep("ex",str,value=F)
x
x <- grep("ex",str,value=T)
x

#summary() function is a generic function used to produce result summaries of the
#results of various model fitting functions
# setwd("D:/SL Instructor/Data Science with R")
setwd
restaurant <- read.csv("Restaurant.csv")
restaurant
summary(restaurant)
list.files()
#------------------------------
#str function gives information about structure of the R object
str(restaurant)
#install package
install.packages("dplyr")
library(dplyr)
#-----------------------------
# glimpse() also gives information about an R object
# we need to install the dplyr package for this function
library(dplyr)
glimpse(restaurant)
#------------------------------
# class function returs class of an object
data <- c("East","West","East","North","North","East","West","West","West","East","North")
class(data)
# Apply the factor function.
factor_data <- factor(data)
class(factor_data)
#------------------------------
#mode() function gets or sets the type or storage mode of an object
x <- 3
mode(x)
#set the mode to character
mode(x) <- "character"
mode(x)
#---------------------------------------------
#APPLY family of functions
# The family of apply has 6 apply functions:
#apply
#lapply
#sapply
#tapply
#vapply
#mapply
# apply can be used to apply a function to a matrix.It is used to
# perform a specific change to
# each column or row of R objects.
#For example, let's create a sample dataset:
data <- matrix(c(1:10, 21:30), nrow = 5, ncol = 4)
data
#Now we can use the apply function to find the sum of each row as follows:
apply(data, 1, sum)
apply(data, 2, sum)
#Now we can use the apply function to find the mean of each row as follows:
apply(data, 1, mean)
#The second parameter is the dimension. 1 signifies rows and 2 signifies columns.
apply(data, 2, mean)
# The family of apply has 6 apply functions:
#apply
#lapply
#sapply
#tapply
#vapply
#mapply
# Lets first discuss the apply function
#apply function helps to apply a function to a matrix row or a column and
# returns a vector, array or list
m <- matrix(c(1,2,3,4),2,2)
m
apply(m, 1, sum)
apply(m, 2,sum)
#------------------------------------------------
#Lapply() function
#lapply is similar to apply, but it takes a list as an input, and returns a list as the output.
#example 1. Let's create a list
data <- list(x = 1:5, y = 6:10, z = 11:15)
data
#Now, we can use lapply to apply a function to each element in the list. For example:
lapply(data, FUN = median)
#example 2:
data2 <- list(a=c(1,1), b=c(2,2), c=c(3,3))
data2
lapply(data2, sum)
lapply(data2, mean)
#----------------------------------------------
#Sapply function
#sapply is the same as lapply, but returns a vector instead of a list.
#example 1 :
data <- list(x = 1:5, y = 6:10, z = 11:15)
data
sapply(data, FUN = median)
lapply(data, FUN = median)
#Note : if the result are all scalars, then a vector is returned
#for example
data3 <- list(a=c(1,1), b=c(2,2), c=c(3,3))
data3
sapply(data3, FUN = sum)
# however if the result are of same size (>1) then a matrix is returned else
data4 <- list(a=c(1,2), b=c(1,2,3), c=c(1,2,3,4))
data4
sapply(data4, FUN = range)
#-----------------------------------------------
# tapply() tapply splits the array based on specified data, usually factor levels
#and then applies the function to it.
#example 1:
age <- c(23,33,28,21,20,19,34)
gender <- c("m" , "m", "m" , "f", "f", "f" , "m")
tapply(age, gender, mean)
#example number 2
#load the datasets
library(datasets)
#you can view all the datasets
data()
data(package = .packages(all.available = TRUE))
#load the mtcars dataset
View(mtcars)
class(mtcars)
str(mtcars)
summary(mtcars)
mtcars$wt
mtcars$cyl
tapply(mtcars$wt, mtcars$cyl, mean)
#------------------------------------------
# vapply () is very similar to sapply(). While sapply() guesses,
# vapply() takes an additional argument specifying the output type.
list <- list(a=c(1,1), b=c(2,2), c=c(3,3))
vapply(list, sum, FUN.VALUE = double(1))
sapply(list, sum )
#------------------------------------------
#mapply() - mapply is a multivariate version of sapply. It will apply the specified function
#to the first element of each argument first, followed by the second element, and so on.
#example 1-
x <- 1:5
b <- 6:10
x
b
mapply(mean, x, b)
## example number 2
#create a 4 x 4 matrix using rep function repeatedly, four times
Q=matrix(c(rep(1, 4), rep(2, 4), rep(3, 4), rep(4, 4)),4,4)
Q
# where we bind the results of the rep function with c , and ask for a 4 x 4 matrix.
# alternatively we can use the mapply function
Q=mapply(rep,1:4,4)
Q
# Example 3
# create a list:
a <- list(rep(1,4), rep(2,3), rep(3,2), rep(4,1))
a
b <- mapply(rep, 1:4, 4:1)   # rep(1,2,3,4),(4,3,2,1)
b
#-------------------------------------------------
# Dplyr package
# it transforms and summarizes tabular data with rows and columns
# install Dplyr package
install.packages("dplyr")
#load the package
library(dplyr)
# functions of dplyr package
# select()
# filter()
# arrange()
# mutate()
# summarize()
# to understand each of these functions , lets consider the the dataset mtcars
View(mtcars)
# Select function allows us to select specific columns from large data sets
# select columns by names
select(mtcars, mpg, disp)
# select a range of columns by names
select(mtcars, mpg:hp)
# select columns with string match
# for this load another data called Iris
View(iris)
select(iris, starts_with("Petal"))
select(iris, ends_with("Width"))
select(iris, contains("etal"))
select(iris, matches("."))
select(iris, contains(".")) # without Species
select(iris, matches(".")) # with Species
#---------------------------------------------
#filter() enables easy filtering, zoom in, and zoom out of relevant data.
# two types of filters are :
# simple filter
filter(mtcars, cyl== 8)
filter(mtcars, cyl < 6)
# multiple criteria filter
filter(mtcars, cyl <6, vs == 1)
filter(mtcars, cyl <6 | vs == 1)
#---------------------------------------------
# arrange function helps arrange the data in a specif order
arrange(mtcars, desc(disp))
func <- arrange(mtcars, cyl, disp)
func
write.csv(func, "abc.csv")
#---------------------------------------------
# mutate() helps add new variables to an existing data set.
mutate(mtcars, my_custom_disp = disp/1.0237)
#--------------------------------------------
#summarize() function summarizes multiple value into a single value in a dataset.
summarise(group_by(mtcars, cyl), mean(disp))
summarise(group_by(mtcars, cyl), m = mean(disp), sd = sd(disp))
#-------------------------------------------
## Creating Simple Bar Charts
counts <- table(mtcars$gear)
counts
barplot(counts, main="Car Distribution",
        xlab="Number of Gears")
#nextsession

## Creating Simple Bar Charts
# setwd("D:/SL Instructor/Data Science with R")
counts <- table(mtcars$gear)
counts
barplot(counts, main="Car Distribution",
        xlab="Number of Gears")
barplot(counts, main="Car Distribution",
        xlab="Number of Gears", ylab = "No. of Cars", ylim = c(0,20))
# horizontal bar chart
barplot(counts, main = "Car Distribution", horiz = TRUE,
        names.arg = c("3 Gears", "4 Gears", "5 Gears"), xlim = c(0,20))
# Editing a simple Bar Chart
barplot(counts, main = "Car Distribution", xlab="Number of Gears", ylab = "Frequency",
        ylim = c(0,20),legend= rownames(counts),col = c("red", "yellow", "green"))
## Create a stacked barplot with colors and legends
counts <- table(mtcars$vs, mtcars$gear)
counts
barplot(counts, main = "Car Distribution by Gears and VS", xlab="Number of Gears",
        ylim = c(0,20), legend= rownames(counts),col = c("red", "yellow"))
## Create a Grouped Bar Plot
barplot(counts, main = "Car Distribution by Gears and VS", xlab="Number of Gears",
        ylim = c(0,15),legend= rownames(counts),col = c("red", "yellow"), beside = TRUE)
#--------------------------------------------------------------
## Pie-Charts
# Simple Pie Chart
slices <- c(10, 12,4, 16, 8)
lbls <- c("US", "UK", "Australia", "Germany", "France")
pie(slices, labels = lbls, main="Pie Chart of Countries")
# Adding percentages to Pie-chart
slices <- c(10, 12, 4, 16, 8,15)
slices
lbls <- c("US", "UK", "Australia", "Germany", "France","India")
lbls
pct <- round(slices/sum(slices)*100)
pct
lbls <- paste(lbls, pct) # add percents to labels
lbls
lbls <- paste(lbls,"%",sep="")
lbls
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Pie Chart of Countries")
# Create a 3-D pie chart
# Install "plotrix" package
# install.packages("plotrix")
# library(plotrix)
# slices <- c(10, 12, 4, 16, 8)
# lbls <- c("US", "UK", "Australia", "Germany", "France")
# pie3D(slices,labels=lbls,explode=0.1,
#       main="Pie Chart of Countries ")
#-----------------------------------------------------------
#Histograms
#Create a Histogram
hist(mtcars$mpg)
#coloured histogram with different number of bins
hist(mtcars$mpg, breaks = 5, col = "darkgreen")
#----------------------------------------------------------
## Create a Kernel density plot
d <- density(mtcars$mpg)
d
plot(d)
# Fill density plot with color
plot(d, main = "Kernel Density of Miles per Gallon")
polygon(d, col = "Skyblue", border = "Black")
#--------------------------------------------------------------
## Line Charts
weight <- c(2.5, 2.8, 3.2, 4.8, 5.1, 5.9, 6.8, 7.1, 7.8, 8.1)
months <- c(0,1,2,3,4,5,6,7,8,9)
plot(months, weight, type = "b", main = "Baby Weight Chart")
#------------------------------------------------------------
#create a box-plot
vec <- c(3,2,5,6,4,8,1,2,3,2,4)
summary(vec)
boxplot(vec, varwidth = TRUE)
boxplot(mpg~cyl,data=mtcars, main="Car Milage Data",
        xlab="Number of Cylinders", ylab="Miles Per Gallon")
#-------Scatter Plot-------------------
plot(x = mtcars$wt, y = mtcars$mpg,
     xlab = 'Weight', ylab = 'Milege',
     xlim = c(2.5,4), ylim = c(5,20),
     main = "Weight vs Mileage")
plot(x = mtcars$disp, y = mtcars$mpg,
     xlab = 'disp', ylab = 'Milege',
     main = "Weight vs Mileage")
pairs( formula = ~wt+mpg+disp+cyl, data = mtcars, main = "Scatterplot Matrix")
#----------------------------------------------------------
install.packages("ggplot2")
library(ggplot2)
## Heatmaps
## refer to http://sebastianraschka.com/Articles/heatmaps_in_r.html
#---------------------------------------------------------
##Saving a graphic file
# setwd("D:/SL Instructor/Data Science with R")
dev.copy(jpeg, filename = "hist.jpg")
hist(mtcars$mpg, breaks = 5, col = "darkgreen")
dev.off()