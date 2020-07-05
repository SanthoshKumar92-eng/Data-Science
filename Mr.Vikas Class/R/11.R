#exercise 1 : chk num is even or odd

num = as.integer(readline(prompt="Enter a number: "))
if((num %% 2) == 0) {
  print(paste(num,"is Even"))
} else {
  print(paste(num,"is Odd"))
}

#excercise 2: print multiplication table

num = as.integer(readline(prompt = "Enter a number: "))
for(i in 1:10) {
  print(paste(num,'x', i, '=', num*i))
}
k= -5:7
k
l=seq(-5,8,)
l
l=seq(-5,8,2.5)
l
library(dplyr)
view(mtcars)
mtcars
view(mtcars)
input<-matrix[ ,c("mpg","disp","hp","wt")]
