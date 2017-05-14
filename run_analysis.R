# one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)

# Read all relevant files

path <- "./GettingCleaningCourseProjectData/Data"

# read the common features and activities
features <- read.table(file.path(path,"features.txt"), stringsAsFactors = FALSE)
activities <- read.table(file.path(path,"activity_labels.txt"), stringsAsFactors = FALSE)

# read the training data
traindata <- read.table(file.path(path,"train/X_train.txt"))
trainsubject <- read.table(file.path(path,"train/subject_train.txt"))
trainactivity <- read.table(file.path(path,"train/y_train.txt"))

# read the test data
testdata <- read.table(file.path(path,"test/X_test.txt"))
testsubject <- read.table(file.path(path,"test/subject_test.txt"))
testactivity <- read.table(file.path(path,"test/y_test.txt"))

#############################################################
# 1. MERGE TRAINING AND TEST DATA SETS TO CREATE ONE DATA SET

# column bind subject, activity and data for training
completetraindata <- cbind(trainsubject, trainactivity, traindata)

# column bind subject, activity and data for test
completetestdata <- cbind(testsubject, testactivity, testdata)

# row bind the two data sets
totaldata <- rbind(completetraindata, completetestdata)

# create column names
names(totaldata) <- c("subject","activity",features[,2])

#############################################################
# 2. EXTRACT ONLY MEASUREMENTS ON MEAN AND STANDARD DEVIATION

# keep columns "subject", "activity", and matches with "mean" and "std"
# note that this also selects names with "meanFreq" and does not select any such as "gravityMean"

finaldata <- totaldata[, grepl("subject|activity|mean|std",names(totaldata))]

##########################################################################
# 3. USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET

# encode the integers in activity to the factor labels
finaldata$activity <- as.character(factor(finaldata$activity, levels = 1:6, labels = activities[,2]))

#######################################################
# 4. LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES

# names are already by the original descriptive variable name, but can remove the "()" to
# improve readability

names(finaldata) <- gsub("\\(\\)","",names(finaldata))

###################################################################################
# 5. CREATE SECOND INDEPENDENT TIDY DATA SET WITH AVERAGE OF EACH VARIABLE FOR EACH 
#    ACTIVITY AND EACH SUBJECT

# create new data set that has means of the features grouped by subject and activity

averages <- finaldata %>% group_by(subject, activity) %>% summarize_all(mean)
write.table(averages,"./GettingCleaningCourseProject/averages.txt", row.names = FALSE)
