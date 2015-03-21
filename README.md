# Course Project
"Getting and Cleaning Data" course on Coursera


## Files in this repository

* `CodeBook.md` is the file describing the data and transformations applied to it
* `README.md` is the file you're reading right now
* `run_analysis.R` is the script that performs the data transformation and analysis


## How to run the script

You should be able to simply run it without problems:

    ~ $ git clone https://github.com/pwseo/GetdataCourseProject.git
    ~ $ cd GetdataCourseProject
    ~/GetdataCourseProject $ R -f run_analysis.R
    
You can also run the script from a currently running R session:

    > source('run_analysis.R')
    
If you're running this script on Windows, please make sure you're aware of your current directory -- that's where the data will be downloaded to and also where the results will be saved.
You can check your current directory with the `getwd()` function and set it with `setwd()`.
If you're using RStudio you can also set it by clicking *Session > Set working directory > Choose directory...* in the menus.

When the script is done running, the results will be saved to the working directory in a file named `final.txt`.


## What the script does

The script was written to function without interaction from the user.
Breaking it down to steps, the script does the following:

1. Download the datasets' zip file from the internet.
2. Extract the downloaded zip file (creating a `UCI HAR Dataset` directory).
3. Assemble the `train` and `test` datasets from their individual components.
4. Merge the `train` and `test` datasets into a single dataset.
6. Keep only data related to the means and standard deviations of the original measurements.
5. Label the resulting dataset's variables (columns) and activities appropriately.
7. Summarize the dataset by averaging every variable (column) grouped by subject and activity.
8. Output the dataset to the `final.txt` file.


## Packages required

The script was written using only base R functions, so no third-party packages are required.
