# Getting-and-Cleaning-Data
Repository containing files for the final assignment of the getting and cleaning data course.


## This file contains the scripts for Coursera course "Getting and Cleaning Data" - Final Assignment
## It is authored by Laurent Barcelo on July 29, 2016

## THE FOLLOWING CONTAINS DETAILED NOTES FOR 2 FUNCTIONS and SCRIPT SEQUENCE FOR THE FINAL ASSIGNMENT

## functions description
## 1. read_name(): Function that readsfile, assign to a variable, labels column properly and writes the cleaned file back to disk
## 2. mergefiles(): function tht reads 2 files and merge them with cbind or rbind and writes the merged file to disc
## See the read_name.r and mergefiles.r for the script of the functions


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


## CORRESPONDING SCRIPTS
## script for sequence 1
read_name("/Users/lbarcelo/R_Repo/Coursera/UCI HAR Dataset", "activity_labels.txt", c("activity_code", "activity_desc"))
  ## This gives meaningful column names to the activity labels file and save to cl_activity_labels.txt

## script for sequence 2
read_name("/Users/lbarcelo/R_Repo/Coursera/UCI HAR Dataset", "features.txt", c("features_code", "features_desc"))
  ## This gives meaningful column names to the features file and save to cl_features.txt

## script for sequence 3
activity<-read.table("cl_activity_labels.txt") ## Creates a activity data frame
read_name("/Users/lbarcelo/R_Repo/Coursera/UCI HAR Dataset/train", "X_train.txt", features$features_desc)
  ## This gives meaningful column names to the X_train file

## script for sequence 4
read_name("/Users/lbarcelo/R_Repo/Coursera/UCI HAR Dataset/train", "Y_train.txt", "activity_code")
read_name("/Users/lbarcelo/R_Repo/Coursera/UCI HAR Dataset/train", "subject_train.txt", "subject_code")
  ## This gives meaningful column name to the Y_train file and subject_train.txt and writes it to cl_Y_train.txt and cl_subject_train.txt

## script for sequence 5
mergefiles("/Users/lbarcelo/R_Repo/Coursera/UCI HAR Dataset/train", "c", "cl_subject_train.txt", "cl_Y_train.txt", "cl_sY_train.txt")
mergefiles("/Users/lbarcelo/R_Repo/Coursera/UCI HAR Dataset/train", "c", "cl_sY_train.txt", "cl_X_train.txt", "cl_XY_train.txt")
  ## this merges the files with subject code and activity code with the measured features. Saves to cl_XY_train.txt

##script for sequence 6
activity<-read.table("cl_activity_labels.txt") ## Creates a activity data frame
read_name("/Users/lbarcelo/R_Repo/Coursera/UCI HAR Dataset/test", "X_test.txt", features$features_desc)
read_name("/Users/lbarcelo/R_Repo/Coursera/UCI HAR Dataset/test", "Y_test.txt", "activity_code")
read_name("/Users/lbarcelo/R_Repo/Coursera/UCI HAR Dataset/test", "subject_test.txt", "subject_code")
mergefiles("/Users/lbarcelo/R_Repo/Coursera/UCI HAR Dataset/test", "c", "cl_subject_test.txt", "cl_Y_test.txt", "cl_sY_test.txt")
mergefiles("/Users/lbarcelo/R_Repo/Coursera/UCI HAR Dataset/test", "c", "cl_sY_test.txt", "cl_X_test.txt", "cl_XY_test.txt")
  ## this reproduces the sames steps as 3-5 with the test data files

##script for sequence 7
setwd("/Users/lbarcelo/R_Repo/Coursera/UCI HAR Dataset/train")
cl_XY_train<-read.table("cl_XY_train.txt")
setwd("/Users/lbarcelo/R_Repo/Coursera/UCI HAR Dataset/test")
cl_XY_test<-read.table("cl_XY_test.txt")
setwd("/Users/lbarcelo/R_Repo/Coursera/UCI HAR Dataset")
write.table(cl_XY_train, "cl_XY_train.txt")
write.table(cl_XY_test, "cl_XY_test.txt")
  ## first copy cl_XY_test.txt cl_XY_train.txt to same directory
mergefiles("/Users/lbarcelo/R_Repo/Coursera/UCI HAR Dataset", "r", "cl_XY_train.txt", "cl_XY_test.txt", "cl_XY.txt")
  ## merge train and test files by row (direction "r") and copy to cl_XY.txt

## Script for sequence 8
activity_labels<-read.table("cl_activity_labels.txt")
cl_XY<-read.table("cl_XY.txt")
cl_XY$sorting_key<-as.numeric(row.names(cl_XY))    ##sorting key vector added to cl_XY
write.table(cl_XY, "cl_XY.txt") ## writes to disc
cl_XYb<-merge(activity_labels, cl_XY, by.x="activity_code", by.y="activity_code") ## mergin of activity label description
cl_XYc<-cl_XYb[order(cl_XYb$sorting_key),] ## resorting of the file as the merge function has changed row order.
write.table(cl_XYc, "cl_XYc.txt") ## File (train and test) are now merged, with descriptive activity names.

## Script for sequence 9
selcolumns<-grep("mean|std", names(cl_XYc)) ## selects the columns containing only the mean or std deviation information and store in selcolumns vector
selcolumns<-c(1,2,3,selcolumns, 565) ## addition of the 3 first columns that give activity codes and sorting key (last column).
cl_XYs<-cl_XYc[,selcolumns] ## stores in cl_XYs only the columns with Std and mean values
write.table(cl_XYs, "cl_XYs.txt") ## and writes it to disc

## Script for sequence 10
temp_var<-aggregate(cl_XYs, by = list(cl_XYs$subject_code , cl_XYs$activity_desc), FUN="mean") ## aggregation by subject and by activity
  ## the following lines are for updating column names
columnsel<-c(1, 2, 3, 6:84) 
cl_XYsplit<-temp_var[,columnsel]
mynames<-names(cl_XYsplit)
mynames[1]<-"subject_code"
mynames[2]<-"activity_desc"
names(cl_XYsplit)<-mynames
write.table(cl_XYsplit, "cl_XYsplit.txt", row.name=FALSE)


