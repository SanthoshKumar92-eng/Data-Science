# -*- coding: utf-8 -*-
"""
Created on Sun Jul 26 10:53:03 2020

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
from sklearn.preprocessing import normalize
df=pd.read_csv('Wholesale customers data.csv')
df.head()
dfscaled=normalize(df)
dfscaled.dtype
dfscaled=pd.DataFrame(dfscaled,columns=df.columns)
dfscaled.info()

import scipy.cluster.hierarchy as shc
link=shc.linkage(dfscaled,method='ward')
link
dend=shc.dendrogram(link)
#plot

plt.figure(figsize=(10, 7))  
plt.title("Dendrograms")  
dend = shc.dendrogram(shc.linkage(dfscaled, method='ward'))
plt.axhline(y=6, color='r', linestyle='--')


from sklearn.cluster import AgglomerativeClustering
cluster=AgglomerativeClustering(n_clusters=2, affinity='euclidean',linkage='ward')
clusters=cluster.fit_predict(dfscaled)
dfscaled.columns
#cluster.labels_

dfscaled['clusters']=clusters
dfscaled.head()


sns.scatterplot(dfscaled['Milk'],dfscaled['Grocery'],hue=dfscaled['clusters'])



























