# Before executing this script, make sure to save it in the same directory as the raw data / see Readme.md for more information
# set your working directory accordingly

# load dplyr package
library(dplyr)

# load data related to training
# name variables in each files 
trainsubject <- read.table("./train/subject_train.txt")
names(trainsubject) <- c("subject")
trainactivity <- read.table("./train/y_train.txt")
names(trainactivity) <- c("activity")
traindata <- read.table("./train/X_train.txt")

# load feature files and select mean and standard deviation measurement variables
featurelabels <- read.table("./features.txt")
feat2 <- filter(featurelabels, grepl("mean|std", featurelabels$V2))

#Clean up variable names
feat2$V2 <- sub("\\()","",feat2$V2)
feat2$V2 <- tolower(feat2$V2)
feat2$V2 <- sub("acc"," from accelerometer ",feat2$V2)
feat2$V2 <- sub("bodybody|body","body accelaration",feat2$V2)
feat2$V2 <- sub("gravity","gravity acceleration",feat2$V2)
feat2$V2 <- sub("gyro","from gyroscope ",feat2$V2)
feat2$V2 <- sub("mag","magnitude ",feat2$V2)
feat2$V2 <- sub("jerk","jerk ",feat2$V2)
feat2$V2 <- sub("^t","time ",feat2$V2)
feat2$V2 <- sub("^f","frequency ",feat2$V2)
feat2$V2 <- sub("-x"," on x axis",feat2$V2)
feat2$V2 <- sub("-y"," on y axis",feat2$V2)
feat2$V2 <- sub("-z"," on z axis",feat2$V2)
feat2$V2 <- sub("-mean","mean",feat2$V2)
feat2$V2 <- sub("-std","standard deviation",feat2$V2)

## then apply same selection (mean and standard deviation) to measurement data using index of labels as column index
traindata <- select(traindata, feat2$V1)

# name the measurement data variable using the feature labels
names(traindata) <- feat2$V2

# enrich train data with subject and activity and add a type variable with value "train"
traindata <- cbind(trainsubject, trainactivity, traindata) %>%
  mutate(type="train")

# repeat above sequence and load data related to test
# name variables in each files
testsubject <- read.table("./test/subject_test.txt")
names(testsubject) <- c("subject")
testactivity <- read.table("./test/y_test.txt")
names(testactivity) <- c("activity")
testdata <- read.table("./test/X_test.txt")
testdata <- select(testdata, feat2$V1)
names(testdata) <- feat2$V2

# enrich test data with subject and activity and add a type column with value "test"
testdata <- cbind(testsubject, testactivity, testdata)%>%
  mutate(type="test")

#collate test and train data into one single file
obsdata <- rbind(testdata, traindata)

# load activity names
activitylabels <- read.table("./activity_labels.txt")

# Merge obdervation data and activity names by joining on the activity id variable and rearrange columns
obsdata2 <- merge(activitylabels, obsdata, by.x = "V1", by.y = "activity")
obsdata3 <- select(obsdata2,V2 ,subject , 4:82)
names(obsdata3)[1] <- c("activity")

# creata a separate file grouped by activities and subject and containing average of each type of measurement by grouping
obsdata4 <- group_by(obsdata3, activity, subject)%>%
  summarize_each(funs(mean))

# Save the file on disc
write.csv(obsdata4, file="./AverageMeasurementData.csv")

# end of the script -----
