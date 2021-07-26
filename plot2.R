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

#create a line graph showing the association between variables "DateTime" and "Global active power"  
#export the graph into png
png(filename = "plot2.png", width = 480, height = 480)
plot(data$DateTime, data$Global_active_power, 
     type = "l",
     xlab = NA,
     ylab = "Global Active Power (kilowatts)")
dev.off()