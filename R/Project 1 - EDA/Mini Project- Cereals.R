setwd('D:/Data Science/Dr Vinod online classes/Mini project')
getwd()
data <- read.csv('D:/Data Science/Dr Vinod online classes/Mini project/cereals_data.csv')
View(data)
str(data)
summary(data)
sum(complete.cases(data))# 4NAs

#----missing value----
data[21,] #1 NA
data[5,]#1 NA
data[58,]#2 NA
library(VIM)
library(dplyr)
library(ggplot2)
imp_data <- kNN(data)
imp_data <- imp_data[,-c(17:32)]
dim(imp_data)
summary(imp_data)

#----EDA----
#----Analysis of each variable----


names(imp_data)
e.data <- imp_data
dim(e.data)

library(psych)
str(e.data)

describe(e.data)
pairs.panels(e.data)


#1.Name
unique(e.data$name)
length(unique(e.data$name))

Top_10_cereals <- e.data %>% select(name,rating) %>% arrange(desc(rating)) %>% head(10)
ggplot(Top_10_cereals,aes(reorder(name,-rating),rating,fill=rating))+geom_bar(stat='identity')+
       labs(x='Cereal name',y='rating',title = 'Top 10 cereals by rating')+
       theme(axis.text.x = element_text(angle = 90))+
       scale_colour_brewer(palette='Dark2')

Bottom_10_cereals <- e.data %>% select(name,rating) %>% arrange(rating) %>% head(10)
ggplot(Bottom_10_cereals,aes(reorder(name,rating),rating,fill=rating))+geom_bar(stat='identity')+
  labs(x='Cereal name',y='rating',title = 'Bottom 10 cereals by rating')+
  theme(axis.text.x = element_text(angle = 90))+
  scale_colour_brewer(palette='Dark2')



#2.Mfr
unique(e.data$mfr)
length(unique(e.data$mfr)) #7 level
table(e.data$mfr)
barplot(table(e.data$mfr),col=rainbow(20),ylim=c(0,30))

count_mfr <- e.data %>% count(mfr) 
count_mfr
ggplot(count_mfr,aes(x=mfr,y=n))+geom_bar(stat = 'identity')
ggplot(count_mfr,aes(x=reorder(mfr,-n),y=n))+geom_bar(stat = 'identity')#descending
ggplot(count_mfr,aes(x=reorder(mfr,-n),y=n))+geom_bar(stat = 'identity',fill='blue')
ggplot(count_mfr,aes(x=reorder(mfr,-n),y=n))+geom_bar(stat = 'identity',fill='blue')+
      geom_text(aes(label=n,vjust=-1))


per_mfr <- e.data %>% count(mfr) %>%
          mutate(per=round(n/sum(n),2),perc=paste((per*100),'%'))
per_mfr
ggplot(per_mfr,aes(reorder(mfr,-n),n))+geom_bar(stat='identity',fill='blue')+
       geom_text(aes(label=perc,vjust=-0.5))
  
#3.Type
unique(e.data$type)
length(unique(e.data$type))# 2 level
table(e.data$type)
barplot(table(e.data$type),col=rainbow(20),ylim=c(0,100))


count_type <- e.data %>% count(type)
count_type
ggplot(count_type,aes(x=reorder(type,n),y=n))+geom_bar(stat='identity',fill='blue')+
       geom_text(aes(label=n,vjust=-0.5))


per_type <- e.data %>% count(type) %>% 
            mutate(perc=paste(round(n/sum(n),2)*100,'%'))
per_type
ggplot(per_type,aes(reorder(type,-n),n))+geom_bar(stat='identity',fill='blue')+
       geom_text(aes(label=perc,vjust=-0.5))


#4.Calories
describe(e.data$calories)#avg=107,negaive skew,+kyrt
hist(e.data$calories,col='green')
densityplot(e.data$calories,col='red')
boxplot(e.data$calories,col='blue')

library(packHV)
hist_boxplot(e.data$calories,freq = F,density = TRUE,col='red')#for density,freq is False
hist_boxplot(e.data$calories,freq = T,density = TRUE,col='red')#without density, pass freq=T
abline(v=mean(e.data$calories),col='green')
abline(v=median(e.data$calories),col='blue')

#5.protein
describe(e.data$protein)#avg=2.55 grams,positive skew,+kurt
hist(e.data$protein,col='green')
densityplot(e.data$protein,col='red')
boxplot(e.data$protein,col='blue')

#6.Fat
describe(e.data$fat)#avg=1.01grams,positive skew,+kurt
hist(e.data$fat,col='green')
densityplot(e.data$fat,col='red')
boxplot(e.data$fat,col='blue')
#7.Sodium
describe(e.data$sodium)#avg=160 mg,negaive skew,-kurt
hist(e.data$sodium,col='green')
densityplot(e.data$sodium,col='red')
boxplot(e.data$sodium,col='blue')
#8.Fiber
describe(e.data$fiber)#avg=2.15 gms,positive skew,+kurt
hist(e.data$fiber,col='green')
densityplot(e.data$fiber,col='red')
boxplot(e.data$fiber,col='blue')
#9.carbo
describe(e.data$carbo)#avg=14.79 gms,almost normal dist,-kurt
hist(e.data$carbo,col='green')
densityplot(e.data$carbo)

#10.Sugars
describe(e.data$sugars)#avg=7gms, almost normal dist,-kurt
hist(e.data$sugars,col='green')
densityplot(e.data$sugars,col='red')
boxplot(e.data$sugars,col='blue')
#11.Potass
describe(e.data$potass)#avg=98.9 mg,+skew,+kurt
hist(e.data$potass,col='green')
densityplot(e.data$potass,col='red')
boxplot(e.data$potass,col='blue')
#12.vitamins
describe(e.data$vitamins)#Cateorical in nature
table(e.data$vitamins)
unique(e.data$vitamins)
length(unique(e.data$vitamins))
#_hist(e.data$shelf,col='green')
#-hist(e.data$vitamins,col='green')
#-densityplot(e.data$vitamins,col='red')
#-boxplot(e.data$vitamins,col='blue')

#13.Shelf
describe(e.data$shelf)#categorical 3 shelves
table(e.data$shelf)
unique(e.data$shelf)
length(unique(e.data$shelf))
hist(e.data$shelf,col='green')

count_shelf <- e.data %>% count(shelf)
count_shelf
ggplot(count_shelf,aes(x=shelf,y=n))+geom_bar(stat='identity',fill='blue')+
      geom_text(aes(label=n,vjust=-0.5))

#14.Weight
describe(e.data$weight)#avg=1.03,+skew, +kurt
hist(e.data$weight,col='green')
densityplot(e.data$weight,col='red')
boxplot(e.data$weight,col='blue')
#15.Cups
describe(e.data$cups)#avg=0.82 cups ,-skew,+kurt
hist(e.data$cups,col='green')
densityplot(e.data$cups,col='red')
boxplot(e.data$cups,col='blue')
#16.Rating
describe(e.data$rating)#avg=42,+skew,+kurt
hist(e.data$rating,col='green')
densityplot(e.data$rating,col='red')
boxplot(e.data$rating,col='blue')


e.data %>% describe()#all variables

dev.off()


#Data Manipulation----
m.data <- e.data
names(m.data)
m.data$vitamins <- as.factor(m.data$vitamins)
m.data$shelf <- as.factor(m.data$shelf)
str(m.data)

#1 Mfr wise count,percentage,rating,calories
m.data %>% select(mfr,name) %>% group_by(mfr) %>% summarise(cereals=n())
count_mfr <- m.data %>% count(mfr) #same
count_mfr
ggplot(count_mfr,aes(x=reorder(mfr,-n),y=n))+geom_bar(stat = 'identity',fill='blue')+
  geom_text(aes(label=n,vjust=-1))+labs(x='mfr',y='no_of_cereals')

per_mfr <- m.data %>% count(mfr) %>%
  mutate(per=round(n/sum(n),2),perc=paste((per*100),'%'))
per_mfr
ggplot(per_mfr,aes(reorder(mfr,-n),n))+geom_bar(stat='identity',fill='blue')+
  geom_text(aes(label=perc,vjust=-0.5))

ggplot(m.data,aes(x=mfr,y=rating))+geom_boxplot(fill='green')



#2.type wise count,percentage,rating,calories,sugar

count_type <- m.data %>% count(type)
count_type
ggplot(count_type,aes(x=reorder(type,n),y=n))+geom_bar(stat='identity',fill='blue')+
  geom_text(aes(label=n,vjust=-0.5))+labs(x='type',y='count')


per_type <- m.data %>% count(type) %>% 
  mutate(perc=paste(round(n/sum(n),2)*100,'%'))
per_type
ggplot(per_type,aes(reorder(type,n),n))+geom_bar(stat='identity',fill='blue')+
  geom_text(aes(label=perc,vjust=-0.5))

ggplot(m.data,aes(x=type,y=rating))+geom_boxplot(fill='green')

ggplot(m.data,aes(x=type,y=calories))+geom_boxplot(fill='green')

ggplot(m.data,aes(x=type,y=sugars))+geom_boxplot(fill='green')



#3.calories w.r.t  mfr, type , 


m.data %>% select(calories,mfr) %>% group_by(mfr) %>% 
  summarise(Mean=mean(calories),Max=max(calories),Min=min(calories))
ggplot(m.data,aes(x=mfr,y=calories))+geom_boxplot(fill='green')
#Avg calories of R is high, N is least.
#max calorie producing cmpny is K, min is K and Q.

tapply(m.data$calories,m.data$type,mean)
m.data %>% select(calories,mfr,type) %>% group_by(type) %>% 
  summarise(Mean=mean(calories),Max=max(calories),Min=min(calories))
ggplot(m.data,aes(x=type,y=calories))+geom_boxplot(fill='green')
#avg,max,min calories typr wise.

ggplot(m.data,aes(calories,cups,color=shelf))+geom_point()


ggplot(m.data,aes(calories,rating))+geom_point()#Rating dec as cal incr.
plot(m.data$calories,m.data$rating)
abline(lm(rating~calories,data=m.data),col='blue')

ggplot(m.data,aes(calories,fat))+geom_point()#cal inc with inc in sugar,weight and fat.
plot(m.data$calories,m.data$fat)
abline(lm(fat~calories,data=m.data),col='blue')

ggplot(m.data,aes(calories,sugars))+geom_point()
plot(m.data$calories,m.data$sugars)
abline(lm(sugars~calories,data=m.data),col='blue')

ggplot(m.data,aes(calories,weight))+geom_point()
plot(m.data$calories,m.data$weight)
abline(lm(weight~calories,data=m.data),col='blue')

plot(m.data$fiber,m.data$rating) #rating inc if there is more fiber and K.
abline(lm(rating~fiber,data=m.data),col='blue')

plot(m.data$potass,m.data$fiber) #fiber inc when potasium increases
abline(lm(fiber~potass,data=m.data),col='blue')



library(psych)
pairs.panels(e.data[,4:16])#mostly there is no correlation
#- rating dec with inc in calories
#-Rating dec with inc in sugars
#-calories inc with inc in weight


e.data %>% group_by(mfr) %>% summarise(Mean=mean(rating))
ggplot(e.data,aes(reorder(mfr,-rating),rating))+geom_bar(stat = 'summary',fun.y='mean')
#-cmpny N has high average rating, 2nd is A, 3rd is K, last is G.
#-rating of most companies are similar

ggplot(e.data,aes(as.factor(mfr),calories))+geom_bar(stat = 'summary')
#-mean calories of all companies are almost equal

#INteresting
str(m.data)
summary(m.data)
m.data$calories
m1.data <- within(m.data,{cal <- NA
              cal[calories>=50&calories<80] <- "L"
              cal[calories>=80&calories<110] <- "M"
              cal[calories>=110] <- "H"
              })
View(m.data)
View(m1.data)
View(imp_data)
m1.data$vitamins <- m.data$vitamins

m1.data %>% select(cal,rating) %>% group_by(cal) %>% #relation
            summarise(Mean_rating=mean(rating))

m1.data$vitamins <- as.numeric(m1.data$vitamins)
m1.data %>%
      select(cal,type,vitamins,potass,fiber,protein,fat,sodium,carbo,sugars,cups) %>%
      group_by(cal) %>% #relation
      summarise(Mean_potass=mean(potass),
                Mean_fiber=mean(fiber),
                Mean_protein=mean(protein),
                Mean_fat=mean(fat),
                Mean_sodium=mean(sodium),
                Mean_carbo=mean(carbo),
                Mean_sugars=mean(sugars),
                Mean_cups=mean(cups),
                Mean_vitamins=mean(vitamins)
                )

m1.data %>%
  select(cal,type,vitamins,potass,fiber,protein,fat,sodium,carbo,sugars,cups) %>%
  group_by(type) %>% #relation
  summarise(Mean_potass=mean(potass),
            Mean_fiber=mean(fiber),
            Mean_protein=mean(protein),
            Mean_fat=mean(fat),
            Mean_sodium=mean(sodium),
            Mean_carbo=mean(carbo),
            Mean_sugars=mean(sugars),
            Mean_cups=mean(cups),
            Mean_vitamins=mean(vitamins)
  )
#distribution of calories
m1.data %>% 
  ggplot(aes(x = calories)) +
  geom_density(fill = "blue", alpha = 0.8, adjust = 3, linetype = 0) +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Calories ", expand = c(0,0)) +
  scale_y_continuous(name = "Proportion", expand = c(0,0)) +
  labs(fill = "Manufacturer", title = "Distribution of Calories in Cereals") +
  theme_minimal()

m1.data %>% 
  ggplot(aes(x = calories, fill = mfr)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Calories ", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 10), breaks = seq(0, 10, 2)) +
  labs(fill = "Manufacturer", title = "Distribution of Calories in Cereals") +
  theme_minimal()

m1.data %>% 
  ggplot(aes(x = calories, fill = type)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Set1", direction = -1) +
  scale_x_continuous(name = "Calories (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 10), breaks = seq(0, 10, 2)) +
  labs(fill = "Type", title = "Distribution of Calories in Cereals") +
  theme_minimal()



#cal as categorical

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

corr <- round(cor(e.data[,4:16]),2)
library(ggcorrplot)
ggcorrplot(corr)



