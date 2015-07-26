# Clean up workspace
rm(list=ls())

# Download and unzip the dataset:
fileName <- "getdata_projectfiles_UCI HAR Dataset.zip"

if (!file.exists(fileName)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, fileName)
}  

if (!file.exists("UCI HAR Dataset")) { 
    unzip(fileName) 
}

# read the general data files
features <- read.table("UCI HAR Dataset/features.txt", header=FALSE)
activityLabels <- read.table('UCI HAR Dataset/activity_labels.txt', header=FALSE)

# read the train data files
subjectTrain <- read.table('UCI HAR Dataset/train/subject_train.txt', header=FALSE)
xTrain <- read.table('UCI HAR Dataset/train/x_train.txt', header=FALSE)
yTrain <- read.table('UCI HAR Dataset/train/y_train.txt', header=FALSE)

# Assigin column names to activity labels file
colnames(activityLabels) <- c('activityId','activityType')

# Assigin column names to the train data
colnames(subjectTrain) <- "subjectId"
colnames(xTrain) <- features$V2 
colnames(yTrain) <- "activityId"

# create the training data
trainingData <- cbind(subjectTrain, yTrain, xTrain)

# read the test data files
subjectTest <- read.table('UCI HAR Dataset/test/subject_test.txt', header=FALSE)
xTest <- read.table('UCI HAR Dataset/test/x_test.txt', header=FALSE)
yTest <- read.table('UCI HAR Dataset/test/y_test.txt', header=FALSE)

# Assign column names to the test data 
colnames(subjectTest) <- "subjectId"
colnames(xTest) <- features$V2 
colnames(yTest) <- "activityId"

# create the test data
testData <- cbind(subjectTest, yTest, xTest)

# create an unique dataset by combining training and test data
uniqueData = rbind(trainingData, testData)

# get all column names 
allColNames <- colnames(uniqueData)

# assign logical value TRUE to column containing measurements of interest:
# subjectId, activityId, mean and std measurements 
colToExtract <- grepl("subject", allColNames) | grepl("activityId", allColNames) | 
                grepl("mean()", allColNames, fixed=TRUE) | grepl("std()", allColNames)

# subset the finalData based on the previous selected columns of interest
subsetData <- subset(uniqueData, select=allColNames[colToExtract])

# Use descriptive activity names to name the activities in the data set
subsetData$activityType <- activityLabels$activityType[subsetData$activityId]

# update the column names with the new dataset
allColNames <- colnames(subsetData)

# Appropriately label the data set with descriptive activity name

# first, create a function with the set of all change to made
descrLabel <- function (x) {
    cols <- names(x)
    for (i in 1:length(cols)) {
        cols[i] <- gsub("\\()", "", cols[i])
        cols[i] <- gsub("-std", "StdDev", cols[i])
        cols[i] <- gsub("-mean", "Mean", cols[i])
        cols[i] <- gsub("^(t)", "time", cols[i])
        cols[i] <- gsub("^(f)", "freq", cols[i])
        cols[i] <- gsub("([Gg]ravity)", "Gravity", cols[i])
        cols[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)", "Body", cols[i])
        cols[i] <- gsub("[Gg]yro", "Gyro", cols[i])
        cols[i] <- gsub("AccMag", "AccMagnitude", cols[i])
        cols[i] <- gsub("([Bb]odyaccjerkmag)", "BodyAccJerkMagnitude", cols[i])
        cols[i] <- gsub("JerkMag", "JerkMagnitude", cols[i])
        cols[i] <- gsub("GyroMag", "GyroMagnitude", cols[i])
        }
    cols
}

# then, apply the function to subset
names(subsetData) <- descrLabel(subsetData)

# create a second, independent tidy data set with the average of 
# each variable for each activity and each subject.
tidyData <- aggregate(subsetData[ ,names(subsetData) != "activityType"],
                     by=list(subjectId=subsetData$subjectId,
                             activityType=subsetData$activityType),
                     FUN=mean)

# clean the dataset from clone columns
tidyData[,3] <- NULL

# order the dataset by subjectId and activityId
tidyData <- tidyData[order(tidyData$subjectId, tidyData$activityId),]

# clean the dataset from row.names column
row.names(tidyData) <- NULL

# Export the tidyData set 
write.table(tidyData, 'tidyData.txt', row.names=FALSE, sep='\t')