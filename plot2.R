##########################################################################
###    Main Code Body
##########################################################################

# Load modules that are common to all of the plotx.R programs. This is to avoid 
# repetition and provide code reuse. The module is called loadData.R. The entry
# point is a function called ldMain().
source("loadData.R")

data <- ldMain()

# Plot the Data
# Plot 2
png(filename="plot2.png", width=480, height=480, units="px", restoreConsole=TRUE)
par(mar=c(4, 4, 0, 0))
with(data, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()