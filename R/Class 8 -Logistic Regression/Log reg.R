#logistic regression
cs2m <- read.csv('D:/Data Science/Dr Vinod online classes/Class 8 -Logistic Regression/cs2m.csv')

names(cs2m)
model <- glm(DrugR~., data=cs2m , family=binomial)
summary(model)

preds <- predict(model,type='response')
head(preds)
preds>=0.5 # threshold set is 0.5 above that true below false.
table(cs2m$DrugR,preds>=0.5)

#gplot for roc curve
library(gplots)
perf <- performance(preds,"tpr","fpr")

plot(perf, colorize=T)




