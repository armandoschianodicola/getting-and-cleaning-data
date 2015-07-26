### Project overview
The project involved collecting data from the accelerometers of the Samsung Galaxy S II smartphone.

A full description is available at the site where the data was obtained:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Source data for the project:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Study design and data processing
***

### Collection of Raw Data

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

A full list of the variables taken for each record it is provided in the "Variables" Section

### Variables

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.  
- Triaxial Angular velocity from the gyroscope.   
- A 561-feature vector with time and frequency domain variables.   
- Activity labels.   
- An identifier of the subject who carried out the experiment.  

### Notes on the raw data

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

### Tidy Data

In order to tidy the data, the R script, "run_analysis.R", does the following: 

1. Downloads the dataset if it does not already exist in the working directory  
2. Loads the activity labels and feature info files 
3. Loads both the training and test datasets
4. Creates a unique dataset by binding the training and test sets
5. Keeps only those columns which reflect a mean or standard deviation  
6. Uses descriptive activity names to name the activities in the data set  
7. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and each activity.  
8. Put The end result in the output file "tidyData.txt".
