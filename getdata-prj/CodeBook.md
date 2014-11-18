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

### Resulting Variables

