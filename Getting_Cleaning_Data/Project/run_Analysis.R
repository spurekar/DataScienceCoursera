run_Analysis <- function() {
    # set up environment
    library(dplyr)
    
    #Import data files
    traindata <- read.table("UCI HAR Dataset/train/X_train.txt")
    testdata <- read.table("UCI HAR Dataset/test/X_test.txt")
    
    trainsubj <- read.table("UCI HAR Dataset/train/subject_train.txt")
    testsubj <- read.table("UCI HAR Dataset/test/subject_test.txt")
    
    trainact <- read.table("UCI HAR Dataset/train/y_train.txt")
    testact <- read.table("UCI HAR Dataset/test/y_test.txt")
    
    colheaders <- read.table("UCI HAR Dataset//features.txt")
    actnames <- read.table("UCI HAR Dataset//activity_labels.txt")
    
    #add column names to test and train data
    names(traindata) <- make.names(colheaders[,2],unique=TRUE)
    names(testdata) <- make.names(colheaders[,2],unique=TRUE)
    
    #extract mean and SD variables
    trainmean <- select(traindata,contains(".mean."))
    trainstd <- select(traindata,contains(".std."))
    testmean <- select(testdata,contains(".mean."))
    teststd <- select(testdata,contains(".std."))
    
    #combine mean and SD data for each set
    traindata <- cbind(trainmean,trainstd)
    testdata <- cbind(testmean,teststd)
    
    #combine all train files
    names(trainact) <- c("activity")
    names(trainsubj) <- c("subject")
    traindata <- cbind(trainact,traindata)
    traindata <- cbind(trainsubj,traindata)
    #we have a training dataset with subject, activity, data
    
    #combine all test files
    names(testact) <- c("activity")
    names(testsubj) <- c("subject")
    testdata <- cbind(testact, testdata)
    testdata <- cbind(testsubj, testdata)
    
    #merge in to one large data set
    data <- rbind(traindata, testdata)
    
    #add descriptive activity names
    acts <- as.factor(data[,2])
    levels(acts) <- actnames[,2]
    data[,2] <- acts
    
    #make data numeric
    data[,3:68] <- sapply(data[,3:68],as.numeric)
    data[,2] <- sapply(data[,2],as.character)
    
    #create summary dataset
    groups <- group_by(data,subject,activity)
    summaries <- summarise_each(groups,funs(mean))
    
    #output tidy data set
    summaries
}
