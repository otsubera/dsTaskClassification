# -*- coding: utf-8 -*-
"""
Created on Wed Aug 29 

@author: Elena_Tsubera
"""

import pandas as pd
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
from sklearn.metrics import confusion_matrix

# download dataset
df = pd.read_csv('dataset_rm_2018-08-09.csv')
# drop 'utc_time' column for simplifying model
df = df.drop('utc_time', axis = 1)


#Create matrix of features and matrix of target variable
y = df.pop('is_buyer')
X = df

# get dummies - convertng categorical variables to digits
X_dummy = pd.get_dummies(X, columns =('country', 'platform', 'channel', 'hash_uri'), drop_first=True)



# Create train (80%) and test (20%) set
X_train, X_test, y_train, y_test = train_test_split(X_dummy, y, test_size=0.2, random_state=21, stratify=y)


""" KNeighborsClassifier approach predicts with 74 accuracy """
# Create a k-NN classifier with 3 neighbors
knn = KNeighborsClassifier(n_neighbors = 3)

# Fit the classifier to the data
knn.fit(X_train, y_train)

# Predict the labels for the training data X
new_prediction_test = knn.predict(X_test)
print("Prediction: {}".format(new_prediction_test))
knn.score(X_test, y_test)
accuracy_score(y_test, knn.predict(X_test))
# Creating the Confusion Matrix
cm = confusion_matrix(y_test.values, new_prediction_test)
cm


for case_predict in new_prediction_test:
    if case_predict == 0:
        print("Not a buyer")
    else:
        print("Buyer")
        

""" LogisticRegression approach predicts with 75 accuracy
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression

sc = StandardScaler()
X_train_scale = sc.fit_transform(X_train)
X_test_scale = sc.transform(X_test)

log=LogisticRegression(penalty='l2',C=.01)
log.fit(X_train_scale,y_train)
accuracy_score(y_test,log.predict(X_test_scale)) 

"""