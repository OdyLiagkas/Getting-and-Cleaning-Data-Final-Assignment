## This is the code book file that describes the variables, the data, and any transformations/work that performed to clean up the data. 

### In order to run the analysis first and foremost you have to download the R script included in this repo.

##### Don't worry about having the data sets downloaded. I have made it so that it automatically downloads the data for you in your working directory.
##### The raw (for us) data is obtained through the following link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 The data is collected from the accelerometers from the Samsung Galaxy S smartphone. 
##### A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 
### Variables found in file:
###### * url contains the url of the file that contains the Data Sets
###### * x_train , y_train and subject_train contain the data from the train Data Set
###### * x_test , y_test and subject_test contain the data from the test Data Set
###### * features contains the list of features
###### * activity_labels contains the correspondance of activity to numbered label
###### * train_merged and test_merged are the result of the merging of all of the train and all of the test Data Sets respectively
###### * merged_data contains the new merged Data Set
###### * column_names contains the names of the columns of the merged_data variable 
###### * id_mean_std contains the instances for the id, the mean and the std for each measurement in column_names
###### * id_mean_std_subset contains the subset of the merged_data using the id_mean_std vector
###### * id_mean_std_subset_with_activity_labels is the result of merging the above subset with the activity_labels variable
###### * second_set is the tidy data set with the average of each variable for each activity and each subject

### Regarding the actual R script file:
run_analysis.R does the following steps:
   
0. Reading files into tables using read.table()    
  0.0 Downloading and unzipping the data set
  0.1.1 Reading X_train.txt, y_test.txt and subject_train.txt files   
  0.1.2 Reading X_test.txt, y_test.txt and subject_test.txt files 
  0.1.3 Reading features.txt file 
  0.1.4 Reading activity_labels.txt   
  0.2 Assigning the correct variable names to the columns of the tables
1. Merging the training and the test sets to create one Merged Data Set.
2. Extracting only the measurements on the mean and standard deviation for each measurement.   
  2.1 Reading the column names of the merged Data Set  
  2.2 Creating variable for defining ID, mean and standard deviation   
  2.3 Creating the subset from merged Data Set containing the mean and standard deviation for each measurement   
3. Uses descriptive activity names to name the activities in the data set. 
4. Appropriately labels the data set with descriptive variable names.    
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.   
  5.1 Creating the 2nd tidy Data Set named 'second_set'   
  5.2 Writing the 2nd Data Set in a new txt file called 'output_data.txt'
