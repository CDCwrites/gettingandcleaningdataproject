## run_analysis.R
##
##      PURPOSE:    
##          Create tidyDataSet and write to file: tidydataset.txt
##          - containing mean of all training and test vars grouped by (activity, participant)
##      DESC:
##          Merge training and test sets into tidyDataSet
##          Label activities in tidyDataSet with descriptive names
##          Label vars (columns) in tidyDataSet with descriptive names
##          Extract mean and std measurements from tidyDataSet
##          Create aggregation of average of each var in tidyDataSet by (activity, participant)
##      NOTES:
##          "UCI HAR Dataset.zip" is downloaded to "Project" directory
##              created from the current working directory or passed-parameter-string. 
##
##          The date and time of the download is reported to stdout
##
##          The download fileURL works on Windows Vista OS.
##
##          For the MAC OS use: 
##              fileURL = https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip"
##              download.file(fileURL, "UCI%20HAR%20Dataset.zip, method=curl)
##

run_analysis <- function( directory = NA ) {
    ##  directory       IN:     char vector 
    ##                  DESC:   start directory
    
    # unzip "UCI HAR Dataset" into "Project" directory
    # create dataset directory structure, if necessary
    #
    if ( !is.na( directory )) {
        mainDir <- directory
    }
    else {
        mainDir <- getwd()
    }

    newProjectDir <- "./Project"
    if( !file.exists( newProjectDir )) {
        dir.create( file.path( mainDir, newProjectDir ))
    }
    setwd( file.path( mainDir, newProjectDir ))
    zipFileName <- "UCI HAR Dataset.zip"
    if( !file.exists( zipFileName )) {
        fileURL = "http://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI HAR Dataset.zip"
        download.file( fileURL, zipFileName )
        
        # RECORD TIME dataset downloaded
        dateDownloaded <- date()
        print("downloaded zipfile: UCI HAR Dataset.zip")
        print(date())
        
        # unzip file
        unzip( zipFileName )
    }
    
    # change to dataset directory and read dataset tables into memory
    #
    setwd( "./UCI HAR Dataset" )
    getFeatures <- read.table( "./features.txt" ) # 'features' is numeric movement data of study-participants
    colnames(getFeatures) <- c("index", "featurename")
    getActivityLabels <- read.table( "./activity_labels.txt" ) # SITTING, WALKING, ...
    colnames( getActivityLabels ) <- c( "index", "activity" )
    
    setwd( "./train" )
    getMoves1 <- read.table( "X_train.txt" )  # read trained-study-participant movement
    getActivity1 <- read.table( "y_train.txt" )  # read trained-study-participant activity 
    getParticipants1 <- read.table( "subject_train.txt" ) # read trained-study-participant tag
    
    setwd("../test")
    getMoves2 <- read.table("X_test.txt")   # read study-participant movement
    getActivity2 <- read.table("y_test.txt")   # read study-participant activity
    getParticipants2 <- read.table("subject_test.txt") # read study-participant tag
    
    # combine analogous tables
    #
    studyPersons <- rbind( getParticipants1, getParticipants2 )
    colnames( studyPersons ) <- "participant"   
    
    # save activity data as strings 
    studyActivities <- rbind( getActivity1, getActivity2 )
    colnames(studyActivities) <- "activity"
    # translate activity-index to activity-string
    tmp <- as.character(unlist(getActivityLabels$activity))    
    for ( i in 1:nrow(studyActivities )) {
        studyActivities[i, "activity"] <- tmp[ as.numeric(studyActivities[i, "activity"]) ]
    }
        
    # combine trained-study and study participants moves
    studyMoves <- rbind( getMoves1, getMoves2 )
    # create descriptive column names 
    tmp <- getFeatures[ , "featurename"]
    tmp <- gsub("[Bb]odybody", "", tmp)
    tmp <- tolower(tmp)
    tmp <- gsub("[Bb]ody", "", tmp)
    tmp <- gsub("-", " ", tmp)
    tmp <- gsub("^[t]acc", "acceleration time ", tmp)
    tmp <- gsub("^[f]acc", "acceleration frequency ", tmp)
    tmp <- gsub("^[f]", "frequency ", tmp)
    tmp <- gsub("^[t]", "time ", tmp)
    tmp <- gsub("time gravityacc ", "time gravity acceleration ", tmp)
    colnames(studyMoves) <- tmp
    
    # make new tidydataset of analogous tables
    tidyDataSet <- cbind( cbind( studyPersons, studyActivities ), studyMoves)
    
    # extract person, activity, and mean and standard deviation columns from tidydataset
    dataSubset <- tidyDataSet[ , 1:2 ]
    tmp <- c( grep ("mean()", colnames(tidyDataSet), fixed=TRUE), grep ("std()", colnames(tidyDataSet), fixed=TRUE))
    df <- tidyDataSet[ , tmp]
    tmp2 <- c( grep ("std()", colnames(tidyDataSet), fixed=TRUE), grep ("std()", colnames(tidyDataSet), fixed=TRUE))
    df2 <- tidyDataSet[ , tmp2]
    newTidyDataSet <- cbind( cbind( dataSubset, df ), df2)
    
    # calculate means and remove duplicate cols
    aggregateData <- aggregate.data.frame(newTidyDataSet, by=list(activitygroup=newTidyDataSet$activity, participantgroup=newTidyDataSet$participant), FUN=mean, na.rm=TRUE, subset=newTidyDataSet[ , 3:ncols( newTidyDataSet )])
    df <- aggregateData[ , 1:2]
    colnames(df) <- c("activity", "participant")
    df2 <- aggregateData[ , 5:ncol( aggregateData )] 
    aggregateData <- cbind( df, df2 )
    
    # write newTidyDataSet to file under "Project" directory
    setwd( file.path( mainDir, newProjectDir ))
    write.table( aggregateData, "tidydataset.txt")
    
}
