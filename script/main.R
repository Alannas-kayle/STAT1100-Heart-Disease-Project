# load packages
library(caret)
library(rpart)
library(rpart.plot)

# ------------------------------------------------------
# STEP 1: Load and clean clinical health data
# ------------------------------------------------------



# ------------------------------------------------------
# STEP 2: Balanced 80/20 data partitioning
# ------------------------------------------------------

heart_data <- heart_cleaned

set.seed(123)

train_index <- createDataPartition(
  heart_data$target,
  p = 0.80,
  list = FALSE
)

train_data <- heart_data[train_index, ]
test_data <- heart_data[-train_index, ]

# Check dataset sizes
print(nrow(train_data))
print(nrow(test_data))

# Check class counts
print(table(train_data$target))
print(table(test_data$target))


# ------------------------------------------------------
# STEP 3: 10-fold cross validation for tuning CP
# ------------------------------------------------------

cv_settings <- trainControl(
  method="cv",
  number=10
)

set.seed(523)

tuned_tree <- train(
  target ~ .,
  data = train_data,
  method ="rpart",
  trControl = cv_settings,
  tuneLength = 10
)

print(tuned_tree$bestTune)
print(tuned_tree$results)

plot(
  tuned_tree,
  main ="Cross-Validation Accuracy vs. Complexity Parameter(CP)"
)

# ------------------------------------------------------
# STEP 4: Unseen predictions and matrix table evaluation
# ------------------------------------------------------

predictions <- predict(tuned_tree, newdata = test_data)

confustion_table <- table(Actual = test_data$target, Predicted = predictions)

correct_counts <- sum(diag(confusion_table))

total_counts <- sum(confustion_table)
test_accuracy <- correct_counts/total_counts

cat("\nFinal Calculated Test Accuracy Rate:",round(test_accuracy*100, 2), "%\n")