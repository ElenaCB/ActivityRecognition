library(reshape2)

setwd("./Samsung data")

###read the X_train data
trainX<-read.table("X_train.txt",header=F)

##read the X_test data
testX<-read.table("X_test.txt",header=F)

##read the y_train data
y_train<-read.table("y_train.txt",header=F)

##read the y_test data
y_test<-read.table("y_test.txt",header=F)

##read the names of the features
n_features<-read.table("features.txt",header=F)
name_features<-n_features[,2,drop=FALSE]

##read the subject_train data
subject_train<-read.table("subject_train.txt",header=F)

##read the subject_test data
subject_test<-read.table("subject_test.txt",header=F)

##add the trainX table with the testX table
X<-rbind(trainX,testX)

## rename the data base
Data<-X

## the names_features to the table Data
colnames(Data)<-name_features$V2

## add the y_train with y_test
Y<-rbind(y_train,y_test)

## add the subject_train with subject_test
subject<-rbind(subject_train,subject_test)

##add the "y" variable to the Data table
Data$y<-Y$V1

##add the subject variable to the Data table
Data$subject<-subject$V1

##Columns with mean, std, Y and subject from the data Data (take by observation from the labels)
mean_std_data<-Data[,c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543,562:563)]

## read the activity_labes
activity_labels<-read.table("activity_labels.txt",header=F)

##labels for the activities
labels_data<-merge(mean_std_data,activity_labels,by.x="y",by.y="V1")

##rename the new column
colnames(labels_data)[69]<-"activity"

##average for each variable in labels_data
average<-apply(labels_data[,c(1:67)],1,mean)

##combine new table the td, the subject and the activity
tidy<-data.frame(labels_data$subject, labels_data$activity, average)

##crate the new table of the average of each variable for each activity and each subject.
TidyData<-xtabs(average~labels_data.subject+labels_data.activity,data=tidy)

##print the tidy data.
print(TidyData)