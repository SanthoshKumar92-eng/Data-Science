# -*- coding: utf-8 -*-
"""
Created on Sat Jul 25 20:26:10 2020

@author: LENOVO
"""
#libraries
import numpy as np
import pandas as pd
import seaborn as sns
color = sns.color_palette()
sns.set_style('darkgrid')
import matplotlib.pyplot as plt
%matplotlib inline
import warnings
def ignore_warn(*args, **kwargs):
    pass
warnings.warn = ignore_warn #ignore annoying warning (from sklearn and seaborn)
from scipy import stats
from scipy.stats import norm, skew #for some statistics
pd.set_option('display.float_format', lambda x: '{:.3f}'.format(x)) #Limiting floats output to 3 decimal points

 #data
# data=pd.DataFrame(rbicsv)
# header=data.iloc[0]
# data=data[1:]
# data.columns=header

# data=data.set_index('State')
# data.head()
# data.columns
# data.index
data=pd.read_csv('rbi.csv')
data.head()
data=data.set_index('State')
data.head()
data.columns
data.index

#EDA
data.info()
data.describe()
data.isnull().sum()

sns.pairplot(data)
cor=data.corr()
cor
sns.heatmap(cor,xticklabels=cor.columns.values,
            yticklabels=cor.columns.values,
            annot=True)
sns.heatmap(data,annot=True,annot_kws={'size':5})
sns.clustermap(data)
sns.clustermap(data,metric='correlation',method='single',
               standard_scale=1,annot=True,
               cmap='Blues')

#data[numerical].hist(bins=15, figsize=(15, 6), layout=(2, 2))
data.columns
sns.distplot(data.BirthRate)
sns.boxplot(data.BirthRate)
sns.distplot(data.MortalitityRate)
sns.boxplot(data.MortalitityRate)
sns.distplot(data.PowerAvailability)
sns.boxplot(data.PowerAvailability)
sns.distplot(data.RoadLength)
sns.boxplot(data.RoadLength)

#Cluster analysis
from sklearn.preprocessing import scale
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score
from random import sample
from scipy.spatial import distance_matrix
from scipy.spatial import distance
pip install pyclustertend
from pyclustertend import vat

sample=data.sample(frac=0.29,replace=False,random_state=123)
len(sample)
sample
DM=pd.DataFrame(distance_matrix(sample.values, sample.values), index=sample.index, columns=sample.index)
round(DM,2)
plt.plot(DM)
plt.show()
vat(sample)

#scale
datascaled=StandardScaler().fit_transform(data)
datascaled

#elbow method
# Using the elbow method to find the optimal number of clusters
#init is random or Kmeans++
wcss = []
for i in range(1, 11):
    kmeans = KMeans(n_clusters = i, init = 'random', random_state = 42)
    kmeans.fit(datascaled)
    wcss.append(kmeans.inertia_)
plt.plot(range(1, 11), wcss)
plt.title('The Elbow Method')
plt.xlabel('Number of clusters')
plt.ylabel('WCSS')
plt.show()
 
#cluster membership
kmeans=KMeans(n_clusters=4) #creating object
clusters=kmeans.fit_predict(datascaled)
clusters
final=clusters+1 #make 0,1,2,3  as 1,2,3,4
clusters=list(final)
data['clusters']=clusters
data.head()

data[data['clusters']==1]
data[data['clusters']==2]
data[data['clusters']==3]
data[data['clusters']==4]
#cluster profiling
data.groupby('clusters').mean()
#plot
sns.scatterplot(data['BirthRate'],data['MortalitityRate'],
                hue=clusters,
                palette=['green','orange','blue','red'])


















































































































