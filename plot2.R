power <- read.table("household_power_consumption.txt", sep = ";", header = TRUE) #reading the data
power$newDate <- paste(power$Date, power$Time) #combine the column of date and time
power$newDate <- strptime(power$newDate, "%d/%m/%Y %H:%M:%S", tz = "GMT") #convert the data type into Date type
#subsetting the data
power$Date <- strptime(power$Date, "%d/%m/%Y")
feb1 <- strptime(20070201, "%Y%m%d") == power$Date
feb2 <- strptime(20070202, "%Y%m%d") == power$Date
subset <- feb1 | feb2
power2 <- power[subset,]

#make a line graph
power2$Global_active_power <-  as.numeric(power2$Global_active_power)
png("plot2.png", width = 480, height = 480)
plot(power2$newDate, power2$Global_active_power, type = "l", col = "black", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
