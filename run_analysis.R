# GETTING AND CLEANING DATA
# Course Project
# António Pedro Cunha (pwseo)

data.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'  
data.zip <- 'getdata_projectfiles_UCI HAR Dataset.zip' 
data.dir <- 'UCI HAR Dataset'
data.out <- 'final.txt'


# STEP 0.
# Download the data files and unzip them

if (!file.exists(data.dir)) {
  if (!file.exists(data.zip)) {
    download.file(data.url, destfile = data.zip, method = "curl")
  }
  unzip(data.zip)
}


# STEP 1.
# Merge the 'train' and 'test' datasets in one dataset

# Read all the different components first
train.x <- read.table(paste0(data.dir, '/train/X_train.txt'))
train.y <- read.table(paste0(data.dir, '/train/y_train.txt'))
train.s <- read.table(paste0(data.dir, '/train/subject_train.txt'))
test.x <- read.table(paste0(data.dir, '/test/X_test.txt'))
test.y <- read.table(paste0(data.dir, '/test/y_test.txt'))
test.s <- read.table(paste0(data.dir, '/test/subject_test.txt'))

# Assemble the 'train' and 'test' datasets from their individual components
train <- do.call(cbind, list(train.s, train.y, train.x))
test  <- do.call(cbind, list(test.s, test.y, test.x))

# Merge both datasets by simply clipping them together one below the other
ds <- rbind(train, test)

# Read variable names from the supplied 'features.txt' file and use them
# as the names for the dataset (this is part of Step 4).
features <- read.table(paste0(data.dir, '/features.txt'), stringsAsFactors = F)[, 2]
names(ds) <- c('SubjectID', 'Activity', features)


# STEP 2.
# Extract only the measurements on the mean() and std() for each measurement

# Keep only the columns named 'SubjectID', 'Activity' and those whose name
# has either 'mean()' or 'std()' in it (via regular expression '(mean|std)\(\)').
ds <- ds[, c('SubjectID', 'Activity', grep('(mean|std)\\(\\)', names(ds), value = T))]


# STEP 3.
# Use descriptive names to name the activities in the dataset.

activities <- read.table(paste0(data.dir, '/activity_labels.txt'))
ds$Activity <- factor(ds$Activity, levels = activities[,1], labels = activities[,2])


# STEP 4.
# Appropriately label the dataset with descriptive variable names.

names(ds) <- gsub('-mean()', 'Mean', names(ds), fixed = T)
names(ds) <- gsub('-std()', 'SD', names(ds), fixed = T)
names(ds) <- gsub('-([XYZ])$', '.\\1', names(ds))


# STEP 5.
# Create a second independent tidy dataset with the average of each variable for each activity and each subject.

ds2 <- aggregate(ds[, 3:ncol(ds)], by = list(SubjectID = ds[,1], Activity = ds[,2]), FUN = mean)
ds2 <- ds2[order(ds2$SubjectID, ds2$Activity),]

# Finally, we write the tidy dataset to the 'final.txt' file.
write.table(ds2, file = data.out, row.names = F)


# EXTRA GOODIES:
# 
# I didn't use neither dplyr nor data.table because I wanted the script to be independent
# of external packages.
# If I did, however, here's what Step 5 would look like:
# 
# STEP 5 in dplyr:
# library(dplyr)
# ds2 <- ds %>%
#     group_by(SubjectID, Activity) %>%
#     summarise_each(funs(mean))    %>%
#     arrange(SubjectID, Activity)
#
# STEP 5 in data.table:
# library(data.table)
# ds2 <- as.data.table(ds)
# ds2[, lapply(.SD, mean), keyby = list(SubjectID, Activity)]
