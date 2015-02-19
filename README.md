# GettingAndCleaningDataProject


This repo contains the script and the codebook for the course project for the John Hopkins University's course Getting and Cleaning Data.
The script `run_analysis.R`performs the 5 steps described in the course project's definition.
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the above mentioned data set, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The sript downloads the Samsung data (which is zipped) in a subdirectory `./data`. 
If `./data` does not exist, the script creates it. The data is unzipped in `./data/UCI HAR Dataset` .
The final independent dataset with the average of each variable for each activity and each subject is created in `./data/UCI HAR Dataset`. 
The file is `tidydata.txt`

The script is written in R version 3.1.2 (2014-10-31) -- "Pumpkin Helmet".
It was run and tested on RStudio Version 0.98.1091 – © 2009-2014 RStudio, Inc.
OS - Linux Mint 17.1 "Rebecca" Cinnamon Edition. 
