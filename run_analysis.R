##run_analysis.R
run_analysis <- function(workingFolder = "") {
    ##"~/R/R-Work/CleanData/week3/Assignment1"
    ## Set working folder
    setwd(workingFolder)
    
    # Using Reshape package to melt and cast the data to find the average for the each activity for each person.
    
    library(reshape)
    
    ##Load Data
    xTrain <- read.table("X_train.txt", header=FALSE)
    xTest <- read.table("X_test.txt", header=FALSE)
    
    
    yTrain <- read.table("y_train.txt", header=FALSE)
    yTest <- read.table("y_test.txt", header=FALSE)
    
    ## Load Subject: test and train
    subjectTrain <- read.table("subject_train.txt", header=FALSE)
    subjectTest <- read.table("subject_test.txt", header=FALSE)
    
    ## Load Features and Lables Data
    features <- read.table("features.txt", header=FALSE)
    activityLabels <- read.table("activity_labels.txt", header=FALSE)
    
    
    
    ###Preparing Data
    ## Merge X_train, X_test  measurements
    xTrainTest <- rbind(xTrain, xTest)
    
    ##Add column names from 'features.txt' to the merged test/train measurement
    colnames(xTrainTest) <- features$V2
    
    ##Merge yTrain & yTest data 
    yTrainTest <- rbind(yTrain, yTest)
    
    
    #Merge Subject train & test data
    subjectTrainTest <-  rbind(subjectTrain, subjectTest)
    colnames(subjectTrainTest) <- c("subject")
    
    
    ##1. Merges the training and the test sets to create one data set.
    #Combined y,x  train and test data
    
    trainTestDs <- cbind(yTrainTest,xTrainTest)
    
    
    
    #2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    
    #subsetting columns containing text: "mean()", "std()" 
    mesurmentsWithMeansDS <- trainTestDs[,grepl("mean()", names(trainTestDs), fixed=TRUE)]
    mesurmentsWithStdDS <- trainTestDs[,grepl("std()", names(trainTestDs), fixed=TRUE)]
    
    #3.Uses descriptive activity names to name the activities in the data set
    
    mapActivity <-merge(x=yTrainTest,y=activityLabels, by.x="V1", by.y="V1", all=TRUE)
    
    ##Add column name as "activity" to the merged y test/train data
    colnames(mapActivity) <- c("activityId","activity")
    
    
    #4. Appropriately labels the data set with descriptive variable names. 
    
    ## Activity with Means
    actitvityWithMeansDS <- cbind(mapActivity,mesurmentsWithMeansDS)
    
    ##Activity with STDs
    actitvityWithStdDS <- cbind(mapActivity,mesurmentsWithStdDS)
    
    ##Combine Activity, means and STD 
    activityDS <- cbind(mapActivity,mesurmentsWithMeansDS, mesurmentsWithStdDS)
    
    
    #5. From the data set in step 4, creates a second, independent 
    #   tidy data set with the average of each variable for each activity and each subject.
    
    #Add subject to activityDS
    
    subjectActivityDs <- cbind(mapActivity,subjectTrainTest, mesurmentsWithMeansDS, mesurmentsWithStdDS)
    
  
    
    # melt the dataframe for easy casting
    meltDs <- melt(subjectActivityDs, id=c("activityId",  "activity",	"subject"))
    
    #Cast the melted data to do the average for the each Subjects each activity. 
    averageBySubjectActivityDS <-cast(meltDs, activityId +  activity +subject  ~	variable, mean)
    
    #Create a text file of the tidy data
    write.table(averageBySubjectActivityDS, paste0(workingFolder,'/TidyDataSet.txt'), sep=",", row.names=FALSE ) 
    
    #Print the tidy data
    print(averageBySubjectActivityDS)

}
