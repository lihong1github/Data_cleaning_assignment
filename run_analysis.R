# analysis code


# install.packages("plyr")

library(here)
library(dplyr)
library(tibble)
library(plyr)

### read data annotation

dir.home <- here()
dir.anno <- file.path(dir.home,"UCI HAR Dataset")

activity.label <- read.table(file=file.path(dir.anno, "activity_labels.txt"))
feature.label <- read.table(file=file.path(dir.anno, "features.txt"))


### read test data

dir.test <- file.path(dir.home, "UCI HAR Dataset", "test")

setwd(dir.test)

test.file.list <- list.files(dir.test, pattern = ".txt")

test.file.list

test.data.df <- data.frame(read.table(test.file.list[[1]]),
                           read.table(test.file.list[[3]]),
                           read.table(test.file.list[[2]])
                           ) 

colnames(test.data.df) <- c("subject_id", "activity_type", feature.label[,2])

table(test.data.df$subject_id)

### read train data

dir.train <- file.path(dir.home, "UCI HAR Dataset", "train")

setwd(dir.train)

train.file.list <- list.files(dir.train, pattern = ".txt")
train.file.list

train.data.df <- data.frame(read.table(train.file.list[[1]]),
                           read.table(train.file.list[[3]]),
                           read.table(train.file.list[[2]])
) 

colnames(train.data.df) <- c("subject_id", "activity_type", feature.label[,2])

table(train.data.df$subject_id)

### combine test and train data

df.merged <- bind_rows(test.data.df,train.data.df)

### label activity with real names

df.merged$activity_type <- plyr::mapvalues(df.merged$activity_type, from=activity.label[,1], to=activity.label[,2])


### select only column with mean and std

col_select_index <- c(1:2, 
                      grep(x=colnames(df.merged), pattern=c("mean")), 
                      grep(x=colnames(df.merged), pattern=c("std")))

df.merged.tidy <- df.merged[, col_select_index]

write.table(df.merged.tidy, file=file.path(dir.home, "tidydata.txt"), row.names=F)


df.merged.tidy.mean <- df.merged.tidy %>% group_by(subject_id, activity_type) %>% summarise_if(is.numeric, mean)

View(df.merged.tidy.mean)

write.table(df.merged.tidy.mean, file=file.path(dir.home, "tidydata_mean.txt"), row.names=F)

grep(x=colnames(df.merged.tidy.mean), pattern=c("std"))






