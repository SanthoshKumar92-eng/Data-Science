age <- c(12,14,21,22,25,26,13,28,24,22,23,32,28,28,27,27,29,30,35,34,33)
summary(age)
library(psych)

#cs2m
cs2m <- read.csv("D:/Data Science/Dr Vinod online classes/Class 2/cs2m.csv") 

View(cs2m)
summary(cs2m)

summarise(cs2m,mage=mean(Age,na.rm=T),
          Medage=median(Age,na.rm=T))

#----Visualization----

describe(cs2m)
describe(cs2m$Age)
hist(cs2m$Age, col="green")

describe(cs2m$BP)
hist(cs2m$BP, col="green")
plot(cs2m$BP, col="red")
boxplot(cs2m$BP, col="blue")


describe(cs2m$Chlstrl)
par(mfrow=c(2,1))
hist(cs2m$Chlstrl, col="green")
plot(cs2m$Chlstrl, col="red")
boxplot(cs2m$Chlstrl, col="blue")

s<-cs2m[,c(1:3)]
pairs.panels(s) #pairsplot

m<-cs2m
m<-as.matrix(cs2m)
heatmap(m)  #input should be in matrix
heatmap(m,col=topo.colors(100))

#quiz1,2,3,total,gpa heatmap
library(dplyr)
n<-as.matrix(select(grades,quiz1,quiz2,quiz3,total,gpa))
heatmap(n)

#barplot for cat vars

a <- table(cs2m$AnxtyLH)
barplot(a,main="barplot of AnxLh", names.arg = c("low","high"),col=c("red","blue"))

#make barplot of section var in grades

b <- table(grades$section)
b
barplot(b,main="barplot of section", names.arg = c("one","two","three"),xlab=("no of section"),ylab=("count"),col=c("red","blue","green"))



#-----pairplot----
grades <- read.csv("D:/Data Science/Dr Vinod online classes/Class 2/grades.csv")
str(grades)
#createpairplot for quiz1,total,gpa
a<-data.frame(grades$quiz1,grades$total,grades$gpa)
a
pairs.panels(a)
#anothersubsetting
names(grades)
b<-grades[,c(13,19,10)]
pairs.panels(b)

#set seed returns same numbers everytime- Replace t means with replacement, F means without replacement.
set.seed(11)
g<-sample(1:6,10,replace=T) #roll of die simulation of 10 times
g
g<-sample(1:6,10,replace=F)#error will come coz 6 numbers is possible but we gave 10 simulation
g
g<-sample(1:6,6,replace=F) #crct one
g

#data manipulation

str(grades)
grades$final
?cut

grades$finalcat <- cut(grades$final, 
                      breaks=seq(40,75,5),
                      labels=c("f1","f2","f3","f4","f5","f6","f7"),
                      include.lowest = T,
                      )
grades$finalcat

library(dplyr)
View(grades)

grades%>%group_by(gender,ethnicity)%>%
          select(gender,ethnicity,gpa,final)%>%
          summarise(Agpa=mean(gpa),Afinal=mean(final))

grades%>%group_by(gender,ethnicity)%>%
  select(gender,ethnicity,gpa,final)%>%
  summarise(Agpa=mean(gpa),Afinal=mean(final))%>%
  filter(Agpa>2.25)

#may16 class-DataManipulation
f<-read.csv("D:/Data Science/Dr Vinod online classes/Class 4-may16/framingham.csv")
t<-read.csv("D:/Data Science/Dr Vinod online classes/Class 3/Data manipulation/t.csv")
str(t)
summary(t)
complete.cases(t)
t_complete<-t[complete.cases(t),]
library(dplyr)
library(reshape)
str(cs2m)
cs2m_mutate<-mutate(cs2m,chlsbp=Chlstrl/BP)
cs2m_mutate

cs2m$chlsbp<-cs2m$Chlstrl/cs2m$BP
cs2m

m<-cs2m
j<-m
#rename
names(j)
?rename
j<-rename(j,c(Chlstrl="cholestrol",Prgnt="pregnant",AxtyLH="anxiety",DrugR="reaction"))
names(j)
names(m)
#----range----
cs2m_asc<-arrange(j,Age)
head(cs2m_asc)
cs2mdes<-arrange(j,desc(Age))
head(cs2mdes)
#-----select-----
names(grades)
gradessel<-subset(grades,select=c(quiz1,gpa,final))
gradessel<-select(grades,quiz1,gpa,final)
gradessel<-select(grades,c(quiz1,gpa,final))
gradessel

#----apply-----
apply(cs2m,2,mean)#all cols
round(apply(cs2m,2,mean),2)#roundoff to 2 decimals
mean(cs2m$BP)#singlecol

names(mtcars)
str(mtcars)
head(mtcars)
by(mtcars[,-2],mtcars$cyl,colMeans) #by function, all cols except cyl in mtcars grouped by cylinder and mean of all cols

names(cs2m)
tapply(cs2m$BP,cs2m$Prgnt,mean)
names(grades)
tapply(grades$gpa,grades$ethnicity,mean)

final60<-subset(grades,final>60)
head(final60)
par(mfrow=c(2,1))
boxplot(grades$final,col = "red",horizontal = F)
boxplot(final60$final,col = "green",horizontal = F)
dev.off()

#----CorTest----
cor.test(grades$gpa,grades$final)
cor.test(final60$gpa,final60$final)

#----Filter age bw20 and 32----
names(cs2m)

cs2mfil<-subset(cs2m,Age>20 & Age<32) #20 and 32 not included
cs2mfil
cs2mfil1<-filter(cs2m,Age>20&Age<32)#20 and 32 not included
cs2mfil1

names(grades)
gradesfil<-subset(grades,ethnicity==4)
head(gradesfil)
grades$catfin<-ifelse(grades$final<60,"final<60","final>60")#new cat variable from cont var
table(grades$catfin)
head(grades)
grades<-select(grades,-gradescatfin) #removing old col
head(grades)

#----cut----
grades$finalcat<-cut(grades$final,breaks=seq(40,75,5),
                     labels=c("f1","f2","f3","f4","f5","f6","f7"),
                     include.lowest = T
                     )
grades$finalcat
grades$final

#----within----
m <- cs2m
head(m)
m <- within(m,{agecat <- NA
          agecat[Age>15&Age<=25] <- "low"
          agecat[Age>26&Age<=40] <- "medium"
          agecat[Age>40] <- "higm"
          })
head(m,3)
#----convert Cat var into anothher short cat var

head(grades,3)
grades$cateth <- grades$ethnicity
grades$cateth[grades$cateth==1|grades$cateth==3|grades$cateth==5] <- "1"
grades$cateth[grades$cateth==4|grades$cateth==4] <- "2"
grades$cateth
str(grades$cateth)

#----sample----

ind <- sample(x=1:nrow(grades),size=0.2*nrow(grades),replace = T)
str(ind)
head(ind)
sam <- grades[ind,]
str(sam)
head(sam)

#----summarise----
library(dplyr)
summarise(cs2m,MeanAge=mean(Age,na.rm=T),MedAge=median(Age,na.rm=T))

#----Piping----
names(cs2m)
dfpip <- cs2m %>% filter(Prgnt==1) %>% 
         select(BP,Age,DrugR,Prgnt) %>% 
         mutate(bpage=BP/Age)
str(dfpip)

grades %>% group_by(ethnicity) %>% 
           summarise(Avgpa=mean(gpa),Avgfinal=mean(final),Avgtot=mean(total))

grades %>% group_by(ethnicity,gender) %>% #select(gender,ethnicity,gpa,final) %>%  is optional,same result
           summarise(Avgpa=mean(gpa),Avgfinal=mean(final))

grades %>% group_by(ethnicity,gender) %>% #select(gender,ethnicity,gpa,final) %>%  is optional,same result
  summarise(Avgpa=mean(gpa),Avgfinal=mean(final)) %>% 
  filter(Avgpa>2.25)


head(mtcars)
mtcars %>% group_by(cyl,gear) %>% #select(cyl,gear,mpg,wt,am) %>% is optional,same o/p
           summarise(avgmpg=mean(mpg),avgwt=mean(wt)) %>% 
           filter(avgmpg>15)

#----Automation----
m <- cs2m
head(m)
m$Prgnt[m$Prgnt==0] <- "no" #change prgnt cat var into yes for 1, no for 0
m$Prgnt[m$Prgnt==1] <- "yes"
head(m)

head(cs2m)
f <- function(x){
     for(i in 1:ncol(x)){
       if(count(unique(x[i]))==2){
        x[i] <- ifelse(x[i]==0,"no","yes")
       }
     }
  return(x)
}

cs2m1 <- f(cs2m)
str(cs2m1)
head(cs2m1)
head(cs2m)
cs2m1$DrugR#its a list not a factor

#what if count is more than 2 ???
head(cs2m)
cs2mmm <- cs2m
cs2mmm[1,4] <- "2"
cs2mmm[1,5] <- "2"
cs2mmm[1,6] <- "2"
head(cs2mmm)
f1 <- function(y){
  for(i in 1:ncol(y)){
    if(count(unique(y[i]))==3){
     y[i] <- ifelse(y[i]==0,"low",ifelse(y[i]==1,"medium","high"))
    }
  }
  return(y)
}
cs2m2 <- f1(cs2mmm)
head(cs2m2)
head(cs2m1)


#----gather and spread from tidyr package
?gather
library(tidyr)
preg <- read.csv("D:/Data Science/Dr Vinod online classes/Class 3/Data manipulation/preg.csv")
str(preg)
head(preg)

preg1 <- preg %>% gather(treatment,n,treatmenta:treatmentb) %>% 
               arrange(names,treatment)
str(preg1) #pass argument strings as factors to false to get names as chr

#same as above
preg1 <- preg %>% gather(key="treatment",value = 'n',treatmenta:treatmentb) %>% 
  arrange(names,treatment)
str(preg1)





