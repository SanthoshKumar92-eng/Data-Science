# -*- coding: utf-8 -*-
"""
Created on Sun Jul 19 08:33:32 2020

@author: Santhosh
"""
import os
#os.chdir("D:/Data Science/Dr Vinod Python/Basics")

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from scipy import stats
import statsmodels.api as sm
from statsmodels.formula.api import ols

cs2m=pd.read_csv("D:/Data Science/Dr Vinod Python/Basics/cs2m.csv")
cs2m=pd.DataFrame(cs2m)
grades=pd.read_csv("D:/Data Science/Dr Vinod Python/Basics/grades.csv")
grades=pd.DataFrame(grades)

cs2m.shape
grades.shape

len(cs2m.BP)
len(grades.final)
grades.firstname.unique()
grades.firstname.unique().shape

grades.quiz1.head()
grades.quiz1
grades.quiz1.dtype
grades['quiz1'].dtype #same
cs2m.info()
grades.info()

cs2m.describe()
grades.describe()

cs2m.Age.describe()
cs2m['Age'].describe()

cs2m.Age.groupby(cs2m.Prgnt).describe()

grades.ethnicity.value_counts()

grades.final.min()
grades.final.max()
grades.final.sum()
grades.final.std()
grades.final.skew()
grades.final.kurtosis()
round(grades.final.kurt(),2)

from scipy.stats import sem
grades.final.sem()
round(grades.final.sem(),4)

cs2m.skew()
grades.std() #only numeric considered

cs2m.head(3)
cs2m.tail(3)


#Histogram--------

plt.hist(grades.total)
plt.hist(grades.total,bins='auto')

#run together
plt.hist(grades.total,bins='auto',facecolor='red')
plt.xlabel("Total")
plt.ylabel("Counts")
plt.title("Histogram")

grades.hist("total") #matplotlib has grids

#boxplot-----

cs2m.boxplot('BP')



#Data Manipulation----

grades.columns
#grades.ix[: , 0:4].head(3) #ix is indexing , all rows,0 to 3 columns
grades.iloc[: , 0:4].head(3) #ix not working for DF

#showing row 21 to 23 and col 1 to 3 (index strts at 0)
grades.iloc[20:23 , 0:4].head(3) #last index will be omitted

cs2m1=cs2m[0:12] #actually 13th row will be omited, all columns
cs2m1


#random sample
from random import sample
cs2m.sample(frac=0.3,replace=False,random_state=123)
sp=cs2m.sample(10,random_state=21)
sp

#selecting choiced vars
cs2m.ix[:,(1,3,5)].head(3)

a=grades[['quiz1','gpa','final']]
a.head()
#which...compress
cs2m.BP.cpmpress((cs2m.BP==170))

#all rows BP>140
cs2m_BP=cs2m[cs2m.BP>140]
cs2m_BP
cs2mDrug=cs2m[cs2m.DrugR==1]
cs2mDrug

grades3=grades[grades.ethnicity==3]
grades5=grades[grades.ethnicity==5]
grades35=pd.concat([grades3,grades5])
len(grades35)

#new var
cs2m['AgeLH']=np.where(cs2m['Age']<32,'L','H')
cs2m.head()

cs2mdrop=cs2m.drop(['Age','BP'],1)
cs2mdrop.head()

#stats
cs2m.Age.groupby(cs2m.Prgnt).mean()
cs2m.Age.groupby(cs2m.Prgnt).median()
cs2m.Age.groupby(cs2m.Prgnt).describe()

import seaborn as sns
sns.pairplot(cs2m)
sns.pairplot(cs2m,hue='Prgnt')

#interesting stat
#cont vs 1 cat
m=cs2m.groupby(cs2m.Prgnt)
m=m['Age']
m.mean()
m.describe()
#cont vs 2 cat
k=cs2m.groupby(['Prgnt','DrugR'])
k=k['Age']
k.mean()
k.describe()

#dtype conversion
a=cs2m
a.info()
a['Prgnt']=a['Prgnt'].astype('category')
a.info()
a.shape
a['Age']=a['Age'].astype('float')
a.info()
a['Age']=a['Age'].astype('int64')
a.info()

#IQR and Quantiles
stats.iqr(cs2m.Age)
cs2m.Age.quantile(0.25)
cs2m.Age.quantile(0.75)
cs2m.Age.quantile(0.5)
#cross tab(Margin true gives total)
pd.crosstab(grades.ethnicity,grades.gender,margins='T')

#export
j=grades.sample(20)
j.head()
j.to_csv('j.csv')

#string is immutable

string='I am Learning Python'
len(string)
string[len(string)-1]
string[-2] #negative means from last
string[-4]
string[4]
string[2]
string[0:3] #index 3 not included
string[3:6]
string[:4]
string[17:]
a="all is well"
b='A'+a[1:]
b
tuple=(7,'Lucky','Excellent',5.5)
len(tuple)
tuple[0]
tuple[4]
tuple[0:4]# 4 excluded 

#sorted tpl is a list
tuple1=(11,33,22,44)
tuple2=sorted(tuple1)
tuple2
isinstance(tuple2,tuple)
isinstance(tuple2,list)

#list
#alias and clone is diff in list
a=[1,2,3,4]
b=a #alias, any chane in a reflect in b
a[0]=500
b

a=[1,2,3,4]
b=a[:] #clone , any change in a dont reflect in b
a[0]=500
b

#dict, key value pair
d={'a':1,'b':2,'c':3,'d':4}
d.keys()
d.values()
d.items()
d.popitem()#remove last item and show, original changed


#set,no order,no indexing
a={1,2,3,4}
b={3,4,5,6}
#union
a|b
#intersection
a&b
#diff
a-b
b-a
#symetrical diff
a^b 
b^a


#visualisation 

sns.pairplot(cs2m)
sns.pairplot(cs2m,vars=['Age','BP'],kind='reg')
sns.pairplot(cs2m,vars=['Age','BP'],kind='scatter')
sns.jointplot(x=cs2m['Age'],y=cs2m['BP'],kind='scatter')
sns.regplot(x=cs2m['Age'],y=cs2m['BP'])
sns.heatmap(cs2m,annot=True,annot_kws={'size':5})
cor=cs2m.corr()
cor
sns.heatmap(cor,xticklabels=cor.columns.values,
            yticklabels=cor.columns.values,
            annot=True)

sns.clustermap(cs2m)
sns.clustermap(cs2m,metric='correlation',method='single',
               standard_scale=1,annot=True,
               cmap='Blues')


grades.ethnicity.value_counts()
#horz barplot
sns.countplot(data=cs2m,y='AnxtyLH')
sns.countplot(data=cs2m,y='AnxtyLH',hue='Prgnt')
sns.countplot(data=cs2m,y='AnxtyLH',hue='DrugR')
#vert barplot
sns.countplot(data=cs2m,x='AnxtyLH')
sns.countplot(data=cs2m,x='AnxtyLH',hue='Prgnt')
sns.countplot(data=cs2m,x='AnxtyLH',hue='DrugR')


#hyp test(1sam,2sam rel,2sam ind,chi sq)
import scipy
onesam=scipy.stats.ttest_1samp(a=cs2m.Age,popmean=40)
onesam #ho : Hyp mean population of age is 40

paired=scipy.stats.ttest_rel(grades.quiz1,grades.quiz2)
paired#ho: mu of quiz1 - mu of quiz2 = 0 

cs2m.shape
cs2mAnxL=cs2m[cs2m.AnxtyLH==0]
cs2mAnxL.shape
cs2mAnxH=cs2m[cs2m.AnxtyLH==1]
cs2mAnxH.shape
ind=scipy.stats.ttest_ind(cs2mAnxL.BP,cs2mAnxH.BP)
ind #h0: pop mean of BP across Anxty levels are same

#one way anova
#use sales-city data

 #chi sq test
#Do crosstab, make array and then do chi sq test























