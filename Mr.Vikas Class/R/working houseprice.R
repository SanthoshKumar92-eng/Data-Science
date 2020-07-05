setwd("D:/Data Science/R")

library(Hmisc)
library(dplyr)
library(ggplot2)
library(tidyr)
library(mice)
library(moments)
library(dummies)
library(corrplot)
library(DAAG)

data <- read.csv("train_houseprice.csv")
View(data)
str(data)
dim(data)
summary(data)
describe(data)

target <- data['SalePrice']
head(target, n =10)
str(target)
typeof(target)
hist(target)


# Log 
target <- log(target)
hist(target)

hist(data$SalePrice)
hist(target)
dev.off()

raw_data <- data
data <- select(data,-c(SalePrice))
dim(data)
describe(data)
str(data)

# Feature Engineering
# MSSubClass=The building class
data$MSSubClass <- as.factor(data$MSSubClass)

# Changing OverallCond into a categorical variable
data$OverallCond <- as.factor(data$OverallCond)

#Year and month sold are transformed into categorical features.
data$YrSold <- as.factor(data$YrSold)
data$MoSold <- as.factor(data$MoSold)
str(data)

# Adding total 
data$TotalSF <- data$TotalBsmtSF + data$X1stFlrSF + data$X2ndFlrSF
data <- select(data, -c(Id, TotalBsmtSF, X1stFlrSF, X2ndFlrSF))
dim(data)
str(data)

#splitting
cat_var <- data %>% select_if(is.factor)
str(cat_var)
cat_num <- data %>% select_if(is.numeric)
str(cat_num)
describe(cat_num)
summary(cat_num)
head(cat_var, n = 5)

#  Mean Normalization
length(cat_num)
cat_num_normz <- as.data.frame(scale(cat_num[1:30]))
dim(cat_num_normz)
str(cat_num_normz)
dev.off()
ggplot(gather(cat_num_normz), aes(value)) +
  geom_histogram(bins = 10) +
  facet_wrap(~key, scales = 'free_x')

#missing data
null_in_HousePrice <- sapply(data, function(x) sum(is.na(x)))
null_in_HousePrice
null_in_HousePrice = null_in_HousePrice[null_in_HousePrice > 0]
null_in_HousePrice
barplot(sort(null_in_HousePrice))
total <- sort(null_in_HousePrice, decreasing = T)
total
barplot(total)


# Missing value dealing
for(i in 1:ncol(cat_num)){
  missing_values = sum(is.na(cat_num[i]))
  if(missing_values > 260){
    cat_num <- select(cat_num, -c(cat_num[i]))
  }else{
    cat_num[is.na(cat_num[,i]), i] <- median(cat_num[,i], na.rm = TRUE)
  }
}
cat_num
str(cat_num)
str(cat_var)
dim(cat_var)
for(i in 1:ncol(cat_var)){
  missing_values <- sum(is.na(cat_var[i]))
  if(missing_values > 50){
    print(paste("Missing Values > 50 in column : ", colnames(cat_var[i])))
  }
}
new_cat_var <- select(cat_var,
                      -c('Alley','FireplaceQu','GarageType','GarageFinish','GarageQual',
                         'GarageCond','PoolQC','Fence','MiscFeature'))

dim(new_cat_var)
describe(new_cat_var)
str(new_cat_var)
names(new_cat_var)

new_cat_var_dummies <- dummy.data.frame(new_cat_var)
head(new_cat_var_dummies)
dim(new_cat_var_dummies)
ncol(cat_num)
print(paste("Numerical features : ", ncol(cat_num)))
print(paste("Categorical features : ", ncol(new_cat_var_dummies)))
n <- cor(cat_num)
n
res2 <- rcorr(as.matrix(cat_num))
res2

df1 <- data.frame(cat_num, new_cat_var_dummies, target)
dim(df1)
model1 <- lm(SalePrice~., data = df1)
summary(model1)
dev.off()
model2 <- lm(SalePrice~LotArea+OverallQual+BsmtFullBath+FullBath+HalfBath+KitchenAbvGr
             +Fireplaces+GarageYrBlt+GarageCars+GarageArea+WoodDeckSF+
               ScreenPorch+MSZoningC..all.+MSZoningFV+MSZoningRL+
               UtilitiesAllPub+LotConfigCulDSac+LandSlopeGtl+LandSlopeMod+
               NeighborhoodEdwards+NeighborhoodMeadowV+NeighborhoodMitchel+NeighborhoodNAmes+
               NeighborhoodNWAmes+NeighborhoodOldTown+NeighborhoodSawyer+
               Condition2Artery+Condition2PosN+Condition2RRAe+OverallCond3+
               OverallCond4+OverallCond5+ OverallCond6+OverallCond7+
               RoofStyleFlat+RoofStyleGable+RoofStyleGambrel+RoofStyleHip+RoofStyleMansard+
               RoofMatlClyTile+Exterior1stWd.Sdng+Exterior2ndWd.Sdng,data = df1)
summary(model2)
model3 <- lm(SalePrice~LotArea+OverallQual+BsmtFullBath+FullBath+HalfBath+
               Fireplaces+GarageYrBlt+GarageCars+GarageArea+WoodDeckSF+
               ScreenPorch+MSZoningC..all.+MSZoningFV+MSZoningRL+
               LotConfigCulDSac+LandSlopeGtl+LandSlopeMod+
               NeighborhoodEdwards+NeighborhoodMeadowV+NeighborhoodMitchel+NeighborhoodNAmes+
               NeighborhoodNWAmes+NeighborhoodOldTown+NeighborhoodSawyer+
               Condition2Artery+Condition2PosN++OverallCond3+
               OverallCond4+OverallCond5+ OverallCond6+
               RoofStyleFlat+RoofStyleGable+RoofStyleHip+
               RoofMatlClyTile+Exterior1stWd.Sdng,data = df1)
summary(model3)
model4 <- lm(SalePrice~LotArea+OverallQual+BsmtFullBath+FullBath+HalfBath+
               Fireplaces+GarageYrBlt+GarageCars+GarageArea+WoodDeckSF+
               ScreenPorch+MSZoningC..all.+MSZoningFV+MSZoningRL+
               LotConfigCulDSac+LandSlopeGtl+LandSlopeMod+
               NeighborhoodEdwards+NeighborhoodMeadowV+NeighborhoodMitchel+NeighborhoodNAmes+
               NeighborhoodNWAmes+NeighborhoodOldTown+NeighborhoodSawyer+
               Condition2Artery+Condition2PosN++OverallCond3+
               OverallCond4+OverallCond5+ OverallCond6+
               RoofStyleGable+RoofMatlClyTile+Exterior1stWd.Sdng,data = df1)
summary(model4)
vif(model4)
model5 <- lm(SalePrice~LotArea+OverallQual+BsmtFullBath+FullBath+HalfBath+
               Fireplaces+GarageYrBlt+GarageArea+WoodDeckSF+
               ScreenPorch+MSZoningC..all.+MSZoningFV+MSZoningRL+
               LotConfigCulDSac+LandSlopeMod+
               NeighborhoodEdwards+NeighborhoodMeadowV+NeighborhoodMitchel+NeighborhoodNAmes+
               NeighborhoodNWAmes+NeighborhoodOldTown+NeighborhoodSawyer+
               Condition2Artery+Condition2PosN++OverallCond3+
               OverallCond4+OverallCond5+ OverallCond6+
               RoofStyleGable+RoofMatlClyTile+Exterior1stWd.Sdng,data = df1)

summary(model5)

vif(model5)
plot(model5)  
p <- predict(model5, data = df1)
p

tab<-table(p,df1$SalePrice)
tab

testdata <- read.csv("test_houseprice.csv")
dim(testdata)
str(testdata)
p <- predict(model5, data = testdata)
p
p <- as.data.frame(p)
str(p)
testdata$SalesPrice <- p