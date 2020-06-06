power <- read.table("household_power_consumption.txt", sep = ";", header = TRUE) #reading the data
power$newDate <- paste(power$Date, power$Time) #combine the column of date and time
power$newDate <- strptime(power$newDate, "%d/%m/%Y %H:%M:%S", tz = "GMT") #convert the data type into Date type
#subsetting the data
power$Date <- strptime(power$Date, "%d/%m/%Y")
feb1 <- strptime(20070201, "%Y%m%d") == power$Date
feb2 <- strptime(20070202, "%Y%m%d") == power$Date
subset <- feb1 | feb2
power2 <- power[subset,]
#make a line graph (plot3)
power2$Sub_metering_1 <-  as.numeric(power2$Sub_metering_1)
power2$Sub_metering_2 <-  as.numeric(power2$Sub_metering_2)
power2$Sub_metering_3 <-  as.numeric(power2$Sub_metering_3)
png("plot3.png", width = 480, height = 480)
plot(power2$newDate, power2$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
points(power2$newDate, power2$Sub_metering_1, type = "l", col = "black")
points(power2$newDate, power2$Sub_metering_2, type = "l", col = "red")
points(power2$newDate, power2$Sub_metering_3, type = "l", col = "blue")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", legend = labels, col = c("black","red","blue"), lty = 1)
dev.off()
