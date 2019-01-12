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
data <- read.csv.sql("household_power_consumption.txt", sql = "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'", sep = ";")


## Plot the data and annotate
hist(data$Global_active_power, main="Global Active Power", xlab ="Global Active Power (kilowatts)", col="red")

## Save the image as a png
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()