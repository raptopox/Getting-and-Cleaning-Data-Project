Codebook
========

## Analysis

The following steps were followed to produce the tidy data set:
 
* We downloaded the `.zip` file from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and we extracted the files into our working directory.
* From the necessary files (`activity_labels.txt`, `features.txt`, `subject_test.txt`, `X_test.txt`, `Y_test.txt`, `subject_train.txt`, `X_train.txt`, `Y_train.txt`) we created in R the 6x2 data frame `activity_labels`, the 561x2 data frame `features`, the 2947x1 data frame `subject_test`, the 2947x561 data frame `X_test`, the 2947x1 data frame `Y_test`, the 7352x1 data frame `subject_train`, the 7352x561 data frame `X_train` and the 7352x1 data frame `Y_train`. 
* We used `rbind()` to combine `X_train` and `X_test` into a 10299x561 data frame called `data`.
* We used the data frame `features` and the function `make.names()` to provide valid and unique names for the corresponding columns of the data frame `data`.
* We extracted from `data` only the columns that correspond to the mean and standard deviation for each measurement, by using the `grepl()` function to keep only names with main() and std() in them (thus excluding meanFreq). This resulted in `data` becoming a 10299x66 data frame.
* By combining `subject_train` and `subject_test`, we made a 561x1 data frame, which we appended to the end of our data, with the name "Subject", thus making `data` a 10299x67 data frame.
* By combining `Y_train` and `Y_test`, we made a 561x1 data frame, which we appended to the end of our data, with the name "Activities", thus making `data` a 10299x68 data frame.
* We used `activity_labels` to associate each activity ID with its descriptive name. In the end, the Activity column was converted back to a factor variable with levels the names of the activities.
* Using the `reshape2` library, we melted (using the `melt()` function) our data with respect to the variables "Subject" and "Activity" into a new thin data frame `tidy_data` of dimensions 679734x4.
* We used the function `dcast()` on `tidy_data` to compute the average of each variable in `data` for each activity and each subject and stored the result back to `tidy_data`, thus making the latter a 180x68 data frame. 
* Finally, we stored `tidy_data` into a `tidy_data.txt` file, using with `write.table()` with `row.name=FALSE`.

## Variable description

*Subject*: Integer between 1 and 30, indicating the number of the subject from which the respective measurements were taken.
*Activity*: Factor variable with levels "LAYING", "SITTING", "STANDING", "WALKING", "WALKING_DOWNSTAIRS" and "WALKING_UPSTAIRS".
*The rest of the variables*: Numeric variables that correspond to the average of the respective variables as described in the `feature_info.txt` file, with respect to Activity and Subject.
