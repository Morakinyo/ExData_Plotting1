if (!file.exists(filename)){
fileUrl <- "https://d396qusza40orc.cloudfront.net/expdata%2Fpdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, filename)
}  


# Checking if folder/file exists
if (!file.exists("household_power_consumption")) { 
unzip(filename) 
}

## read pdata
pdata <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";")

## Create column in table with date and time merged together
fulltimedate <- strptime(paste(pdata$Date, pdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
pdata <- cbind(pdata, fulltimedate)

## change class of all columns to correct class
pdata$Date <- as.Date(pdata$Date, format="%d/%m/%Y")
pdata$Time <- format(pdata$Time, format="%H:%M:%S")
pdata$Global_active_power <- as.numeric(pdata$Global_active_power)
pdata$Global_reactive_power <- as.numeric(pdata$Global_reactive_power)
pdata$Voltage <- as.numeric(pdata$Voltage)
pdata$Global_intensity <- as.numeric(pdata$Global_intensity)
pdata$Sub_metering_1 <- as.numeric(pdata$Sub_metering_1)
pdata$Sub_metering_2 <- as.numeric(pdata$Sub_metering_2)
pdata$Sub_metering_3 <- as.numeric(pdata$Sub_metering_3)

## subset pdata from 2007-02-01 and 2007-02-02
subdata <- subset(pdata, Date == "2007-02-01" | Date =="2007-02-02")

## plot the 4 graphs
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(subdata, plot(fulltimedate, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(subdata, plot(fulltimedate, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
with(subdata, plot(fulltimedate, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(subdata$fulltimedate, subdata$Sub_metering_2,type="l", col= "red")
lines(subdata$fulltimedate, subdata$Sub_metering_3,type="l", col= "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black","red","blue"), cex = 0.8, lty = 1 , bty = "n")
with(subdata, plot(fulltimedate, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
dev.off()
