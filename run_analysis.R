library(reshape2)

#Download the data file if it does not already exist in the working directory

zipfile <- "projectdataset.zip"

if (!file.exists(zipfile)){
	fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, zipfile, method="curl")

}

#if folder doesn't exist , unzip file
if (!file.exists("UCI HAR Dataset")){
unzip(zipfile) 	
}

#Load the activity and feature info in activityLabels and features data frames respectively

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

features <- read.table("UCI HAR Dataset/features.txt")

# keeping only those columns which reflect a mean or standard deviation

desiredmeasurements <- grep(".*mean.*|.*std.*", features[,2])
desiredmeasurements.names <- features[desiredmeasurements,2]
desiredmeasurements.names = gsub('-mean', 'Mean', desiredmeasurements.names)
desiredmeasurements.names = gsub('-std', 'Std', desiredmeasurements.names)
desiredmeasurements.names <- gsub('[-()]', '', desiredmeasurements.names)

#Load both the training datasets

Xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")[desiredmeasurements]
  Ytrain <- read.table("UCI HAR Dataset/train/Y_train.txt")
  trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

#Load the activity and subject data for each dataset, and merges those columns with the dataset

Xtrain <- cbind(trainSubjects, Ytrain, Xtrain)

#Load test datasets
Xtest <- read.table("UCI HAR Dataset/test/X_test.txt")[desiredmeasurements]
Ytest <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

#Merge the two datasets
Xtest <- cbind(testSubjects, Ytest, Xtest)
Data <- rbind(Xtrain, Xtest)


colnames(Data) <- c("subject", "activity", desiredmeasurements.names)

#Converts the  activity and subject columns into factors
Data$activity <- factor(Data$activity, levels = activityLabels[,1], labels = activityLabels[,2])


Data$subject <- as.factor(Data$subject)


#Melt data frame with id vector subject and activity

Data.melted <- melt(Data, id = c("subject", "activity"))


# cast molten data frame into a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

Data.mean <- dcast(Data.melted, subject + activity ~ variable, mean)

write.table(Data.mean, "tidydata.txt", row.names = FALSE, quote = FALSE)


