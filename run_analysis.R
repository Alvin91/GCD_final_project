### R script for course Getting and Cleaning data
### date: 31-05-2018

## import reshape2 & define folder name
library(reshape2)
folder_name <- paste(getwd(),'/UCI HAR Dataset/',sep = '')

## load the general files
activity_labels <- read.table(paste(folder_name,'activity_labels.txt',sep = ''))
features <- read.table(paste(folder_name,'features.txt',sep = ''))

## load the train files
x_train <- read.table(paste(folder_name,'/train/','X_train.txt',sep = ''))
y_train <- read.table(paste(folder_name,'/train/','y_train.txt',sep = ''))
subject_train <- read.table(paste(folder_name,'/train/','subject_train.txt',sep = ''))

## load the test files
x_test <- read.table(paste(folder_name,'/test/','X_test.txt',sep = ''))
y_test <- read.table(paste(folder_name,'/test/','y_test.txt',sep = ''))
subject_test <- read.table(paste(folder_name,'/test/','subject_test.txt',sep = ''))

## merge according to x, y and subject
x_total <- rbind(x_test, x_train)
y_total <- rbind(y_test, y_train )
subject_total <- rbind(subject_test, subject_train)

## extract mean & standard deviation, tidy the name
feature_extract <- grep('.*mean.*|.*std.*',features[,2])


## subset the data from x_total, change the name and tidy the name
x_sub <- x_total[,feature_extract]
feature_extract.names <- features[feature_extract,2]
feature_extract.names <- gsub('-std','STD',gsub('-mean','MEAN',feature_extract.names))
feature_extract.names <- gsub('[()]','',gsub('-', '', feature_extract.names))
colnames(x_sub) <- feature_extract.names

## tidy the activity names with labels
y_total[,1] <- activity_labels[y_total[,1],2]
names(y_total) <- 'activity'
names(subject_total) <- 'subject'

## merge all data
data_total <- cbind(x_sub, y_total, subject_total)

## calculate mean value
tidy_mean_value <- dcast(melt(data_total,id=c('activity','subject') ), subject+activity~variable, mean)
write.table(tidy_mean_value,'tidy_mean.txt', row.names = FALSE)