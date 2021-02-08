# K Nearest Neighbor Classifier

# Import the Dataset

dataset = read.csv('Social_Network_Ads.csv')
dataset = dataset[,3:5]

# Import the Libraries
# install.packages('caTools') - Package for split train test
# install.packages('class') - Package for KNN Classifier

library(caTools)
library(class)

# Split Training and Test set

set.seed(1234)
split = sample.split(dataset$Purchased, SplitRatio = 0.75)
training_Set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Apply Feature scaling

training_Set[,1:2] = scale(training_Set[,1:2])
test_set[,1:2] = scale(test_set[,1:2])

# Train KNN model on the Training set and predicting the test result

y_pred = knn(train = training_Set[,1:2], test = test_set[,1:2], cl= training_Set[,3], k=5)

# Evaluate the prediction using Confusion Matrix

cm = table(test_set[,3],y_pred)

# Visualizing the training set result

set = training_Set
X1 = seq(min(set[,1])-1, max(set[,1])+1, by=0.01)
X2 = seq(min(set[,2])-1, max(set[,2])+1, by=0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age','EstimatedSalary')
prob_set = knn(train = training_Set[,1:2], test = grid_set, cl= training_Set[,3], k=5)
y_grid = ifelse(prob_set > 0.5, 1, 0)
plot(set[,-3],
     main = 'KNN Classifier (Training Set)',
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
prob_set = knn(train = training_Set[,1:2], test = grid_set, cl= training_Set[,3], k=5)
y_grid = ifelse(prob_set > 0.5, 1, 0)
plot(set[,-3],
     main = 'KNN Classifier (Test Set)',
     xlab = 'Age', ylab = 'EstimatedSalary',
     xlim = range(X1), ylim = range(X2))
contour(X1,X2,matrix(as.numeric(y_grid),length(X1),length(X2)),add = TRUE)
points(grid_set, pch = '.', col=ifelse(y_grid ==1, 'springgreen3','tomato'))
points(set, pch = 21, bg = ifelse(set[,3] ==1, 'green4','red3'))