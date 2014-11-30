## This function takes three arguments: the 2-character abbreviated name of a 
## state, an outcome name, and the requested rank. The function reads the 
## outcome-of-care-measures.csv file and returns a character vector with the 
## name of the hospital that has the requested rank in 30-day mortality for the 
## specified outcome in that state.
rankhospital <- function(state, outcome, num = "best")
{
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character", header=TRUE)
    possible_outcomes <- c("heart attack", "heart failure", "pneumonia")
    
    ## Check that state and outcome are valid
    if(!is.element(state, state.abb))
    {
        stop("invalid state")
    }
    if(!is.element(outcome, possible_outcomes))
    {
        stop("invalid outcome")
    }
    
    ## Format input outcome name in to column name in data
    outcome_formatted = sapply(strsplit(simpleCap(outcome), " "),paste,collapse=".")
    colname <- paste("Hospital.30.Day.Death..Mortality..Rates.from",outcome_formatted, sep=".")
    
    ## Extract hospital and outcome columns from data for the state passed in
    dat <- subset(data, State==state, select= c("Hospital.Name", colname))
    
    ## Remove all invalid occurrences
    dat <- dat[dat[,colname] != "Not Available",]
    
    ## Sort by hospital name
    sorted_name <- dat[order(dat["Hospital.Name"]),]
    
    ## Make outcome values numeric, and sort by outcome. This makes the minimum
    ## come to the top, and if there is a tie, the hospitals are already sorted 
    ## by name from the previous step
    sorted_name[,colname] <- sapply(sorted_name[,colname],as.numeric)
    sorted_min <- sorted_name[order(sorted_name[colname]),]
    
    ## Return hospital name in that state with 30-day death rate rank passed in
    if (num == "best") {num <- 1 }
    if (num == "worst") {num <- nrow(sorted_min) }
    print(sorted_min[num,"Hospital.Name"])
}

## This function takes a string and capitalizes the first letter of each word.
simpleCap <- function(x) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1,1)), substring(s, 2),
          sep="", collapse=" ")
}