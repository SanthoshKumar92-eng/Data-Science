#kNN Classifier



wbcd <- read.csv('D:/Data Science/Dr Vinod online classes/Class 10- kNN Classifier/wbcd.csv')
#View(wbcd)
dim(wbcd)
str(wbcd)
wbcd <- wbcd[,-1]
dim(wbcd)
str(wbcd)


table(wbcd$diagnosis)
barplot(table(wbcd$diagnosis),col=c('green','blue'))
text(barplot(table(wbcd$diagnosis),col=c('green','blue')),0,table(wbcd$diagnosis),cex=2,pos=3)

#change labels
wbcd$diagnosis <- factor(wbcd$diagnosis, levels = c("B",'M'), labels = c('Benign','Malignant'))
table(wbcd$diagnosis)
text(barplot(table(wbcd$diagnosis),col=c('green','blue')),0,table(wbcd$diagnosis),cex=2,pos=3)

#proportion
round(prop.table(table(wbcd$diagnosis))*100,2)

#normalization

normalize <- function(x){
  
  return((x-min(x))/(max(x)-min(x)))
}

normalize(c(10,20,30,40,50))

#new normalized data

wbcd_n <- as.data.frame(lapply(wbcd[,2:31], normalize))
str(wbcd_n)
str(wbcd)

#train and test
dim(wbcd_n)
train <- wbcd_n[1:469,]
test <- wbcd_n[470:569,]

wbcd_trainlabels <- wbcd[1:469,1]
wbcd_testlabels <-  wbcd[470:569,1]

str(wbcd_trainlabels)
str(wbcd_testlabels)
table(wbcd_testlabels)

#prediciton
library(class)

#trainig and testing done at a time and k is sqrt of num of obs.
test_pred <- knn(train,test,cl=wbcd_trainlabels,k=21)
summary(test_pred)
table(test_pred)

#evaluate model
library(gmodels)

CrossTable(x=wbcd_testlabels, y=test_pred, chisq = F)

#testinf acc for diff K values

# i=1
# acc=1
# for (i in 1:28){
#   test_pred <- knn(train_norm,test_norm,cl=train_labels,k=i)
#   acc[i] <- 100 * sum(test_labels == test_pred)/NROW(test_labels)
#   j=i
#   cat(j,'=',acc[i],'')
# }

#Accuracy plot
# plot(acc, type="b", xlab="K- Value",ylab="Accuracy level")

