## load required packages
library(plyr)
library(dplyr)

## load data from files into dataframes
  ## dictionaries
activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
  ## measurements (test)
setwd("test")
x_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")
  ## measurements (train)
setwd(".."); setwd("train");
x_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")
setwd("..")

## rename columns of y/subject/dictionary dataframes
names(y_test) <- c("activity_id")
names(y_train) <- c("activity_id")
names(subject_train) <- c("subject_id")
names(subject_test) <- c("subject_id")
names(activity_labels) <- c("activity_id", "activity_name")

## bind x,y and subject data into single dataframe
test <- cbind(subject_id = subject_test$subject_id, activity_id = y_test$activity_id, x_test)
train <- cbind(subject_id = subject_train$subject_id, activity_id = y_train$activity_id, x_train)

## merge train and test data into single dataframe
all_data <- rbind(train, test)

## add readable activity name into dataframe
all_data <- merge(activity_labels, all_data, by = "activity_id")

## rename measurements columns with readable features names
names(all_data) <- c("activity_id", "activity_name", "subject_id", as.character(features$V2))

## select key-columns and columns with mean() and std() measurements
all_data <- all_data[, grep("(mean\\()|std\\(|activity_name|subject_id", names(all_data))]

## column names fining
names(all_data) <- gsub("\\(\\)", "", gsub("-", "_", tolower(names(all_data))))

## group by key columns, datasummarize by predefined groups and save into the file
result_file_name <- "uci_har_measuremets_means.txt"
if (file.exists(result_file_name)) {
  file.remove(result_file_name)
}
  
all_data %>% group_by(activity_name, subject_id) %>%
  summarise_each(funs(mean)) %>%
  write.table(file = result_file_name)

## garbage collection
rm(activity_labels, features, subject_test, subject_train,
   test, train, x_test, x_train, y_test, y_train, result_file_name)