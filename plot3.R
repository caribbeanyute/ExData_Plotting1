#Plot plot3.png
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
png("plot3.png", width = 500, height =500)
# 2. Create the plot
plot(oneday$Sub_metering_1~oneday$DateTime,type="l",ylab = "Energy sub metering",xlab = "")
lines(oneday$Sub_metering_2~oneday$DateTime,col="red")
lines(oneday$Sub_metering_3~oneday$DateTime,col="blue")
legend("topright",pch=NA,legend = colnames(oneday[,7:9]),col=c("black","red", "blue"))

# 3. Close the file
dev.off()

