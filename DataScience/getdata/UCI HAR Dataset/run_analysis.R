
{
  # run_analysis.R - an R script that creates data set called motion_study by
  # combining datasets of activity names, activity, subject and measurement 
  # data from test data and merging them with a training data set created in
  # a similar manner, to create one data set, and then extracts mean values 
  # of the measurements on the mean and standard deviation for each 
  # measurement, for each activity and each subject.
  
  #Available data sets are:
  #activity_labels - labels for activities
  #X_test - test measurements
  #Y_test - test activities for each measurement.
  #test_subjects - number of test subject
  #x_train - training data measurements
  #Y_train - training activity for each measurement
  #train_subjects - number of training subject
  
  # Find field names for X_test and X_train
  field_names<-read.table("teatures.txt", sep=" ")
  
  #Create character matrix of field names for X_test and Y_test
  
  fnames<-as.vector(field_names)
  
  #Make field names for data set.
  
  exptnames<-c("subject","activity_no","activity",fnames[,2])
  
  #Create data set linking activity number to activity description.
  
  activities<-merge(activity_labels, Y_test, by.x=1, by.y=1)
  
  #Combine test subjects, activities and measurements.
  
  test_set<-cbind(test_subjects, activities,X_test)
  
  # Label data
  
  colnames(test_set)<-exptnames
  
  #Make data set of training activity numbers and descriptions.
  train_activities<-merge(activity_labels, Y_train, by.x=1, by.y=1)
  
  #Create training data set
  
  train_set<-cbind(train_subjects,train_activities,X_train)
  
  #Now make full data set 
  
  expt_set<-rbind(test_set,train_set)
  
  
  
  
  # Produce data set of training numbers and corresponding description
  train_activities<-merge(activity_labels, Y_train, by.x=1, by.y=1)  
}
