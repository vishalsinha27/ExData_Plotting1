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
png(file="plot1.png")
hist(subsetdata$Global_active_power, xlab="Global Active Power (kilowatts)", col="red" , main= "Global Active Power")
dev.off()