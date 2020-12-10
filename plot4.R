###Part 1: Set the corresponding work directory where the dataset is stored.
###Prerequisite: Download the dataset first

library("data.table")

setwd("~\Documents\Work\Coursera\R works\exdata_data_household_power_consumption")

###Part 2: Read the whole dataset itself
pow_DT = data.table::fread(input = "household_power_consumption.txt", na.strings="?")

###Part 3: Use apply function for a column to prevent change the numbers to scientific notation
pow_DT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

###Part 4: Make a POSIXct date capable of being filtered and graphed by time of day
pow_DT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

###Part 5: Filter the Date just between 2007-Feb-01 and 2007-Feb-02
pow_DT = pow_DT[(Date >= "2007-02-01") & (Date < "2007-02-03")]

###Part 6: Create a png file to save the plot
png("plot4.png", width=480, height=480)

###Part 7: Create an empty two by two matrix of graphs
par(mfrow=c(2,2))

###Part 8: For the upper left plot, plot the time series of datetime and global active power with the specifications.
plot(pow_DT[, dateTime], pow_DT[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

###Part 9: For the upper right plot, plot the time series of datetime and voltage with the specifications.
plot(pow_DT[, dateTime],pow_DT[, Voltage], type="l", xlab="datetime", ylab="Voltage")

###Part 10: For the lower left plot, Recreate the third plot in plot3.R code earlier.
plot(pow_DT[, dateTime], pow_DT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(pow_DT[, dateTime], pow_DT[, Sub_metering_2], col="red")
lines(pow_DT[, dateTime], pow_DT[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

###Part 11: For the lower right plot, plot the time series of datetime and global reactive power with the specifications.
plot(pow_DT[, dateTime], pow_DT[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

###Part 12: Turn off the software
dev.off()