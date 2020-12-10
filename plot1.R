###Part 1: Set the corresponding work directory where the dataset is stored.
###Prerequisite: Download the dataset first

library("data.table")

setwd("~\Documents\Work\Coursera\R works\exdata_data_household_power_consumption")

###Part 2: Read the whole dataset itself
pow_DT = data.table::fread(input = "household_power_consumption.txt", na.strings="?")

###Part 3: Use apply function for a column to prevent change the numbers to scientific notation
pow_DT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

###Part 4: Use the apply function for a date column to change into another format
pow_DT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

###Part 5: Filter the Date just between 2007-Feb-01 and 2007-Feb-02
pow_DT = pow_DT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

###Part 6: Create a png file to save the plot
png("plot1.png", width=480, height=480)

###Part 7: Create the plot itself with the following specification
hist(pow_DT[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

###Part 8: Turn off the software
dev.off()