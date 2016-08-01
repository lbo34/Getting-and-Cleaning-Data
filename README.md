# Getting-and-Cleaning-Data
Repository containing files for the final assignment of the getting and cleaning data course.


## This file contains the scripts for Coursera course "Getting and Cleaning Data" - Final Assignment
## It is authored by Laurent Barcelo on July 29, 2016

## THE FOLLOWING CONTAINS DETAILED NOTES FOR 2 FUNCTIONS and SCRIPT SEQUENCE FOR THE FINAL ASSIGNMENT

## functions description
## 1. read_name(): Function that readsfile, assign to a variable, labels column properly and writes the cleaned file back to disk
## 2. mergefiles(): function tht reads 2 files and merge them with cbind or rbind and writes the merged file to disc
## See the functions.r for the script of the functions


## Script sequence
## 1. run read_name() with activity_labels.txt and assign meaningful column names
## 2. run read_name() with features.txt and assign meaningful column names
## 3. assign the features labels to a vector and run read_name with X_train.txt and assign the feature labels as column heads
## 4. run readname() with y_train and assign the "activity_code" column name and do the same for subject_train.txt
## 5. run mergefiles() with "cl_Y_train.txt" and "cl_X_train.txt" and "cl_subject_train.txt" with direction "c" (=cbind) and write to "cl_XY_train.txt" 
## 6. rerun items 3-5 with the test files
## 7. merge train and test files obtained in steps 5 and 6 and paste direction "r" (=rbind) and write to "cl_XY.txt"
## 8. assign the activity label by merging the "cl_activity_label.txt" and "cl_XY.txt" files by matching the activity_code
## 9. selection of columns with mean and standard deviation and writes to disc /// THIS FILE (cl_XYs.txt) CORRESPONDS TO DELIVERABLES 1 - 4 of the ASSIGNMENT
## 10. produce a tidy data set with average by activity and subject
## See the script.r for the detailed script


