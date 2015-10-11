## R-Script for Exploratory Data Analysis Course Project 1 - Coursera exdata-033
## Gabriel Lages - gabrielclages@gmail.com

#R-script to create a png file with the PLOT 4

# Seting the Working Directory
setwd("C:/Gabriel/Biblioteca/Cursos/R - Assignment/EDA")

## Course Project 1 - Exploratory Data Analysis

## Installing Packages
install.packages("downloader")
library(downloader)

#Downloading Data
fileurl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(fileurl, dest="dataset.zip", mode="wb")

#Unzip the file in working directory
unzip("dataset.zip")

# Importing the Data Set

header<-read.table("household_power_consumption.txt",sep=";",nrows=2, header = 1)
hpc<-read.table("household_power_consumption.txt",sep=";",skip=(grep("1/2/2007", readLines("household_power_consumption.txt")))-2,nrows=2880,na.strings = '?', header = TRUE)

#Inserting Headers in the Table
names(hpc)<-names(header)

#Inserting a new variable with the correct Date/Time Classes for each row
FullTime<-strptime(paste(hpc$Date,hpc$Time),"%d/%m/%Y %H:%M:%S")
hpc<-cbind(hpc,FullTime)

#Changing the time locale 
#(I've just used it because I live in Brazil and the results are supposed to be in english)
Sys.setlocale("LC_TIME", "English")



#Plot 4
#4 different charts 
#Seting the area for 4 charts
par(mfrow = c(2, 2))

#Chart 1 - Global_active_power x Time
plot(hpc$Global_active_power~hpc$FullTime, type="l", ylab="Global Active Power", xlab="")

#Chart 2 - Voltage x time
plot(hpc$Voltage~hpc$FullTime, type="l", ylab="Voltage", xlab="datetime")

#Chart 3 - sub metering (1,2,3) x time
plot(hpc$Sub_metering_1~hpc$FullTime, type="l", ylab="Energy sub metering", xlab="")
lines(hpc$Sub_metering_2~hpc$FullTime, col=2)
lines(hpc$Sub_metering_3~hpc$FullTime, col=4)
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.7, col=c(1,2,4), lty=1, bty="n")

#Chart 4 - Global_reactive_power x Time
plot(hpc$Global_reactive_power~hpc$FullTime, type="l", ylab="Global_rective_power", xlab="datetime")


#Saving plot4 to a png file
dev.copy(png, file="plot4.png")
dev.off()

