#download data:
filename <- "getdata_projectfiles_UCI HAR Dataset.zip"
if (!file.exists(filename)){
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, filename)
}
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}
#load data:

activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

Xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")  ##load training set 
names(Xtrain) <- features$V2   ##name variables
Ytrain <- read.table("UCI HAR Dataset/train/Y_train.txt") ##load training labels
names(Ytrain) <- "activity"    ##name variables
Subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt") ##load training subjects
names(Subjecttrain) <- "subject"    ##name variables
train <- cbind(Subjecttrain, Ytrain, Xtrain) ##binding training data

Xtest <- read.table("UCI HAR Dataset/test/X_test.txt")  ##load test set
names(Xtest) <- features$V2    ##name variables
Ytest <- read.table("UCI HAR Dataset/test/Y_test.txt")  ##load test labels
names(Ytest) <- "activity"     ##name variables
Subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt") ##load test subjects
names(Subjecttest) <- "subject"  ##name variables
test <- cbind(Subjecttest, Ytest, Xtest) #binding test data

#Merge the training and the test sets to create one data set:
mergedata <- rbind(train, test)

#Use descriptive activity names to name the activities in the data set:
mergedata$activity <- activitylabels[mergedata$activity, 2]

#Extract  mean and standard deviation for each measurement:
extractcol <- grep(".*[Mm]ean.*|.*std.*|subject|activity", names(mergedata))
extractdata<- mergedata[,extractcol]



#Appropriately label the data set with descriptive variable names:
names(extractdata) <- gsub("-mean()", "Mean", names(extractdata))
names(extractdata) <- gsub("-std()", "Std", names(extractdata))
names(extractdata) <- gsub("[-()]", "", names(extractdata))

#create tidy data set with the average of each variable for each activity 
#and each subject.
library(reshape2)
meltdata <- melt(extractdata, id = c("subject", "activity"))
meandata <- dcast(meltdata, subject + activity ~ variable, mean)
View(meandata)
write.table(meandata, "tidydata.txt", row.names = FALSE)
