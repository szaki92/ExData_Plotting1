#read data
data <- read.table("C:/Users/szaka/OneDrive/Dokumentumok/household_power_consumption.txt"
                   , sep = ";", header = TRUE)

#subset data between 1 and 2 Feb 2007
library(dplyr)
data <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

#convert char to num
data$Global_active_power <- as.numeric(data$Global_active_power)

#create a histogram from the variable "Global Active Power" and export it into png
png(filename = "plot1.png", width = 480, height = 480)
hist(data$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     col = "red")
dev.off()