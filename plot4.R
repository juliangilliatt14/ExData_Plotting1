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

## create plot 4 and save as png
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(subPower, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="datetime")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
