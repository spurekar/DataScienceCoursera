##Summary
This is an assignment for The Coursera Getting and Cleaning Data course offered by Johns Hopkins.

The objective of the assignment was to create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Code Walk-through

The code from the Run_analysis file creates a function Run_analysis() which 

1. Sets up the environment by loading the dplyr library
2. Imports the following data files:
    - X_train.txt and X_test.txt which have the feature data from each of the 30 subjects
    - subject_train.txt and subject_test.txt which list the subject tested in the same order as the training data
    - y_train.txt and y_test.txt which list the subject tested as a number in the same order as the training data
    - features.txt which lists each feature tested in the data files (used as the column headers for the data)
    - activity_labels.txt which has the desciption of each activity listed in the y-train and y-test files
3. Adds column names to test and train data using the features file
4. Extracts mean and standard deviation variables for each of the features using the dplyr 'select' function
6. Combines the mean and standard deviation data for the training and test data sets
6. Adds information about the subject and the activities (numeric) using 'cbind' to both data sets
7. Combines the test and train data in to one large data set
8. Adds descriptive activity names to the second column of the data using factors
9. Makes the relevant data numeric for grouping and summarizing purposes
10. Groups (group_by) and summarizes (summarise_each) the data with the average of each variable for each activity and each subject
11. returns the tidy data set of averages

##Code Book Variables
The datafile SummaryData.txt includes the following variables:

1. Subject: which of the 30 volunteers the observation pertains to

2. Activity: which of the 6 activities the observation records

3. Averages of mean and standard deviation for each of the features from the initial study:

  - tBodyAcc-XYZ
  - tGravityAcc-XYZ
  - tBodyAccJerk-XYZ
  - tBodyGyro-XYZ
  - tBodyGyroJerk-XYZ
  - tBodyAccMag
  - tGravityAccMag
  - tBodyAccJerkMag
  - tBodyGyroMag
  - tBodyGyroJerkMag
  - fBodyAcc-XYZ
  - fBodyAccJerk-XYZ
  - fBodyGyro-XYZ
  - fBodyAccMag
  - fBodyAccJerkMag
  - fBodyGyroMag
  - fBodyGyroJerkMag


##Original feature file
The original file with the feature explanations is here:
Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
