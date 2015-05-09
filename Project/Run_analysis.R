
# Task 1
# Merge the training and test sets to create one data set

#set working directory to the location where the UCI HAR Dataset was unzipped
setwd("D:/R/COURSE3_project/UCI HAR Dataset")

library(plyr)

# Read in the data
features     = read.table('./features.txt',header=FALSE)
activityType = read.table('./activity_labels.txt',header=FALSE)

subjectTrain = read.table('./train/subject_train.txt',header=FALSE)
xTrain       = read.table('./train/x_train.txt',header=FALSE)
yTrain       = read.table('./train/y_train.txt',header=FALSE)

subjectTest = read.table('./test/subject_test.txt',header=FALSE)
xTest       = read.table('./test/x_test.txt',header=FALSE)
yTest       = read.table('./test/y_test.txt',header=FALSE)

# Assigin column names to the imported data
colnames(activityType)  = c("activityID","activityType")
colnames(subjectTrain)  = "subjectID"
colnames(xTrain)        = features[,2] 
colnames(yTrain)        = "activityID"
colnames(subjectTest)   = "subjectID"
colnames(xTest)         = features[,2] 
colnames(yTest)         = "activityID"

# Merging yTrain, subjectTrain and xTrain to final training set
trainingData = cbind(yTrain,subjectTrain,xTrain)

# Merging yTest, subjectTest and xTest to final test set
testData = cbind(yTest,subjectTest,xTest)

# Combine training and test sets to final data set
masterData = rbind(trainingData,testData)

# Task 2
# Extracts only the measurements on the mean and standard deviation for each measurement.

# find columns with mean() or std() in their names and subset columns
masterData_measures<- masterData[,grep("-(mean|std)\\(\\)",names(masterData))]

# Task 3 & 4
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names

masterData = cbind(masterData$activityID,masterData$subjectID,masterData_measures)
names(masterData)[1] <- "activityID"
names(masterData)[2] <- "subjectID"
masterData = merge(masterData,activityType,by="activityID",all.x=TRUE)

# Task 5
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
clean_data <- ddply(masterData, .(subjectID, activityID, activityType), function(x) colMeans(x[, 3:68]))
write.table(clean_data, "clean_data.txt", row.name=FALSE)

