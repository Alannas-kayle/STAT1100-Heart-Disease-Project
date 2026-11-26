# Part 2: Stratified 80/20 Data.
# Run Part 1 first to create the cleaned heart_data.
# The target column must already be a factor.

library(caret)

set.seed(123)

train_index <- createDataPartition(
  heart_data$target,
  p = 0.80,
  list = FALSE
)

train_data <- heart_data[train_index, ]
test_data <- heart_data[-train_index, ]

# Check the number of rows
nrow(train_data)
nrow(test_data)

# Check the class counts
table(train_data$target)
table(test_data$target)