# Read data
setwd('D:/Data Science/Dr Vinod online classes/Mini project')
getwd()
data <- read.csv('D:/Data Science/Dr Vinod online classes/Mini project/cereals_data.csv')
View(data)
str(data)
summary(data)
data[!complete.cases(data),]# 4NAs
#libraries
library(VIM)
library(dplyr)
library(ggplot2)
library(psych)
library(cluster)
library(factoextra)
library(ggcorrplot)
library(purrr)
#missing values imputation
data <- kNN(data)
dim(data)
data <- data[,-c(17:32)]
dim(data)
View(data)
data[!complete.cases(data),]# 0 NAs
dat <- data

#Each variables EDA
?keep # PURR

dat %>%
  keep(is.numeric) %>%                     # Keep only numeric columns
  gather() %>%                             # Convert to key-value pairs
  ggplot(aes(value)) +                     # Plot the values
  facet_wrap(~ key, scales = "free") +   # In separate panels
  geom_density(fill='blue') 



lapply(c("mfr", "type"),
       function(col) {
         ggplot(dat, aes_string(col)) + geom_bar(fill='blue')
           
       })


#Distribution of Calorie vs all variables

m1.data <- within(data,{cal <- NA
cal[calories>=50&calories<80] <- "L"
cal[calories>=80&calories<110] <- "M"
cal[calories>=110] <- "H"})


count_cal <- m1.data %>%group_by(mfr) %>%  count(cal)
count_cal
ggplot(count_cal,aes(x=reorder(cal,n),y=n,fill=mfr))+geom_bar(stat='identity')+
  labs(x='cal',y='count',title='Mfr wise calorie distribution')


count_cal1 <- m1.data %>%group_by(type) %>%  count(cal)
count_cal1
ggplot(count_cal1,aes(x=reorder(cal,n),y=n,fill=type))+geom_bar(stat='identity')+
  labs(x='cal',y='count',title='Typewise calorie distribution')



m1.data %>% 
  ggplot(aes(x = weight, fill = cal)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Weight (in ounces)", expand = c(0,0)) +
  labs(fill = " Cal ", title = "Distribution of weight vs cal", subtitle = "HIgh in weight means high in calories") +
  theme_classic()

m1.data %>% 
  ggplot(aes(x = cups, fill = cal)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "no of cups", expand = c(0,0)) +
  labs(fill = " Cal ", title = "Distribution of cups vs cal", subtitle = "No effect of no of cups in calories") +
  theme_classic()

m1.data %>% 
  ggplot(aes(x = rating, fill = cal)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Ratings", expand = c(0,0)) +
  labs(fill = " Cal ",y ='count', title = "Distribution of Ratings vs cal", subtitle = "Low rating for Hogh calories") +
  theme_classic()

m1.data %>% 
  ggplot(aes(x = fiber, fill = cal)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "fiber", expand = c(0,0)) +
  labs(fill = " Cal ",y ='count', title = "Distribution of fiber vs cal", subtitle = "fiber content is more in when cereal has low calorie") +
  theme_classic()

m1.data %>% 
  ggplot(aes(x = protein, fill = cal)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "protein", expand = c(0,0)) +
  labs(fill = " Cal ",y ='count', title = "Distribution of protein vs cal", subtitle = "No relationof protein w.r.t cal") +
  theme_classic()

m1.data %>% 
  ggplot(aes(x = fat, fill = cal)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "fat", expand = c(0,0)) +
  labs(fill = " Cal ",y ='count', title = "Distribution of fat vs cal", subtitle = "No relation of fat w.r.t cal") +
  theme_classic()

m1.data %>% 
  ggplot(aes(x = carbo, fill = cal)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "carbo", expand = c(0,0)) +
  labs(fill = " Cal ",y ='count', title = "Distribution of carbo vs cal", subtitle = "No relation of carbo w.r.t cal") +
  theme_classic()

m1.data %>% 
  ggplot(aes(x = sugars, fill = cal)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "sugars", expand = c(0,0)) +
  labs(fill = " Cal ",y ='count', title = "Distribution of sugars vs cal", subtitle = "high sugar in high calorie cereals") +
  theme_classic()

#distribution of weight per serving
str(m1.data)
m1.data$weight
m1.data %>% 
  ggplot(aes(x = weight, fill = mfr)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Set5") +
  scale_x_continuous(name = "Weight (in ounces)", expand = c(0,0)) +
  labs(fill = "Manufacturer", title = "Distribution of Weight per Serving", subtitle = "different weights for servings") +
  theme_classic()

m1.data %>% 
  ggplot(aes(x = weight, fill = type)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Set4") +
  scale_x_continuous(name = "Weight (in ounces)", expand = c(0,0)) +
  labs(fill = "type", title = "Distribution of Weight per Serving", subtitle = " different weights ") +
  theme_classic()


#distribution of cups per serving
str(m1.data)
m1.data$cups
m1.data %>% 
  ggplot(aes(x = cups, fill = mfr)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Spectral") +
  scale_x_continuous(name = "no of cups", expand = c(0,0)) +
  labs(fill = "Manufacturer", title = "Distribution of cups per Serving", subtitle = "different cups for servings") +
  theme_classic()

m1.data %>% 
  ggplot(aes(x = cups, fill = type)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Spectral") +
  scale_x_continuous(name = "no of cups", expand = c(0,0)) +
  labs(fill = "type", title = "Distribution of cups per Serving", subtitle = "different cups for same type") +
  theme_classic()

#correletion

corr <- round(cor(data[,4:16]),2)
library(ggcorrplot)
ggcorrplot(corr)

#K means Clustering

df <- data

str(df)
summary(df)
names(df)
row.names(df) <- df[,1]
df <- df[,c('calories','protein','fat','rating')]
df <- scale(df)
dim(df)

fviz_nbclust(df, kmeans, method = "wss") +
  geom_vline(xintercept = 5, linetype = 5,col="red")+
  labs(subtitle = "Elbow method")
#compute
set.seed(123) # for reproducibility
km.res <- kmeans(df, 5, nstart = 25)#df is scaled data, default uses euclidean method
km.res
km.res$cluster
# Visualize
# fviz_cluster(km.res, data = df, col=rainbow(8),
#              star.plot=T,
#              repel = T,
#              ellipse.type = "euclid",
#              ggtheme = theme())
fviz_cluster(km.res, data = df, palette = "jco",
             ggtheme = theme_minimal())

#adding membership to original data
df_km <- cbind(data,clustertype=km.res$cluster)
head(df_km)
View(df_km)

#Means of all variables clusterwise in org data

aggregate(df_km,list(cluster=km.res$cluster),mean)

#linear model----


df_lm <- select(dat,-c("name","mfr","type","shelf","weight","cups"))
dim(df_lm)

set.seed(1234)
ind <- sample(2, nrow(df_lm), replace = TRUE , prob = c(0.8,0.2))
ind
train <- df_lm[ind==1,]
train
head(train)
test <- df_lm[ind==2,]
test
head(test)

str(train)
str(test)

?lm
model <- lm(rating~. , data=train)
summary(model)
plot(model)

# train$predicted <- predict(model)
testpred <- predict(model,test)
head(testpred)
head(test)

