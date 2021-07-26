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

#covert char to num
data$Global_active_power <- as.numeric(data$Global_active_power)

#open png device
png(filename = "plot4.png", width = 480, height = 480)

#set layout to 2x2 for a multipanel graph
par(mfrow = c(2, 2))

#create a line graph showing the association between variables "DateTime" and "Global active power"  
plot(data$DateTime, data$Global_active_power, 
     type = "l",
     xlab = NA,
     ylab = "Global Active Power")

#create a line graph showing the association between variables "DateTime" and "Voltage"  
plot(data$DateTime, data$Voltage, 
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

#create a line graph with three series of data (Sub_metering_1, ~2, ~3)
#plotted against DateTime
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

#create a line graph showing the association between variables "DateTime" and "Global reactive power"  
plot(data$DateTime, data$Global_reactive_power, 
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

#export to png
dev.off()