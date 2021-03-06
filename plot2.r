## Load the library to only load the necessary data
library(sqldf)

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "household.zip"

## If zip file doesn't exist, download it
if(!file.exists("household.zip"))
{
	download.file(fileURL, fileName)
	unzip(fileName)
}

## Only load the necessary data required to plot the graph with SQL
data <- read.csv.sql("household_power_consumption.txt", sql = "SELECT * from  file WHERE Date = '1/2/2007' OR Date = '2/2/2007'", sep = ";")

## Convert the dates to an R date object
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

library(dplyr)
## We cannot just convert the time. We need the date as well, so we add an extra column that
data <- mutate(data, Full_date = paste(data$Date, data$Time, sep = " "))

## Convert the times to an R time object
data$Full_date <- strptime(data$Full_date, format = "%Y-%m-%d %H:%M:%S")

## Plot the graph #2
with(data, plot(data$Full_date, data$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)"))

## Save the image as a png
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()