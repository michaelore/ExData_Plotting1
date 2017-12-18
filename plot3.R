library(ggplot2)

df <- read.csv2("household_power_consumption.txt", stringsAsFactors = FALSE)
numCols <- c("Global_active_power", "Global_reactive_power", "Voltage",
             "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
df <- transform(df, Global_active_power=as.numeric(Global_active_power),
                Global_reactive_power=as.numeric(Global_reactive_power),
                Voltage=as.numeric(Voltage), Sub_metering_1=as.numeric(Sub_metering_1),
                Sub_metering_2=as.numeric(Sub_metering_2),
                Sub_metering_3=as.numeric(Sub_metering_3))

df$dt <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
sdf<-df[(df$dt$year==107)&(df$dt$mon==1)&(df$dt$mday>=1)&(df$dt$mday<=2),]

png("plot3.png")

plot(sdf$dt, sdf$Sub_metering_1, type="n",
     xlab="", ylab="Energy sub metering")
lines(sdf$dt, sdf$Sub_metering_1, lty=1, col="blue")
lines(sdf$dt, sdf$Sub_metering_2, lty=1, col="red")
lines(sdf$dt, sdf$Sub_metering_3, lty=1, col="green")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), col=c("blue", "red", "green"))

dev.off()