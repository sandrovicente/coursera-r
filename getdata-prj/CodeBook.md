# Code Book

### Input Data Summary

The dataset analyser summarizes data collected from accelerometers from Sansung Galaxy S Smartphones.

One example of the dataset containing such information can be located at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This data contains results of experiments carried out with a group of 30 voluteers performing six activities: WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING and LAYING. 

The data to be analysed is presented as:

* A 561-feature vector with time and frequency domain variables. 
* Its activity label (1 for WALKING, 4 for SITTING, etc) 
* An identifier of the subject who carried out the experiment (1-30).

This data is normalized, splitted across several files, divided into 2 main groups:

**Train:**

* 'train/X_train.txt': Training set (561-feature vector with time and frequency domain variables).
* 'train/y_train.txt': Training activity labels (1-6) 
* 'train/subject_train.txt: identifier for the subjects in training data (1-30)

**Test:**

* 'test/X_test.txt': Testing set (the 561-feature vector for tests).
* 'test/y_test.txt': Testing activity labels (1-6). 
* 'test/subject_test.txt: identifier for the subjects in test data (1-30)

The data also comprises a file associating activity labels to names:

* 'activity_labels.txt'

and a file with the names of the 561 features:

* 'features.txt'

Detailed information on the contents of these files can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

All this data should be collected, associated, filtered and aggregated in order to generate a tidy dataset containing aggregated information regarding values of standard deviation and means of the original dataset.

The generated tidy dataset should contain the average of the variables (representing averages and standard deviations) aggregated per subject and activity.

### Transformation performed by 'run_analysis.R'

Run analysis reads all the files mentioned in the section above. The following steps are performed:

1. Merge rows from the feature vectors contained in 'test/X_test.txt' and 'train/X_train.txt', in this order.

2. Columns of the feature vectors corresponding to standard deviation and mean measurements are selected.  
 1. This is performed by identifying the names of the features from the file 'features.txt' which contains 'std()' and 'mean()';
 2. The names of the features are ordered following the order of the columns of the feature vectors in X_test / X_train;
 3. The indexes of the features corresponding to 'std()' and 'mean()' are used to filter the corresponding columns in the feature vectors;
 4. The other columns in the feature vectors are discarded.

3. The activities, described by identifiers contained in 'test/y_test.txt' and 'train/y_train.txt', are assigned to the feature vectors as an additional column, named 'al' (activity label).

4. The subjects identifiers, contained in 'test/subject_test.txt' and 'train/subject_train.txt', are also added to the feature vectors as another extra column 'id'.

5. The resulting feature vectors, including 'id' and 'al' columns, are matched to the activity names, contained in 'activity_labels.txt' through the use of 'merge' function. 'al' is the key to associate activity names to the feature vectors. 

6. The result is a dataset containing all the previous columns ('mean()' and 'std()' features together with 'id' and 'al') plus a new column 'activity' with the corresponding activity name. 

7. The 'aggregate' function is executed, performing the function 'mean' on feature values regarding each combination of subject ('id') and activity. The 'al' column is discarded in the process.

8. The resulting dataset contains a single combination of subject ('id') and activity per row. Each row contains the means of the values of the variables 'mean()' and 'std()' of the original feature vector. The mean is calculated for the corresponding combination of subject and activity of the row.

### Running 'run_analysis.R'

The dataset files should be placed in a specific folder, named DATA.ROOT. Inside this folder, they should be organized as follows:

* DATA.ROOT/activity_labels.txt
* DATA.ROOT/features.txt
* DATA.ROOT/train/X_train.txt
* DATA.ROOT/train/y_train.txt 
* DATA.ROOT/train/subject_train.txt
* DATA.ROOT/test/X_test.txt
* DATA.ROOT/test/y_test.txt
* DATA.ROOT/test/subject_test.txt

DATA.ROOT folder should be set in 'run_analysis.R' before running the script.

Also, the variable SEPARATOR should be set with the file path separator used by the operating system ('\\\\' for Windows or '/' for Unix or Mac OS X)

The RESULT may be set with the name of the data file containing the results. The default value is 'mean_file.txt'
The result file is generated in DATA.ROOT.

More details on executing 'run_analysis.R' can be found in 'README.md'. 

### Resulting Variables

* "id" - Subject identification (1-30) 
* "activity" - Activity name (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING and LAYING)
* "mean.of.tBodyAcc.mean.X" - mean of means for measures from accelerometer for body on X axis (time domain)
* "mean.of.tBodyAcc.mean.Y" - same as above for Y axis
* "mean.of.tBodyAcc.mean.Z" - same as above for Z axis
* "mean.of.tBodyAcc.std.X" - mean of standard deviations from accelerometer body on X axis (time domain)
* "mean.of.tBodyAcc.std.Y" - same as above for Y axis
* "mean.of.tBodyAcc.std.Z" - same as above for Z axis
* "mean.of.tGravityAcc.mean.X" - mean of means for measures for measures from accelerometer for gravity on X axis (time domain)
* "mean.of.tGravityAcc.mean.Y" - same as above for Y axis
* "mean.of.tGravityAcc.mean.Z" - same as above for Z axis 
* "mean.of.tGravityAcc.std.X" - mean of standard deviations for measures from accelerometer for gravity on X axis  (time domain)
* "mean.of.tGravityAcc.std.Y"  - same as above for Y axis
* "mean.of.tGravityAcc.std.Z"  - same as above for Z axis
* "mean.of.tBodyAccJerk.mean.X" - mean of means for measures of accelerometer jerks on X axis (time domain)
* "mean.of.tBodyAccJerk.mean.Y"  - same as above for Y axis
* "mean.of.tBodyAccJerk.mean.Z"  - same as above for Z axis
* "mean.of.tBodyAccJerk.std.X"  - mean of standard deviations for measures from accelerometers for jerks on X axis (time domain)
* "mean.of.tBodyAccJerk.std.Y"  - same as above for Y axis
* "mean.of.tBodyAccJerk.std.Z"  - same as above for Z axis
* "mean.of.tBodyGyro.mean.X"  - mean of means for measures from gyroscope body on X axis (time domain)
* "mean.of.tBodyGyro.mean.Y"  - same as above for Y axis
* "mean.of.tBodyGyro.mean.Z"  - same as above for Z axis
* "mean.of.tBodyGyro.std.X"  - mean of standard deviations for measures from gyroscope body on X axis (time domain)
* "mean.of.tBodyGyro.std.Y"  - same as above for Y axis
* "mean.of.tBodyGyro.std.Z"  - same as above for Z axis
* "mean.of.tBodyGyroJerk.mean.X"  - mean of means for measures from gyroscope jerks on X axis (time domain)
* "mean.of.tBodyGyroJerk.mean.Y"  - same as above for Y axis
* "mean.of.tBodyGyroJerk.mean.Z"  - same as above for Z axis
* "mean.of.tBodyGyroJerk.std.X"  - mean of standard deviations for measures from gyroscope jerks on X axis (time domain)
* "mean.of.tBodyGyroJerk.std.Y"  - same as above for Y axis
* "mean.of.tBodyGyroJerk.std.Z"  - same as above for Z axis
* "mean.of.tBodyAccMag.mean" - mean of means of linear acceleration measurements (involving X, Y and Z axis) on body (time domain)
* "mean.of.tBodyAccMag.std" - mean of standard deviations of linear acceleration measurements (X, Y and Z axis) on body (time domain)
* "mean.of.tGravityAccMag.mean" - mean of means of linear acceleration measurements (involving X, Y and Z axis) on gravity (time domain)
* "mean.of.tGravityAccMag.std" - mean of standard deviations of linear acceleration measurements (X, Y and Z axis) on gravity (time domain)
* "mean.of.tBodyAccJerkMag.mean" - mean of means of linear acceleration measurements for jerk signals on body (time domain)
* "mean.of.tBodyAccJerkMag.std" - mean of standard deviations on linear acceleration measurements for jerk signals on body (time domain)
* "mean.of.tBodyGyroMag.mean" - mean of means of gyroscope signals using Euclidian norm (all axis, time domain)
* "mean.of.tBodyGyroMag.std" - mean of standard deviations of gyroscope signals using Euclidian norm (all axis, time domain)
* "mean.of.tBodyGyroJerkMag.mean" - mean of means of gyroscope signals for jerks using Euclidian norm (all axis, time domain)
* "mean.of.tBodyGyroJerkMag.std" - mean of standard deviations of gyroscope signals for jerks using Euclidian norm (all axis, time domain)
* "mean.of.fBodyAcc.mean.X"  - mean of means for measures from accelerometer for body on X axis (frequency domain)
* "mean.of.fBodyAcc.mean.Y"  - same as above for Y axis 
* "mean.of.fBodyAcc.mean.Z"  - same as above for Z axis
* "mean.of.fBodyAcc.std.X"  - mean of standard deviations from accelerometer body on X axis (frequency domain)
* "mean.of.fBodyAcc.std.Y"  - same as above for Y axis
* "mean.of.fBodyAcc.std.Z"  - same as above for Z axis
* "mean.of.fBodyAccJerk.mean.X"  - mean of means for measures of accelerometer jerks on X axis (frequency domain)
* "mean.of.fBodyAccJerk.mean.Y"  - same as above for Y axis
* "mean.of.fBodyAccJerk.mean.Z"  - same as above for Z axis
* "mean.of.fBodyAccJerk.std.X"  - mean of standard deviations for measures from accelerometers for jerks on X axis (frequency domain)
* "mean.of.fBodyAccJerk.std.Y"  - same as above for Y axis
* "mean.of.fBodyAccJerk.std.Z"  - same as above for Z axis
* "mean.of.fBodyGyro.mean.X"    - mean of means for measures from gyroscope body on X axis (frequency domain)
* "mean.of.fBodyGyro.mean.Y"  - same as above for Y axis
* "mean.of.fBodyGyro.mean.Z"  - same as above for Z axis
* "mean.of.fBodyGyro.std.X"  - mean of standard deviations for measures from gyroscope body on X axis (frequency domain)
* "mean.of.fBodyGyro.std.Y"  - same as above for Y axis
* "mean.of.fBodyGyro.std.Z"  - same as above for Z axis
* "mean.of.fBodyAccMag.mean" - mean of means of linear acceleration measurements (involving X, Y and Z axis) on body (frequency domain)   
* "mean.of.fBodyAccMag.std" - mean of standard deviations of linear acceleration measurements (X, Y and Z axis) on body (frequency domain)
* "mean.of.fBodyBodyAccJerkMag.mean" - mean of means of linear acceleration measurements for jerk signals on body (frequency domain)               
* "mean.of.fBodyBodyAccJerkMag.std" - mean of standard deviations on linear acceleration measurements for jerk signals on body (frequency domain)  
* "mean.of.fBodyBodyGyroMag.mean" - mean of means of gyroscope signals using Euclidian norm (all axis, frequency domain)                           
* "mean.of.fBodyBodyGyroMag.std" - mean of standard deviations of gyroscope signals using Euclidian norm (all axis, frequency domain)              
* "mean.of.fBodyBodyGyroJerkMag.mean" - mean of means of gyroscope signals for jerks using Euclidian norm (all axis, frequency domain)             
* "mean.of.fBodyBodyGyroJerkMag.std" - mean of standard deviations of gyroscope signals for jerks using Euclidian norm (all axis, frequency domain)
