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
# Merge the 'train' and 'test' datasets

train.x <- read.table(paste0(data.dir, '/train/X_train.txt'))
train.y <- read.table(paste0(data.dir, '/train/y_train.txt'))
train.s <- read.table(paste0(data.dir, '/train/subject_train.txt'))
test.x <- read.table(paste0(data.dir, '/test/X_test.txt'))
test.y <- read.table(paste0(data.dir, '/test/y_test.txt'))
test.s <- read.table(paste0(data.dir, '/test/subject_test.txt'))

train <- do.call(cbind, list(train.s, train.y, train.x))
test  <- do.call(cbind, list(test.s, test.y, test.x))

ds <- rbind(train, test)

features <- read.table(paste0(data.dir, '/features.txt'), stringsAsFactors = F)[, 2]
names(ds) <- c('SubjectID', 'Activity', features)


# STEP 2.
# Extract only the measurements on the mean() and std() for each measurement

ds <- ds[, c('SubjectID', 'Activity', grep('(mean|std)\\(\\)', names(ds), value = T))]


# STEP 3.
# Use descriptive names for the activities in the dataset

activities <- read.table(paste0(data.dir, '/activity_labels.txt'))
ds$Activity <- factor(ds$Activity, levels = activities[,1], labels = activities[,2])


# STEP 4.

names(ds) <- gsub('-mean()', 'Mean', names(ds), fixed = T)
names(ds) <- gsub('-std()', 'SD', names(ds), fixed = T)
names(ds) <- gsub('-([XYZ])$', '.\\1', names(ds))

# library(data.table)
# DT <- as.data.table(ds)
# # Sort and aggregate.
# DT <- DT[, lapply(.SD, mean), keyby = list(SubjectID, Activity)]


# STEP 5.

ds <- aggregate(ds[, 3:ncol(ds)], by = list(SubjectID = ds[,1], Activity = ds[,2]), FUN = mean)
ds <- ds[order(ds$SubjectID, ds$Activity),]

# Finally, we write the tidy dataset to the 'final.txt' file.

write.table(ds, file = data.out, row.names = F)
