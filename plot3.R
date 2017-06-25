
### STEP 1 - LOAD THE DATA IN TO R

Dataset <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

Dataset$Date <- as.Date(Dataset$Date, "%d/%m/%Y")

Dataset <- subset(Dataset,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

Dataset <- Dataset[complete.cases(Dataset),]

## MANIPULATE DATA SET AS PER NEEDS

dateTime <- paste(Dataset$Date, Dataset$Time)

dateTime <- setNames(dateTime, "DateTime")

Dataset <- Dataset[ ,!(names(Dataset) %in% c("Date","Time"))]

Dataset <- cbind(dateTime, Dataset)

Dataset$dateTime <- as.POSIXct(dateTime)

### STEP 2 - BRING THE CHART

with(Dataset, {
    plot(Sub_metering_1~dateTime, type="l",
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~dateTime,col='Red')
    lines(Sub_metering_3~dateTime,col='Blue')
  })
  legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

### STEP 3 - PUBLISH THE CHART

dev.copy(png,"plot3.png", width=480, height=480)
dev.off()