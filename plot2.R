## set the working directory
setwd("/Users/jgilliatt14/downloads")

## load in data; subset 
powerConsumption <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
subPower <- subset(powerConsumption, Date == "1/2/2007" | Date == "2/2/2007")
subPower$Date <- as.Date(subPower$Date, format="%d/%m/%Y")
rm(powerConsumption)

## convert dates and create DateTime column
dateTime <- paste(as.Date(subPower$Date), subPower$Time)
subPower$dateTime <- as.POSIXct(dateTime)

## create plot2 and save as png 
plot(subPower$Global_active_power ~ subPower$dateTime, type = "l", ylab = "Global Active Power (killowatts)", xlab = "")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
