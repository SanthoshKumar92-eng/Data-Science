#K means- RBI
RBI <- read.csv("D:/Data Science/Dr Vinod online classes/Class 5-Cluster/RBI.csv")

head(RBI,3)
library(dplyr)
library(factoextra)
library(cluster)

df <- RBI[,-1]
rownames(df) <- RBI[,1]
head(df,3)

is.na(df)

summary(df)#no NAs
df <- scale(df)#scaled data
head(df)

#----View sample data for cluster possiblity----
ind <- sample(1:nrow(df),15,replace = T)
df15 <- df[ind,]

str(df15)
dim(df15)
dim(df)
head(df15)

df15_dist <- dist(df15)#euclidean by default
df15_dist
as.matrix(df15_dist)
fviz_dist(df15_dist)

#----no of clusters----
?fviz_nbclust
?geom_vline
fviz_nbclust(df,kmeans,method='wss')+geom_vline(xintercept = 5,linetype=7,col='green')#linetype is thkness value
fviz_nbclust(df, kmeans, nstart = 25,k.max = 10,  method = "gap_stat", nboot = 150)
#gap stat method shows 5.
#Elbow wss also seems 5.

#k means
df.km=kmeans(df,5,nstart=20)
df.km
df.km$cluster
#Profiling-see cluster means of all variables of org data cluster wise

aggregate(RBI[,-1],by=list(df.km$cluster),mean)#org data- warning because of states is factor var
df.km #scaled data means of all variables cluster wise

#add cluster membership
RBI_1 <- cbind(RBI,df.km$cluster)
RBI_1 <- cbind(RBI,Clusters=df.km$cluster)
head(RBI_1,3)



#----Hclust----
#take scaled data and cal euc dist, kmeans does it automatic

df.dist <- dist(df,method="euclidean")
df.hc <- hclust(df.dist,method='ward.D2')
fviz_dend(df.hc)
grp <- cutree(df.hc,k=5)
grp #same output as df.km$cluster result

#then chk their means and bind it.
aggregate(RBI,by=list(grp),mean)
df.km

RBI_2 <- cbind(RBI,clusters=grp)
head(RBI_2,3)


#compare km and hclust
table(df.km$cluster,grp)

df.km
str(df.km)
grp
str(grp)

fviz_cluster(list(cluster=grp, data = df), palette = "jco",ggtheme = theme_classic())#list only wrks


fviz_cluster(df.km, data = df, palette = "jco",ggtheme = theme_minimal())


#Kmeans 5 clusters of 10,13,6,2,5
#Hclust 5 clusters of 10,14,2,6,4 (almost same )
list1 <- as.list(RBI_1 %>% filter(Clusters==1) %>% select(States_Union))
list2 <- as.list(RBI_1 %>% filter(Clusters==2) %>% select(States_Union))
list3 <- as.list(RBI_1 %>% filter(Clusters==3) %>% select(States_Union))
list4 <- as.list(RBI_1 %>% filter(Clusters==4) %>% select(States_Union))
list5 <- as.list(RBI_1 %>% filter(Clusters==5) %>% select(States_Union))
 result1 <- c(list1,list2,list3,list4,list5)
result1

list11 <- as.list(RBI_2 %>% filter(grp==1) %>% select(States_Union))
list22<- as.list(RBI_2 %>% filter(grp==2) %>% select(States_Union))
list33<- as.list(RBI_2 %>% filter(grp==3) %>% select(States_Union))
list44<- as.list(RBI_2 %>% filter(grp==4) %>% select(States_Union))
list55<- as.list(RBI_2 %>% filter(grp==5) %>% select(States_Union))
result2 <- c(list11,list22,list33,list44,list55)
result2









