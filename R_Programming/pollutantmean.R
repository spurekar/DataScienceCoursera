pollutantmean <- function(directory, pollutant, id=1:332)
{
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    
    files <- list.files(directory, full.names=TRUE)
    dat <- data.frame()
    
    ##for each id number
    for(i in id)
    {
        ##open the file
        ##add data to vector
        dat <- rbind(dat,read.csv(files[i]))
    }
    
    ##find and return mean
    mean(dat[,pollutant], na.rm=TRUE)
}

