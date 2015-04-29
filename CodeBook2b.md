# Getting and Cleaning Data Course Project (G&CDCP)

This is the G&CDCP repo with files for scottb185 

# Description

This CodeBook file contains additional info on the run_analysis.R script

# Source Data

The source data for this project is contained in the getdata_projectfiles_UCI HAR Dataset.zip file

# Data Set Info (from source data zip README.txt)

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Provided for each record:

*Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration
*Triaxial Angular velocity from the gyroscope 
*A 561-feature vector with time and frequency domain variables 
*Its activity label 
*An identifier of the subject who carried out the experiment

# Section 1 - Merge the training and test sets to create one data set

*Source data is read into the R code and new column names are assigned, variable names match source (i.e. variable ytest from y_test.txt)
*Training and test data sets are created using the cbind function 
*Variable final (final data set) is created by applying the rbind function to test and training sets
*Variable colnames2 is created, will be used to select the mean and stddev columns later in code

# Section 2 - Extract only the measurements on mean and standard deviation for each measurement

*Variables c1-c7 and truthcheck use grepl function to find 'TRUE' values for activity, subject, mean and stddev values
*Variable final is redefined subsetting true values only

# Section 3 - Use descriptive activity names to name the activities in the data set

*Using (left) join function, final is joined with activitylabels to include descriptive activity names
*Variable colnames2 is redefined storing column names of final variable from previous step
 
# Section 4 - Appropriately label the data set with descriptive activity names 

*Using gsub function, for loop sweeps through and cleans up variable names

# Section 5 - Create a second, independent tidy data set with the average of each variable for each activity and each subject

*Variables finald and finald2 are subsetted from final data set in prep for tidy data set definition
*Variable tidy (tidy data set) is created using ddply function to include mean for each activity and subject
*Variable tidy is redefined using (left) join function  to include descriptive activity names
*Variable tidy is sorted ascending by (primary) activityid and (secondary) subjectid and exported to txt file


  
  
















*Merges the training and test sets to create one data set
*Pulls only the mean and standard deviation for each measurement
*Uses descriptive activity names to name the activities in the data set
*Appropriately labels the data set with descriptive activity names
*Creates a second, independent tidy data set with the average of each variable for each activity and each subject

Additonal info can be found in the project codebook.  
