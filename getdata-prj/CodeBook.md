# Code Book

### Input Data Description

The dataset analyser summarizes data collected from accelerometers from Sansung Galaxy S Smartphones.

One example of the dataset containing such information can be located at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This data contains results of experiments carried out with a group of 30 voluteers performing six activities: WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING and LAYING. 

The data to be analysed is presented as:

* A 561-feature vector with time and frequency domain variables. 
* Its activity label (WALKING, SITTING, etc) 
* An identifier of the subject who carried out the experiment.

This data is normalized, splitted across several files, divided into 2 groups:

**Train:**

* 'train/X_train.txt': Training set (561-fature vector with time and frequency domain variables).
* 'train/y_train.txt': Training activity labels (1-6) 
* 'train/subject_train.txt: identifier for the subjects in training data

**Test:**

* 'test/X_test.txt': Testing set (the 561-feature vector for tests).
* 'test/y_test.txt': Testing activity labels (1-6). 
* 'test/subject_test.txt: identifier for the subjects in test data

Also contains a file associating activity labels to names:

* 'activity_labels.txt'

and a file with the names of the 561 features:

* 'features.txt'

Detailed information on the contents of these files can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

All this data should be collected, associated, filtered and aggregated in order to generate a tidy dataset containing aggregated information regarding values of standard deviation and means of the original dataset.

The generated tidy dataset should contain the average of the variables (representing averages and standard deviations) aggregated per subject and activity.

### Transformation performed by 'run_analysis.R'

Run analysis reads all the files mentioned in the section above. The following steps are performed:

1. Merge of rows from the feature vectors contained in 'test/X_test.txt' and 'train/X_train.txt'

2. Columns of the feature vectors corresponding to standard deviation and mean measurements are selected.  
 1. This is performed by identifying the names of the features from the file 'features.txt' which contains 'std()' and 'mean()';
 2. The names of the features are ordered following the order of the columns of the feature vectors from X_test / X_train;
 3. The indexes of the features corresponding to 'std()' and 'mean()' are used to filter the corresponding columns on the feature vectors.

3. The activities, contained in 'test/y_test.txt' and 'train/y_train.txt' are assigned to the feature vectores as an additional column, named 'al' (activity label).

4. The subjects identifiers, contained in 'test/subject_test.txt' and 'train/subject_train.txt', are also added to the feature vectors as another extra column 'id'.

5. The resulting feature vector, containing 'id' and 'al', is associated to the activity names, contained in 'activity_labels.txt' through the use of 'merge' function.

6. The result is a dataset containing all the previous columns (all mean and std features, 'id' and 'al') plus a new column 'activity' with the activity name.

7. This result is aggregated by 'id' and 'activity' (the column 'al' is discarded) in order to obtain the mean of the feature values per subject ('id') and activity.

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

Also the variable SEPARATOR should be set with the file path separator used by the operating system ('\\\\' for Windows or '/' for Unix / Mac OS X)

The RESULT can be set with the name of the data file containing the results. 
The file is generated in DATA.ROOT.

More details on executing 'run_analysis.R' can be found in 'README.md'. 

### Resulting Variables

"id" - Subject identification (1-30) 
"activity" - Activity name (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING and LAYING)
"mean.of.tBodyAcc.mean.X" - mean of means for measures from accelerometer for body on X axis 
"mean.of.tBodyAcc.mean.Y" - same as above for Y axis
"mean.of.tBodyAcc.mean.Z" - same as above for Z axis
"mean.of.tBodyAcc.std.X" - mean of standard deviations from accelerometer body on X axis
"mean.of.tBodyAcc.std.Y" - same as above for Y axis
"mean.of.tBodyAcc.std.Z" - same as above for Z axis
"mean.of.tGravityAcc.mean.X" - mean of means for measures for measures from accelerometer for gravity on X axis 
"mean.of.tGravityAcc.mean.Y" - same as above for Y axis
"mean.of.tGravityAcc.mean.Z" - same as above for Z axis 
"mean.of.tGravityAcc.std.X" - mean of standard deviations for measures from accelerometer for gravity on X axis  
"mean.of.tGravityAcc.std.Y"  - same as above for Y axis
"mean.of.tGravityAcc.std.Z"  - same as above for Z axis
"mean.of.tBodyAccJerk.mean.X" - mean of measores 
"mean.of.tBodyAccJerk.mean.Y" 
"mean.of.tBodyAccJerk.mean.Z"
"mean.of.tBodyAccJerk.std.X"
"mean.of.tBodyAccJerk.std.Y"
"mean.of.tBodyAccJerk.std.Z"
"mean.of.tBodyGyro.mean.X"
"mean.of.tBodyGyro.mean.Y"
"mean.of.tBodyGyro.mean.Z"
"mean.of.tBodyGyro.std.X"
"mean.of.tBodyGyro.std.Y"
"mean.of.tBodyGyro.std.Z"
"mean.of.tBodyGyroJerk.mean.X"
"mean.of.tBodyGyroJerk.mean.Y"
"mean.of.tBodyGyroJerk.mean.Z"
"mean.of.tBodyGyroJerk.std.X"
"mean.of.tBodyGyroJerk.std.Y"
"mean.of.tBodyGyroJerk.std.Z"
"mean.of.tBodyAccMag.mean"
"mean.of.tBodyAccMag.std"
"mean.of.tGravityAccMag.mean"
"mean.of.tGravityAccMag.std"
"mean.of.tBodyAccJerkMag.mean"
"mean.of.tBodyAccJerkMag.std"
"mean.of.tBodyGyroMag.mean"
"mean.of.tBodyGyroMag.std"
"mean.of.tBodyGyroJerkMag.mean"
"mean.of.tBodyGyroJerkMag.std"
"mean.of.fBodyAcc.mean.X"
"mean.of.fBodyAcc.mean.Y"
"mean.of.fBodyAcc.mean.Z"
"mean.of.fBodyAcc.std.X"
"mean.of.fBodyAcc.std.Y"
"mean.of.fBodyAcc.std.Z"
"mean.of.fBodyAccJerk.mean.X"
"mean.of.fBodyAccJerk.mean.Y"
"mean.of.fBodyAccJerk.mean.Z"
"mean.of.fBodyAccJerk.std.X"
"mean.of.fBodyAccJerk.std.Y"
"mean.of.fBodyAccJerk.std.Z"
"mean.of.fBodyGyro.mean.X"
"mean.of.fBodyGyro.mean.Y"
"mean.of.fBodyGyro.mean.Z"
"mean.of.fBodyGyro.std.X"
"mean.of.fBodyGyro.std.Y"
"mean.of.fBodyGyro.std.Z"
"mean.of.fBodyAccMag.mean"
"mean.of.fBodyAccMag.std"
"mean.of.fBodyBodyAccJerkMag.mean"
"mean.of.fBodyBodyAccJerkMag.std"
"mean.of.fBodyBodyGyroMag.mean"
"mean.of.fBodyBodyGyroMag.std"
"mean.of.fBodyBodyGyroJerkMag.mean"
"mean.of.fBodyBodyGyroJerkMag.std"
