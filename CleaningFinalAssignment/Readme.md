************************************************************************
Running analysis on Human Activity Recognition Using Smartphones Dataset
************************************************************************

The run_analysis.R script generates a file containing the average value of a series of features measured during experiments carried out with 30 volunteers subjects performing a series of six activities: LAYING, SITTING, STABDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS 

The output file contains 180 records of 81 variables. Complete description of all variables is available in the code book provided with the script.

Before executing this script, make sure to save it in the same directory as the raw data.
You may want to set your working directory accordingly

Raw data are available as a ZIP folder containing text files on the following address
##  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones ##

Data are split in two sets based on random selection of volunteers: test and trainning 

The dataset includes the following files:
=========================================

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training activities labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals: raw data ignored here

- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test activities labels.
- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'test/Inertial Signals: raw data ignored here

For each set, the run_analysis.R script will load the files related to subjects and activities and name the variables
Then it will load the measurement features data (X_train.txt and X_test.txt)
The features.txt file is loaded as it contains the complete list of feature variables

A subset of this file is taken to retain only the mean and standard deviation data as well as mean frequencies for for frequency measurements
Variable names are then cleaned up (all lower case, descriptive names, removal of special characters)
Measurement data for training and test sets are then selected using the index of the subset features file (feat2) corresponding to the retained variables

For each set (trainning and test) a single file is then created with the complete information: activities, subject, mean and standard deviation features measurement data
test and Trainning files are then collated together and columns rearranged

Finaly a new dataset is generated to provide the average of all mean and standard deviation feature measurement grouped by activities and subject
This file is saved as AverageMeasurementData.csv in the root folder 


NOTE
===========

This script uses dplyr package and for certainty, will load it at the beginning

Explanation on how raw data have been generated can be found in the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
