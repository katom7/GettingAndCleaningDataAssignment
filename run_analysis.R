library(dplyr)

# Path depnds on your environment
datadir <- "../../../Data/UCI\ HAR\ Dataset"

# Read Data
features <- read.table(paste(datadir,"features.txt",sep="/"),fill=TRUE,as.is=TRUE)
train <- read.table(paste(datadir,"train","X_train.txt", sep="/"))
test <- read.table(paste(datadir,"test","X_test.txt", sep="/"))

# Read Labels
trainLabels <- read.table(paste(datadir,"train","y_train.txt",sep="/"))
testLabels <- read.table(paste(datadir,"test","y_test.txt",sep="/"))

# Read Subjects
trainSubjects <- read.table(paste(datadir,"train","subject_train.txt",sep="/"))
testSubjects <- read.table(paste(datadir,"test","subject_test.txt",sep="/"))

# Merge Labels to Data
train <- cbind(trainSubjects, trainLabels, train)
test <- cbind(testSubjects, testLabels, test)

# Merge Train and test data
data <- rbind(train,test)

# Add header to data.frame
<<<<<<< HEAD
names(data) <- c("Subject","Activity",features$V2)

# Filter mean and std data
#  Select mean & std
condition <- grep("mean|std",names(data))
data <- data[,c(1,2,condition)]
#  Remove meanFreq
condition2 <- grep("meanFreq",names(data))
data <- data[,-condition2]

# Read Activity Labels
activity.labels <- read.table(paste(datadir,"activity_labels.txt",sep="/"),fill=TRUE,as.is=TRUE)

# Lookup Activity Labels
data$Activity <- activity.labels[data$Activity,2]

# Set variable names
headers <- names(data)

headers <- sub("tBodyAcc","time.Body.Acc",headers)
headers <- sub("tGravityAcc","time.Gravity.Acc",headers)
headers <- sub("tBodyGyro","time.Body.Gyro",headers)
headers <- sub("fBodyAcc","freq.Body.Acc",headers)
headers <- sub("fBodyGyro","freq.Body.Gyro",headers)
headers <- sub("fBodyBodyAcc","freq.Body.Acc",headers)
headers <- sub("fBodyBodyGyro","freq.Body.Gyro",headers)
headers <- sub("Jerk",".Jerk",headers)
headers <- sub("Mag",".Mag",headers)
headers <- sub("-mean()",".mean",headers, fixed=TRUE)
headers <- sub("-std()",".std",headers, fixed=TRUE)
headers <- sub("-meanFreq() ",".mean.freq",headers, fixed=TRUE)
headers <- make.names(headers)

names(data) <- headers

# Get new data.frame
data.result <- aggregate(data[,-(1:2)], list(data$Subject, data$Activity), mean)

# Rename 1st. and 2nd. columns
headers <- names(data.result)
headers[1] <- "Subject"
headers[2] <- "Activity"

names(data.result) <- headers

# Write results
write.table(data.result,"~/GitHub/GettingAndCleaningData/submission.txt", row.names = FALSE)

