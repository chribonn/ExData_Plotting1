##########################################################################
###    Main Code Body
##########################################################################

# Load modules that are common to all of the plotx.R programs. This is to avoid 
# repetition and provide code reuse. The module is called loadData.R. The entry
# point is a function called ldMain().
source("loadData.R")

data <- ldMain()

# Plot the Data
# Plot 1
png(filename="plot1.png", width=480, height=480, units="px", restoreConsole=TRUE)
hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", cex.main=1)
dev.off()