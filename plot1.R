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

## Make Plot 1, display on the screen then copy to png
par(mfrow = c(1,1))
hist(edatatbl$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylim = c(0,1200))
dev.copy(png,"plot1.png")
dev.off()
