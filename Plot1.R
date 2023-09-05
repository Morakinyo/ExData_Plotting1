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

# Plotting the histogram plot
hist(data[, 3], col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

# Saving the plot to a PNG file
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
