###
#
# According to the README.txt file provided with the dataset:
#
#- 'activity_labels.txt': Links the class labels with their activity name.
#     e.g. 1: WALKING,... 6: LAYING.
#- 'features.txt': list of 561 the features 
#     e.g. 1: tBodyAcc-mean()-X, ..., 58: tGravityAcc-energy()-Y, ... 561: angle(Z,gravityMean)
#
# Also according to README.TXT, each line in the files below, for 'train' and 'test', correspond to a observation containing
#   - A 561-feature vector with time and frequency domain variables. 
#   - Its activity label. 
#   - An identifier of the subject who carried out the experiment.
# 
# Train:
#
#- 'train/X_train.txt': Training set (561-fature vector with time and frequency domain variables).
#- 'train/y_train.txt': Training activity labels (1-6) 
#- 'train/subject_train.txt: identifier for the subjects in training data
#
# Test:
#
#- 'test/X_test.txt': Testing set (the 561-feature vector for tests).
#- 'test/y_test.txt': Testing activity labels (1-6). 
#- 'test/subject_test.txt: identifier for the subjects in test data
#

#
# *IMPORTANT*: This should be changed to the location where the dataset was extracted.
#

DATA.ROOT <- "C:\\tmp\\data\\UCI_HAR_Dataset"  # Windows style root path
RESULT <- "mean_file.txt" # default name
SEPARATOR <- "\\"  # Windows style path separator

#
# 1. Merge test and training feature vectors
#

X_test.file <- paste(DATA.ROOT, "test", "X_test.txt", sep=SEPARATOR) # X_test.txt full path
X_test <- read.table(X_test.file)

X_train.file <- paste(DATA.ROOT, "train", "X_train.txt", sep=SEPARATOR) # X_train.txt full path
X_train <- read.table(X_train.file)

# *IMPORTANT* We established this order: 1st. Test, 2nd. Training Data
# This order should be the same for merging activity labels and subject identifiers

# Here, only feature vectors rows are merged
X_data <- rbind(X_test, X_train)

#
# 2. Extracts only the measurements on the mean and standard deviation for each measurement
#
# According to the file 'features_info.txt', mean and std are identifed by 'mean()' and 'std()' 

features.file <- paste(DATA.ROOT, "features.txt", sep=SEPARATOR) # features.txt full path
features <- read.table(features.file, colClasses="character")

# create a vector with the positions of the columns corresponding to mean() and std()
mean.std.positions <- grep("(mean|std)\\(\\)", features[,2]) # features contain names at the 2nd column
# these positions should correspond to the positions in the feature vectors
X_data.mean.std <- X_data[,mean.std.positions] # subset of feature vectors with std and mean

#
# 3. Uses descriptive activity names to name the activities in the data set
#

# retrieves activity labels

y_test.file <- paste(DATA.ROOT, "test", "y_test.txt", sep=SEPARATOR)
y_test <- read.table(y_test.file)

y_train.file <- paste(DATA.ROOT, "train", "y_train.txt", sep=SEPARATOR)
y_train <- read.table(y_train.file)

# also retrieves subject identifier here, to have all data in a single row. It is easier to do it here because 'merge' will reorder the rows

subject_test.file <- paste(DATA.ROOT, "test", "subject_test.txt", sep=SEPARATOR) # subject_test.txt full path
subject_test <- read.table(subject_test.file)

subject_train.file <- paste(DATA.ROOT, "train", "subject_train.txt", sep=SEPARATOR) # subject_train.txt full path
subject_train <- read.table(subject_train.file)

# Includes 2 new columns at the beginning of the dataset:
#  1. subject id
#  2. activity label
# *IMPORTANT* Rows should be merged: 1st. Test, 2nd. Training. X_data already follows this order
data.mean.std.act <- cbind(rbind(subject_test, subject_train), rbind(y_test, y_train), X_data.mean.std)

# name the columns containing the subject id "id" and activity label "al". Assign names for the other columns as well, since that will facilitate the 'merge' ahead
colnames(data.mean.std.act) = c("id", "al", features[,2][mean.std.positions]) # This does part of step 4!

activity_label.file <- paste(DATA.ROOT, "activity_labels.txt", sep=SEPARATOR) # activity_labels.txt full path
activity_label <- read.table(activity_label.file)

names(activity_label) <- c("al", "activity") # name the columns to facilitate 'merge' command. 

merged.data <- merge(data.mean.std.act, activity_label, by="al") # merge activity labels to the dataset with measurements

# *IMPORTANT* After 'merge' command, rows are probably reordered.

#
# 4. Appropriately labels the data set with descriptive variable names. 
#
# This was done in the previous step, before 'merge' function. All measurements must have names corresponding to the original 'features.txt' in the previous step. Only the mean and std ones.

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#

# Uses 'aggregate' function to 
# aggregate all data by id and activity, applying function 'mean'
# columns 1:'id', 2: 'activity', 3:68 means and stds from measurements (to which 'mean' is applied), column 69: activity label. 

mean.data <- with(merged.data, aggregate(merged.data[,3:68], by=list(id, activity), FUN=mean))   
colnames(mean.data)[1:2]=c("id","activity") # fix columns referring to 'id' and 'activity'

# function to make a better names for measurements columns
f.make.mean.name = function(x) { 
  spl <- unlist(strsplit(make.names(x), "\\.")); # Breakdown names removing '(', ')' and '-'. They are not "plyr-friendly".
  spl <- spl[spl != ""]; # empty parts are removed
  paste(c("mean","of",spl), collapse=".") # join parts using '.' ("plyr-friendly") and include prefix 'mean.of'
}

# and apply makeover on names referring to measurements only: columns 3 to 68
colnames(mean.data)[3:68] = sapply(colnames(mean.data)[3:68], f.make.mean.name)

message("Script successfully executed. Check 'merged.data' and 'mean.data'")

result.file <- paste(DATA.ROOT, RESULT, sep=SEPARATOR) # result file full location
write.table(mean.data, file=result.file, row.names=F)

message("Dataset 'mean.data' written into ", result.file)
