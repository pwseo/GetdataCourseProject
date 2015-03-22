# Code book
"Getting and Cleaning Data" course on Coursera


## How to run the script

Please refer to the `README.md` file for instructions on how to run the R script.


## Data transformation and analysis

1. For each of the datasets provided (`test` and `train`) the script will:
  1. Read variable names from the `/features.txt` file and attach them to the data present in the `/<dataset>/X_<dataset>.txt` file.
  2. Merge the dataset obtained in the previous step with a new variable (`Activity`) with data from `/<dataset>/y_<dataset>.txt`.
  3. Merge the dataset obtained in the previous step with a new variable (`SubjectID`) with data from `/<dataset>/subject_<dataset>.txt`
2. Merge the two datasets obtained in the previous step.
3. Keep only the columns (variables) `SubjectID`, `Activity` and those whose name contains either `mean()` or `std()`.
4. Clean up variable names:
  - replace `-mean()` with `Mean`, and `-std()` with `SD` ('*S*tandard *D*eviation').
  - replace `-X`, `-Y` and `-Z` with `.X`, `.Y` and `.Z`, respectively.
5. Aggregate data by `SubjectID` and `Activity` (in that order) and calculate means for every variable (column) in the aggregated groups.
6. Save the result in the `final.txt` file.


## Variables in the final dataset

- `SubjectID`, integer that identifies the subject; range from 1 to 30
- `Activity`, categorical variable (a *factor*, in R's terms) which can have one of the following values:
  - `WALKING`
  - `WALKING_UPSTAIRS`
  - `WALKING_DOWNSTAIRS`
  - `SITTING`
  - `STANDING`
  - `LAYING`

The remaining variables in the final dataset contain averages for each of the variables kept from the original dataset, grouped by subject and activity.
To ease understanding, the remaining variable names were left mostly untouched (appart from the substitutions of `-mean()` and `-std()` for `Mean` and `SD` and `-XYZ` for `.XYZ`, meant to tidy the variable names).
For details on what each variable represents, please refer to the `README.txt` file shipped with the data at the root of the `UCI HAR Dataset` directory.


## References

1. (UCI Machine Learning Repository: Human Activity Recognition Using Smartphones Data Set)[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones]
