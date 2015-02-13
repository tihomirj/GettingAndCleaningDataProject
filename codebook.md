# Getting and Cleaning Data Course Project 

Tihomir Jilevski

## Description

The script `run_analysis.R`performs the 5 steps described in the course project's definition.
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The sript downloads the Samsung data (which are zipped) in a subdirectory `./data`. The data is unzipped in `./data/UCI HAR Dataset` .
The final independent dataset (point 5. above) is created in  `./data/UCI HAR Dataset`. The file is `tidydata.txt`

## Source Data
A full description of the data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Attribute Information
For each record in the dataset it is provided: 
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

### Section 1. Download data. Merge the training and the test sets to create one data set.
The script 'run_anaysis.R' downloads the Samsung data (which are zipped) in a subdirectory **./data**.
The data is unzipped in **./data/UCI HAR Dataset** 
 
After setting the source directory for the files, read into tables the data located in
- import all features from file **features.txt** and saved into data frame **features**
- import activity labels from file **activity_labels.txt** and saved into data frame **activity**
- import the identification of subject who performed the train activity from file **subject_train.txt** and saved into data frame **subjectTrain**
- import training set from file **X_train.txt** and save into data frame **XTrain**
- import training labels from file **y_train.txt** and save into data frame **yTrain**
- import the identification of subject who performed the test activity from file **subject_test.txt** and saved into data frame **subjectTest**
- import the test set from file **X_test.txt** and save into data frame **XTest**
- import the test labels from file **y_test.txt** and save into data frame **yTest**

Column names which are taken from `features` are assigned to `XTest`, `XTrain`. 
The name `activityId` is assigned to `yTest` and `yTrain`.
The name `subjectId` is assigned to `subjectTest` and `subjectTrain`.
Using `cbind` the data frames `XTrain`, `yTrain` and `subjectTrain` are combined into data frame`trainingData`.
Similarly, using `cbind` the data frames `XTest`, `yTest` and `subjectTest` are combined into data frame`testData`.
Finally,  using `rbind` the data frames `trainingData` and `testData` are merged into `Data` .

### Section 2. Extracts only the measurements on the mean and standard deviation for each measurement.
Using `grep` and the vector `features$V2` a subset of feature names that measure mean and standard deviation is created. To these names are added `subjectId` and `activityId` and the final data frame `Data` is created.

### Section 3. Uses descriptive activity names to name the activities in the data set
The vector `Data$activityId` is factorized using the labels `activity$activityType` from data frame `activity`. Thus the activities now are coded with meaningful names.

### Section 4. Appropriately labels the data set with descriptive variable names. 
`gsub` function for pattern replacement is used to clean up the data labels.
- "^t" is replaced by "time" 
- "^f" is replaced by "frecuency" 
- "Acc" is replaced by "Accelerometer" 
- "Gyro" is replaced by "Gyroscope" 
- "Mag" is replaced by "Magnitude"
- "BodyBody" is replaced by "Body"

### Section 5. From the data set in section 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Using `aggregate` a new dataset `Data2` with the average of each variable for each activity and each subject is created. The dataset is created in directory `./data/UCI HAR Dataset`. The file is `tidydata.txt`.
