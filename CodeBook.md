# Getting and Cleaning Data Project #

## Data Set Information ##

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Attribute Information ##

For each record in the dataset it is provided:
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope.
* A 561-feature vector with time and frequency domain variables.
* Its activity label.
* An identifier of the subject who carried out the experiment.

## Project goals ##

* Step 1
Merges the training and the test sets to create one data set.

At first, training, test, features and activity Type data sets are read in with read.table command. Next step is to assign column names to the imported data (activityID, activityType, subjectID, features). Then, training and test data sets are merged to final training and final test sets with cbind function. Last step is to combine final sets to create one final set (masterData set)

* Step 2
Extracts only the measurements on the mean and standard deviation for each measurement.

Extract mean and standard deviation columns by searching for columns which contain "mean" or "std" character strings in masterData column names, using grep function. 66 variables are extracted and saved as masterData_measurement data frame.

* Step 3 & 4
Uses descriptive activity names to name the activities in the data set. Appropriately labels the data set with descriptive variable names

Combine activityID, subjectID from masterData set with masterData_measurement data frame into one set (overwrite masterData set). Then, using merge function join masterData with activityType by key value - activityID. 

* Step 5
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Create final data set (clean_data) using ddply function (subjectID, activityID, activityType) and  apply colMean function to all columns from masterData_measurement column to compute mean values.

Generate clean_data set into the text file with write.table function (30 subjects * 6 activities = 180 rows). Upload the file to the repository.