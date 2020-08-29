# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 19:16:48 2020

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


# DBSCAN Clustering function
# def dbscan(X, eps, min_samples):
#     ss = StandardScaler()
#     X = ss.fit_transform(X)
#     db = DBSCAN(eps=eps, min_samples=min_samples)
#     db.fit(X)
#     y_pred = db.fit_predict(X)
#     plt.scatter(X.iloc[:,0], X.iloc[:,1],c=y_pred, cmap='Paired')
#     plt.title("DBSCAN")

# dbscan(Xcomp,0.3,4)


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

# Plot result`
# Black removed and is used for noise instead.
# unique_labels = set(labels)
# colors = [plt.cm.Spectral(each)
#           for each in np.linspace(0, 1, len(unique_labels))]
# for k, col in zip(unique_labels, colors):
#     if k == -1:
#         # Black used for noise.
#         col = [0, 0, 0, 1]

#     class_member_mask = (labels == k)

#     xy = X[class_member_mask & core_samples_mask]
#     plt.plot(xy[:, 0], xy[:, 1], 'o', markerfacecolor=tuple(col),
#              markeredgecolor='k', markersize=14)

#     xy = X[class_member_mask & ~core_samples_mask]
#     plt.plot(xy[:, 0], xy[:, 1], 'o', markerfacecolor=tuple(col),
#              markeredgecolor='k', markersize=6)

# plt.title('Estimated number of clusters: %d' % n_clusters_)
# plt.show()
# Building the label to colour mapping 
colours = {} 
colours[0] = 'r'
colours[1] = 'g'
colours[2] = 'b'
colours[-1] = 'k'
  
# Building the colour vector for each data point 
cvec = [colours[label] for label in labels] 
  
# For the construction of the legend of the plot 
r = plt.scatter(X_principal['P1'], X_principal['P2'], color ='r'); 
g = plt.scatter(X_principal['P1'], X_principal['P2'], color ='g'); 
b = plt.scatter(X_principal['P1'], X_principal['P2'], color ='b'); 
k = plt.scatter(X_principal['P1'], X_principal['P2'], color ='k'); 
  
# Plotting P1 on the X-Axis and P2 on the Y-Axis  
# according to the colour vector defined 
plt.figure(figsize =(9, 9)) 
plt.scatter(X_principal['P1'], X_principal['P2'], c = cvec) 
  
# Building the legend 
plt.legend((r, g, b, k), ('Label 0', 'Label 1', 'Label 2', 'Label -1')) 
  
plt.show() 


#function for Cluster Analysis
#KMeans Clustering
def kmeans(X, n_clusters):
    ss = StandardScaler()
    X = ss.fit_transform(X)
    km = KMeans(n_clusters=n_clusters)
    km.fit(X)
    y_pred = km.predict(X)
    plt.scatter(X[:,0], X[:,1],c=y_pred, cmap='Paired')
    plt.title("K-means")
#heir
def hier(X, n_clusters):
    ss = StandardScaler()
    X = ss.fit_transform(X)
    hier = AgglomerativeClustering(n_clusters=n_clusters)
    y_pred = hier.fit_predict(X)
    plt.scatter(X[:,0], X[:,1],c=y_pred, cmap='Paired')
    plt.title("Hierarchical")
#3. DBSCAN Clustering
def dbscan(X, eps, min_samples):
    ss = StandardScaler()
    X = ss.fit_transform(X)
    db = DBSCAN(eps=eps, min_samples=min_samples)
    db.fit(X)
    y_pred = db.fit_predict(X)
    plt.scatter(X[:,0], X[:,1],c=y_pred, cmap='Paired')
    plt.title("DBSCAN")





















