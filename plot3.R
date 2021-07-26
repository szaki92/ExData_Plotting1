#read data
data <- read.table("C:/Users/szaka/OneDrive/Dokumentumok/household_power_consumption.txt"
                   , sep = ";", header = TRUE)

#subset data between 1 and 2 Feb 2007 and create a new variable from Date and Time
library(dplyr)
data <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")
data$DateTime <- paste(data$Date, data$Time, sep = " ")

#convert char to date
library(lubridate)
data$DateTime <- dmy_hms(data$DateTime)
Sys.setlocale("LC_TIME", "English")

#convert char to num
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

#create a line graph with three series of data (Sub_metering_1, ~2, ~3)
#plotted against DateTime
#export the graph into png
png(filename = "plot3.png", width = 480, height = 480)
with(data, plot(DateTime, Sub_metering_1, 
                type = "l", 
                col = "grey", 
                xlab = NA, 
                ylab = "Energy sub metering"
                ))
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("grey", "red", "blue"), 
       lty = 1)
with(data, lines(DateTime, Sub_metering_2, 
                 col = "red"))
with(data, lines(DateTime, Sub_metering_3, 
                 col = "blue"))
dev.off()