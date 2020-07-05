#Time Series Analysis

kings <- scan('http://robjhyndman.com/tsdldata/misc/kings.dat',skip=3)
rain <- read.csv("D:/Data Science/Dr Vinod online classes/Class 11- Time Series/rain.csv")
sovenir <- read.csv("D:/Data Science/Dr Vinod online classes/Class 11- Time Series/sovenir.csv")
skirts <- read.csv("D:/Data Science/Dr Vinod online classes/Class 11- Time Series/skirts.csv")


#Kings----
kings
str(kings)
kingsts <- ts(kings)
kingsts
plot.ts(kingsts,col='blue')#no trend,cycle and seasonality , randomness is constant

#moving average
library(TTR)
kingstsSMA3 <- SMA(kingsts,n=3)
plot.ts(kingstsSMA3,col=('blue'))

kingstsSMA8 <- SMA(kingsts,n=8)
plot.ts(kingstsSMA8,col=('blue'))

#mse3
kingsts
kingstsSMA3
e3 <- kingsts - kingstsSMA3
e3

mse3 <- sum(e3^2,na.rm = T)/40
mse3
#mse8
kingsts
kingstsSMA8
e8 <- kingsts - kingstsSMA8
e8

mse8 <- sum(e8^2,na.rm = T)/35
mse8

#births----

births <- scan('http://robjhyndman.com/tsdldata/data/nybirths.dat')
head(births)
birthsts <- ts(births,start=c(1946,1),frequency = 12)
birthsts
summary(births)
summary(birthsts)
plot.ts(birthsts,col='blue') #seasonality exists

birthsts_comps <- decompose(birthsts) #additive
birthsts_comps
plot(birthsts_comps,col='blue')



















