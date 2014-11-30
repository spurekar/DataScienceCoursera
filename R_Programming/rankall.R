## This function takes two arguments: the an outcome name, and the requested 
## rank. The function reads the outcome-of-care-measures.csv file and returns a
## data frame with the name of the hospital that has the requested rank in 
## 30-day mortality for the specified outcome in that state.
rankall <- function(outcome, num = "best")
{
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character", header=TRUE)
    possible_outcomes <- c("heart attack", "heart failure", "pneumonia")
    
    ## Check that state and outcome are valid
    if(!is.element(outcome, possible_outcomes))
    {
        stop("invalid outcome")
    }
    
    ## Format input outcome name in to column name in data
    outcome_formatted = sapply(strsplit(simpleCap(outcome), " "),paste,collapse=".")
    colname <- paste("Hospital.30.Day.Death..Mortality..Rates.from",outcome_formatted, sep=".")
    
    ## Extract state, hospital and outcome columns from data, remove all invalid rows
    dat <- subset(data, data[,colname] != "Not Available", select= c("State", "Hospital.Name", colname))
    
    ranked <- data.frame()
    
    ## Make all outcome data numeric, then rank each states' data and extract the required values
    dat[,colname] <- sapply(dat[,colname],as.numeric)
    statedata <- by(dat, dat$State, function(df) { d <- df[with(df, order(df[colname],df$Hospital.Name)),]
                                                   if (num == "best") {num <- 1 }
                                                   if (num == "worst") {num <- nrow(d) }
                                                   data.frame(hospital=d[num,"Hospital.Name"],state=df$State[1])
                                                 } )
    ## Create data frame from "by" object, and return it
    ranked <- do.call(rbind, statedata)
}

## This function takes a string and capitalizes the first letter of each word.
simpleCap <- function(x) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1,1)), substring(s, 2),
          sep="", collapse=" ")
}