Getting-and-Cleaning-Data-Project
=================================

## Description

This repo contains the necessary files for the project assignement in the Data Science specialization course *Getting and Cleaning Data*.

## Contents of the repo

This repo contains the following files:

* the current `README.md` file which describes how to use the files of this repo and how they are connected.
* the `run_analysis.R` file which is a script written in R that was used to perform our data cleaning.
* the `tidy_data.txt` file which is the output of our data cleaning process.
* the `codebook.md` which describes the steps in data cleaning process and also provides a description of each variable in the output .txt file.  

## How to use the contents of this repo

We assume that the `run_analysis.R` file exists in the current working directory.
We also assume that the contents of the `getdata_projectfiles_UCI HAR Dataset.zip` file (that can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )) is unzipped in the current working directory.
To get the output file, type `source("run_analysis.R")` in Rstudio. The output file `tidy_data.txt` will then be created in your working directory.
To read the output file into R, type `read.table("tidy_data.txt", header=TRUE)` in Rstudio.
