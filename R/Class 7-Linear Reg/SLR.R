# Read data
setwd('D:/Data Science/Dr Vinod online classes/Class/Class 7-Linear Reg')
getwd()
slr <- read.csv('D:/Data Science/Dr Vinod online classes/Class 7-Linear Reg/slr.csv')
View(slr)
str(slr)
summary(slr)

plot(slr$Advt~slr$Sales)
cor(slr$Advt,slr$Sales)

#model building
mod <- lm(Sales~Advt,data=slr)
summary(mod)

#predictions
predict(mod)
pred <- predict(mod)
slr$Sales
mod$residuals

slr$predicted <- predict(mod) #add predicted values

res=residuals(mod)
slr$residuals <- mod$residuals #add residuals


View(slr)

plot(slr$Advt,slr$Sales,abline(lm(slr$Sales~slr$Advt),col='red'),col='blue')

#assumptions
#1.Normality of error
hist(slr$residuals,col='red')
boxplot(slr$residuals,col='red',horizontal = T)

#2.Linearity(x axis-adv, y axis-errors)
plot(slr$Advt,slr$residuals,main = 'Linearity',col='red')

#3.Independance of error(x axis- obs number, y axis-error)
plot(slr$Observation.no,slr$residuals,main = 'independance of error',col='red')

#4.Constant error variance(homoscedasticity)(x axis-predicted values , y axis-error)
plot(slr$predicted,slr$residuals,main = 'constant error var',col='red')

#all in one plot
plot(mod)



#mtcars
str(mtcars)
mod1 <- lm(mpg~hp+wt+drat+disp , data=mtcars)
summary(mod1)

library(car)
vif(mod1)
vif(mod1)>5
#vif>10 for huge data set only.

mod2 <- lm(mpg~hp+wt,data=mtcars)
summary(mod2)

pred <- predict(mod2)
dat$mpg

dat <- mtcars
View(dat)
dat$predicted <- pred
dat$residuals <- mod2$residuals
View(dat)
head(dat)
#multicollinearity

library(car)
vif(mod1) 


#aautocollinearity checking
library(lmtest)
dwtest(mod2)
dwtest(mod1)
write.csv(mod1$residuals,'res.csv')

#HCtest

bptest(mod1)




#assumptions
#1.Normality of error
hist(dat$residuals,col='red')
boxplot(dat$residuals,col='red',horizontal = T)

#2.Linearity(x axis-adv, y axis-errors)
plot(dat$hp,dat$residuals,main = 'Linearity',col='red')#doubt
plot(dat$wt,dat$residuals,main = 'Linearity',col='red')#doubt
#3.Independance of error(x axis- obs number, y axis-error)
library(dplyr)
dat1 <- dat %>% mutate(obs=c(1:32))
str(dat)  
str(dat1)
plot(dat1$obs,dat1$residuals,main = 'independance of error',col='red')

#4.Constant error variance(homoscedasticity)(x axis-predicted values , y axis-error)
plot(dat$predicted,dat$residuals,main = 'constant error var',col='red')

#all in one plot
plot(mod2)