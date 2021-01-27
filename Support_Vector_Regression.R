#SVR

# Data Pre-processing

#Import Dataset

datasets = read.csv('Position_Salaries.csv')
datasets = datasets[,2:3]


#Fitting Support Vector Regression to the data set
# install.packages('e1071') # package to install for svm
library(e1071)
svr_regressor = svm(formula = Salary ~ .,
                    data = datasets, 
                    type = 'eps-regression') 
# Kernel used by default is Gaussian kernel

summary(svr_regressor)

# Predicting a new result with Support Vector Regression

y_pred = predict(svr_regressor, data.frame(Level = 6.5))



#Visualizing the Support Vector Regression results

library(ggplot2)
ggplot()+
  geom_point(aes(x=datasets$Level, y=datasets$Salary), colour = 'red')+
  geom_line(aes(x=datasets$Level, y=predict(svr_regressor, newdata = datasets)), colour = 'blue')+
  ggtitle('Level vs Salary (Support Vector Regression)') +
  xlab('Level') +
  ylab('Salary')


