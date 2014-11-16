###
#
# According to the README.txt file provided with the dataset:
#
#- 'activity_labels.txt': Links the class labels with their activity name.
#     e.g. 1: WALKING,... 6: LAYING.
#- 'features.txt': list of 561 the features 
#     e.g. 1: tBodyAcc-mean()-X, ..., 58: tGravityAcc-energy()-Y, ... 561: angle(Z,gravityMean)
#
# Also according to README.TXT, each line in files below, for 'train' and 'test', correspond to reading containing
#   - A 561-feature vector with time and frequency domain variables. 
#   - Its activity label. 
#   - An identifier of the subject who carried out the experiment.
# 
# Train:
#- 'train/X_train.txt': Training set (561-fature vector with time and frequency domain variables).
#- 'train/y_train.txt': Training activity labels (1-6) 
#- 'train/subject_train.txt: identifier for the subjects in training data
#
# Test:
#- 'test/X_test.txt': Testing set (the 561-feature vector for tests).
#- 'test/y_test.txt': Testing activity labels (1-6). 
#- 'test/subject_test.txt: identifier for the subjects in test data
#

DATA.ROOT <- "C:\\tmp\\data\\UCI_HAR_Dataset"

#
# 1. Merge test and training feature vectors
#

X_test.file <- paste(DATA.ROOT, "test\\X_test.txt", sep="\\")
X_test <- read.table(X_test.file)

X_train.file <- paste(DATA.ROOT, "train\\X_train.txt", sep="\\")
X_train <- read.table(X_train.file)

# *IMPORTANT* We established this order: 1st. Test, 2nd. Training Data
# This order should be the same for merging activity labels and subject identifiers

# Here, only feature vectors are merged
X_data <- rbind(X_test, X_train)

#
# 2. Extracts only the measurements on the mean and standard deviation for each measurement
#
# According to the file 'features_info.txt', mean and std are identifed by mean() and std() 

features.file <- paste(DATA.ROOT, "features.txt", sep="\\")
features <- read.table(features.file, colClasses="character")

# create a vector with the positions of the measurements corresponding to mean() and std()
mean.std.positions <- grep("(mean|std)\\(\\)", features[,2]) #features contain names at the 2nd column
# these positions should correspond to the positions in the feature vectors
X_data.mean.std <- X_data[,mean.std.positions]

#
# 3. Uses descriptive activity names to name the activities in the data set
#

# retrieves activity labels

y_test.file <- paste(DATA.ROOT, "test\\y_test.txt", sep="\\")
y_test <- read.table(y_test.file)

y_train.file <- paste(DATA.ROOT, "train\\y_train.txt", sep="\\")
y_train <- read.table(y_train.file)

# also retrieves subject identifier here, to have all data in a single row

subject_test.file <- paste(DATA.ROOT, "test\\subject_test.txt", sep="\\")
subject_test <- read.table(subject_test.file)

subject_train.file <- paste(DATA.ROOT, "train\\subject_train.txt", sep="\\")
subject_train <- read.table(subject_train.file)

# Includes 2 new columns in the dataset:
#  1. subject id
#  2. activity label
# *IMPORTANT* Rows should be merged: 1st. Test, 2nd. Training. X_data already follows this order
data.mean.std.act <- cbind(rbind(subject_test, subject_train), rbind(y_test,y_train), X_data.mean.std)

# name the columns containing the subject id "id" and activity label "al". Assign names for the other columns as well, since that will facilitate the merge step
colnames(data.mean.std.act) = c("id", "al", features[,2][mean.std.positions]) 

activity_label.file <- paste(DATA.ROOT, "activity_labels.txt", sep="\\")
activity_label <- read.table(activity_label.file)
names(activity_label) <- c("al", "activity") # name de columns to facilitate 'merge' command. 

merged.data <- merge(data.mean.std.act, activity_label, by="al") 
# *IMPORTANT* After 'merge' command, rows/columns have been reordered.
#
# 4. Appropriately labels the data set with descriptive variable names. 
#
# This should be done by now. All data must have descriptive variable name assigned in the previous step.

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#

mean.data <- with(merged.data,aggregate(merged.data[,3:68], by=list(id, activity), FUN=mean))   
colnames(mean.data)[1:2]=c("id","activity")

