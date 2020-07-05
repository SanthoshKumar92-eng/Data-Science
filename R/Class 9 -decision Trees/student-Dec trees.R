#student data set
#decision trees regression----

data <- read.csv('D:/Data Science/Dr Vinod online classes/Class 9 -decision Trees/student.csv')
str(data)
#EDA
sum(is.na(data))

#train and test
set.seed(123)
ind <- sample(2,nrow(data),replace=T,prob = c(0.8,0.2))
train <- data[ind==1,]
test <- data[ind==2,]

str(test)
colnames(test)
mark <- test[,6]
test <- test[,-6]

dim(train)
dim(test)


#Modelling

# library(tree)
# tree <- tree(Mark~. ,data=train)
# summary(tree)
# plot(tree)
# text(tree,pretty = T)

library(rpart)

tree <- rpart(Mark ~., method="anova", data=train)
plot(tree, uniform=F,  main="Regression Tree ")
text(tree,pretty = T,cex=0.5)

printcp(tree)

par(mfrow=c(1,2)) 
rsq.rpart(tree)

#prediction on test data
str(train)
str(test)

pred <- predict(tree,newdata=test)
head(pred)
head(mark)











