
#{
# run_analysis.R - an R script that creates data set called motion_study by
# combining datasets of activity names, activity, subject and measurement 
# data from test data and merging them with a training data set created in
# a similar manner, to create one data set, and then extracts mean values 
# of the measurements on the mean and standard deviation for each 
# measurement, for each activity and each subject, and writes the resulting data
# a file named motion_summary.txt. 
#This function also outputs a list of all the 
#Author: Warwick Taylor
#Date: 
#Available data sets are:
#activity_labels - labels for activities
#X_test - test measurements
#Y_test - test activities for each measurement.
#test_subjects - number of test subject
#x_train - training data measurements
#Y_train - training activity for each measurement
#train_subjects - number of training subject

library(dplyr)
library(data.table)

run_analysis<-function() {
# Find field names for X_test and X_train
field_names<-read.table("features.txt", sep=" ",stringsAsFactors = FALSE)

#Create character matrix of field names for X_test and Y_test

wanted_features<-grep("mean|std", field_names[,2])
fnames<-as.character(field_names[wanted_features,2])



# Read activity labeels, test subjects, training subjects, test and training data.

activity_labels<-read.table("activity_labels.txt",sep=" ",stringsAsFactors = FALSE)
test_subjects<-read.csv("test/subject_test.txt",header = FALSE)
train_subjects<-read.csv("train/subject_train.txt",header = FALSE)
X_test<-fread("test/X_test.txt",sep=" ",stringsAsFactors = FALSE)
Y_test<-fread("test/y_test.txt",sep=" ",stringsAsFactors = FALSE)
X_train<-fread("train/X_train.txt",sep=" ",stringsAsFactors = FALSE)
Y_train<-fread("train/y_train.txt",sep=" ",stringsAsFactors = FALSE)

#Create data set linking activity number to activity description.

activities<-merge(activity_labels, Y_test, by.x=1, by.y=1)

#Combine test subjects, activities and measurements.

test_set<-cbind(test_subjects, activities, data.table(X_test)[,wanted_features, with=FALSE])


#Make data set of training activity numbers and descriptions.
train_activities<-merge(activity_labels, Y_train, by.x=1, by.y=1)

#Create training data set

train_set<-cbind(train_subjects,train_activities,data.table(X_train)[,wanted_features, with=FALSE])

#Now make full data set 

motion_study<-rbind(test_set,train_set)

#Make field names for data set.

wanted_cols<-c("subject", "activity", paste0("mean_",fnames,sep=""))
wanted_names<-gsub("\\(\\)","", wanted_cols)
exptnames<-c("subject","activity_no","activity",wanted_names[3:length(wanted_names)])

# Label data

colnames(motion_study)<-exptnames

# Extract data required - ie.,subject, activity, and average and standard deviation measurements

wanted<-select(motion_study,-contains("activity_no"))

# Write basis of codebook

fwrite(transpose(as.list(wanted_names)), "codebook.stub")

#Now produce a data set of means of all measurement for each subject and activity

output_means<-wanted%>%group_by(subject, activity)%>%summarise_all(mean)
fwrite(output_means, "motion_summary.txt")
}


