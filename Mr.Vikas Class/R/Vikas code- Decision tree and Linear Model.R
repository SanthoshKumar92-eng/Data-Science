#--------------------------------------------------------------------------
#Decision Trees
library(rpart)
library(rpart.plot)
library(RColorBrewer)
# install.packages("RColorBrewer")
setwd("D:/Data Science/R")
getwd()
data <-read.csv("CTG.csv")
str(data)
data$NSPF <- factor(data$NSP)
str(data)
# Partition data into training and validation datasets
set.seed(1234)
pd <- sample(2, nrow(data), replace = TRUE , prob = c(0.8,0.2))
pd
train <- data[pd==1,]
train
validate <- data[pd==2,]
validate
# decision Tree with party package
# install.packages("party")
library(party)
tree <- ctree(NSPF~LB+AC+FM, data = train)
tree
plot(tree)
# Pruning the tree to make it simple by controlling parameters
tree <- ctree(NSPF~LB+AC+FM, data = train, controls = ctree_control(mincriterion = 0.99,
                                                                    minsplit = 500))
tree
plot(tree)
# Predict
predict(tree, validate, type = "prob")
# Decision Tree using rpart
library(rpart)
tree1 <- rpart(NSPF~LB+AC+FM, data = train)
library(rpart.plot)
rpart.plot(tree1, extra = 3)
## Misclassification of error
## Misclassification of error for train data
tab <- table(predict(tree), train$NSPF)
tab
1- sum(diag(tab))/sum(tab)
## Misclassification of error for validate data
testPred <- predict(tree, newdata = validate)
tab <- table(testPred, validate$NSPF)
tab
1- sum(diag(tab))/sum(tab)

#------------------Accuracy----
sum(diag(tab))/sum(tab)
8:02
#Consider the data set "mtcars" available in the R environment.
#It gives a comparison between different car models in terms of mileage per gallon (mpg),
#cylinder displacement("disp"), horse power("hp"), weight of the car("wt")
# and some more parameters.
#The goal of the model is to establish the relationship between "mpg" as a response variable
#with "disp","hp" and "wt" as predictor variables.
#We create a subset of these variables from the mtcars data set for this purpose.
inastall.packages("car")
library(car)
# library(GGally)
View(mtcars)
input <- mtcars[,c("mpg","disp","hp","wt")]
head(input)
dim(input)
str(input)
summary(input)
# Y <- mpg (Target Variable)
# X's or features <- disp, wt, hp
#Create Relationship Model & get the Coefficients
# ggpairs(input, title="correlogram with ggpairs()")
model <- lm(mpg ~ disp+hp+wt, data = input)
model
summary(model)
model1 <- lm(mpg ~ hp+wt, data = input)
model1
summary(model1)
vif(model1)
#Create Equation for Regression Model
# Y = a + disp.x1 + hp.x2 + wt.x3
#Apply Equation for predicting New Values
#We can use the regression equation created above to predict the mileage
#when a new set of values for displacement, horse power and weight is provided.
#For a car hp = 110 and wt = 1.95 the predicted mileage is ???
# Y (mpg) = 37.22727+(-0.03177)*hp+(-3.87783)*wt
Y = 37.22727+(-0.03177)*110+(-3.87783)*1.95
Y
##-----------------------------------------------------------------------
##Case study 2 - we will use a built-in data set called state.x7
head(state.x77)
dim(state.x77)
# Lets look at the class
class(state.x77)
## clearly it is not a dataframe , so we need to convert it into one
st <- as.data.frame(state.x77)
class(st)
head(st)
colnames(st)[4] = "Life.Exp"   ## no spaces in variable names
colnames(st)[6] = "HS.Grad"
head(st)
# Y = Life.exp
model<- lm(formula = Life.Exp ~ ., data = st)
summary(model)
model1<- lm(formula = Life.Exp ~ Murder+HS.Grad, data = st)
summary(model1)
vif(model1)