README.md

DESCRIPTION OF WHAT THE SCRIPT SHOULD DO:
The R script, run_analysis.R, collects, works with, and cleans a data set. It prepares tidydataset.txt that can be used for later analysis. 

The data linked to from the following website represents data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available from that site: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
run_analysis.R uses data from: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

It does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

INSTRUCTIONS ON HOW TO USE THE SCRIPT:
run_analysis(directory=NA) will create a “Project” directory under the current working directory, unless a start directory is specified:
	run_analysis()		create “Project” directory under current working directory
	run_analysis(directory)	create “Project” directory under  ‘directory’
Notes: 
	The download URL is valid for Windows Vista Operating System. ..For pther Operating Systems the source may have to be changed to reflect a different URL structure.  For the MAC Operating System use: 
 fileURL = https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip"
download.file(fileURL, "UCI%20HAR%20Dataset.zip, method=curl)

	the output from run_analysis.R is a tidy data set, called tidydataset.txt, found under the ‘Project’ directory.

LISTING OF ALL RELATED FILES:
       README.md – this text file.  
       run_analysis.R – R script that creates a tidy data set based on raw data from
Under PROJECT directory:
       UCI HAR Dataset.zip – downloaded by run_analysis.R script .
      https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
	tidydataset.txt
Under: 	Project \UCI HAR Dataset directory
"	activity_labels.txt
       features.txt
       features_info.txt 
       README.txt	Describes all the unzipped files.
        test directory 
       train directory
Under Project\train directory
       "Inertial Signals
       subject_train.txt
       X_train.txt
       y_train.txt
Under Project\test directory
       Inertial Signals
       subject_test.txt
        X_test.txt
        y_test.txt
GENERAL DESCRIPTION OF RAW DATA :
	Please see the above file structure for files pertaining to the raw data.   

LINK TO CODEBOOK.MD:
https://github.com/CDCwrites/gettingandcleaningdataproject

Describes the tidydataset variables and the transformations.

