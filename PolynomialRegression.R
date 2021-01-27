# Polynomial Regression

# Data Preprocessing 

# Import Dataset

datasets = read.csv('Position_Salaries.csv')
datasets = datasets[,2:3]

#Fitting Simple Linear Regression to the data set

ln_regressor = lm(formula = Salary ~ Level,
               data = datasets)  

summary(ln_regressor)

#Fitting Polynomial Regression to the data set

datasets$Level2 = datasets$Level^2
datasets$Level3 = datasets$Level^3
datasets$Level4 = datasets$Level^4
poly_regressor = lm(formula = Salary ~ .,
                    data = datasets)

summary(poly_regressor)

#Visualizing the Linear Regression results

library(ggplot2)
ggplot()+
  geom_point(aes(x=datasets$Level, y=datasets$Salary), colour = 'red')+
  geom_line(aes(x=datasets$Level, y=predict(ln_regressor, newdata = datasets)), colour = 'blue')+
  ggtitle('Level vs Salary (Linear Regression)') +
  xlab('Level') +
  ylab('Salary')

#Visualizing the Polynomial Regression results

ggplot()+
  geom_point(aes(x=datasets$Level, y=datasets$Salary), colour = 'red')+
  geom_line(aes(x=datasets$Level, y=predict(poly_regressor, newdata = datasets)), colour = 'blue')+
  ggtitle('Level vs Salary (Polynomial Regression)') +
  xlab('Level') +
  ylab('Salary')

# Predicting a new result with Linear Regression

y_pred = predict(ln_regressor, data.frame(Level = 6.5))


# Predicting a new result with Polynomial Regression

y_pred = predict(poly_regressor, data.frame(Level = 6.5, 
                                            Level2=6.5^2,
                                            Level3=6.5^3,
                                            Level4=6.5^4))

