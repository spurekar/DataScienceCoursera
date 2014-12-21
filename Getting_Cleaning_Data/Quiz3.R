#Question 1
Question1 <- function()
{
    filename = "housingData.csv"
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv ",destfile=filename)
    housingData <- read.csv(filename)
    agricultureLogical <- c(housingData$ACR==3, housingData$AGR == 6)
    print(which(agricultureLogical)[1:3])
}

#Question 2
Question2 <- function()
{
    filename = "jeff.jpg"
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",destfile=filename,mode="wb")
    img <- readJPEG(filename, native=TRUE)
    quantile(img,probs=c(.3,.8))
}

#Question 3
Question3 <- function()
{
    GDPfile = "gdp.csv"
    Edufile = "edu.csv"
    #download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",destfile=GDPfile)
    #download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",destfile=Edufile)
    gdp <- read.csv(GDPfile, skip=4, stringsAsFactors=FALSE)
    edu <- read.csv(Edufile)
    
    keep <- c("X","X.1","X.3","X.4")
    gdp <- gdp[,keep]
    names(gdp) <- c("CountryCode","Ranking","Country","GDP")
    gdp <- gdp[gdp$Ranking != "",]
    gdp <- gdp[1:190,]
    
    merged <- merge(gdp,edu,by=intersect(names(gdp),names(edu)))
    merged$Ranking <- as.numeric(merged$Ranking)
    arrange(merged,desc(merged$Ranking))
}


#Question 4
Question4 <- function()
{
    merged <- Question3()
    tapply(merged$Ranking,merged$Income.Group,mean)
    #merged$GDP <- sapply(merged$GDP, function(x) {as.numeric(str_trim(gsub(",","",x,fixed=TRUE)))})
}


#Question 5
Question5 <- function()
{
    merged <- Question3()
    tapply(merged$Ranking,merged$Income.Group,mean)
    merged$RankingGroups = cut(merged$Ranking,breaks=quantile(merged$Ranking,c(0,.2,.4,.6,.8,1)))
    xt <- xtabs(Freq ~ RankingGroups + Income.Group,data=merged)
}