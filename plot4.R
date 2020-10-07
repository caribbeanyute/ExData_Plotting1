#Plot plot4.png
data <- read.csv("household_power_consumption.txt",sep=";")

#Parsing the Date as Date
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")

# We will be only using data from 2007-02-01 and 2007-02-02.
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")
oneday <- data[data$Date >= date1 & data$Date <= date2,]
#Removing data object
rm(data)

oneday$DateTime <- as.POSIXct(paste(oneday$Date, oneday$Time), format="%Y-%m-%d %H:%M:%S")


cols.num <- c("Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
oneday[cols.num] <- sapply(oneday[cols.num],as.numeric)
oneday[,] <- as.numeric(oneday[,c("Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")])


# 1. Open png file
png("plot4.png", width = 480, height = 480)
# set rows ans columns
par(mfrow=c(2,2))
# 2. Create the plot
with(oneday, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

# 3. Close the file
dev.off()

