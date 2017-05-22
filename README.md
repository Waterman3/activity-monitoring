activity-monitoring

Getting and Cleaning Data Course Project to produce a tidy dataset set from monitoring physical activity using smartphones.

Readme file for Getting and Cleaning Data Course Project

Author: Warwick Taylor

Aim: To summarise activities performed by trialists wearing smartphones by reporting the average displacements for each person for each of the following activities:

    walking;
    walking upstairs;
    walking downstairs;
    sitting;
    standing;
    laying.

The source data are contained in a zip file located at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Processing Steps

1.    Download zip file

2.    Examine contents of zip file

3.    Extract files from zip file.

4.    Find required fields

5.    Allocate names for required fields

6.    Read required data and make into a dataset with required fields.

7.   Find mean values of the mean and the standard deviation for each measurement, for each activity and each person
     and write to a file.

Steps 3 to 7 have been performed by the script run_analysis.R.

The output data are in file motion_summary.txt

The file motion_codebook.txt describes the output data.

Available data files are:
activity_labels.txt - labels for activities
X_test.txt - test measurements
Y_test.txt - test activities for each measurement.
test_subjects.txt - number of test subject
x_train.txt - training data measurements
Y_train.txt - training activity for each measurement
train_subjects.txt - number of training subject
features.txt - labels for measurements

The relative working directory for this project is UCI HAR Dataset, which is a directory created by unzipping the downloaded data file.

