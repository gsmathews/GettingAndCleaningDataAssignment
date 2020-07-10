# Initialize packages
library(dplyr)
library(tidyr)
library(tidyverse)


# 1. Merges the training and the test sets to create one data set.
merge_data <- function() {
  # Read feature names
  features <- read.table(file = "UCI HAR Dataset/features.txt")
  feature_names <- features$V2
  
  # Read and merge train data set
  train_df <- as_tibble(read.table(file = "UCI HAR Dataset/train/X_train.txt", col.names = feature_names))
  trainy_df <- as_tibble(read.table(file = "UCI HAR Dataset/train/Y_train.txt"))
  subjects <- as_tibble(read.table(file = "UCI HAR Dataset/train/subject_train.txt", col.names = "Subject"))
  train_df <- bind_cols(train_df, trainy_df, subjects)
  train_df <- rename(train_df, Training.Label = V1)
  colnames(train_df)
  
  test_df <- as_tibble(read.table(file = "UCI HAR Dataset/test/X_test.txt", col.names = feature_names))
  testy_df <- as_tibble(read.table(file = "UCI HAR Dataset/test/Y_test.txt"))
  subjects <- as_tibble(read.table(file = "UCI HAR Dataset/test/subject_test.txt", col.names = "Subject"))
  test_df <- bind_cols(test_df, testy_df, subjects)
  test_df <- rename(test_df, Training.Label = V1)
  #colnames(test_df)
  
  # Merge train and test
  df <- bind_rows(train_df, test_df, .id = NULL)
  #colnames(df)
  
  return(df)
}

df <- merge_data()

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

extract_mean_sd <- function(df){
  df <- select(df, contains("sd")|contains("mean")|"Training.Label"|"Subject")
  colnames(df)
  
  return(df)
}

df <- extract_mean_sd(df)
head(df)

# 3. Uses descriptive activity names to name the activities in the data set

combine_activity_labels <- function(df){
  activity_labels <- as_tibble(read.table("UCI HAR Dataset/activity_labels.txt"))
  df <- left_join(df, activity_labels, by = c("Training.Label" = "V1"))
  df <- rename(df, Training.Label.Desc = V2)

  return(df)
}

df <- combine_activity_labels(df)
head(df)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

average_subject_activity <- function(df){
  df %>% group_by(Training.Label.Desc, Subject) %>% summarise(mean(1:55))
}
