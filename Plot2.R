# Setting Language to English (days in the x-axis)
Sys.setlocale("LC_TIME", "English")

if (!file.exists(filename)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, filename)
}  


# Checking if folder/file exists
if (!file.exists("household_power_consumption")) { 
  unzip(filename) 
}

# Loading the data
file_name <- "household_power_consumption.txt"
data <- read.table(file_name, header = TRUE, sep = ";", dec = ".", na.strings = "?")

# Subsetting data over the first two days in February
data <- data[data$Date %in% c("1/2/2007","2/2/2007"), ]

# Formatting the time vector into objects of type Date and POSIXct
date_converted <- as.Date(data[, 1], format = "%d/%m/%Y")
time_converted <- strptime(data[, 2], format = "%H:%M:%S")
time_axis <- as.POSIXct(paste(date_converted, data2[, 2]))

# Plotting data
plot(time_axis, data[, 3], xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")

# Saving data to PNG
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
