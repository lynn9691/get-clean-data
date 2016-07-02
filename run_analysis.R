#read data
test.x <- read.table("./test/X_test.txt")
test.y <- read.table("./test/y_test.txt")
test.sub <- read.table("./test/subject_test.txt")
train.x <- read.table("./train/X_train.txt")
train.y <- read.table("./train/y_train.txt")
train.sub <- read.table("./train/subject_train.txt")

#merge data
train_merge <- cbind(train.sub,train.y, train.x)
test_merge <- cbind(test.sub,test.y,test.x)
full <- rbind(train_merge,test_merge)

#extract data
feature.name <- read.table("features.txt", stringsAsFactors = FALSE)
meanindex <- grep("mean\\(\\)",feature.name[,2])
stdindex <- grep("std\\(\\)",feature.name[,2])
final <- full[,c(1, 2, meanindex + 2, stdindex + 2)]
name <- feature.name[c(meanindex,stdindex),2]
colnames(final) <- c("subject","activity",name)

#name activities
act.name <- read.table("activity_labels.txt")
final$activity = factor(final$activity, levels = act.name[,1], labels = act.name[,2])

#rename variables
colnames(final) <- gsub("^t", "time", colnames(final))
colnames(final) <- gsub("^f", "frequency", colnames(final))
colnames(final) <- gsub("\\(\\)","",colnames(final))
colnames(final) <- gsub("-mean","Mean",colnames(final))
colnames(final) <- gsub("-std","Std",colnames(final))

#create a new data set
library(dplyr)
groupdata <- final %>% group_by(subject,activity) %>%
                    summarize_each(funs(mean))

write.table(groupdata, file = "groupdata.txt",row.names = FALSE)
