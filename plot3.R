## This file uses Hmisc, lubridate (to convert dates), 
## and dplyr(to filter, etc.) 
library(Hmisc)
library(lubridate)
library(dplyr)

## Read semicolon delimted file directly from the specified URL
eurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

alledata <- read.csv(getZip(eurl), sep = ";", 
                  colClasses = c("factor","factor","numeric","numeric",
                                 "numeric","numeric","numeric","numeric",
                                 "numeric"), na.strings = "?")

## Select only those data corresponding to the two dates in question
edata <- alledata[(alledata$Date == "1/2/2007" | alledata$Date == "2/2/2007"),]

## Convert to table for faster operations and use of dplyr 
edatatbl <- tbl_df(edata)
## Append date and time to get a date-time character string, 
## then use lubridate function to convert to time
edatatbl <- mutate(edatatbl, datetime = dmy_hms(paste(Date,Time)))

## Free up memory by deleting large tables
rm(alledata)

## Make Plot 3, display on the screen then copy to png
par(mfrow = c(1,1))
with(edatatbl, plot(datetime,Sub_metering_1, type = "l",
                    ylab = "Energy sub metering", xlab = ""))
with(edatatbl, points(datetime,Sub_metering_2, type = "l", col = "red"))
with(edatatbl, points(datetime,Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = 1, col = c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png,"plot3.png")
dev.off()