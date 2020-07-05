grades <- read.csv("D:/Data Science/Dr Vinod online classes/Class 2/grades.csv")
str(grades)
cs2m <- read.csv("D:/Data Science/Dr Vinod online classes/Class 2/cs2m.csv")
str(cs2m)
library(psych)
#one sample
t.test(cs2m$Age,mu=40)#95 CL as default.
#paired sample
t.test(x=grades$quiz1,y=grades$quiz2,mu=0,alternative = "two.sided",paired=T)
t.test(x=grades$quiz1,y=grades$quiz3,mu=0,paired=T)
t.test(x=grades$quiz1,y=grades$quiz5,mu=0,paired=T)
t.test(x=quiz1,y=quiz2,data=grades,mu=0,paired=T)#wrongone
#Independent sample(Assumeing unequal variance)
t.test(cs2m$BP~cs2m$AnxtyLH)


#Independent sample(Assumeing equal variance)
t.test(cs2m$BP~cs2m$AnxtyLH,var.equal=T)

#One Sample Proportion Test
#A researcher believes that market size of diesel cars is 30%. 
#For testing his belief, he had taken a sample of 130 cars and 
#found 50 diesel cars.  Ho: p=0.30
prop.test(50,130,p=0.3,alternative = 'two.sided',correct = F,conf.level = 0.95)

#Two Samples Proportion Test
#A researcher has found 10 stressed faculties out of a sample of 40 at Christ college 
#and 22 out of 50 at St. John. Ho: p1-p2 = 0
prop.test(c(10,22),c(40,50),alternative = 'two.sided',correct = F,conf.level = 0.95)


#one way anova
salescity <- read.csv("D:/Data Science/Dr Vinod online classes/Class 2/salescity.csv")
View(salescity)
plot(sales~city, data=salescity,col='blue')
plot(sales~city, data=salescity,col=heat.colors(4))
#Ho-mean sales is same
#Ha-atleast one city differs
results <- aov(sales~city,data=salescity)
summary(results)
TukeyHSD(results)#HSD-Honest difference.
#d and b has no diff as it has enough evidence to support HO.


#chi sq test

chisq.test(cs2m$AnxtyLH,cs2m$DrugR)








