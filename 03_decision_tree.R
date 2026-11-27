# 10-Fold Cross-Validation for Hyperparameter Tuning

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