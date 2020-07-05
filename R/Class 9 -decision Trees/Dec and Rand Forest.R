# library(rattle)
# library(RGtk2)
# rattle()

#Decision trees ----

# library(ISLR)
# attach(Carseats)
# dim(Carseats)
# write.csv(Carseats,'D:/Data Science/Dr Vinod online classes/Class 9 -decision Trees/Carseats.csv')
data <- Carseats
dim(data)
str(data)
summary(data)

library(dplyr)

data$Sales <- ifelse(data$Sales<=8,'NO',"Yes")
data$Sales <- as.factor(data$Sales)
str(data)
head(data)
 #model----
library(tree)
library(party)

# ctree <- ctree(Sales~., data)
# summary(ctree)

tree <- tree(Sales~., data)
summary(tree)
plot(tree)
text(tree,pretty = 0)
tree

set.seed(111)
ind <- sample(2,nrow(data),replace = T,prob = c(0.5,0.5))
train <- data[ind==1,]
test <- data[ind==2,]
testSales <- test$Sales
test <- test[,-1]
str(train)
str(test)

#train and test accuracy without pruning
tree_train <- tree(Sales~., data=train)
summary(tree_train) #accuracy near to 90percent

pred <- predict(tree_train,test,type='class')
tab <- table(pred,testSales)
acc <- sum(diag(tab))/sum(tab)
acc #accuracy 76.8


#train and test accuray with pruning

#pruning params
set.seed(123)
cv <- cv.tree(tree_train,FUN = prune.misclass) #cv tree with function of misclassification error
names(cv)
cv
#plotting
dev.off()
par(mfrow=c(1,2))
plot(cv$size,cv$dev,type='b',col='red',lwd=2)
plot(cv$k,cv$dev,type='b',col='red',lwd=2)

#prune tree
pruned.tree_train <- prune.misclass(tree_train,best=18)
plot(pruned.tree_train)
text(pruned.tree_train,pretty = 0)

#testing pruned tree

pred1=predict(pruned.tree_train,test,type = 'class')
tab1 <- table(pred1,testSales)
acc1 <- sum(diag(tab1))/sum(tab1)
acc1 #accuracy 76.8..same as without pruning ..not much use in this dataset



#randomforest----
library(randomForest)
set.seed(1)
rf <- randomForest(Sales~., data=train,importance=T)
importance(rf)
varImpPlot(rf,col='red')
rf #OOB error is 26.67%


#testing RF
pred2=predict(rf,test,type = 'class')
tab2 <- table(pred2,testSales)
tab2
acc2 <- sum(diag(tab2))/sum(tab2)
acc2

#mtry=3 

set.seed(1)
rf1 <- randomForest(Sales~., data=train,mtry=3,importance=T)
importance(rf1)
varImpPlot(rf1,col='red')
rf1 #OOB error is 26.67%


#testing RF
pred2=predict(rf1,test,type = 'class')
tab2 <- table(pred2,testSales)
tab2
acc2 <- sum(diag(tab2))/sum(tab2)
acc2 #rf test - 77.8 accuracy







