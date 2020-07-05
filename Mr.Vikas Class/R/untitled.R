setwd("D:/Data Science/R")
getwd()
a= c(2,3,4,6,8,9,10,12)
count=0
for (val in a) {
  if (val %% 2 == 0) {count=count+1}
}
print(count)
setwd("D:Data Science\R")
getwd()
Rest=read.csv("Restaurant.csv")
summary(Rest)
str(Rest)
data<- matrix(c(1:10,21:30),5,4)
data
pply(data,1,mean)
data<-list(1:5,10:15,20:25)
data
lapply(data,median)
data2 <- list(a=c(1,1), b=c(2,2), c=c(3,3))
data2

lapply(data2, sum)

lapply(data2, mean)
mtcars
tapply(mtcars$wt,mtcars$cyl,mean)
list<- list(a=c(1,1),b=c(2.8,2),c=c(3,3))
vapply(list, sum, FUN.VALUE = double(1))
sapply(list, sum)
d=mapply(rep,1:4,4)
d
s=mapply(rep,1:4,4:1)
s
install.packages("dplyr")
library(dplyr)
View(iris)
select(iris,starts_with("petal"))
select(iris, contains(".")) # without Species
select(iris, matches(".")) # with Species 
filter(mtcars,cyl<6,vs==1)
func=arrange(mtcars,cyl,disp)
write.csv(func,"abc.csv")
summarise(group_by(mtcars,cyl),m=mean(disp),sd=sd(disp))
summarise(group_by(mtcars,disp),mean(cyl),sd(cyl))
install.packages("xlsx")
install.packages("ggplot2")
library(ggplot2)
# Program to check if the input number is odd or even.
# A number is even if division by 2 give a remainder of 0.
# If remainder is 1, it is odd.
num = as.integer(readline(prompt="Enter a number: "))
if((num %% 2) == 0) {
  print(paste(num,"is Even"))
} else {
  print(paste(num,"is Odd"))
}
setwd("D:/Data Science/R")
getwd()
anvdata<-read.csv(file.choose())
head(anvdata)
st_prod <- stack(anvdata)
head(st_prod)

names(st_prod) <- c("Productivity", "Project")
st_prod
# Box plot
boxplot(Productivity ~ Project, data = st_prod,
        xlab = "Project", ylab = "Productivity",
        frame = FALSE, col = c("#00AFBB", "#E7B800", "#FC4E07","#FC4E08"))
# Compute the analysis of variance
res.aov <- aov(Productivity ~ Project, data = st_prod)
# Summary of the analysis

summary(res.aov)
# Tukey multiple pairwise-comparisons
# As the ANOVA test is significant, we can compute
# Tukey HSD (Tukey Honest Significant Differences,
# R function: TukeyHSD()) for performing multiple
# pairwise-comparison between the means of groups.

# The function TukeyHD() takes the fitted ANOVA as an argument.

TukeyHSD(res.aov)

plot(TukeyHSD(res.aov))

