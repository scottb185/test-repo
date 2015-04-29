# Coursera Getting and Cleaning Data Course Project
# scottb185

# Steps:

# S1-Merge training/test sets to create one data set 
# S2-Extract only the measurements on mean and standard deviation for each measurement  
# S3-Use descriptive activity names to name the activities in the data set 
# S4-Appropriately label the data set with descriptive activity names  
# S5-Create a second, independent tidy data set with the average of each variable for each activity and each subject  

# S1-Merge training/test sets to create one data set

require(plyr)
rm(list=ls()) 
col=2
features = read.table('./features.txt',header=FALSE) 
activitylabels = read.table('./activity_labels.txt',header=FALSE) 
colnames(activitylabels)=c('activityid','activitylabels')
subjecttrain = read.table('./train/subject_train.txt',header=FALSE) 
colnames(subjecttrain)="subjectid" 
xtrain = read.table('./train/x_train.txt',header=FALSE) 
colnames(xtrain)=features[,col]  
ytrain = read.table('./train/y_train.txt',header=FALSE) 
colnames(ytrain)="activityid" 
subjecttest = read.table('./test/subject_test.txt',header=FALSE) 
colnames(subjecttest) = "subjectid" 
xtest=read.table('./test/x_test.txt',header=FALSE) 
colnames(xtest)= features[,col]  
ytest=read.table('./test/y_test.txt',header=FALSE)
colnames(ytest)="activityid"

trainingdata = cbind(ytrain,subjecttrain,xtrain) 
testdata = cbind(ytest,subjecttest,xtest) 
final = rbind(trainingdata,testdata) 
colnames2 = colnames(final)  

# S2-Extract only the measurements on mean and standard deviation for each measurement  

c1<-grepl("-std()..-",colnames2,ignore.case=FALSE)
c2<-grepl("-std..",colnames2,ignore.case=FALSE)
c3<-grepl("mean..-",colnames2,ignore.case=FALSE)
c4<-grepl("-meanFreq..",colnames2,ignore.case=FALSE)
c5<-grepl("-mean..",colnames2,ignore.case=FALSE)
c6<-grepl("subject..",colnames2,ignore.case=FALSE)
c7<-grepl("activity..",colnames2,ignore.case=FALSE)

truthcheck = (!c1&c2|!c3&!c4&c5|c6|c7)
 
final = final[truthcheck==TRUE]

# S3-Use descriptive activity names to name the activities in the data set 

final = join(final,activitylabels,by="activityid")
colnames2  = colnames(final)  

# S4-Appropriately label the data set with descriptive activity names 
 
for (i in 1:21)  
{
        
        colnames2[i] <- gsub("Gyro","AngularSpeed",colnames2[i])     
        colnames2[i] <- gsub("JerkMag","JerkMagnitude",colnames2[i]) 
        colnames2[i] <- gsub("([Gg]ravity)","Gravity",colnames2[i]) 
        colnames2[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colnames2[i]) 
        colnames2[i] <- gsub("GyroJerk","AngularAcc",colnames2[i]) 
        colnames2[i] <- gsub("Acc","Acceleration",colnames2[i]) 
        colnames2[i] <- gsub("\\()","",colnames2[i]) 
        colnames2[i] <- gsub("\\.std","StdDev",colnames2[i]) 
        colnames2[i] <- gsub("\\.mean","Mean",colnames2[i]) 
        colnames2[i] <- gsub("^t","time",colnames2[i]) 
        colnames2[i] <- gsub("^f","freq",colnames2[i]) 

} 
 
colnames(final)<-colnames2

# S5-Create a second, independent tidy data set with the average of each variable for each activity and each subject  

finald<-final[,names(final) != "activitylabels"]
finald2<-finald[,names(finald) != c("activityid","subjectid")]
tidy=ddply(finald2,.(activityid=finald$activityid,subjectid = finald$subjectid),numcolwise(mean))
tidy=join(tidy,activitylabels,by="activityid")
tidy<-tidy[order(tidy$activityid,rank(tidy$subjectid),decreasing=FALSE),]

write.table(tidy, './tidy.txt',row.names=TRUE,sep='\t') 
