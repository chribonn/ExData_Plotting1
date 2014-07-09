##########################################################################
###    Main Code Body
##########################################################################

# Load modules that are common to all of the plotx.R programs. This is to avoid 
# repetition and provide code reuse. The module is called loadData.R. The entry
# point is a function called ldMain().
source("loadData.R")

data <- ldMain()

# Plot the Data
# Plot 3
png(filename="plot3.png", width=480, height=480, units="px", restoreConsole=TRUE)
with(data, plot(DateTime, Sub_metering_1, type="l", col="black", xlab="", ylab=""))
with(data, points(DateTime, Sub_metering_2, type="l", col="red", xlab="", ylab=""))
with(data, points(DateTime, Sub_metering_3, type="l", col="blue", xlab="", ylab=""))
title(ylab="Energy sub metering")
legend("topright", col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lwd=2, cex=0.75)
dev.off()

