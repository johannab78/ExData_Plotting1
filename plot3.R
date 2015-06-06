library(sqldf)
library(dplyr)

#Reading in desired date span, specify headers and type of separation, omit leading 0
power_consumption1 <- read.csv.sql("household_power_consumption.txt", 
                                   header = TRUE, sep = ";",
                                   sql = 'select * from file where Date in ("1/2/2007","2/2/2007")')
closeAllConnections()
#This yields 2880 observations of 9 variables

#convert Date and Time variables using strptime() and as.Date() functions
#first check structure of the data
str(power_consumption1)
#Date and Time are characters:
#first reformat the date column (0 had been removed earlier and reformat european date format)
power_consumption1$Date <-as.Date(power_consumption1$Date, format = "%d/%m/%Y")

power_consumption1$DateTime <-as.POSIXct(paste(power_consumption1$Date, power_consumption1$Time), format = "%Y-%m-%d %H:%M:%S")
#then join the Date and time columns using paste and convert ti POSIXct format (tricky to find right nomenclature)
#or strptime(paste(power_consumption1$Date, power_consumption1$Time), format = "%Y-%m-%d %H:%M:%S") works as well

#delete old Date and time columns
power_consumption1<-select(power_consumption1, -(Date:Time))

#see if conversion worked
str(power_consumption1)

#plot nr 3
png(file = "plot3.png", width = 480, height = 480, bg ="dark grey")
with(power_consumption1, plot(DateTime, Sub_metering_1, type = "n", xlab= "",
                              ylab="Energy sub metering"))
with(power_consumption1, lines(DateTime, Sub_metering_1, col = "black"))
with(power_consumption1, lines(DateTime, Sub_metering_2, col = "red"))
with(power_consumption1, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()