library(reshape2)

## Read the relevant .txt files into R.
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")
features<-read.table("UCI HAR Dataset/features.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
X_test<-read.table("UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("UCI HAR Dataset/test/Y_test.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("UCI HAR Dataset/train/Y_train.txt")

## Merge the test and training sets and store the result to the data frame "data".
data<-rbind(X_train, X_test)

## Assign descriptive variable names by using the features.txt file. 
names(data)[1:dim(data)[2]]<-make.names(features$V2, unique=TRUE)

## Extract only the measurements on the mean and standard deviation for each measurement. 
data<-data[grepl("mean\\.\\.", names(data)) | grepl("std\\.\\.", names(data))]

## Append the subject IDs to the data.
data<-cbind(data, rbind(subject_train, subject_test))
names(data)[dim(data)[2]]<-"Subject"

## Append the activity IDs to the data.
data<-cbind(data, rbind(Y_train, Y_test))
names(data)[dim(data)[2]]<-"Activity"

## Give descriptive activity names from activity_labels.txt.
for (i in 1:dim(data)[1]){
  data$Activity[i]<-as.character(activity_labels$V2[as.integer(data$Activity[i])])
}
data$Activity<-as.factor(data$Activity) ## Converts the Activities back to factors (from strings).

## Make an independent data set "tidy_data".
## Melt the "data" data frame with respect to Subject and Activity and assign it to "tidy_data".
tidy_data<-melt(data, id.vars = c("Subject", "Activity"))

## Cast "tidy_data" so that it contains the average of each variable for each activity and each subject.
tidy_data<-dcast(tidy_data, Subject + Activity ~ variable, fun = mean)

## Output a .txt file.
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)