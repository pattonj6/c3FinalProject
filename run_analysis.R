## 12.19.15 jpatton
## final project for Getting and Cleaning Data

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the 
##  average of each variable for each activity and each subject.
library(dplyr)
library(tidyr)
library(data.table)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/run_analysis.zip")

unzip("./data/run_analysis.zip", exdir = "./data")

setwd("C:/Users/jpatton/Downloads/Coursera/c3_Get_Data/data/UCI HAR Dataset")
df_features <- data.frame(read.table("features.txt", header = FALSE, sep = ""))
df_activity_labels <- data.frame(read.table("activity_labels.txt", header = FALSE, sep = ""))

setwd("C:/Users/jpatton/Downloads/Coursera/c3_Get_Data/data/UCI HAR Dataset/train")
df_train_subject_train <- data.frame(read.table("subject_train.txt", header = FALSE, sep = ""))
df_train_X_train <- data.frame(read.table("X_train.txt", header = FALSE, sep = ""))
df_train_y_train <- data.frame(read.table("y_train.txt", header = FALSE, sep = ""))

setwd("C:/Users/jpatton/Downloads/Coursera/c3_Get_Data/data/UCI HAR Dataset/test")
df_test_subject_test <- data.frame(read.table("subject_test.txt", header = FALSE, sep = ""))
df_test_X_test <- data.frame(read.table("X_test.txt", header = FALSE, sep = ""))
df_test_y_test <- data.frame(read.table("y_test.txt", header = FALSE, sep = ""))

## merge the training and test data together, stack train on top of test, they have same
## number of columns (it was originally divided for a machine learning model)
merged_dataset <- data.table()
merged_dataset <- rbind(df_train_X_train, df_test_X_test)

## This step puts the column names onto the merged training and test data.  
## I use the transpose command, then the colnames to label the larger
## dataset.

list(df_features[,2]) -> column_names
transpose(column_names) -> transposed_column_names
transposed_column_names -> colnames(merged_dataset)

## I chose to stack the y labels into 1 tall column, then cbind it to the larger dataset.
## I did this to avoid a messy column name step, prior, which would have made me add a 
## row to get column 1 labeled.

merged_y_column <- rbind(df_train_y_train, df_test_y_test)
"activitylabels" -> colnames(merged_y_column)

## I chose to stack the y labels into 1 tall column, then cbind it to the larger dataset.
## I did this to avoid a messy column name step, prior, which would have made me add a 
## row to get column 1 labeled.
## I tested the subject test file in the main folder vs the test folder and they are 
## identical.
## identical(df_subject_test, df_test_subject_test) == TRUE

merged_y_subject_column <- rbind(df_train_subject_train, df_test_subject_test)
"subjectlabels" -> colnames(merged_y_subject_column)

## now merge the subject and activity labels alongside the big data set.  
## subject will be col1, activities will be in col2.
merged_w_activity_col <- cbind(merged_y_subject_column, merged_y_column, merged_dataset)

## convert to data.table
dt_merged_w_activity_col <- data.table(merged_w_activity_col)

valid_column_names <- make.names(names=names(dt_merged_w_activity_col), unique=TRUE, allow_ = FALSE)
names(dt_merged_w_activity_col) <- valid_column_names

## If I grep out the "label|mean|std" column names I get the columns I want. 
## Method 2a -- A safe idiom for excluding columns matching a regular expression
## df3 <- df3[, which(!grepl("^foo$", colnames(df3))), with=FALSE]
dt_merged_w_activity_col <- dt_merged_w_activity_col[, which(grepl("label|mean|std", 
                                                                   colnames(dt_merged_w_activity_col), 
                                                                   ignore.case = TRUE)), 
                                                     with=FALSE]

## edit the column names, use alternating capital words.  Remove all the dots, parentheses.
sub("tBodyAcc", "timeBodyAccelerometer", names(dt_merged_w_activity_col)) -> colnames(dt_merged_w_activity_col)
sub("tGravityAcc", "timeGravityAccelerometer", names(dt_merged_w_activity_col)) -> colnames(dt_merged_w_activity_col)
sub("tBodyGyro", "timeBodyGyroscope", names(dt_merged_w_activity_col)) -> colnames(dt_merged_w_activity_col)
sub("fBodyAcc", "frequencyBodyAccelerometer", names(dt_merged_w_activity_col)) -> colnames(dt_merged_w_activity_col)
sub("Mag", "Magnitude", names(dt_merged_w_activity_col)) -> colnames(dt_merged_w_activity_col)
sub("fBodyGyro", "frequencyBodyGyroscope", names(dt_merged_w_activity_col)) -> colnames(dt_merged_w_activity_col)
sub(".meanFreq", "MeanFrequency", names(dt_merged_w_activity_col)) -> colnames(dt_merged_w_activity_col)
sub(".mean", "Mean", names(dt_merged_w_activity_col)) -> colnames(dt_merged_w_activity_col)
sub(".std", "Std", names(dt_merged_w_activity_col)) -> colnames(dt_merged_w_activity_col)
sub("fBodyBodyAcc", "frequencyBodyAccelerometer", names(dt_merged_w_activity_col)) -> colnames(dt_merged_w_activity_col)
sub("fBodyBodyGyro", "frequencyBodyGyroscope", names(dt_merged_w_activity_col)) -> colnames(dt_merged_w_activity_col)

gsub("\\.", "", names(dt_merged_w_activity_col)) -> colnames(dt_merged_w_activity_col)


## I am sure there is a more elegant way to do this step, probably with a loop.
dt_merged_w_activity_col$activitylabels[dt_merged_w_activity_col$activitylabels == 1] <- "WALKING"
dt_merged_w_activity_col$activitylabels[dt_merged_w_activity_col$activitylabels == 2] <- "WALKING_UPSTAIRS"
dt_merged_w_activity_col$activitylabels[dt_merged_w_activity_col$activitylabels == 3] <- "WALKING_DOWNSTAIRS"
dt_merged_w_activity_col$activitylabels[dt_merged_w_activity_col$activitylabels == 4] <- "SITTING"
dt_merged_w_activity_col$activitylabels[dt_merged_w_activity_col$activitylabels == 5] <- "STANDING"
dt_merged_w_activity_col$activitylabels[dt_merged_w_activity_col$activitylabels == 6] <- "LAYING"

## group by person subject and activity labels 
dt_merged_by_sbact <- group_by(dt_merged_w_activity_col, subjectlabels, activitylabels) 

## dt[, lapply(.SD, sum, na.rm=TRUE), by=category ]
## http://stackoverflow.com/questions/16513827/r-summarizing-multiple-columns-with-data-table

dt_test <- summarise_each(dt_merged_by_sbact, funs(mean))

write.table(dt_test, file = "./data/tidyactivityphone.txt", row.names = FALSE)
