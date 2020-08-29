# -*- coding: utf-8 -*-
"""
Created on Sun Aug  2 10:30:31 2020

@author: LENOVO
"""
import numpy as np
import pandas as pd
import seaborn as sns
import pylab as pl
color = sns.color_palette()
sns.set_style('darkgrid')
import matplotlib.pyplot as plt
%matplotlib inline

data=pd.read_csv('D:/Data Science/Dr Vinod Python/DT and RF/petrol_consumption.csv')
data.head()
X=data.iloc[:,0:4].values
y=data.iloc[:,4].values

from sklearn.model_selection import train_test_split
X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.2,random_state=1)
X_train.shape,X_test.shape,y_train.shape,y_test.shape

from sklearn.preprocessing import StandardScaler
X_train=StandardScaler().fit_transform(X_train)
X_test=StandardScaler().fit_transform(X_test)

#model
from sklearn.tree import DecisionTreeRegressor
reg=DecisionTreeRegressor(random_state=0)
model=reg.fit(X_train,y_train)
y_pred=model.predict(X_test)
y_test
y_pred
from sklearn import metrics
mse=metrics.mean_squared_error(y_test,y_pred)
rmse=np.sqrt(mse)
mae=metrics.mean_absolute_error(y_test,y_pred)
mae,mse,rmse

#pruning
reg1=DecisionTreeRegressor(max_depth=2,random_state=0)
reg2=DecisionTreeRegressor(max_depth=5,random_state=0)
reg3=DecisionTreeRegressor(max_depth=8,random_state=0)

m1=reg1.fit(X_train,y_train)
m2=reg2.fit(X_train,y_train)
m3=reg3.fit(X_train,y_train)

y_pred1=m1.predict(X_test)
y_pred2=m2.predict(X_test)
y_pred3=m3.predict(X_test)

mse1=metrics.mean_squared_error(y_test,y_pred1)
rmse1=np.sqrt(mse1)
mae1=metrics.mean_absolute_error(y_test,y_pred1)
mae1,mse1,rmse1

mse2=metrics.mean_squared_error(y_test,y_pred2)
rmse2=np.sqrt(mse2)
mae2=metrics.mean_absolute_error(y_test,y_pred2)
mae2,mse2,rmse2

mse3=metrics.mean_squared_error(y_test,y_pred3)
rmse3=np.sqrt(mse3)
mae3=metrics.mean_absolute_error(y_test,y_pred3)
mae3,mse3,rmse3

#plot
import numpy as np
x=np.arange(10)
x
plt.plot(x,y_test,lw=5)
plt.plot(x,y_pred)
plt.plot(x,y_pred1)
plt.plot(x,y_pred2)
plt.plot(x,y_pred3)
plt.legend(['ytest','ypred','ypred1','ypred2','ypred3'],loc='upper left')
plt.show()

#Bagging(First build reg tree and use that as base for bagging)
from sklearn.tree import DecisionTreeRegressor
rt=DecisionTreeRegressor(random_state=0)
model=rt.fit(X_train,y_train)
y_pred=model.predict(X_test)

from sklearn import metrics
mse=metrics.mean_squared_error(y_test,y_pred)
rmse=np.sqrt(mse)
mae=metrics.mean_absolute_error(y_test,y_pred)
mae,mse,rmse

from sklearn.ensemble import BaggingRegressor
br=BaggingRegressor(base_estimator=rt,n_estimators=300,oob_score=True,n_jobs=1,random_state=0)
br.fit(X_train,y_train)
y_pred_bag=br.predict(X_test)

mse=metrics.mean_squared_error(y_test,y_pred_bag)
rmse=np.sqrt(mse)
mae=metrics.mean_absolute_error(y_test,y_pred_bag)
mae,mse,rmse

#plot
import numpy as np
x=np.arange(10)
x
plt.plot(x,y_test,lw=5)
plt.plot(x,y_pred_bag)
plt.legend(['ytest','ypredbag'],loc='upper left')
plt.show()

#Random Forest---------

# data=pd.read_csv('D:/Data Science/Dr Vinod Python/DT and RF/petrol_consumption.csv')
# data.head()
# X=data.iloc[:,0:4].values
# y=data.iloc[:,4].values

#   from sklearn.model_selection import train_test_split
# X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.2,random_state=1)
# X_train.shape,X_test.shape,y_train.shape,y_test.shape

# from sklearn.preprocessing import StandardScaler
# X_train=StandardScaler().fit_transform(X_train)
# X_test=StandardScaler().fit_transform(X_test)

from sklearn.ensemble import RandomForestRegressor
reg20= RandomForestRegressor(n_estimators=20,random_state=0) #20 trees
reg20.fit(X_train,y_train)
y_pred20=reg20.predict(X_test)
y_test

mse=metrics.mean_squared_error(y_test,y_pred20)
rmse=np.sqrt(mse)
mae=metrics.mean_absolute_error(y_test,y_pred20)
mae,mse,rmse #46 rmse

reg200= RandomForestRegressor(n_estimators=200,random_state=0) #200 trees
reg200.fit(X_train,y_train)
y_pred200=reg200.predict(X_test)

mse=metrics.mean_squared_error(y_test,y_pred200)
rmse=np.sqrt(mse)
mae=metrics.mean_absolute_error(y_test,y_pred200)
mae,mse,rmse #44 rmse

x=np.arange(10)
x
plt.plot(x,y_test,lw=5)
plt.plot(x,y_pred20)
plt.plot(x,y_pred200)
plt.legend(['ytest','ypred20','ypred200'],loc='upper left')
plt.show()

#linear regression-----
from sklearn.linear_model import LinearRegression
lin=LinearRegression()
lin.fit(X_train,y_train)
y_pred_lin=lin.predict(X_test)

mse=metrics.mean_squared_error(y_test,y_pred_lin)
rmse=np.sqrt(mse)
mae=metrics.mean_absolute_error(y_test,y_pred_lin)
mae,mse,rmse #58 rmse


#KNN-----------
data=pd.read_csv('D:/Data Science/Dr Vinod Python/DT and RF/petrol_consumption.csv')
data.head()
X=data.iloc[:,0:4].values
y=data.iloc[:,4].values

from sklearn.model_selection import train_test_split
X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.2,random_state=1)
X_train.shape,X_test.shape,y_train.shape,y_test.shape

from sklearn.preprocessing import StandardScaler
X_train=StandardScaler().fit_transform(X_train)
X_test=StandardScaler().fit_transform(X_test)

from sklearn.neighbors import KNeighborsRegressor
knn=KNeighborsRegressor(n_neighbors=3)
knn.fit(X_train,y_train)
y_pred=knn.predict(X_test)

mse=metrics.mean_squared_error(y_test,y_pred)
rmse=np.sqrt(mse)
mae=metrics.mean_absolute_error(y_test,y_pred)
mae,mse,rmse #51 rmse










