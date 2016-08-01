## This file contains the scripts for Coursera course "Getting and Cleaning Data" - Final Assignment
## It is authored by Laurent Barcelo on July 29, 2016

## functions description
## 1. read_name(): Function that readsfile, assign to a variable, labels column properly and writes the cleaned file back to disk
## 2. mergefiles(): function tht reads 2 files and merge them with cbind or rbind and writes the merged file to disc

read_name<-function(mydir, filename, colnames) {
  ## This function performs the following actions:
  ## 1. assign the working directory
  ## 2. reads the file name and assigns to the varname
  ## 3. assigns understandable column names
  ## 4. writes the files with the same filename with a "cl_" addition to the filename
  ## 5. returns to initial directory
  
  ## Setting the working directory
  initialdirectory<-getwd()
  setwd(mydir)
  
  ## Reads the file name and assigns to the varname
  varname<-read.table(filename)
  names(varname)<-colnames
  
  ## writes cleaned file to new filename
  newmame<-paste0("cl_",filename)
  write.table(varname, newmame)
  
  ##Return to initial directory
  setwd(initialdirectory)
}


mergefiles<-function(mydir, direction, filename1, filename2, filename3) {
  ## This function performs the following actions:
  ## 1. assign the working directory
  ## 2. reads the filename1 and assigns to the varname1 & reads the filename2 and assigns to the varname2
  ## 3. cbind the datatables
  ## 4. writes the result in a file called filename3 to disc
  ## 5. returns to initial directory
  
  ## Setting the working directory
  initialdirectory<-getwd()
  setwd(mydir)
  
  ## Reads the filenames and assigns to the varnames
  varname1<-read.table(filename1)
  varname2<-read.table(filename2)
  if(direction=="c") {
    varname3<-cbind(varname1, varname2)
  }
  if(direction=="r") {
    varname3<-rbind(varname1, varname2)
  }
  
  ## writes cleaned file to new filename
  write.table(varname3, filename3)
  
  ##Return to initial directory
  setwd(initialdirectory)
}