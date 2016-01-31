library(dplyr)

# Read Data
features <- read.table("features.txt",fill=TRUE,as.is=TRUE)
train <- read.table("X_train.txt")
test <- read.table("X_test.txt")

# Read Labels
trainLabels <- read.table("Y_train.txt")
testLabels <- read.table("Y_test.txt")

# Merge Labels to Data
train <- cbind(trainLabels, train)
test <- cbind(testLabels, test)

# Merge Train and test data
data <- rbind(train,test)

# Add header to data.frame
names(data) <- c("V1",features$V2)

# Filter mean and std data
condition <- grep("mean|std",names(result))
data2 <- data[,c(1,condition)]

# Read labels for activities
activityLabels <- read.table("activity_labels.txt", as.is = TRUE)

# Join activity labels and data
data3 <- merge(x = activityLabels, y = data2)
data3 <- data3[,-1]

# Set variable names
headers <- names(data3)
headers <- sub("tBodyAcc","Body Acceleromater",headers)
headers <- sub("tGravityAcc","Gravity Acceleromater",headers)
headers <- sub("tBodyGyro","Body Gyroscope",headers)

headers <- sub("fBodyAcc","FFT Body Acceleromater",headers)
headers <- sub("fBodyGyro","FFT Body Gyroscope",headers)

headers <- sub("fBodyBodyAcc","FFT Body Body Acceleromater",headers)
headers <- sub("fBodyBodyGyro","FFT Body Body Gyroscope",headers)

headers <- sub("Jerk"," Jerk Signals",headers)
headers <- sub("Mag"," Magnitude",headers)

headers <- sub("-mean()"," Mean",headers, fixed=TRUE)
headers <- sub("-std()"," Standard Deviation",headers, fixed=TRUE)
headers <- sub("-meanFreq() "," Mean Frequency",headers, fixed=TRUE)

headers <- sub("-X"," X-axis",headers)
headers <- sub("-Y"," Y-axis",headers)
headers <- sub("-Z"," Z-axis",headers)

names(data3) <- headers

# Get new data.frame
wearableActivities <- aggregate(data3[,-1], list(data3$V2), mean)

# Rename first column
headers <- names(wearableActivities)
headers[1] <- "Activity"
names(wearableActivities) <- headers

# Write results
write.table(wearableActivities,"submission.txt", row.names = FALSE)


write.table(wearableActivities,"submission.txt", row.names = FALSE)

