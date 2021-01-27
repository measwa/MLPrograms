
# Data Pre-processing

#Import Dataset

datasets = read.csv('Data.csv')
datasets = datasets[,2:3]

# Fill missing variables
# datasets$Age = ifelse(is.na(datasets$Age),
#                       ave(datasets$Age, FUN = function(x) mean(x, na.rm = TRUE)),
#                       datasets$Age)
# 
# datasets$Salary = ifelse(is.na(datasets$Salary),
#                       ave(datasets$Salary, FUN = function(x) mean(x, na.rm = TRUE)),
#                       datasets$Salary)
# 
# #Encoding Categorical data
# 
# datasets$Country = factor(datasets$Country,
#                           levels = c('France','Spain','Germany'),
#                           labels = c(1,2,3))
# 
# datasets$Purchased = factor(datasets$Purchased,
#                           levels = c('No','Yes'),
#                           labels = c(0,1))

#Splitting the dataset into Training set and Test Set

# install.packages('caTools')

# select the library via code 
library(caTools)

set.seed(123)
split = sample.split(datasets$Purchased, SplitRatio = 0.8)

training_set = subset(datasets, split == TRUE)
test_set = subset(datasets, split == FALSE)

#Perform Feature Scaling
# 
# training_set[,2:3] = scale(training_set[,2:3])
# test_set[,2:3] = scale(test_set[,2:3])





