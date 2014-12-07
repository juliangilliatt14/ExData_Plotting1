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

## create plot3
with(subPower, {
    plot(Sub_metering_1~dateTime, type="l",
         ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~dateTime,col='Red')
    lines(Sub_metering_3~dateTime,col='Blue')
})

## add legend
legend("topright", col=c("black", "red", "blue"), lty = 1, lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## save as png
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()


