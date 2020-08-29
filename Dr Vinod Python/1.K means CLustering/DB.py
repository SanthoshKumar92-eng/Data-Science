# -*- coding: utf-8 -*-
"""
Created on Fri Aug 21 13:37:31 2020

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

#data(RBI)
data=pd.read_csv('rbi.csv')
data.head()
data=data.set_index('State')
data.head()
data.columns
data.index
sns.pairplot(data)

#Process
from sklearn.cluster import DBSCAN 
from sklearn.preprocessing import StandardScaler 
from sklearn.preprocessing import normalize 
from sklearn.decomposition import PCA 
X=data.copy()
X.head()
Xscaled=StandardScaler().fit_transform(X) #array o/p
Xn=normalize(Xscaled) #array o/p
X=pd.DataFrame(Xn,columns=data.columns,index=data.index)
X.head()

obj=PCA(n_components=2,random_state=123)
Xcomp=obj.fit_transform(X)
Xcomp=pd.DataFrame(Xcomp, columns=['P1',"P2"],index=X.index)
Xcomp.head()

#model
model=DBSCAN(eps=0.3,min_samples=4)
fit=model.fit(Xcomp)
labels=fit.labels_
y_pred = model.fit_predict(Xcomp) #labels

#plot
  plt.scatter(Xcomp.iloc[:,0], Xcomp.iloc[:,1],c=y_pred, cmap='Paired')
  plt.title("DBSCAN")
#summary
n_clusters_ = len(set(labels)) - (1 if -1 in labels else 0)
n_noise_ = list(labels).count(-1)
print(' number of clusters: %d' % n_clusters_)
print(' number of noise points: %d' % n_noise_)
print("Silhouette Coefficient: %0.3f"% metrics.silhouette_score(Xcomp, labels))


#data(Wholesale price)
df=pd.read_csv('Wholesale customers data.csv')
df.head()
#Process
X=df.copy()
X.head()
Xscaled=StandardScaler().fit_transform(X) #array o/p
Xn=normalize(Xscaled) #array o/p
X=pd.DataFrame(Xn,columns=df.columns,index=df.index)
X.head()

obj=PCA(n_components=2,random_state=123)
Xcomp=obj.fit_transform(X)
Xcomp=pd.DataFrame(Xcomp, columns=['P1',"P2"],index=X.index)
Xcomp.head()

#model
model=DBSCAN(eps=0.12,min_samples=4)
fit=model.fit(Xcomp)
labels=fit.labels_
y_pred = model.fit_predict(Xcomp) #labels

#plot
  plt.scatter(Xcomp.iloc[:,0], Xcomp.iloc[:,1],c=y_pred, cmap='Paired')
  plt.title("DBSCAN")
#summary
n_clusters_ = len(set(labels)) - (1 if -1 in labels else 0)
n_noise_ = list(labels).count(-1)
print(' number of clusters: %d' % n_clusters_)
print(' number of noise points: %d' % n_noise_)
print("Silhouette Coefficient: %0.3f"% metrics.silhouette_score(Xcomp, labels))



#data()Bankloan
from sklearn.preprocessing import normalize
df=pd.read_csv('Bankloan1.csv')
df = df.drop('default', 1)
df.head()
dfscaled=normalize(df)
dfscaled.dtype
dfscaled=pd.DataFrame(dfscaled,columns=df.columns)
dfscaled=dfscaled.iloc[:, 3:6]
dfscaled.head()

#PCA
from sklearn.decomposition import PCA 
pca = PCA(n_components = 2) 
X_principal = pca.fit_transform(dfscaled) 
X_principal = pd.DataFrame(X_principal) 
X_principal.columns = ['P1', 'P2'] 
print(X_principal.head()) 



# Compute DBSCAN
from sklearn.cluster import DBSCAN
from sklearn import metrics
from sklearn.datasets import make_blobs
# X=dfscaled.copy()
# db = DBSCAN(eps=0.3, min_samples=16).fit(X)
# core_samples_mask = np.zeros_like(db.labels_, dtype=bool)
# core_samples_mask[db.core_sample_indices_] = True
# labels = db.labels_

# Numpy array of all the cluster labels assigned to each data point 
db_default = DBSCAN(eps = 0.0375, min_samples = 8).fit(X_principal) 
labels = db_default.labels_ 
# Number of clusters in labels, ignoring noise if present.
n_clusters_ = len(set(labels)) - (1 if -1 in labels else 0)
n_noise_ = list(labels).count(-1)
#plot
#plot
  plt.scatter(X_principal.iloc[:,0], X_principal.iloc[:,1],c=labels, cmap='Paired')
  plt.title("DBSCAN")
#summary

print(' number of clusters: %d' % n_clusters_)
print(' number of noise points: %d' % n_noise_)
print("Silhouette Coefficient: %0.3f"% metrics.silhouette_score(X_principal, labels))