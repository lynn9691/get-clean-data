#Read data
test.x, test.y, test.sub, train.x, train.y, train.sub are the data sets read in from the corresponding files;

#Merge data
Merge three data sets of train/test into a data set called train_merge/test_merge.
Then merge the train_merge and test_merge into a data set called full, which contains all the original data.

#Extract data
Read in the features' name into feature.name;
Then get the indices of names that contains mean() or std() and store them into meanindex and stdindex;
Then extract the data needed - whose index is included in meanindex or stdindex, and the first two rows which contains subject and activity, and store the data set into final
And rename final's columns by the features' name.

#Name activities
Read in the activities' labels into act.name;
Then rename the activities by the labels.

#Rename variables
To make the variable names understandable, replace the beginning t by time and the beginning f by frequency, and remove the parentheses.

#Create a new data set
Using the summarize_each function in dplyr package to get a data set called groupdata which contains the average of each variable for each activity and each subject.
