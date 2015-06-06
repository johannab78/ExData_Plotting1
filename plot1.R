library(sqldf)

#Reading in desired date span, specify headers and type of separation, omit leading 0
power_consumption1 <- read.csv.sql("household_power_consumption.txt", 
                                   header = TRUE, sep = ";",
                                   sql = 'select * from file where Date in ("1/2/2007","2/2/2007")')
closeAllConnections()
#This yields 2880 observations of 9 variables

#plot nr 1
png(file = "plot1.png", width = 480, height = 480, bg ="dark grey")
hist(power_consumption1$Global_active_power, 
     col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()