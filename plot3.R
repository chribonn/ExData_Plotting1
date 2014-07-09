# Check whether the data file exists. If it does not, download the zip archive
# and extact it. If it exists tell user that the file exists and show her the
# date when it was downloaded. Ask whether she would like to refresh or use the
# downloaded file. Store the date the file was last downloaded on in a file.
downloadFile <- function() {
    # This module does the actual downloading and file extraction
    downloadFl <- function(fileDtTm) {
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        zipFile <- "./data/household_power_consumption.zip"
        download.file(url, destfile = zipFile)
        
        # extract the archive
        unzip(zipFile, overwrite=TRUE, exdir="./data")
        
        # update the date the file was downloaded
        downloadDtTm <- format(Sys.time(), "%b %d %Y at %H:%M:%S")
        save(downloadDtTm, file = fileDtTm)        
    }
    
    fileDtTm <- "./data/household_power_consumption.RData"
    if (!file.exists("./data/household_power_consumption.txt")) {
        downloadFl(fileDtTm)
    }
    else {
        load(fileDtTm, envir=environment())
        cat("A data file already exists. It was downloaded on", downloadDtTm)
        ans <- readline("Download data again? [Y - to download again, any other input to use existing information] ") 
        if (tolower(ans) == "y") {
            downloadFl(fileDtTm)
        }
        
    }
}

# Check whether the data directory exists. If not create it
init <- function() {
    if (!file.exists("./data")) {
        dir.create("./data")
    }
}


# This module loads the file from the text file. It returns to the calling
# module a data set that only contains records having dates between 2007-02-01
# and 2007-02-02 (inclusive). The retruned data is properly classed as Date,
# POSIXlt with the remain columns classed as numeric
rst <- function() {
    # Read the data
    setClass("dmyyDate", representation(x="Date"))
    setAs("character","dmyyDate", function(from) as.Date(from, format="%d/%m/%Y"))
    data <- read.csv2("./data/household_power_consumption.txt", colClasses=c("dmyyDate", rep("character",8)), na.strings = "?")
    
    # Extract the required range
    data <- subset(data, Date >= as.Date("2007-02-01", format="%Y-%m-%d") & Date <= as.Date("2007-02-02", format="%Y-%m-%d"))
    
    # Convert all columns except the first 2 to numeric
    data[,3:ncol(data)] <- sapply(data[,3:ncol(data)], as.numeric)
    
    # Update the Time colum to class POSIXt. In order to acheive this, the date column must be combined with it
    data$Time <- strptime(paste(as.character(data[,1]), as.character(data[,2])), format="%Y-%m-%d %T")

    return(data)
}

##########################################################################
###    Main Code Body
##########################################################################

# Initialise any directories
init()

# This module deals with getting the data from the external source, unzipping
# the archive if this is not found. The the data alreay exists locally, the user
# is asked whether she would like to refresh it or use the existing download.
downloadFile()

# Read, subset and tidy the data
data <- rst()

# Plot the Data
# Plot 3
png(filename="plot3.png", width=480, height=480, units="px", restoreConsole=TRUE)
with(data, plot(Time, Sub_metering_1, type="l", col="black", xlab="", ylab=""))
with(data, points(Time, Sub_metering_2, type="l", col="red", xlab="", ylab=""))
with(data, points(Time, Sub_metering_3, type="l", col="blue", xlab="", ylab=""))
title(ylab="Energy sub metering")
legend("topright", col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lwd=2, cex=0.75)
dev.off()

