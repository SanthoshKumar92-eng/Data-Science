# -*- coding: utf-8 -*-
"""
Created on Wed Jul 22 10:02:15 2020

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
from sklearn.metrics import accuracy_score
from sklearn.metrics import roc_auc_score,roc_curve,auc
from sklearn.metrics import classification_report
#!pip install graphviz
#import graphviz

#Data Prep
bank=pd.read_csv('D:/Data Science/Dr Vinod Python/Project 3 - Bank loan/Bankloan1.csv')
bank.default.value_counts()
bank.head()
bank.info()
sns.pairplot(bank)

#scaling
from sklearn.preprocessing import MinMaxScaler
scaler=MinMaxScaler()
bank_scaled=pd.DataFrame(scaler.fit_transform(bank),columns=bank.columns)
bank_scaled.head()
bank_scaled=bank_scaled.drop('default',1)

#train test split
X=bank_scaled.copy()
y=bank['default']
X.shape,y.shape
X.columns
from sklearn.model_selection import train_test_split
X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.3,random_state=123)
X_train.shape,X_test.shape,y_train.shape,y_test.shape
X_train.head()

#modelling
#1.Logistic
from sklearn.linear_model import LogisticRegression
log=LogisticRegression()
model1=log.fit(X_train,y_train)

model1.coef_ #co efficients
model1.intercept_ #intercept

predict_train = model1.predict(X_train)
print('Target on train data',predict_train) 
from sklearn.metrics import accuracy_score
accuracy_train = accuracy_score(y_train,predict_train)
print('accuracy_score on train dataset : ', accuracy_train)
predict_test = model1.predict(X_test)
predict_test
accuracy_test = accuracy_score(y_test,predict_test)
accuracy_test

#2.Decision Trees
from sklearn.tree import DecisionTreeClassifier
tree=DecisionTreeClassifier()
model2=tree.fit(X_train,y_train)

model2.get_depth()
model2.get_n_leaves()
model2.get_params()

predict_train=model2.predict(X_train)
predict_train
accuracy_train=accuracy_score(y_train,predict_train)
accuracy_train
predict_test=model2.predict(X_test)
predict_test
accuracy_test=accuracy_score(y_test,predict_test)
accuracy_test

#3.KNN Classifier
#Data Prep
bank=pd.read_csv('D:/Data Science/Dr Vinod Python/Project 3 - Bank loan/Bankloan1.csv')
bank.default.value_counts()
bank.head()
bank.info()
#sns.pairplot(bank)
#scaling
from sklearn.preprocessing import StandardScaler
scaler=StandardScaler()
bank_scaled=pd.DataFrame(scaler.fit_transform(bank),columns=bank.columns)
bank_scaled.head()
bank_scaled=bank_scaled.drop('default',1)

#train test split
X=bank_scaled.copy()
X.columns
X=X[['age','employ','income','debtinc','creddebt']]
X.head()
y=bank['default']
X.shape,y.shape
from sklearn.model_selection import train_test_split
X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.3,random_state=123)
X_train.shape,X_test.shape,y_train.shape,y_test.shape
X_train.head()

from sklearn.neighbors import KNeighborsClassifier
knn=KNeighborsClassifier(n_neighbors=11)
model3=knn.fit(X_train,y_train)

model3.n_neighbors

predict_train=model3.predict(X_train)
predict_train
accuracy_train=accuracy_score(y_train,predict_train)
accuracy_train
predict_test=model3.predict(X_test)
predict_test
accuracy_test=accuracy_score(y_test,predict_test)
accuracy_test
classification_report(y_test, predict_test)
pd.crosstab(y_test,predict_test,rownames=['Actual'],colnames=['Pred'])

#finetune

error_rate = []

for i in range(1,20):
 
 knn = KNeighborsClassifier(n_neighbors=i)
 knn.fit(X_train,y_train)
 pred_i = knn.predict(X_test)
 error_rate.append(np.mean(pred_i != y_test))
  

#4.Random Forest
from sklearn.ensemble import RandomForestClassifier
rf=RandomForestClassifier()
model4=rf.fit(X_train,y_train)

model4.get_params()
model4.n_estimators

predict_train=model4.predict(X_train)
predict_train
accuracy_train=accuracy_score(y_train,predict_train)
accuracy_train
predict_test=model4.predict(X_test)
predict_test
accuracy_test=accuracy_score(y_test,predict_test)
accuracy_test


#5.GBM 
from sklearn.ensemble import GradientBoostingClassifier
model5= GradientBoostingClassifier(n_estimators=100).fit(X_train,y_train)

predict_train=model5.predict(X_train)
predict_train
accuracy_train=accuracy_score(y_train,predict_train)
accuracy_train
predict_test=model5.predict(X_test)
predict_test
accuracy_test=accuracy_score(y_test,predict_test)
accuracy_test

#6.XGB
from xgboost import XGBClassifier
model6=XGBClassifier().fit(X_train,y_train)

predict_train=model6.predict(X_train)
predict_train
accuracy_train=accuracy_score(y_train,predict_train)
accuracy_train
predict_test=model6.predict(X_test)
predict_test
accuracy_test=accuracy_score(y_test,predict_test)
accuracy_test






























