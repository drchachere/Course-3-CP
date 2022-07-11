All data is originally from the url below:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Full description for dataset above:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 



df_1.csv
________

Combined the following datasets into df_1.csv:
- UCI_HAR_Dataset/train/subject_train.txt
- UCI_HAR_Dataset/train/X_train.txt
- UCI_HAR_Dataset/train/y_train.txt
- UCI_HAR_Dataset/test/subject_test.txt
- UCI_HAR_Dataset/test/X_test.txt
- UCI_HAR_Dataset/test/y_test.txt

Created a list of subjects (1 - 30) for each measurement taken (from UCI_HAR_Dataset/train/subject_train.txt).  Then a list of mean and standard deviation scores from UCI_HAR_Dataset/train/X_train.txt was created.  This file contained many measurements (listed in UCI_HAR_Dataset/features.txt), so the indices of the desired measurements were identified and were then used to extract the desired measurements of each measurement in UCI_HAR_Dataset/train/X_train.txt.  Then a list of the actual activities being performed during each measurement was made (from the UCI_HAR_Dataset/train/y_train.txt).  Then these three lists were column binded to create the "top half" of df_1.  The same procedure described above was repeated for the corresponding "test" files to create the "bottom half" of df_1.  Then the "top" and "bottom" halfs of the dataset, representing the training and test data sets respectively, were row binded to create df_1.

The first column "subject" represents the id of the testing participants.

The last column "activity" represents the activity being performed by the testing participant at the time the measurements were taken.

The middle columns correspond to measurements named and described in UCI_HAR_Dataset/features_info.txt.  Original values were normalized and bounded within [-1,1].


df_2.csv
________

To create a dataframe from df_1 that had the average of all of the extracted measurements for each activity and each subject.  Data was grouped by activity and subject, in that order, and then averages were calculated for each group.  Before averages were calculated, the values of the df_1 dataframe had to be converted into numeric values.

The first column "activity" represents the activity being performed by the testing participant at the time the measurements were taken.

The second column "subject" represents the id of the testing participants.

The other columns correspond to the group averages of each of the measurements from df_1.  Please see UCI_HAR_Dataset/features_info.txt for more detail.  Original values were normalized and bounded within [-1,1].


excerpt from UCI_HAR_Dataset/README.md...
_________________________________________
===================================================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
===================================================================================================
Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Universit‡  degli Studi di Genova, Genoa (I-16145), Italy. 
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat PolitËcnica de Catalunya (BarcelonaTech). Vilanova i la Geltr˙ (08800), Spain
activityrecognition '@' smartlab.ws 