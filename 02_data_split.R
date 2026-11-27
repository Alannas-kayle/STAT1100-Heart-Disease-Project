# Part 2: Stratified 80/20 Data Partitioning
# Run 01_load_and_clean.R first.

library(caret)

# Connect to the cleaned data from Part 1
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
