==================================================================
Getting and Cleaning Data Course Project
Version 1.0
==================================================================
Aldo Bustamante Campo

Johns Hopkins University
Coursera

www.coursera.org - www.jhu.edu
==================================================================
*features
   Length       Class        Mode 
      561   character   character 
Stores the names of the measured variables of the experiment


*subjectTest
   Length       Class    
    2947 x 1   data.frame 

*xTest
   Length       Class    
    2947 x 561   data.frame 

* yTest.activity
   Length       Class    
    2947 x 1   data.frame

* data.test
   Length       Class    
    2947 x 563   data.frame 
data frame that integrates the data collected for the test group
-------------------------------------------------------------------

*subjectTrain
   Length       Class    
    2947 x 1   data.frame 

*xTrain
   Length       Class    
    2947 x 561   data.frame 

* yTrain.activity
   Length       Class    
    2947 x 1   data.frame

* data.Train
   Length       Class    
    2947 x 563   data.frame 
data frame that integrates the data collected for the Train group
-------------------------------------------------------------------
* DFComplete
   Length       Class    
   10299 x 563   data.frame 
data frame that integrates the data of the test group and the training group

* mean.std
   Length       Class    
   80   	integer
vector that stores the indices of the vector features in which they correspond with the regular expression 'mean | std'

*data.mean.std
   Length       Class    
   10299 x 81   data.frame 
data frame made up of the variables of the DFComplete data frame whose indices correspond to the values stored in mean.std

* replaced
Length       Class    
   81        Character
-----------------------------------------------------------------
Vector that stores the names of the variables of the data.mean.std data frame, these names are modified from those that originally come from the DFComplete data frame, so that you have more descriptive names according to the following conventions:

- "[(][)]"  is replaced by ""
- "^t"  is replaced by "TimeDomain_"
- "^f"  is replaced by "FrequencyDomain_"
- "Acc"  is replaced by "Accelerometer"
- "Gyro"  is replaced by "Gyroscope"
- "Mag"  is replaced by "Magnitude"
- "-mean-"  is replaced by "Mean_"
- "-std-"  is replaced by "StandardDeviation_"
- "-"  is replaced by "_"
--------------------------------------------------------------

* data.tidy
   Length       Class    
   180 x 81     data.frame

data frame resulting from sorting data.mean.std according to activity and topic, the grouped data also presents the mean of each group
    
Aldo Bustamante. September 2012.
