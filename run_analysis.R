##
## This R script does the following:-
##    
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for
##    each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set
##    with the average of each variable for each activity and each subject.
##

run_analysis <- function () {

library(plyr)
library(dplyr)

## download the zip data file and extract it
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "dataset.zip", method = 'libcurl')
unzip("dataset.zip")

## prepare the training data

## load the training data. Note: the columns are not labelled
train_data <- read.csv(file = "./UCI HAR Dataset/train/X_train.txt",header = FALSE, sep = "")

## create a column that defines the data type i.e. training or test
train_data$type <- "training"

# get the subject data and assign to the data
subject_train <- read.csv("./UCI HAR Dataset/train/subject_train.txt",header=FALSE, sep = "")
train_data$subject <- subject_train[,1]

# get the activity data and assign to the data
activity_train <- read.csv("./UCI HAR Dataset/train/y_train.txt",header=FALSE, sep = "")
train_data$activity <- activity_train[,1]

## load the test data and set the column labels and define the data type
test_data <- read.csv(file = "./UCI HAR Dataset/test/X_test.txt",header = FALSE, sep = "")
test_data$type <- "test"
subject_test <- read.csv("./UCI HAR Dataset/test/subject_test.txt",
                         header=FALSE, sep = "")
test_data$subject <- subject_test[,1]
activity_test <- read.csv("./UCI HAR Dataset/test/y_test.txt",
                          header=FALSE, sep = "")
test_data$activity <- activity_test[,1]

## Now merge the training and testing data together 
sample_data <- rbind(train_data, test_data)

## test if any NA - all(colSums(is.na(sample_data)))

## assign the column labels to the training data
data_labels <- read.csv("./UCI HAR Dataset/features.txt",header = FALSE, sep = "")
names(sample_data) <- c(as.vector(data_labels[,2]), "type", "subject", "activity")

## There are duplicate names but these are not required as they are not the mean or std
## If left in these cause problems with the select statement below
## So take them out here
dup_names <- duplicated(colnames(sample_data))
sample_data <- sample_data[,!dup_names]

## free some memory
rm(subject_train, subject_test, activity_train, activity_test,
   train_data, test_data, data_labels)

## select the label fields and the mean and stddev fields
sample_data <- select(sample_data, type, subject, activity,
                      contains("mean"), contains("std"))

## Get the activity labels and join the activity name
activity_labels <- read.csv("UCI HAR Dataset/activity_labels.txt", 
                            sep="", header=FALSE)
names(activity_labels) <- c("activity", "activity_name")
sample_data <- merge(sample_data, activity_labels, by.x="activity",
                     y.y="V2", all.x=TRUE)

## write the tidy data out to file      
## write.table(sample_data, file = "tidy_sample_data.txt", sep=",")

## group by the subject and activity to find the mean of each column
summary_data <- sample_data %>%
    group_by(subject, activity_name) %>%
    summarise_each(funs(mean), contains("mean"), contains("std"))
write.table(summary_data, file = "tidy_summary_data.txt", row.names = FALSE)

}
