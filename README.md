# c3FinalProject
README.md
c3GetDataFinalProject


Human Activity Recognition Using Smartphones - A Summarized Tidy Dataset
==================================================================
pattonj6
12/19/2015


Summarize Steps - making tidy data:
=================================================================
The "original" dataset (reference [1]) contained a split data test set (21 person subjects) and training set (9 person subjects) of movement data collected
from a Samsung Galaxy IIs smartphone accelerometer and gyroscope. We created a tidy data set of the data, following these steps:

   1. Download/extract "original" data from here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
   2. We combined the separated, "original" training and test measurement datasets into a single data table with person subjects and activities performed.  
   3. Column names were edited into R syntactically compliant, and reader-friendly format.
   4. The combined data table was summarized into a "tidy data" set - 1) one observation per row and 2) one variable per column.
   5. We present the MEAN (average) of the mean and standard deviation columns in the "original "dataset, grouped by subject and activity.
   6. Running the 'run_analysis.R' code on the "original" data (step1) in your working directory will replicate the tidy data set output. (R Version 3.2.2 or later)

The 'c3FinalProject' github directory includes the following files:
=========================================
- 'README.md'		: info file, shows how to recreate tidy data set
- 'codebook.md'  	: shows information about the variables
- 'run_analysis.R'  	: R code to generate tidy data set from "original" dataset folder

Notes:
=========================================
- The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2).
- The gyroscope units are rad/seg.

"Original" Dataset Details:
=================================================================
The [original] experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities 
(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, we [the researchers] captured 3-axial linear acceleration and 3-axial angular velocity at 
a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned 
into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows 
of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, 
was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only 
low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained 
by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================
- MEAN (average) of the mean and standard deviation columns in the "original" dataset, grouped by person subject and activity.   
- Its activity label. 
- An identifier of the subject who carried out the experiment.

License:
=========================================
Dataset was referenced and given free license from:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the 
authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
