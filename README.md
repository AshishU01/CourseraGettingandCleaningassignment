# CourseraGettingandCleaningassignment
The run_analysis.R does the following Job.

1. Download the data file if it does not already exist in the working directory
2. if folder "UCI HAR Dataset" doesn't exist , unzip file
3. Load the activity and feature info in activityLabels and features data frames respectively
4. Keep only those columns which reflect a mean or standard deviation
5. Load both the training datasets
6. Loads the activity and subject data for each dataset, and merges those columns with the dataset
7. Load test datasets
8. Merge the two datasets
9. Converts the  activity and subject columns into factors
10. Melt data frame with id vector subject and activity
11. Cast molten data frame into a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
12. Write data to 'tidy.txt' file
