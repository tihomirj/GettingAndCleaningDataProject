# Getting and Cleaning Data Course Project
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
# The sript downloads the Samsung data (which are zipped) in a subdirectory "./data". The data is unzipped in "./data/UCI HAR Dataset" .
# The final independent dataset (point 5. above) is created in  "./data/UCI HAR Dataset". The file is "tidydata.txt"

# Clear the workspace
rm(list=ls())

# get the current working directory and save the path in 'wd'
wd <- getwd()

# Create 'data' subdirectory, download the zip file and save it in the 'data' subdirectory
if(!file.exists("./data")) {
    dir.create("./data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,
              destfile = "./data/Dataset.zip",
              method = "curl")

# unzip the file into 'data' subdirectory
unzip(zipfile = "./data/Dataset.zip",
      overwrite = TRUE,
      exdir = "./data")

#set working directory to the 'UCI HAR Dataset' where the files were unzipped
setwd(file.path(wd,"./data/UCI HAR Dataset"))

#imports all features from file features.txt
features <- read.table('./features.txt',header=FALSE) 

#imports activity_labels.txt which Links the class labels with their activity name
activity <-  read.table('./activity_labels.txt',header=FALSE) 

# Read train data

#imports the identification of subject who performed the train activity from file subject_train.txt
subjectTrain <- read.table('./train/subject_train.txt',header=FALSE) 

XTrain <-  read.table('./train/X_train.txt',header=FALSE) #imports training set from file X_train.txt
yTrain <-  read.table('./train/y_train.txt',header=FALSE) #imports training labels from file y_train.txt

# Assigin column names to the data imported above
colnames(activity) <- c('activityId','activityType')
colnames(subjectTrain) <- "subjectId"
colnames(XTrain) <- features[,2]
colnames(yTrain) <- "activityId"

# Create the final training set by merging training labels (yTrain), 
# subject who performed activity (subjectTrain) and  training set (XTrain)
trainingData = cbind(yTrain,subjectTrain,XTrain)

# Read test data

#imports the identification of subject who performed the test activity  from file subject_test.txt
subjectTest <- read.table('./test/subject_test.txt',header=FALSE) 
XTest <- read.table('./test/X_test.txt',header=FALSE) #imports the test set from file X_test.txt
yTest <- read.table('./test/y_test.txt',header=FALSE) #imports the test labels from file y_test.txt

# Assign column names to the test data imported above
colnames(subjectTest) <- "subjectId"
colnames(XTest) <- features[,2]
colnames(yTest) <- "activityId"

# Create the final test set by merging the test set from (XTest), test labels from (yTest) 
# and the subject from (subjectTest) 
testData <- cbind(yTest,subjectTest,XTest)

# Merge training and test data to create one data set
Data <- rbind(trainingData,testData)

#Extracts only the measurements on the mean and standard deviation for each measurement

# subset of feature names that measure mean and standard deviation
subdata_features <-features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]           

# select the columns that will appear in the final dataset
selected_features <- c("subjectId", "activityId",as.character(subdata_features))    
Data<-subset(Data, select = selected_features)

# Use descriptive activity names to name the activities in the data set
Data$activityId <- factor(Data$activityId, labels = activity$activityType)

# Appropriately labels the data set with descriptive variable names

names(Data)<-gsub(pattern = "^t", replacement = "Time", names(Data))         # "^t" replaced by "Time" 
names(Data)<-gsub(pattern = "^f", replacement = "Frequency", names(Data))    # "^f" replaced by "Frecuency" 
names(Data)<-gsub(pattern = "Acc",replacement = "Accelerometer", names(Data))# "Acc" replaced by "Accelerometer" 
names(Data)<-gsub(pattern = "Gyro",replacement =  "Gyroscope", names(Data))  # "Gyro" replaced by "Gyroscope" 
names(Data)<-gsub(pattern = "Mag", replacement = "Magnitude", names(Data))   # "Mag" replaced by "Magnitude"
names(Data)<-gsub(pattern= "BodyBody", replacement = "Body", names(Data))    # "BodyBody" replaced by "Body"

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject
# The dataset is created in directory "./data/UCI HAR Dataset". The file is "tidydata.txt"

Data2 <- aggregate(formula = . ~subjectId + activityId, data = Data, FUN = mean)
Data2 <- Data2[order(Data2$subjectId, Data2$activityId), ] 
write.table(Data2, file = "tidydata.txt", row.name = FALSE)

