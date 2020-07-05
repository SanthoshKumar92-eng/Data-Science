#Exercise on Basics R
3+7
4*8
12>18
12+18=40
12+18==40 #correct one
rep("I HAVE LEARNT R",3)
dear<-c("Banglore","Kolkatta","Mumbai")
dear
dearer<-c(84,65,39)
dearer
dearest<-101:107
dearest
dear[3]
dear[4]<-"Chennai"
dear
dear[c(2,4)]
d<-c(4,5,6)
h<-c(2,3,4)
d*h
dearer==c(84,65,38)
k<- c(3,8,NA,9)
sum(k)
matrix(1,2,2)
w<-1:6
matrix(w,2,3)
q<-1:6
matrix(q,2,3)
names<-c("Alberic","John","Steve","Chris")
midterm<-c(87,89,93,95)
final<-c(92,94,95,98)
result<-data.frame(names,midterm,final)
result
result[,2]
result[["midterm"]]
result$midterm
tests<-merge(merge1,merge2)
tests
write.csv(tests,"D:/Data Science/R/tests.csv")
