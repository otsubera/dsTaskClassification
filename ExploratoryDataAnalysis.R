### PHASE 1 ###
### Exploratory Data Analysis ###
install.packages("ISLR")
install.packages("tree")

library(caret)
library(ISLR)
require(tree)

# load dataset_rm_2018-08-09.csv 
sourceData <- read.csv(file="dataset_rm_2018-08-09.csv")
View(sourceData)

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


ggplot(sourceData, aes(x=country, y=is_buyer)) +
  geom_boxplot()