## Read the data

### Define the working directory

getwd()


### Load Packages
library(data.table)
library(reshape2)

### Locate the folder with the data to use
dir<-setwd("C://Users/demyc 13/Documents/Geovanni/Coursera (Data Science)/Cleaning Data/Quiz/Project")
pathIn <- file.path(dir, "UCI HAR Dataset")

### Read the subject files
dtSubjectTrain <- fread(file.path(pathIn, "train", "subject_train.txt"))
dtSubjectTest <- fread(file.path(pathIn, "test", "subject_test.txt"))

### Read the activity files (label files).

dtActivityTrain <- fread(file.path(pathIn, "train", "Y_train.txt"))
dtActivityTest <- fread(file.path(pathIn, "test", "Y_test.txt"))

### Read the data files. 
dtTrain <- fread(file.path(pathIn, "train", "X_train.txt"))
dtTest <- fread(file.path(pathIn, "test", "X_test.txt"))

## Merge the training and the test sets

### Concatenate the data tables

dtSubject <- rbind(dtSubjectTrain, dtSubjectTest)
setnames(dtSubject, "V1", "subject")
dtActivity <- rbind(dtActivityTrain, dtActivityTest)
setnames(dtActivity, "V1", "activityNum")
dt <- rbind(dtTrain, dtTest)

### Merge columns

dtSubject <- cbind(dtSubject, dtActivity)
dt <- cbind(dtSubject, dt)

### Set key

setkey(dt, subject, activityNum)

## Extract only the mean and standard deviation

### Read the features.txt file

dtFeatures <- fread(file.path(pathIn, "features.txt"))
setnames(dtFeatures, names(dtFeatures), c("featureNum", "featureName"))

### Subset only measurements for the mean and standard deviation

dtFeatures <- dtFeatures[grepl("mean\\(\\)|std\\(\\)", featureName)]

### Convert the column numbers to a vector of variable names matching columns in dt.

dtFeatures$featureCode <- dtFeatures[, paste0("V", featureNum)]

### Subset these variables using variable names.

select <- c(key(dt), dtFeatures$featureCode)
dt <- dt[, select, with = FALSE]

## Use descriptive activity names

### Read activity_labels.txt file. 

dtActivityNames <- fread(file.path(pathIn, "activity_labels.txt"))
setnames(dtActivityNames, names(dtActivityNames), c("activityNum", "activityName"))

## Label with descriptive activity names

### Merge activity labels

dt <- merge(dt, dtActivityNames, by = "activityNum", all.x = TRUE)

### Add activityName as a key.

setkey(dt, subject, activityNum, activityName)

### Melt the data table to reshape it from a short and wide format to a tall and narrow format.

dt <- data.table(melt(dt, key(dt), variable.name = "featureCode"))

### Merge activity name.

dt <- merge(dt, dtFeatures[, list(featureNum, featureCode, featureName)], by = "featureCode", all.x = TRUE)

### Create a new variable, activity (equivalent to activityName) as a factor class. 
### Create a new variable, feature (equivalent to featureName) as a factor class.

dt$activity <- factor(dt$activityName)
dt$feature <- factor(dt$featureName)

### Seperate features from featureName using the helper function grepthis.

grepthis <- function(regex) {
  grepl(regex, dt$feature)
}
## Features with 2 categories
n <- 2
y <- matrix(seq(1, n), nrow = n)
x <- matrix(c(grepthis("^t"), grepthis("^f")), ncol = nrow(y))
dt$featDomain <- factor(x %*% y, labels = c("Time", "Freq"))
x <- matrix(c(grepthis("Acc"), grepthis("Gyro")), ncol = nrow(y))
dt$featInstrument <- factor(x %*% y, labels = c("Accelerometer", "Gyroscope"))
x <- matrix(c(grepthis("BodyAcc"), grepthis("GravityAcc")), ncol = nrow(y))
dt$featAcceleration <- factor(x %*% y, labels = c(NA, "Body", "Gravity"))
x <- matrix(c(grepthis("mean()"), grepthis("std()")), ncol = nrow(y))
dt$featVariable <- factor(x %*% y, labels = c("Mean", "SD"))
## Features with 1 category
dt$featJerk <- factor(grepthis("Jerk"), labels = c(NA, "Jerk"))
dt$featMagnitude <- factor(grepthis("Mag"), labels = c(NA, "Magnitude"))
## Features with 3 categories
n <- 3
y <- matrix(seq(1, n), nrow = n)
x <- matrix(c(grepthis("-X"), grepthis("-Y"), grepthis("-Z")), ncol = nrow(y))
dt$featAxis <- factor(x %*% y, labels = c(NA, "X", "Y", "Z"))

## Create a tydy data set

### Create a data set with the average of each variable for each activity and each subject.

setkey(dt, subject, activity, featDomain, featAcceleration, featInstrument, featJerk, featMagnitude, featVariable, featAxis)
dtTidy <- dt[, list(count = .N, average = mean(value)), by = key(dt)]
write.csv(dtTidy,file="TidyData.csv")