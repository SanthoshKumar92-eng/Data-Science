# -*- coding: utf-8 -*-
"""
Created on Sat Aug  1 08:23:10 2020

@author: LENOVO
"""
#libraries
import numpy as np
import pandas as pd
import seaborn as sns
import pylab as pl
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

from sklearn.metrics import confusion_matrix
from sklearn.metrics import roc_auc_score,roc_curve,auc
from sklearn.metrics import classification_report
#!pip install graphviz
import graphviz

#Data Prep
data=pd.read_csv('D:/Data Science/Dr Vinod Python/Project 3 - Bank loan/Bankloan1.csv')
data.default.value_counts()
data.head()
data.info()

data=data.iloc[:,[0,4,6,7,8]]
data.shape
data.info()

X=data.iloc[:,[0,1,2,3]]
X.info()
y=data.iloc[:,4] #series
y.head()

from sklearn.model_selection import train_test_split
X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.4,random_state=123)
X_train.shape,X_test.shape,y_train.shape,y_test.shape

trn=y_train.value_counts()
trn
109/311
sns.countplot(y_train)
trn.plot.bar(color=('g','r'),alpha=0.9)

tst=y_test.value_counts()
tst
74/206
sns.countplot(y_test)
tst.plot.bar(color=('g','r'),alpha=0.9)

#model
from sklearn.tree import DecisionTreeClassifier
clf=tree.DecisionTreeClassifier()
model1=clf.fit(X_train,y_train)
model1

#graphviz plot
# dot_data=tree.export_graphviz(model1,                    
#                      filled = True)
# graph = graphviz.Source(dot_data) 
# graph.render("bank")
# from IPython.display import display
# display(graphviz.Source(tree.export_graphviz(model1)))

# C:\Users\LENOVO\anaconda3\Lib\site-packages\graphviz
# os.environ["PATH"] += os.pathsep + 'D:/Program Files (x86)/Graphviz2.38/bin/
#tree.plot_tree(model1)
# from sklearn import tree
# tree.plot_tree(model1)



y_predict=model1.predict(X_test)
ct=pd.crosstab(y_test,y_predict,rownames=['Actual'],colnames=['Predicted'])
ct

confusion_matrix(y_test,y_predict)
classification_report(y_test,y_predict)

#roc,auc
from sklearn import metrics
pred_prob=model1.predict_proba(X_test)[:,1]

fpr,tpr,thresholds=metrics.roc_curve(y_test,pred_prob)
d=pd.DataFrame(dict(fpr=fpr,tpr=tpr))

auc=auc(fpr,tpr)
auc

def plot_roc_curve(fpr, tpr,auc):
    plt.plot(fpr, tpr, color='orange', label='AUC %f'%auc)
    plt.plot([0, 1], [0, 1], color='darkblue', linestyle='--')
    plt.xlabel('False Positive Rate')
    plt.ylabel('True Positive Rate')
    plt.title('Receiver Operating Characteristic (ROC) Curve')
    plt.legend()
    plt.show()
    
plot_roc_curve(fpr,tpr,auc)

#pruning DT------------
from sklearn.tree import export_graphviz
!pip install pydotplus
import pydotplus
from IPython.display import display
pi=pd.read_csv('D:/Data Science/Dr Vinod Python/Project 3 - Bank loan/Bankloan1.csv')
pi.shape
#train,test
feat_cols=[feature for feature in pi.columns if feature not in ['default']]
y=pi.default
X=pi[feat_cols]
X.shape,y.shape
X.head()
y.head()
X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.3,random_state=1)
X_train.shape,X_test.shape,y_train.shape,y_test.shape
#model
clf=DecisionTreeClassifier()
model2=clf.fit(X_train,y_train)
y_pred=model2.predict(X_test)

ct=pd.crosstab(y_test,y_pred,margins=True,rownames=['Actual'],colnames=['Predicted'])
ct
confusion_matrix(y_test,y_pred)
classification_report(y_test,y_pred)
#probabality
from sklearn import metrics
from sklearn.metrics import auc
y_prob=model2.predict_proba(X_test)[:,1]
fpr,tpr,thresholds=metrics.roc_curve(y_test,y_prob)
d=pd.DataFrame(dict(fpr=fpr,tpr=tpr))
auc=auc(fpr,tpr)
auc

def plot_roc_curve(fpr, tpr,auc):
    plt.plot(fpr, tpr, color='orange', label='AUC %f'%auc)
    plt.plot([0, 1], [0, 1], color='darkblue', linestyle='--')
    plt.xlabel('False Positive Rate')
    plt.ylabel('True Positive Rate')
    plt.title('Receiver Operating Characteristic (ROC) Curve')
    plt.legend()
    plt.show()
    
plot_roc_curve(fpr,tpr,auc)
#lets prune
clf1=DecisionTreeClassifier(criterion='entropy',max_depth=3)
clf1=clf1.fit(X_train,y_train)
y_pred1=clf1.predict(X_test)
metrics.accuracy_score(y_test,y_pred1)
 #graphviz prined tree

#auc,roc
y_prob=clf1.predict_proba(X_test)[:,1]
fpr,tpr,thresholds=metrics.roc_curve(y_test,y_prob)
d=pd.DataFrame(dict(fpr=fpr,tpr=tpr))
from sklearn import metrics
from sklearn.metrics import auc
auc=auc(fpr,tpr)
auc
plot_roc_curve(fpr,tpr,auc)

#Bagging--------------
from sklearn.ensemble import BaggingClassifier
from sklearn.ensemble import BaggingRegressor
from sklearn.tree import DecisionTreeRegressor

data=pd.read_csv('D:/Data Science/Dr Vinod Python/Project 3 - Bank loan/Bankloan1.csv')
data.shape
data.head()

X=data.iloc[:,:-1]
y=data.iloc[:,-1]
X.shape,y.shape

 from sklearn.model_selection import train_test_split
X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.3,random_state=1)
X_train.shape,X_test.shape,y_train.shape,y_test.shape

#build DT and then Bagging Clf
dt=DecisionTreeClassifier(max_depth=4,min_samples_leaf=1,random_state=1)
bc=BaggingClassifier(base_estimator=dt,n_estimators=100,oob_score=True,n_jobs=1)
bc.fit(X_train,y_train)
y_predB=bc.predict(X_test)

ct=pd.crosstab(y_test,y_predB,margins=True,rownames=['Actual'],colnames=['Predicted'])
ct
confusion_matrix(y_test,y_predB)
classification_report(y_test,y_predB)


predpB=bc.predict_proba(X_test)[:,1]
predpB

fpr,tpr,thresholds=metrics.roc_curve(y_test,predpB)
d=pd.DataFrame(dict(fpr=fpr,tpr=tpr))
from sklearn import metrics
from sklearn.metrics import auc
auc=auc(fpr,tpr)
auc
plot_roc_curve(fpr,tpr,auc)

# print OOB results
oob_acc=bc.oob_score_
oob_acc


#Random forest-----------
data=pd.read_csv('D:/Data Science/Dr Vinod Python/Project 3 - Bank loan/Bankloan1.csv')
data.shape
data.head()

X=data.iloc[:,:-1]
y=data.iloc[:,-1]
X.shape,y.shape

from sklearn.model_selection import train_test_split
X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.2,random_state=1)
X_train.shape,X_test.shape,y_train.shape,y_test.shape

from sklearn.preprocessing import StandardScaler
X_train=StandardScaler().fit_transform(X_train)
X_test=StandardScaler().fit_transform(X_test)

from sklearn.ensemble import RandomForestClassifier
rf=RandomForestClassifier(n_estimators=20,random_state=0)
rf.fit(X_train,y_train)
y_pred_rf=rf.predict(X_test)

from sklearn.metrics import classification_report,confusion_matrix,accuracy_score
confusion_matrix(y_test,y_pred_rf)
classification_report(y_test,y_pred_rf)
accuracy_score(y_test,y_pred_rf)















