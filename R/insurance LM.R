setwd("D:/Data Science/Dr Vinod online classes")
getwd()

data <- read.csv("D:/Data Science/Dr Vinod online classes/insurance.csv")
head(data)
str(data)


barplot(table(data$sex),col = 'red')
barplot(table(data$children),col = 'blue')
barplot(table(data$smoker),col = 'green')
barplot(table(data$region),col = 'yellow')

hist(data$charges,col='blue')
boxplot(data$charges,col='blue',horizontal = T)
summary(data$charges)

hist(data$age,col='blue')
boxplot(data$age,col='blue',horizontal = T)
summary(data$age)

hist(data$bmi,col='blue')
boxplot(data$bmi,col='blue',horizontal = T)
summary(data$bmi)

str(data)
cor(data[c("age","bmi","children","charges")])

pairs(data[c("age","bmi","children","charges")])

library(psych)
pairs.panels(data[c("age","bmi","children","charges")])

#model

model <- lm(charges~. , data=data)
summary(model)


data$age2 <- data$age^2
hist(data$age2)

data$bmi30 <- ifelse(data$bmi>=30,1,0)
barplot(table(data$bmi30))

head(data)  

#add age2 and bmi30 * smoker 
model2 <- lm(charges~age+age2+sex+bmi+children+bmi30*smoker+region , data=data)  
summary(model2)  
  





