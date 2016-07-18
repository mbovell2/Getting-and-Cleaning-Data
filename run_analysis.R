library(data.table)


setwd("C:/Users/Mercedes/Desktop/DataSciece/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset")


activity = read.table('./activity_labels.txt', header = FALSE, col.names = c("activityId", "label"))
features = read.table('./features.txt', header = FALSE, col.names = c("featureId", "feature"))

subjectTrain = read.table('./train/subject_train.txt', header = FALSE, col.names = c("subject"))
xTrain = read.table('./train/x_train.txt', header = FALSE, col.names = features[,2])
yTrain = read.table('./train/y_train.txt', header = FALSE, col.names = "activityId")

subjectTest = read.table('./test/subject_test.txt', header = FALSE, col.names = c("subject"))
xTest = read.table('./test/x_test.txt', header = FALSE, col.names = features[,2])
yTest = read.table ('./test/y_test.txt',header = FALSE, col.names = "activityId")

 

trainingData = cbind(subjectTrain, xTrain, yTrain)
testData = cbind(subjectTest, xTest, yTest)
totalData = rbind(trainingData, testData)


meanStdData = totalData [ grep(".*mean.*|.std*|activityId|subject",names(totalData), value = TRUE) ];


meanStdByActivity<-merge(activity,meanStdData,by='activityId',all.x=TRUE);



alldata <- data.table(meanStdByActivity)
avgActivity = aggregate(alldata, by=list(alldata$activityId, alldata$subject), FUN=mean)

tidydata = (alldata)
write.table (tidydata, row.name=FALSE)
