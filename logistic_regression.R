#Logistic Regression

# Import the Dataset

datasets = read.csv('Social_Network_Ads.csv')
datasets = datasets[, 3:5]

# Import the Libraries

library(caTools)
library(ElemStatLearn)

# Split the Training & Test Dataset
set.seed(123)
split = sample.split(datasets$Purchased, SplitRatio = 0.75)
training_set = subset(datasets, split == TRUE)
test_set = subset(datasets, split == FALSE)

# Feature Scaling
training_set[,1:2] = scale(training_set[,1:2])
test_set[,1:2] = scale(test_set[,1:2])

# Fit the Logistic Regression model on the training set

lr = glm(formula = Purchased ~ .,
         family = binomial,
         data = training_set)

# Predict the test set result

prob_pred = predict(lr, type = 'response', newdata = test_set[-3])
y_pred = ifelse(prob_pred > 0.5, 1, 0)

# Evaluate the prediction using Confusion Matrix

cm = table(test_set[,3],y_pred)

# Visualizing the training set result

set = training_set
X1 = seq(min(set[,1])-1, max(set[,1])+1, by=0.01)
X2 = seq(min(set[,2])-1, max(set[,2])+1, by=0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age','EstimatedSalary')
prob_set = predict(lr, type = 'response', newdata = grid_set)
y_grid = ifelse(prob_set > 0.5, 1, 0)
plot(set[,-3],
     main = 'Logistic Regression (Training Set)',
     xlab = 'Age', ylab = 'EstimatedSalary',
     xlim = range(X1), ylim = range(X2))
contour(X1,X2,matrix(as.numeric(y_grid),length(X1),length(X2)),add = TRUE)
points(grid_set, pch = '.', col=ifelse(y_grid ==1, 'springgreen3','tomato'))
points(set, pch = 21, bg = ifelse(set[,3] ==1, 'green4','red3'))

# Visualizing the test set result

set = test_set
X1 = seq(min(set[,1])-1, max(set[,1])+1, by=0.01)
X2 = seq(min(set[,2])-1, max(set[,2])+1, by=0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age','EstimatedSalary')
prob_set = predict(lr, type = 'response', newdata = grid_set)
y_grid = ifelse(prob_set > 0.5, 1, 0)
plot(set[,-3],
     main = 'Logistic Regression (Test Set)',
     xlab = 'Age', ylab = 'EstimatedSalary',
     xlim = range(X1), ylim = range(X2))
contour(X1,X2,matrix(as.numeric(y_grid),length(X1),length(X2)),add = TRUE)
points(grid_set, pch = '.', col=ifelse(y_grid ==1, 'springgreen3','tomato'))
points(set, pch = 21, bg = ifelse(set[,3] ==1, 'green4','red3'))