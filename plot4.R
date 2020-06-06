power <- read.table("household_power_consumption.txt", sep = ";", header = TRUE) #reading the data
power$newDate <- paste(power$Date, power$Time) #combine the column of date and time
power$newDate <- strptime(power$newDate, "%d/%m/%Y %H:%M:%S", tz = "GMT") #convert the data type into Date type
#subsetting the data
power$Date <- strptime(power$Date, "%d/%m/%Y")
feb1 <- strptime(20070201, "%Y%m%d") == power$Date
feb2 <- strptime(20070202, "%Y%m%d") == power$Date
subset <- feb1 | feb2
power2 <- power[subset,]

#making four figures (plot4)
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
#topleft
power2$Global_active_power <-  as.numeric(power2$Global_active_power)
plot(power2$newDate, power2$Global_active_power, type = "l", col = "black", ylab = "Global Active Power", xlab = "")
#topright
power2$Voltage <- as.numeric(power2$Voltage)
plot(power2$newDate, power2$Voltage, type = "l", col = "black", ylab = "Voltage", xlab = "datetime")
#bottomleft
power2$Sub_metering_1 <-  as.numeric(power2$Sub_metering_1)
power2$Sub_metering_2 <-  as.numeric(power2$Sub_metering_2)
power2$Sub_metering_3 <-  as.numeric(power2$Sub_metering_3)
plot(power2$newDate, power2$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
points(power2$newDate, power2$Sub_metering_1, type = "l", col = "black")
points(power2$newDate, power2$Sub_metering_2, type = "l", col = "red")
points(power2$newDate, power2$Sub_metering_3, type = "l", col = "blue")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", legend = labels, col = c("black","red","blue"), lty = 1)
#bottomright
power2$Global_reactive_power <-  as.numeric(power2$Global_reactive_power)
plot(power2$newDate, power2$Global_reactive_power, type = "l", col = "black", ylab = "Global Reactive Power", xlab = "datetime")
dev.off()
