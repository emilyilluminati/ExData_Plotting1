## Data for Electric power consumption available from 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

setwd('./ExData_Plotting1')

## Function to read data IN WINDOWS ONLY!
# We will only be using data from the dates 2007-02-01 and
# 2007-02-02. One alternative is to read the data from just those dates
# rather than reading in the entire dataset and subsetting to those
# dates.
readPowerData <- function(...) {
  initial <- read.csv("household_power_consumption.txt", 
                      nrows = 100, sep = ';')
  classes <- sapply(initial, class)
  classes["Date"]<-"character"
  classes["Time"]<-"character"
  data <- read.table(pipe('findstr /B /R ^[1-2]/2/2007 household_power_consumption.txt'),
                     header=F, sep=';',colClasses=classes)
  colnames(data) <-names(read.table('household_power_consumption.txt',
                                    header=T,sep=";",nrows=1))
  data$Date<-strptime(data$Date,"%d/%m/%Y")
  data$Time<-strptime(data$Time,"%H:%M:%S")
  rm(classes,initial)
  data
}
## Read data into memory.
PowerConsumption <- readPowerData()

##########################
##PLOT 3
##Plot Time Series of Sub-metering
##########################
par(mfrow = c(1, 1))
png(filename="plot3.png")
plot(as.ts(PowerConsumption$Sub_metering_1),
     ,ylab='Energy sub metering',xlab='',xaxt="n")
lines(as.ts(PowerConsumption$Sub_metering_2),col="red")
lines(as.ts(PowerConsumption$Sub_metering_3),col="blue")
axis(1, at=c(1,nrow(PowerConsumption)/2,nrow(PowerConsumption)), 
     labels=c("Thu","Fri","Sat"))
legend("topright", col = c("black", "red", "blue"), lty= "solid", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
dev.off()
