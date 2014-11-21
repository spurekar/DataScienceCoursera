corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    
    #dat <- data.frame()
    dat <- complete(directory)
    files <- list.files(directory, full.names=TRUE)
    correl <- vector()
    
    for(i in 1:nrow(dat))
    {
        if(dat[i,"nobs"] > threshold)
        {
            file = read.csv(files[i])
            file_sul <- file$sulfate            
            file_nit <- file$nitrate            
            correl <- c(correl, cor(file$sulfate,file$nitrate,use="complete.obs"))
        }
    }
    if (length(correl) == 0)
    {
        correl <- numeric(0)
    }
    
    correl
}
