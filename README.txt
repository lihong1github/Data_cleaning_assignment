This repo contains two files:

1) the "run_analysis.R" file contains the R script used to clean and summarize raw data obtained from 
"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  It provides two output tables: a) "tidydata.txt", which contains all measurments; b) "tidydata_mean.txt", which select only mean() and std() measurements, 
  then summarize numeric values by subject_id and activity type. 

2) the "code_cookbook.md" file describes variables shown in the tidy data file "tidydata_mean.txt"
