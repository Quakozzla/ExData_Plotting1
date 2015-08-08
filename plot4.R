## Import data file, subsetting to 2007-02-01 and 2007-02-02

power.consumption <- subset(
                         read.csv("household_power_consumption.txt", 
                                  na.strings="?", 
                                  sep=";", 
                                  header=TRUE)
                         , Date %in% c("1/2/2007", "2/2/2007")
                    )

## Convert the date and time variables from strings to date/datettime
power.consumption$Date.convert <- as.Date(power.consumption$Date, "%d/%m/%Y")
power.consumption$Time.convert <- 
     strptime(paste(power.consumption$Date, power.consumption$Time, sep=" "), "%d/%m/%Y %T")

power.consumption$Date <- NULL
power.consumption$Time <- NULL

names(power.consumption)[names(power.consumption)=="Date.convert"] <- "Date"
names(power.consumption)[names(power.consumption)=="Time.convert"] <- "Time"

## Open File
png(file="plot4.png",
    width = 480, 
    height = 480)

## Set up 2 x 2 plotting
par(mfcol=c(2,2))

## Create Upper left plot
plot(power.consumption$Time,
     power.consumption$Global_active_power, 
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)"
)

## Create lower left plot
plot(power.consumption$Time,
     power.consumption$Sub_metering_1, 
     type="n",
     xlab="",
     ylab="Energy sub metering"
     )
lines(power.consumption$Time,
      power.consumption$Sub_metering_1,
      col="black")

lines(power.consumption$Time,
      power.consumption$Sub_metering_2,
      col="red")

lines(power.consumption$Time,
      power.consumption$Sub_metering_3,
      col="blue")

legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty=1,
       bty="n")

## Create upper right plot
plot(power.consumption$Time,
     power.consumption$Voltage, 
     type="l",
     xlab="datetime",
     ylab="Voltage"
     )

## Create lower right plot
plot(power.consumption$Time,
     power.consumption$Global_reactive_power, 
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power"
     )

## Reset mfcol
par(mfcol=c(1,1))

## Close file
dev.off()
