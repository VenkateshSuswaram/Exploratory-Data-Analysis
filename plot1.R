
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

hist(Dataset$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

### STEP 3 - PUBLISH THE CHART

dev.copy(png,"plot1.png", width=480, height=480)
dev.off()