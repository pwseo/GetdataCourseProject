# Code book

## Data transformation

1. For each of the datasets provided (`test` and `train`) the script:

  1. Read variable names from the `/features.txt` file and attach them to the data present in the `/<dataset>/X_<dataset>.txt` file.

  2. Merge the dataset obtained in the previous step with a new variable (`Activity`) with data from `/<dataset>/y_<dataset>.txt`.

  3. Merge the dataset obtained in the previous step with a new variable (`SubjectID`) with data from `/<dataset>/subject_<dataset>.txt`

2. Merge the two datasets obtained in the previous step.

3. Keep only the columns (variables) `SubjectID`, `Activity` and those whose name contains either `mean()` or `std()`.

4. Aggregate data by `SubjectID` and `Activity` (in that order) and calculate means for every column in the aggregated groups.

5. Save the result in the `final.txt` file.
