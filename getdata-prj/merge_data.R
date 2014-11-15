###
# Merge Data
#
#- 'activity_labels.txt': Links the class labels with their activity name.
#- 'train/X_train.txt': Training set.
#- 'train/y_train.txt': Training labels. 
#- 'test/X_test.txt': Testing set.
#- 'test/y_test.txt': Testing labels. 
#

DATA.ROOT <- "C:\\tmp\\data\\UCI_HAR_Dataset"

#
# 1. Merge test and training data
#

X_test.file <- paste(DATA.ROOT, "test\\X_test.txt", sep="\\")
X_test <- read.table(X_test.file)

y_test.file <- paste(DATA.ROOT, "test\\y_test.txt", sep="\\")
y_test <- read.table(y_test.file)

X_train.file <- paste(DATA.ROOT, "train\\X_train.txt", sep="\\")
X_train <- read.table(X_train.file)

y_train.file <- paste(DATA.ROOT, "train\\y_train.txt", sep="\\")
y_train <- read.table(y_train.file)

X_data <- rbind(cbind(X_test, y_test), cbind(X_train, y_train))

features.file <- paste(DATA.ROOT, "features.txt", sep="\\")
features <- read.table(features.file, colClasses="character")

names(X_data) <- c(features[,2], "al") # activity label key 

# X_data contains data merged from X_test and X_train, with column names from features.txt.
# 'al' field contains the key for the activity

#
# 2. Extracts only the measurements on the mean and standard deviation for each measurement
#
# Assuming that mean() and std() mark the variables that contain mean and std respectively
#

key.positions =  which(colnames(X_data) == 'al')
mean.std.positions <- grep("(mean|std)\\(\\)", names(X_data))
data.mean.std <- X_data[,c(key.positions, mean.std.positions)]

#
# 'data.mean.std' contains mean/std's measurements and identifiers for the activities
#

#
# 3. Uses descriptive activity names to name the activities in the data set
#

activity_label.file <- paste(DATA.ROOT, "activity_labels.txt", sep="\\")
activity_label <- read.table(activity_label.file)

names(activity_label) <- c("al", "activity")

data.mean.std.act <- merge(data.mean.std, activity_label, by="al")

#
# 4. Appropriately labels the data set with descriptive variable names. 
#
