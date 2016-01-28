setwd("~/Rstudio/3. Getting and cleaning data/Assignment")

library(plyr)
library(dplyr)

## Download data
if(!file.exists("./data.zip")){
        url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(url, destfile = "./data.zip")
}
unzip("./data.zip")

## Read data
features <- read.table("UCI HAR Dataset/features.txt")

XTest<-read.table("UCI HAR Dataset/test/X_test.txt")
YTest<-read.table("UCI HAR Dataset/test/Y_test.txt")
subjTest<-read.table("UCI HAR Dataset/test/subject_test.txt")

XTrain<-read.table("UCI HAR Dataset/train/X_train.txt")
YTrain<-read.table("UCI HAR Dataset/train/Y_train.txt")
subjTrain<-read.table("UCI HAR Dataset/train/subject_train.txt")

## rename columns
names(XTest)<-t(features[2])
names(XTrain)<-t(features[2])

## add subject and activity column
XTest$subject<-subjTest[,1]
XTest$activity<-YTest[,1]
XTrain$subject<-subjTrain[,1]
XTrain$activity<-YTrain[,1]

## Merge the training and the test sets to create one data set.
dataset<-rbind(XTest, XTrain)

## Extract only the measurements on the mean and standard deviation for each measurement.
meanStdFeatures<-features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
columnNames=c("subject", "activity", as.character(meanStdFeatures))
dataset<-subset(dataset, select=columnNames)

## Use descriptive activity names to name the activities in the data set
activityLabel <- read.table("UCI HAR Dataset/activity_labels.txt",header = FALSE)
dataset<-merge(dataset, activityLabel, by.x="activity", by.y="V1")
names(dataset)[69]<-"ActivityLabel"

## Appropriately label the data set with descriptive variable names.

## f = frequency
## t = time
## Acc = acceleration
## Gyro = Gyroscope
## BodyBody = Body
## std() = SD
## mean() = MEAN
## mag = magnitude
## remove - and ()

names(dataset)<-gsub("^f", "Frequency", names(dataset))
names(dataset)<-gsub("^t", "Time", names(dataset))
names(dataset)<-gsub("Acc", "Acceleration", names(dataset))
names(dataset)<-gsub("Gyro", "Gyroscope", names(dataset))
names(dataset)<-gsub("BodyBody", "Body", names(dataset))
names(dataset)<-gsub("std", "SD", names(dataset))
names(dataset)<-gsub("mean", "Mean", names(dataset))
names(dataset)<-gsub("Mag", "Magnitude", names(dataset))
names(dataset)<-gsub("\\(|\\)|-", "", names(dataset))

## From the data set in step 4, create a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

tidyData<-summarise_each(group_by(dataset, activity, subject, ActivityLabel),funs(mean))
write.table(tidyData, "TidyData.txt", row.names = FALSE)
