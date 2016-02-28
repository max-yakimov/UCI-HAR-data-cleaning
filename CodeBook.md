# Coursera Getting and Cleaning Data course project. CodeBook.
Author: Max Yakimov

## Project's purpose
R-script 'run_analysis.R' gets data from preloaded 'UCI HAR Dataset' folder and makes some clearance and aggregation actions (described in 'Activity steps' section) for further analysis.

## How to run and check the results
* to run the script copy 'run_analysis.R' into your 'UCI HAR Dataset' local folder, make sure that it's a working directory and execute command: `source("run_analysis.R")`
* the script creates **all_data** data frame with cleared data result and creates file *uci_har_measuremets_means.txt*
* to load aggregated data from file use following command: `<your data.frame name> <- read.table("uci_har_measuremets_means.txt")`

## Activity steps

1. Load data into data.frames from txt-files (8 items: test and train x-sets, test and train y-sets, test and train subject-sets, dictionaries of activities and features).
2. Bind columns: x-sets with y$V1 values (id of activity type).
3. Bind columns: x-sets with subjects-sets (subject id).
4. Bind rows: test and train x-sets into all_data data.frame.
5. Replace activity_id with activity name through activity_labels merging.
6. Rename original V-columns of all_data with data from features dictionary.
7. Select from all_data just columns for mean() and std() measurements and key columns: subject_id, acitivity_name.
8. Fine column names according to naming convensions (described below)
9. Group all_data by activity and subject.
10. Summarize all_data by mean of each measurement and save result into a file "uci_har_measuremets_means.txt".
11. Post-processing: removing temporary objects.

## Result datasets
### Naming convensions
* Names are in lower case
* Names don't contain non-alpha characters
* Individual words in the names should be separated with "_" character 

### Cleared dataset

Object name: all_data<br/>
Object class: data.frame<br/>
Number of rows: 10,299<br/>
Number of columns: 68<br/>

#### Columns descriptions
* activity_name (factor of 6 levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) - the name of subject's activity
* subject_id (int) - id of certain subject (1:30) 
* _mesurements values columns_ (num) - columns for average and standard deviation values or measurements  

### Aggregated dataset

Object name: uci_har_measuremets_means.txt<br/>
Object class: plane text file<br/>
Number of rows: 180<br/>
Number of columns: 68<br/>

#### Columns descriptions
* activity_name (factor of 6 levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) - the name of subject's activity
* subject_id (int) - id of certain subject (1:30) 
* _average mesurements values columns_ (num) - average values from *all_data* grouped by activity name and subject id
