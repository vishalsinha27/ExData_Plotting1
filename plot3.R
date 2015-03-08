filename <- "household_power_consumption.txt"
if(!file.exists(filename)) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile="exdata-data-household_power_consumption.zip", method="curl", mode="wb")
  dateDownloaded <- date()
  unzip("exdata-data-household_power_consumption.zip")
}

data <- read.table(filename, header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)
data$Date <- as.Date(data$Date ,"%d/%m/%Y")
subsetdata <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02" )
rm(data)
subsetdata$Time <- as.POSIXct(paste(subsetdata$Date, subsetdata$Time), format="%Y-%m-%d %H:%M:%S")
png(file="plot3.png")

plot(subsetdata$Time,subsetdata$Sub_metering_1, type="l" , xlab="", ylab="Energy sub metering")
par(new = TRUE)
submeteringRange <- range(c(subsetdata$Sub_metering_1,subsetdata$Sub_metering_2,subsetdata$Sub_metering_3))


plot(subsetdata$Time,subsetdata$Sub_metering_2, type="l", ylim=submeteringRange, axes=FALSE,xlab="",ylab="",col="red")
par(new = TRUE)

plot(subsetdata$Time,subsetdata$Sub_metering_3, type="l", ylim=submeteringRange, axes=FALSE,xlab="",ylab="",col="blue")
legend("topright",  col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1)
dev.off()