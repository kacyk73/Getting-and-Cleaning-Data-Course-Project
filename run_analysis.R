

# the zip file is "getdata_projectfiles_UCI HAR Dataset.zip"

# Read the data

#header data
features <- read.csv("UCI HAR Dataset/features.txt",header=FALSE, sep = " ")
activity_labels = read.csv("UCI HAR Dataset/activity_labels.txt",header=FALSE, sep = " ")

#train data
subject_train = read.csv("UCI HAR Dataset/train/subject_train.txt",header=FALSE, sep = " ")
x_train = read.table("UCI HAR Dataset/train/x_train.txt",header=FALSE)
y_train = read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE)

#test data
subject_test = read.csv("UCI HAR Dataset/test/subject_test.txt",header=FALSE, sep = " ")
x_test = read.table("UCI HAR Dataset/test/x_test.txt",header=FALSE)
y_test = read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE)

#giving new column names
colnames(activity_labels) <- c("activity_ID","activity_type")

#train
colnames(subject_train) <- "subject_ID" 
colnames(x_train) <- features[,2] 
colnames(y_train) <- "activity_ID"

#test
colnames(subject_test) <- "subject_ID"
colnames(x_test) <- features[,2]
colnames(y_test) <- "activity_ID" 

#merge training data
training_dataset <- cbind(y_train, subject_train, x_train)

#merge test data
test_dataset <- cbind(y_test, subject_test, x_test)

#merge training & test datasets
both <- rbind(training_dataset, test_dataset)

#extract mean and stddev column names
cn <- colnames(both)
ms <- (grepl("subject..",cn) | grepl("-mean..",cn) | grepl("activity..",cn) & !grepl("mean..",cn) & !grepl("meanFreq..-",cn) | grepl("-std()..",cn) & !grepl("-std..-",cn))
both <- both[ms==TRUE]

#merge with activity
both <- merge(both, activity_labels, by="activity_ID", all.x = TRUE)

#names to cn again
cn = colnames(both)

#try to clean names
for (i in 1:length(cn))
{
  cn[i] <- gsub("-mean","Mean",cn[i])
  cn[i] <- gsub("-std$","StdDev",cn[i])
  cn[i] <- gsub("^(t)","time",cn[i])
  cn[i] <- gsub("^(f)","frequency",cn[i])
  cn[i] <- gsub("\\()","",cn[i]) # remove ()
  cn[i] <- gsub("BodyBody","Body",cn[i]) # double Body
  cn[i] <- gsub("Mag","Magnitude",cn[i])

}

#rename names
names(both) <- cn

#prepare mean tidy dataset
#temporarly remove activity labels before calculating means
tidy_temp <-  both[, names(both) != "activity_type"]

#calculate means
tidy <- aggregate(tidy_temp[, names(tidy_temp) != c("subject_ID", "activity_ID")], list(tidy_temp$activity_ID, tidy_temp$subject_ID), mean)
tidy <- tidy[,-c(1:2)]

#merge previously removed activity labels
tidy <- merge(tidy, activity_labels, by="activity_ID", all.x = TRUE)

#export tidy dataset to disk
write.table(tidy, "tidy_dataset.txt", quote = FALSE)