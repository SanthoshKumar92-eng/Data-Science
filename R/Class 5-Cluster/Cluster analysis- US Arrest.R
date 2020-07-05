#----Cluster Analysis----
#Dataclustering consists of data mining methods for identifying groups of similar objects in a multivariate data sets collected from fields such as marketing, bio-medical and geo-spatial.
#Similarity between observations (or individuals) is defined using some inter-observation distance measures including Euclidean and correlation-based distance measures.
#There are different types of data clustering techniques, including:
#Partitioning clustering approaches, which subdivide the data into a set of k groups. One of the popular partitioning method is the k-means clustering
#Hierarchical clustering approaches, which identify groups in the data without subdividing it.

#----Data Preparation----
#remove NAs and do scaling or normalizing to perform CA
data("USArrests")
View(USArrests)
str(USArrests)
df <- USArrests
df <- na.omit(df)
df <- scale(df)
dim(df)
str(df)
View(df)
head(df,3)
#install cluster, factoextra
library(cluster)
library(factoextra)


#----Assessing tha data for cluster tendancy using Hopkins Statistics----
#if H<0.5 no meaningful cluster is data, H>0.5 data has meaningful clusters
#statistical asses



#visual asses by dist matrix by taking sample rows(here 15) from data
set.seed(123)
ind <- sample(1:50,15)
df1 <- df[ind,]
head(df1,3)
df1.scaled <- scale(df1)
str(df1)
head(df1,3)
dist.ecul_15 <- dist(df1,method = "euclidean")#gives one half output in diagonal
as.matrix(dist.ecul_15)#matrix fills upper half also so that column has complete values
round(as.matrix(dist.ecul_15)[1:3,1:3],1)#can use head also instead of[1:3,1:3] to view few rows
fviz_dist(dist.ecul_15)#clustering possible


#----Find optimal No of clusters----eg: any 3 methods for kmeansClust , any 3 methods or view dendogram for hierarchicalClust
#optimal K values for Kmeans Clust can be found by 3 types.
# 1.Elbow method...Linetype = thickness of intercept line...xintercept is our value,meaningless
#find elbow point visually
fviz_nbclust(df, kmeans, method = "wss") +
  geom_vline(xintercept = 9, linetype = 5,col="red")+
  labs(subtitle = "Elbow method")
# 2.Silhouette method
fviz_nbclust(df, kmeans, method = "silhouette")+
  labs(subtitle = "Silhouette method")
# 3.Gap statistic method
      # nboot = 50 to keep the function speedy. 
      # recommended value: nboot= 500 for your analysis.
      # Use verbose = FALSE to hide computing progression.
set.seed(123)
fviz_nbclust(df, kmeans, nstart = 25,k.max = 10,  method = "gap_stat", nboot = 400)+
  labs(subtitle = "Gap statistic method") #choose nboot maximum 200 to 500 to get optimum
#Elbow method: 4 clusters solution suggested
#Silhouette method: 2 clusters solution suggested
#Gap statistic method: 4 clusters solution suggested
#According to these observations, it's possible to define k = 4 as the optimal number of clusters in the data.


#----1.K means Clustering----
#compute
set.seed(123) # for reproducibility
km.res <- kmeans(df, 4, nstart = 25)#df is scaled data, default uses euclidean method
km.res
km.res$totss
km.res$betweenss
km.res$betweenss/km.res$totss
# Visualize
fviz_cluster(km.res, data = df, palette = c("#2e9fdf","#00afbb","#e7b800","#fc4e07"),
             star.plot=T,
             repel = T,
             ellipse.type = "euclid",
             ggtheme = theme())
fviz_cluster(km.res, data = df, palette = "jco",#same as previous
             ggtheme = theme_minimal())
#see means of all variables clusterwise in normz data and org data
rawdata <- USArrests
km.res$cluster
list(km.res$cluster)
aggregate(rawdata,list(cluster=km.res$cluster),mean)#vecotr wont work so made list
aggregate(df,list(km.res$cluster),mean) #or use km.res , it will give same
#adding membership to original data
df_km <- cbind(USArrests,clustertype=km.res$cluster)
head(df_km)
View(df_km)


#----2.Hierarchical Clustering using ward method----
#visual asses by dist matrix by taking all rows from scaled data
res.dist <- dist(df,method="euclidean") #df is scaled data, mention dist matrix method
head(res.dist)
round(as.matrix(res.dist)[1:3,1:3],1)
fviz_dist(res.dist)

#optimal cluster is same as K means but FUN=hcut .

fviz_nbclust(df, FUN = hcut, method = "wss")+
  geom_vline(xintercept = 4, linetype = 5,col="red")+
  labs(subtitle = "Elbow method")#elbow

fviz_nbclust(df, FUN = hcut, method = "silhouette")#silhoutee

gap_stat <- clusGap(df, FUN = hcut, nstart = 25, K.max = 10, B = 500)#gapstat
fviz_gap_stat(gap_stat)
#Elbow 4, sil 2, gap 3.. Chose elbow method

#ward method(note: i think previous Kmeans has no specific method)
res.hc <- hclust(res.dist,method = 'ward.D2')#compute1
res.hc1 <- hclust(dist(df),  method = "ward.D2")#compute2
res.hc
res.hc1
fviz_dend(res.hc, cex = 0.5, k = 4) # Visualize
fviz_dend(res.hc, cex = 0.5, k = 4,
          k_colors = c('#2e9fdf','#00afbb','#e7b800','#fc4e07'),
          color_labels_by_k = T,
          rect=T)# Visualize 2
          
#more beautiful visualize
grp <- cutree(res.hc,k=4)#membership
grp
head(grp)
table(grp)
list(data=df,cluster=grp)
fviz_cluster(list(data=df,cluster=grp),
             palette=c('#2e9fdf','#00afbb','#e7b800','#fc4e07'),
             ellipse = T,
             ellipse.type = 'convex',
             repel = T,
             show.clust.cent = F,
             ggtheme = theme_classic())

#see means of all variables clusterwise in normz data and org data
rawdata1 <- USArrests
grp
list(grp)
aggregate(rawdata,list(cluster=grp),mean)#vecotr wont work so made list
aggregate(df,list(grp),mean) #or use km.res , it will give same
#adding membership to original data
df_hc <- cbind(USArrests,clustertype=grp)
head(df_hc)
View(df_hc)


#comparison kmeans and hclust
df_hc
df_hc$clustertype
df_km$clustertype
table(df_hc$clustertype,df_km$clustertype)
#km has 4 clusters of 13,16,13,8 and HC has 4 clusters of 12,19,12,7

library(dplyr)
filter(df_hc,df_hc$clustertype==2)
filter(df_km,df_km$clustertype==4) #values in cluster are almost same,cluster number not matters.

filter(df_hc,df_hc$clustertype==1)
filter(df_km,df_km$clustertype==1)



fviz_cluster(list(cluster=grp, data = df), palette = "jco",ggtheme = theme_classic())#list only wrks
             
             
fviz_cluster(km.res, data = df, palette = "jco",ggtheme = theme_minimal())
             


             



























