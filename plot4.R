##########################################################################
###    Main Code Body
##########################################################################

# Load modules that are common to all of the plotx.R programs. This is to avoid 
# repetition and provide code reuse. The module is called loadData.R. The entry
# point is a function called ldMain().
source("loadData.R")

data <- ldMain()

# Plot the Data
# Plot 4
png(filename="plot4.png", width=480, height=480, units="px", restoreConsole=TRUE)
par(mfrow = c(2,2), oma = c(1, 1, 1, 1))

# Chart 1
with(data, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))

# Chart 2
with(data, plot(DateTime, Voltage, type="l", ylab="Voltage", xlab="datetime"))

# Chart 3
with(data, plot(DateTime, Sub_metering_1, type="l", col="black", xlab="", ylab=""))
with(data, points(DateTime, Sub_metering_2, type="l", col="red", xlab="", ylab=""))
with(data, points(DateTime, Sub_metering_3, type="l", col="blue", xlab="", ylab=""))
title(ylab="Energy sub metering")
legend("topright", col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lwd=2, cex=0.75, bty = "n")

# Chart 4
with(data, plot(DateTime, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime"))

dev.off()

