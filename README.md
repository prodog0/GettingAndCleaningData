<<<<<<< HEAD
---
title: "Getting and Cleaning Data"
author: "prodog"
date: "27 September 2015"
output: html_document
---

## Description
The GettingAndCleaningData repository holds files for the project associated with the Coursera course "Getting and Cleaning Data".

## File Summary

* run_analysis.R - the R program to extract, clean and summarize (see below)
* codebook.md - explanation of the outputs
* README.md - that's this file. An explanation of the project.
* tidy_summary_data.txt -  summarised data of all the means of the mean and standard deviation readings

## run_analysis.R

This program uses smartphone accelerometer and gyroscope experimental readings from 30 individuals and extracts, cleans and summarizes the data into the tidy_summary_data.txt file.

A further explanation of the experiment can be found at:-

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data from the experiments are downloadable from the following location:-

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### To Run

To run the R script:-

```{r}
source("run_analysis.R")
run_analysis()
```

### Notes

1. libraries - dplyr
2. The requirement was to extract all the mean and standard deviation information into a summary file. Any column name that had "std" or "mean" in the column name was selected. 
3. There were duplicate column names in the data sets. These did not have the names
with "std" or "mean" so they were removed.
4. There were no NA variables in the datasets so this bit of coding was commented out



=======
# GettingAndCleaningData
Getting and Cleaning Data Project
>>>>>>> 0945def5fb96be5e64235b78677edb94ae4b2b3a
