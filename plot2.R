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
##PLOT 2
##Plot Time Series of Global Active Power Use
##########################
par(mfrow = c(1, 1))
Use.Time.Series <- as.ts(PowerConsumption$Global_active_power)
png(filename="plot2.png")
plot(Use.Time.Series,ylab='Global Active Power (kilowatts)',
     xlab='',xaxt="n")
axis(1, at=c(1,nrow(PowerConsumption)/2,nrow(PowerConsumption)), 
     labels=c("Thu","Fri","Sat"))
dev.off()
