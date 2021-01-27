# Multiple Linear Regression

#Import Dataset

datasets = read.csv('50_Startups.csv')

# Encode Categorical variable

datasets$State = factor(datasets$State,
                        levels = c('New York','California','Florida'),
                        labels = c('1','2','3'))


#Splitting the dataset into Training set and Test Set

# install.packages('caTools')

# select the library via code 
library(caTools)

set.seed(123)
split = sample.split(datasets$Profit, SplitRatio = 0.8)

training_set = subset(datasets, split == TRUE)
test_set = subset(datasets, split == FALSE)

#Fitting Multiple Linear Regression to the Training set

regressor = lm(formula = Profit ~ .,
               data = training_set)

#Predicting the Test set results

y_pred = predict(regressor, newdata = test_set)


#Building the optimal model using Backward Elimination

#Step-1

regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
               data = training_set)
summary(regressor)

#Step-2
#Removing independent variables whose P-value > Significance Level (0.05)
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend,
               data = training_set)
summary(regressor)

#Step-2
#Removing independent variables whose P-value > Significance Level (0.05)
regressor = lm(formula = Profit ~ R.D.Spend + Administration,
               data = training_set)
summary(regressor)

#Step-3
#Removing independent variables whose P-value > Significance Level (0.05)
regressor = lm(formula = Profit ~ R.D.Spend,
               data = training_set)
summary(regressor)

y_pred = predict(regressor, newdata = datasets)

y_pred