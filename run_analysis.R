library(plyr)
library(data.table)
features <- read.csv("features.txt", header = FALSE, sep = ' ')
features <- as.character(features[,2])

## Test Data
subjectTest <- read.csv("./test/subject_test.txt",header = FALSE, sep = ' ')
xTest <- read.table("./test/X_test.txt")
yTest.activity <- read.table("./test/y_test.txt")
data.test <-  data.frame(subjectTest, yTest.activity, xTest)

## Train Data
subjectTrain <- read.csv("./train/subject_train.txt",header = FALSE, sep = ' ')
xTrain <- read.table("./train/X_train.txt")
yTrain.activity <- read.table("./train/y_train.txt")
data.train <-  data.frame(subjectTrain, yTrain.activity, xTrain)

## 1.  Merges Training and Testing Sets
DFComplete <- rbind(data.train, data.test)
names(DFComplete) <- c(c('subject', 'activity'), features)


# 2. select measurements on the mean and standard deviation
mean.std <- grep('mean|std', features)
data.mean.std <- DFComplete[,c(1,2,mean.std + 2)]

# 3. name activities in the dataset with descriptive names
activity.names <- read.table("./activity_labels.txt", header = FALSE)  #reading the labels from the activity_labels.txt file
activity.names <- as.character(activity.names[,2])
data.mean.std$activity <- activity.names[data.mean.std$activity]


# 4. label the data set with descriptive variable names
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

# 5 create tidy data set and generate output file
data.tidy <- aggregate(data.mean.std[,3:81], by = list(activity = data.mean.std$activity, subject = data.mean.std$subject),FUN = mean)
write.table(data.tidy, file = "data_tidy.txt", row.names = FALSE)
