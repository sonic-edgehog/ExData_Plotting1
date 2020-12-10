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
png("plot3.png", width=480, height=480)

###Part 7: Create the plot itself with the following specification. It overlays the three plots in a single plot with the specifications.
plot(pow_DT[, dateTime], pow_DT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(pow_DT[, dateTime], pow_DT[, Sub_metering_2],col="red")
lines(pow_DT[, dateTime], pow_DT[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

###Part 8: Turn off the software
dev.off()