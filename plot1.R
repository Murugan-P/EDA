#load sqldf
library(sqldf)

#read the file into dataframe
pwr_df <- file("household_power_consumption.txt")
sub_df <- sqldf("select * from pwr_df where Date == '1/2/2007' or Date == '2/2/2007'  ",
            file.format = list(header = TRUE, sep = ";" ))
close(pwr_df)

#set the size of plot and draw
png("./plot1.png", width = 480, height = 480)
with(sub_df, hist(Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red"))

#close the device
dev.off()