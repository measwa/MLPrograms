# Simple Linear Regression


# Data Pre-processing

#Import Dataset

datasets = read.csv('Salary_Data.csv')

#Splitting the dataset into Training set and Test Set

# install.packages('caTools')

# select the library via code 
library(caTools)

set.seed(123)
split = sample.split(datasets$Salary, SplitRatio = 2/3)

training_set = subset(datasets, split == TRUE)
test_set = subset(datasets, split == FALSE)

#Simple Linear Regression handles Feature Scaling

# Fitting Simple Linear Regression to the Training set

regressor = lm(formula = Salary ~ YearsExperience, data = training_set)


#Predicting the Test set results

y_pred = predict(regressor, newdata = test_set)


# Visualising the Training set results
# install.packages('ggplot2')

library(ggplot2)
ggplot() +
  geom_point(aes(x = training_set$YearsExperience, y = training_set$Salary),
             colour = 'red') +
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = 'blue') +
  ggtitle('Salary vs Experience - Training set') +
  xlab('Years of Experience') +
  ylab('Salary')


# Visualising the Test set results

ggplot() +
  geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
             colour = 'red') +
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = 'blue') +
  ggtitle('Salary vs Experience - Test set') +
  xlab('Years of Experience') +
  ylab('Salary')
