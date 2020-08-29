# -*- coding: utf-8 -*-
"""
Created on Tue Jul 21 11:43:20 2020

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

#Data Prep
train=pd.read_csv('D:/Data Science/Dr Vinod Python/Project 2 - Property Price/Property_Price_Train.csv')
test=pd.read_csv('D:/Data Science/Dr Vinod Python/Project 2 - Property Price/Property_Price_Test.csv')
train.columns
# check out the size of the data
print("Train data shape:", train.shape)
print("Test data shape:", test.shape)
print(train.head())
plt.style.use(style='ggplot')
plt.rcParams['figure.figsize'] = (10, 6)
# Explore the data         
print (train.Sale_Price.describe())
print ("Skew is:", train.Sale_Price.skew())
plt.hist(train.Sale_Price, color='blue')
plt.show()
target = np.log(train.Sale_Price)
print ("\n Skew is:", target.skew())
plt.hist(target, color='blue')
plt.show()
#missing values
df=pd.concat([train.drop('Sale_Price',1),test],axis=0)
df.shape
df.head()
sns.heatmap(df.isnull(),yticklabels=False,cbar=False)
df.isnull().sum()



df_obj=df.select_dtypes(include='object')
df_obj.shape
df_obj.isnull().sum()
obj_cols=df.select_dtypes(include='object').columns
obj_cols.shape
df_obj['Sale_Type']=df_obj['Sale_Type'].fillna(df_obj['Sale_Type'].mode()[0])
df_obj['Functional_Rate']=df_obj['Functional_Rate'].fillna(df_obj['Functional_Rate'].mode()[0])
df_obj['Brick_Veneer_Type']=df_obj['Brick_Veneer_Type'].fillna(df_obj['Brick_Veneer_Type'].mode()[0])
df_obj['Exterior2nd']=df_obj['Exterior2nd'].fillna(df_obj['Exterior2nd'].mode()[0])
df_obj['Exterior1st']=df_obj['Exterior1st'].fillna(df_obj['Exterior1st'].mode()[0])
df_obj['Zoning_Class']=df_obj['Zoning_Class'].fillna(df_obj['Zoning_Class'].mode()[0])
df_obj['Utility_Type']=df_obj['Utility_Type'].fillna(df_obj['Utility_Type'].mode()[0])
none=['Miscellaneous_Feature','Fence_Quality','Pool_Quality',
      'Garage_Condition','Garage_Quality','Garage_Finish_Year','Garage',
      'Fireplace_Quality','Kitchen_Quality','Electrical_System','BsmtFinType2',
      'BsmtFinType1','Exposure_Level','Basement_Condition','Basement_Height',
      'Lane_Type']
for col in none:
    df_obj[col]=df_obj[col].fillna('None')
df_obj.isnull().sum()
sns.heatmap(df_obj.isnull(),yticklabels=False,cbar=False)


df_num=df.select_dtypes(exclude='object')
df_num.shape
num_cols=df.select_dtypes(exclude='object').columns
df_num.isnull().sum()
for col in num_cols:
    df_num[col]=df_num[col].fillna(df_num[col].mean())
sns.heatmap(df_num.isnull(),yticklabels=False,cbar=False)

#encoding cat cols
df_obj.head()
obj_cols
copy_obj=df_obj.copy()

df_obj_dum=pd.get_dummies(df_obj,drop_first=True)
   
df_obj_dum.shape
df_obj_dum =df_obj_dum.iloc[:,~df_obj_dum.columns.duplicated()]
df_obj_dum.shape
df_obj_dum.head()

df_final=pd.concat([df_num,df_obj_dum],axis=1)
df_final.shape
df_final.head()
df_final=df_final.drop(['Id'],axis=1)
df_Train=df_final.iloc[:1459,:]
df_Test=df_final.iloc[1459:,:]
df_Train.shape,df_Test.shape

#train ,test split
X=df_Train
y=target
X.shape, y.shape
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(
                          X, y, random_state=42, test_size=.3)
X_train.shape, X_test.shape, y_train.shape, y_test.shape


#corr features
corr = train.corr()
print (corr['Sale_Price'].sort_values(ascending=False)[:5], '\n')
print (corr['Sale_Price'].sort_values(ascending=False)[-5:])

#modelling

#linearModel
from sklearn import linear_model
lin=linear_model.LinearRegression()
model1=lin.fit(X_train,y_train)
model1.score(X_train, y_train) #train R2

pred=model1.predict(X_test)
model1.score(X_test, y_test)
from sklearn.metrics import mean_squared_error
mse=mean_squared_error(y_test, pred)
mse
rmse=np.sqrt(mse)
rmse


# org_pred=pd.DataFrame(list(np.exp(pred)))
# train.shape
# org_SP=train.loc[1021:, ['Sale_Price']]
# org_SP.head()
# org_pred.head()
# mse1=mean_squared_error(org_SP, org_pred)
# mse1
# rmse1=np.sqrt(mse)
# rmse1

actual_values = y_test
plt.scatter(pred, actual_values, alpha=.7,
            color='b') #alpha helps to show overlapping data
plt.xlabel('Predicted Price')
plt.ylabel('Actual Price')
plt.title('Linear Regression Model')
plt.show()

























#KN rough work----
# features_nan=[feature for feature in dataset.columns if dataset[feature].isnull().sum()>1 and dataset[feature].dtypes=='O']

# for feature in features_nan:
#     print("{}: {}% missing values".format(feature,np.round(dataset[feature].isnull().mean(),4)))
## Replace missing value with a new label
# def replace_cat_feature(dataset,features_nan):
#     data=dataset.copy()
#     data[features_nan]=data[features_nan].fillna('Missing')
#     return data

# dataset=replace_cat_feature(dataset,features_nan)

# dataset[features_nan].isnull().sum()
# numerical_with_nan=[feature for feature in dataset.columns if dataset[feature].isnull().sum()>1 and dataset[feature].dtypes!='O']

# ## We will print the numerical nan variables and percentage of missing values

# for feature in numerical_with_nan:
#     print("{}: {}% missing value".format(feature,np.around(dataset[feature].isnull().mean(),4)))
## Replacing the numerical Missing Values

# for feature in numerical_with_nan:
#     ## We will replace by using median since there are outliers
#     median_value=dataset[feature].median()
    
#     ## create a new feature to capture nan values
#     dataset[feature+'nan']=np.where(dataset[feature].isnull(),1,0)
#     dataset[feature].fillna(median_value,inplace=True)
    
# dataset[numerical_with_nan].isnull().sum()

#label encode
# for feature in categorical_features:
#     labels_ordered=dataset.groupby([feature])['SalePrice'].mean().sort_values().index
#     labels_ordered={k:i for i,k in enumerate(labels_ordered,0)}
#     dataset[feature]=dataset[feature].map(labels_ordered)

#NOTES------

# # fig, ax = plt.subplots()
# # ax.scatter(x = train['Grade_Living_Area'], y = train['Sale_Price'], color = "red")
# # plt.ylabel('Sale_Price', fontsize=13)
# # plt.xlabel('Grade_Living_Area', fontsize=13)
# # plt.show()

# y = train['Sale_Price']
# plt.title('Sale_Price')
# #y.plot.hist(COLOR = "green", bins = 20, ec = "black")
# plt.hist(y,COLOR = "blue", bins = 20, ec = "black")
# plt.show()
# #normalize target variable
# y = np.log1p(y)
# plt.title('Log Sale_Price')
# plt.hist(y,COLOR = "blue", bins = 20, ec = "black")
# plt.show()


# #missing data in train and test
# train.isnull().sum()
# len(train)
# len(train.index)
# missing_train=train.isnull().sum()/len(train)*100
# missing_train = missing_train[missing_train > 0]
# missing_train.sort_values(inplace=True)
# # plt.xlabel("Column Name")
# # plt.ylabel("Percentage Missing")
# # plt.title("Percentage Missing in Train Data")
# # missing_train.plot.bar(width= .5,color = "red",figsize =(12,4))
# len(missing_train)
# sns.barplot(x=missing_train.index, y =missing_train)

# missing_test=test.isnull().sum()/len(test)*100
# missing_test = missing_test[missing_test > 0]
# missing_test.sort_values(inplace=True)
# len(missing_test)
# sns.barplot(x=missing_test.index, y =missing_test)


# #Feature Engg
# train_ID = train['Id']
# test_ID = test['Id']
# train.drop("Id", axis = 1, inplace = True)
# test.drop("Id", axis = 1, inplace = True)
# #drop traget 
# train = train.drop('Sale_Price', axis=1)
# #concat both for feature engineering
# train_num = len(train)
# concat = pd.concat(objs=[train, test], axis=0)
# concat.shape

# #Fill NAs 
# #data description says NA means typical
# concat["Functional_Rate"] = concat["Functional_Rate"].fillna("Typ")

# for col in ("Lane_Type","Basement_Height","Basement_Condition","Exposure_Level","BsmtFinType1","BsmtFinType2","Fence_Quality","Fireplace_Quality",
#             "Garage","Garage_Finish_Year","Garage_Quality","Garage_Condition","Brick_Veneer_Type","Miscellaneous_Feature","Pool_Quality",'Zoning_Class'):
#     concat[col] = concat[col].fillna("None")

# for col in ("Miscellaneous_Value","Pool_Area",'Total_Basement_Area',"BsmtFinSF1","BsmtFinSF2", "Underground_Half_Bathroom",
#             "Underground_Full_Bathroom","BsmtUnfSF","Brick_Veneer_Area","Functional_Rate","Garage_Built_Year", "Garage_Area","Garage_Size"):
#     concat[col] = concat[col].fillna(0)
    
# #Group by neighborhood and fill in missing value by the median LotFrontage of all the neighborhood
# concat["Lot_Extent"] = concat.groupby("Neighborhood")["Lot_Extent"].transform(
#     lambda x: x.fillna(x.median()))

# for col in ('Electrical_System','Kitchen_Quality','Zoning_Class', 'Exterior1st','Exterior2nd','Sale_Type'):
#     concat[col] = concat[col].fillna(concat[col].mode()[0])
    
#     concat = concat.drop(['Utility_Type'], axis=1)

# concat_na=concat.isnull().sum()/len(concat)*100
# concat_na = concat_na[concat_na>0]
# concat_na

# #num to cat conversion
# concat['Building_Class'] = concat['Building_Class'].apply(str)
# concat['House_Condition'] = concat['House_Condition'].astype(str)
# concat['Overall_Material'] = concat['Overall_Material'].astype(str)
# concat['Year_Sold'] = concat['Year_Sold'].astype(str)
# concat['Month_Sold'] = concat['Month_Sold'].astype(str)
# concat.info()
# cat_feats = concat.dtypes[concat.dtypes == "object"].index
# cat_feats.shape

# #label encoding
# from sklearn.preprocessing import LabelEncoder

# cols = ('Fireplace_Quality', 'Basement_Height', 'Basement_Condition', 'Garage_Quality', 'Garage_Condition', 
#         'Exterior_Material', 'Exterior_Condition','Heating_Quality', 'Pool_Quality', 'Kitchen_Quality', 'BsmtFinType1', 
#         'BsmtFinType2', 'Functional_Rate', 'Fence_Quality', 'Exposure_Level', 'Garage_Finish_Year', 'Land_Outline',
#         'Property_Shape', 'Pavedd_Drive', 'Road_Type', 'Lane_Type', 'Air_Conditioning', 'Building_Class', 'House_Condition', 
#         'Year_Sold', 'Month_Sold')
# # process columns, apply LabelEncoder to categorical features
# for col in cols:
#     lbl = LabelEncoder() 
#     lbl.fit(list(concat[col].values)) 
#     concat[col] = lbl.transform(list(concat[col].values))

# # shape        
# print('Shape all_data: {}'.format(concat.shape))

# # Adding total sqfootage feature 
# #concat['TotalSF'] = concat['TotalBsmtSF'] + concat['1stFlrSF'] + concat['2ndFlrSF']


# #log transform skewed numeric features:
# numeric_feats = concat.dtypes[concat.dtypes != "object"].index

# skewed_feats = concat[numeric_feats].apply(lambda x: skew(x.dropna())) #compute skewness
# skewed_feats = skewed_feats[abs(skewed_feats) > 0.75]
# skewed_feats = skewed_feats.index
# concat[skewed_feats] = np.log1p(concat[skewed_feats])
# len(skewed_feats)

# #dummies
# concat= pd.get_dummies(concat)
# print(concat.shape)

# #train and test
# train = concat[:train_num]
# test = concat[train_num:]

# print(train.shape)
# print(test.shape)
















