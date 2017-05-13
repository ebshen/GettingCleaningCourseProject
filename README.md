# GettingCleaningCourseProject

one R script called run_analysis.R that reads in the following files:
* features.txt (the names for the feature vector)
* activity_labels.txt (the labels for the activities)
* X_train.txt (the training data, observations of the feature vector)
* subject_train.txt (the corresponding subjects for the observations in X_train.txt)
* y_train.txt (the correspnding activities for the observations in X_train.txt)
* X_test.txt (the test data, observations of the feature vector)
* subject_test.txt (the corresponding subjects for the observations in X_test.txt)
* y_test.txt (the correspnding activities for the observations in X_test.txt)

run_analysis.R performs the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

The second data set is written to a file, averages.txt
