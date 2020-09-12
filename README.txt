==================================================================
Getting and Cleaning Data Course Project
Version 1.0
==================================================================
Aldo Bustamante Campo

Johns Hopkins University
Coursera

www.coursera.org - www.jhu.edu
==================================================================

Introduction

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following. 1.Merges the training and the test sets to create one data set. 2.Extracts only the measurements on the mean and standard deviation for each measurement. 3.Uses descriptive activity names to name the activities in the data set 4.Appropriately labels the data set with descriptive variable names. 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Script Explanation.

For the development of this activity, the previous configuration of the R working folder is required, in a directory of your choice and containing the "UCI HAR Dataset" folder, for this example the working folder is defined in "D: / UCI HAR Dataset ".


###
features <- read.csv("features.txt", header = FALSE, sep = ' ')
features <- as.character(features[,2])
###

Initially, the file in which the features of the experiment are saved is read and a vector is saved with the names of these.

###
subjectTest <- read.csv("./test/subject_test.txt",header = FALSE, sep = ' ')
xTest <- read.table("./test/X_test.txt")
yTest.activity <- read.table("./test/y_test.txt")
data.test <-  data.frame(subjectTest, yTest.activity, xTest)
###
Each of the files that make up the test data set are read individually, loaded into individual data frames, the latter are subsequently gathered into a single training data frame

###
subjectTrain <- read.csv("./train/subject_train.txt",header = FALSE, sep = ' ')
xTrain <- read.table("./train/X_train.txt")
yTrain.activity <- read.table("./train/y_train.txt")
data.train <-  data.frame(subjectTrain, yTrain.activity, xTrain)
###

Each of the files that make up the training data set are read individually, loaded into individual data frames, the latter are then gathered into a single training data frame

###
DFComplete <- rbind(data.train, data.test)
names(DFComplete) <- c(c('subject', 'activity'), features)
###
Having the test and training data frames, they are combined into a single data frame


###
mean.std <- grep('mean|std', features)
data.mean.std <- DFComplete[,c(1,2,mean.std + 2)]
###
Through the use of regular expressions, those with names related to the mean and standard deviation are searched within the vector of variable names and their indices are stored that correspond to the columns that will be selected to create the subset of mean and standard deviation data.mean.std

###
activity.names <- read.table("./activity_labels.txt", header = FALSE)  #reading the labels from the activity_labels.txt file
activity.names <- as.character(activity.names[,2])
data.mean.std$activity <- activity.names[data.mean.std$activity]
###
A vector is created with the names of the activities developed in the human movements database project, and then by comparing the indices of this vector with the values of the column data.mean.std $ activity the values are replaced Numbers by the names in this column

###
replaced <- names(data.mean.std)
replaced <- gsub("[(][)]", "", replaced)
replaced <- gsub("^t", "TimeDomain_", replaced)
replaced <- gsub("^f", "FrequencyDomain_", replaced)
replaced <- gsub("Acc", "Accelerometer", replaced)
replaced <- gsub("Gyro", "Gyroscope", replaced)
replaced <- gsub("Mag", "Magnitude", replaced)
replaced <- gsub("-mean-", "Mean_", replaced)
replaced <- gsub("-std-", "StandardDeviation_", replaced)
replaced <- gsub("-", "_", replaced)
names(data.mean.std) <- replaced
###
Through the use of regular expressions, particular elements within the text of the variable names of the data.mean.std subset are searched and replaced with descriptive variable names

###
data.tidy <- aggregate(data.mean.std[,3:81], by = list(activity = data.mean.std$activity, subject = data.mean.std$subject),FUN = mean)
write.table(data.tidy, file = "data_tidy.txt", row.names = FALSE)
###

a data frame is generated that is the result of ordering the data in data.mean.std by subject and activity and calculating the mean in each of the different groups associated with this order and a text file is generated with this data

Aldo Bustamante. September 2012.
