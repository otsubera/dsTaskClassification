### PHASE 1 ###
### Exploratory Data Analysis ###
install.packages("ISLR")
install.packages("tree")

library(caret)
library(ISLR)
library(dplyr)
require(tree)

# load dataset_rm_2018-08-09.csv 
sourceData <- read.csv(file="dataset_rm_2018-08-09.csv")
View(sourceData)
class(sourceData)

# number of rows in dataset 1000
nrow(sourceData)
# number of columns in dataset 6
ncol(sourceData)
# column names are: "utc_time" "hash_uri" "country"  "platform" "channel"  "is_buyer"
colnames(sourceData)
# original class of the columns
sapply(sourceData, class)

# any missing data? There is not NA data 
any(is.na(sourceData))

# 202 unique URL pages in dataset
length(unique(sourceData$hash_uri))
# 13 unique country in dataset 
length(unique(sourceData$country))
# 6 unique platform in dataset 
length(unique(sourceData$platform))
# only 1 channel
length(unique(sourceData$channel))

#general summary of data source
summary(sourceData)

# frequency of values for every column
print(data.frame(table(sourceData$country)))
print(data.frame(table(sourceData$hash_uri)))
print(data.frame(table(sourceData$platform)))




# model <- lm(is_buyer ~ ., sourceData)


# randomization of source Data
randomRowIndex <- sample(nrow(sourceData))
randomData <- sourceData[randomRowIndex, ]
head(sourceData)
head(randomData)



# define train set 80%
split <- round(nrow(randomData) * 0.80)
trainSet <- randomData[1:split, ]
head(trainSet)

# define test set 20%
testSet <- randomData[(split + 1):nrow(randomData), ]
head(testSet)

# glm() 
model <- glm(is_buyer ~ ., family = "binomial", trainSet)
p <- predict(model, testSet, type = "response")


library(caret)
head(trainSet)
dmy <- dummyVars(" ~ .", data=trainSet, fullRank = T)
train_transform <- data.frame(predict(dmy, newdata = trainSet))
str(train_transform)

















  
  