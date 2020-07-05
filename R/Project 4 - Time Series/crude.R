#Crude oil Forecasting

crude <- read.csv(file.choose())
head(crude)

crudets <- ts(crude, frequency = 12, start=c(2000,6))
crudets

#write.csv(crudets,"D:/Data Science/Dr Vinod online classes/Project 4 - Time Series/crudets.csv")

attributes(crudets)
plot(crudets,col='blue')

#acf and pacf

par(mfrow=c(1,2))
acf(crudets,  main="ACF",col='red')
pacf(crudets,  main="PACF",col='red')
dev.off()


#stationary check
library(tseries)
adf.test(crudets) #not stationary , so we have to make stationary









