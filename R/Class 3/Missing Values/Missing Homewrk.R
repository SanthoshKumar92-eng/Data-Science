setwd("D:/Data Science/Dr Vinod online classes/Class 3/Data manipulation/Missing Values")
getwd()
#Missing values
dangal<-read.csv(file.choose(),header=T)
View(dangal)
dim(dangal)
str(dangal)
summary(dangal)

hist(dangal$gIta)
boxplot(dangal$gIta)
dangal$gIta
mean(dangal$gIta,na.rm=T)
median(dangal$gIta,na.rm=T)
dangal$gIta[is.na(dangal$gIta)]<-median(dangal$gIta,na.rm=T)
dangal$gIta
hist(dangal$gIta)
str(dangal$gIta)

hist(dangal$babita)
boxplot(dangal$babita)
dangal$babita
mean(dangal$babita,na.rm=T)
median(dangal$babita,na.rm=T)
dangal$babita[is.na(dangal$babita)]<-median(dangal$babita,na.rm=T)
dangal$babita
hist(dangal$babita)
str(dangal$babita)


hist(dangal$amir)
boxplot(dangal$amir)
dangal$amir
mean(dangal$amir,na.rm=T)
median(dangal$amir,na.rm=T)
dangal$amir[is.na(dangal$amir)]<-median(dangal$amir,na.rm=T)
dangal$amir
hist(dangal$amir)
str(dangal$amir)

library(VIM)
dangal1<-read.csv(file.choose(),header=T)
imp<-kNN(dangal1)
View(dangal1)
View(imp)
View(dangal)
