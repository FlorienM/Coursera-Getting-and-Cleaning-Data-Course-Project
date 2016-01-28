# Getting and Cleaning Data: Course Project  
This codebook describes the variables, the data, and any transformations or work performed to clean up the data.

### Datasource
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 


* Original datasource: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Full description of original dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Files used for creating the tidy dataset:  

* `features.txt`: List of all features.  
* `activity_labels.txt`: Links the class labels with their activity name.  
* `train/X_train.txt`: Training set.  
* `train/y_train.txt`: Training labels.  
* `test/X_test.txt`: Test set.  
* `test/y_test.txt`: Test labels.  
* `train/subject_train.txt`: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.  
* `test/subject_test.txt`: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.  

### Transformations to clean up the dataset in `run_analysis.R`
1. Download data if that has not been done yet.
2. Load relevant test and train datatables into R Studio.
3. Rename columns in both test and train data according to the `features.txt` file.
4. Merge the training and the test sets to create one data set.
5. Extract only the measurements on the mean and standard deviation.
6. Label the activities.
7. Create descriptive variable names.
8. Take the average of each variable for each activity and each subject.
9. Export tidy table to `TidyData.txt`.


### Variables in `TidyData.txt`
The tidy dataset exists of 180 rows (30 participants and 6 activities) and 69 columns. The columns are explained below. 
The first row of `TidyData.txt` is the header containing the names for each column.

#### Identifiers
* **subject**: Identifier for the participant (30 in total).
* **activity**: Identifier for the different activities (1-6).
* **ActivityLabel**: Label to identify the activities: WALKING (1), WALKING_UPSTAIRS (2), WALKING_DOWNSTAIRS (3), SITTING (4), STANDING (5), LAYING (6).

#### Measurements
The measurements are averaged per participant per activity, which results in 33 'mean' measurements and 33 'standard deviation' measurements. 

