# Real Estate Price Prediction - using Advanced Linear Regression
# Techniques
# Overview
# There are several factors that influence the price a buyer is willing to pay for a house.
# Some are apparent and obvious and some are not. Nevertheless,
# a rational approach facilitated by machine learning can be very useful
# in predicting the house price. A large data set with 79 different
#features (like living area, number of rooms, location etc) along
# with their prices are provided for residential homes in Ames, Iowa.
# The challenge is to learn a relationship between the important features
# and the price and use it to predict the prices of a new set of houses.
# Here's a brief version of what you'll find in the data description file.
# SalePrice - the property's sale price in dollars. This is the target variable
# that you're trying to predict.
# MSSubClass: The building class
# MSZoning: The general zoning classification
# LotFrontage: Linear feet of street connected to property
# LotArea: Lot size in square feet
# Street: Type of road access
# Alley: Type of alley access
# LotShape: General shape of property
# LandContour: Flatness of the property
# Utilities: Type of utilities available
# LotConfig: Lot configuration
# LandSlope: Slope of property
# Neighborhood: Physical locations within Ames city limits
# Condition1: Proximity to main road or railroad
# Condition2: Proximity to main road or railroad (if a second is present)
# BldgType: Type of dwelling
# HouseStyle: Style of dwelling
# OverallQual: Overall material and finish quality
# OverallCond: Overall condition rating
# YearBuilt: Original construction date
# YearRemodAdd: Remodel date
# RoofStyle: Type of roof
# RoofMatl: Roof materialExterior1st: Exterior covering on house
# Exterior2nd: Exterior covering on house (if more than one material)
# MasVnrType: Masonry veneer type
# MasVnrArea: Masonry veneer area in square feet
# ExterQual: Exterior material quality
# ExterCond: Present condition of the material on the exterior
# Foundation: Type of foundation
# BsmtQual: Height of the basement
# BsmtCond: General condition of the basement
# BsmtExposure: Walkout or garden level basement walls
# BsmtFinType1: Quality of basement finished area
# BsmtFinSF1: Type 1 finished square feet
# BsmtFinType2: Quality of second finished area (if present)
# BsmtFinSF2: Type 2 finished square feet
# BsmtUnfSF: Unfinished square feet of basement area
# TotalBsmtSF: Total square feet of basement area
# Heating: Type of heating
# HeatingQC: Heating quality and condition
# CentralAir: Central air conditioning
# Electrical: Electrical system
# 1stFlrSF: First Floor square feet
# 2ndFlrSF: Second floor square feet
# LowQualFinSF: Low quality finished square feet (all floors)
# GrLivArea: Above grade (ground) living area square feet
# BsmtFullBath: Basement full bathrooms
# BsmtHalfBath: Basement half bathrooms
# FullBath: Full bathrooms above grade
# HalfBath: Half baths above grade
# Bedroom: Number of bedrooms above basement level
# Kitchen: Number of kitchens
# KitchenQual: Kitchen quality
# TotRmsAbvGrd: Total rooms above grade (does not include bathrooms)
# Functional: Home functionality rating
# Fireplaces: Number of fireplaces
# FireplaceQu: Fireplace quality
# GarageType: Garage location
# GarageYrBlt: Year garage was builtGarageFinish: Interior finish of the garage
# GarageCars: Size of garage in car capacity
# GarageArea: Size of garage in square feet
# GarageQual: Garage quality
# GarageCond: Garage condition
# PavedDrive: Paved driveway
# WoodDeckSF: Wood deck area in square feet
# OpenPorchSF: Open porch area in square feet
# EnclosedPorch: Enclosed porch area in square feet
# 3SsnPorch: Three season porch area in square feet
# ScreenPorch: Screen porch area in square feet
# PoolArea: Pool area in square feet
# PoolQC: Pool quality
# Fence: Fence quality
# MiscFeature: Miscellaneous feature not covered in other categories
# MiscVal: Value of miscellaneous feature
# MoSold: Month Sold
# YrSold: Year Sold
# SaleType: Type of sale
# SaleCondition: Condition of sale
getwd()
setwd("//home/vikas/15-Apr-20/DS/R/Trainings/DSP30")
# install.packages("Hmisc")
# install.packages("tidyr")
# install.packages("moments")
# install.packages("mice")
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
?describe
target <- data['SalePrice']
head(target, n =10)
str(target)
typeof(target)
hist(target)
ggplot(target, aes(SalePrice))+
  geom_histogram()
ggplot(target, aes(SalePrice, fill = cut(SalePrice,100)))+
  geom_histogram(show.legend = FALSE)
# As we can see the distribution is left skewed, so in order to
# make it normally distributed, we need to use log transformation.
# Log Transformation
target <- log(target)
hist(target)
ggplot(target, aes(SalePrice))+
  geom_histogram()
ggplot(target, aes(SalePrice, fill = cut(SalePrice,100)))+
  geom_histogram(show.legend = FALSE)
par(mfrow = c(2,2))
hist(data$SalePrice)
hist(target)
dev.off()
# After using log transformation, the Target variable is normally distributed.
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
# Adding total sqfootage feature
data$TotalSF <- data$TotalBsmtSF + data$X1stFlrSF + data$X2ndFlrSF
data <- select(data, -c(Id, TotalBsmtSF, X1stFlrSF, X2ndFlrSF))
dim(data)
str(data)
# 3.4 Split Dataframe into numeric and categorical
# Split dataframe into 2 with:
#   categorical features
#   numerical features
cat_var <- data %>% select_if(is.factor)
str(cat_var)
cat_num <- data %>% select_if(is.numeric)
str(cat_num)
describe(cat_num)
summary(cat_num)
head(cat_var, n = 5)
# 3.5 Reduce Skewness for Numeric Features
# Skewness is a measure of symmetry, or more precisely, the lack of symmetry.
#A distribution, or data set, is symmetric if it looks the same to the left
# and right of the center point. Here we are interested
# in the variables which have skewness more than 0.75
dev.off()
cat_num %>% gather() %>% head()
?gather
ggplot(gather(cat_num), aes(value)) +
  geom_histogram(bins = 10) +
  facet_wrap(~key, scales = 'free_x')
# for (col in 2:ncol(cat_num)) {
#     hist(cat_num[,col], breaks = 10) # breaks is for binsize
# }
cat_num_skew <- skewness(cat_num, na.rm = TRUE)
cat_num_skew <- cat_num_skew[cat_num_skew > 0.75]
cat_num_skew
# kurtosis(cat_num, na.rm = TRUE)
# apply log + 1 transformation for all numeric features with skewnes over 0.75
cat_num[cat_num_skew,] <- log1p(cat_num[cat_num_skew,])
cat_num_skew
# 3.6 Mean Normalization
length(cat_num)
cat_num_normz <- as.data.frame(scale(cat_num[1:30]))
dim(cat_num_normz)
str(cat_num_normz)
dev.off()
# cat_num_normz %>% gather() %>% head()
ggplot(gather(cat_num_normz), aes(value)) +
  geom_histogram(bins = 10) +
  facet_wrap(~key, scales = 'free_x')
# After Mean Normalization the data scale will change
# and it will not affect original data distribution
# 4. Missing Data Analysis
# If the missing values are not handled properly we may end up drawing an
# inaccurate inference about the data. Due to improper handling, the result
# obtained will differ from the ones where the missing values are present.
# first we'll visualize null count in overall dataframe
null_in_HousePrice <- sapply(data, function(x) sum(is.na(x)))
null_in_HousePrice
null_in_HousePrice = null_in_HousePrice[null_in_HousePrice > 0]
null_in_HousePrice
barplot(sort(null_in_HousePrice))
total <- sort(null_in_HousePrice, decreasing = T)
total
barplot(total)
# 5. Missing Data Treatment
# We may leave the data as it is or do data imputation to replace them.
# Suppose the number of cases of missing values is extremely small; then we may
# drop or omit those values from the analysis. In statistical language,
# if the number of the cases is less than 5% of the sample, then we can drop them.
# If there is a larger number of missing values, then it is better to
# drop those cases (rather than do imputation) and replace them.





4:39
# 5.1 Handling Missing Values in Numerical Columns
# Here we do data imputation. If the number of missing values is more than 260, we drop those values from the analysis.
# md.pattern(cat_num)
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
# Select function is in dplyr
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
# Extract the correlation coefficients
res2$r
# EXtract p values
res2$P
corrplot(n, method = "circle")
corrplot(n, method = "pie")
corrplot(n, method = "color")
corrplot(n, method = "number")
corrplot(n, type = "upper")
# corrplot(n, order = "hclust", type = "upper", col = col)
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
res <- resid(model5)
par(mfrow = c(2, 2))  # Split the plotting panel into a 2 x 2 grid
plot(model5)  # Plot the model information
df2 <- df1
df2$predicted <- predict(model5)   # Save the predicted values
df2$residuals <- residuals(model5) # Save the residual values
# Quick look at the actual, predicted, and residual values
# library(dplyr)
df2 %>% select(SalePrice, predicted, residuals) %>% head()
test <- read.csv("test_houseprice.csv")
dim(test)
str(test)
describe(test)
test$SalePrice <- predict(model5, data = test)
#
# write.csv("tp", test)
step(firstModel,direction = "forward",scope = formula(finalModel)) 