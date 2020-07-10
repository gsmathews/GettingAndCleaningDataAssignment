---
title: "CodeBook.md"
author: "Griffin Mathews"
date: "July 10, 2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)

1. Merges the training and the test sets to create one data set.

Each file read in, named, and appended to the overall train/test df.
The test and train df are appended together.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

Only columns with "mean" or "sd" are retained. Subject and training label are both retained as well.

3. Uses descriptive activity names to name the activities in the data set

Activity labels are read into the script, renamed, and appended to the master df

4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The df is grouped by Activity and Training Label, then the mean of all but Training.Label.Desc columns are calculated.