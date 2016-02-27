# Getting and Cleaning Data Course Project

Author: Geovanni Becerril González.

This repo contains the files that make up the course project. These are:

* README.md: Contains a brief description of the repo and instructions to replicate the results of the R code.
* CodeBook.md: Describes the variables, the data, and any transformations or work that you performed to clean up the data.
* run_analysis.R: The R script to cover every aspect requested for evaluation, and create the tidy data required.
 
## Project description.

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following. Merges the training and the test sets to create one data set. Extracts only the measurements on the mean and standard deviation for each measurement. Uses descriptive activity names to name the activities in the data set Appropriately labels the data set with descriptive activity names. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How to replicate the results?

First, you must download and decompress the data in the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Decompressing the data you must obtain the 'UCI HAR Dataset' directory. This folder you must set them in the selected folder as the working directory.

Second, you must open the script "run_analysis.R". You should change the working directory for the address of the folder selected in the previous step. 

Third, run the code called "run_analysis.R". The code contains the description of each instruction to facilitate understanding of the script.

The run_analysis.R will:

* Merge the training and the test sets to create one data set.
* Extract only the measurements on the mean and standard deviation for each measurement.
* Generate a tidy data set with the average of each variable for each activity and each subject.
* Export this final tidy data to a 'TidyData.csv' in your working directory.

