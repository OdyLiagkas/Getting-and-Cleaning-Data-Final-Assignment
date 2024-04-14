#https://github.com/OdyLiagkas

library(plyr)
library(dplyr)

#0. reading files into tables using read.table()

# 0.0 - downloading the data set
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./dataset.zip")

# 0.0 - unzipping the data set
unzip(zipfile = "./dataset.zip", exdir = "./")


# 0.1.1 - reading X_train.txt, y_test.txt and subject_train.txt files
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# 0.1.2 - reading X_test.txt, y_test.txt and subject_test.txt files 
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")


# 0.1.3 - reading features.txt file 
features <- read.table("./UCI HAR Dataset/features.txt")

# 0.1.4 - reading activity_labels.txt 
activity_labels = read.table("./UCI HAR Dataset/activity_labels.txt")

# 0.2 - assigning the correct variable names to the columns of the tables
colnames(x_train) <- features[,2]
colnames(y_train) <- "activity_ID"
colnames(subject_train) <- "subject_ID"

colnames(x_test) <- features[,2]
colnames(y_test) <- "activity_ID"
colnames(subject_test) <- "subject_ID"

colnames(activity_labels) <- c("activity_ID", "activity")

# 1. - merging all datasets into one set
train_merged <- cbind(y_train, subject_train, x_train)
test_merged <- cbind(y_test, subject_test, x_test)
merged_data <- rbind(train_merged, test_merged)

# 2. extracting only the measurements on the mean and sd for each measurement

# 2.1 - reading the column names of the merged data set 
column_names <- colnames(merged_data)

# 2.2 - creating variable for defining ID, mean and standard deviation 
id_mean_std <- (grepl("activity_ID", column_names) | grepl("subject_ID", column_names) | grepl("mean..", column_names) | grepl("std...", column_names)
)

# 2.3 - creating the subset from merged Data Set containing the mean and standard deviation for each measurement
id_mean_std_subset <- merged_data[ , id_mean_std == TRUE]

# 3. - setting activity names to have descriptive activity names
id_mean_std_subset_with_activity_labels <- merge(id_mean_std_subset, activity_labels, by = "activity_ID", all.x = TRUE)

# 4. - now there are appropriate labels in the data set with descriptive variable names


# 5. - from the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

# 5.1 - creating the 2nd tidy Data Set named 'second_set'
second_set <- id_mean_std_subset_with_activity_labels %>%
    group_by(subject_ID, activity_ID) %>%
    summarise(across(everything(), mean)) %>%
    arrange(subject_ID, activity_ID)

# 5.2 - writing the 2nd Data Set in a new txt file called 'output_data.txt'
write.table(second_set, "output_data.txt", row.names = FALSE)

