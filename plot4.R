#load sqldf
library(sqldf)

#read the file into dataframe
pwr_df <- file("household_power_consumption.txt")
sub_df <- sqldf("select * from pwr_df where Date == '1/2/2007' or Date == '2/2/2007'  ",
            file.format = list(header = TRUE, sep = ";" ))
close(pwr_df)

#format the date and time
sub_df1<-paste(sub_df$Date, sub_df$Time, sep=" ")
sub_df2<- strptime(sub_df1, "%d/%m/%Y %H:%M:%S")

#set the size of plot and rows
png("./plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

#draw the plots
plot(sub_df2, sub_df$Global_active_power, xlab="", ylab="Global Active Power", type="n")
with(sub_df,lines(sub_df2,Global_active_power))

plot(sub_df2, sub_df$Voltage, xlab="datetime", ylab="Voltage", type="n")
with(sub_df,lines(sub_df2,Voltage))

plot(sub_df2, sub_df$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
with(sub_df,lines(sub_df2,Sub_metering_1,col="black"))
with(sub_df,lines(sub_df2,Sub_metering_2,col="red"))
with(sub_df,lines(sub_df2,Sub_metering_3,col="blue"))
legend("topright", col=c("black", "red", "blue"), lty=c(1,1,1), legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

plot(sub_df2, sub_df$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="n")
with(sub_df,lines(sub_df2,Global_reactive_power))

#close the device
dev.off()
