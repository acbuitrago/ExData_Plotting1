#Read data file named household_power_consumption.txt. Also, read '?' as NA values
data <-read.csv2("household_power_consumption.txt", na.strings="?")

#Create a new POSIXlt column from the Date column in dataset
data$DateNew<-strptime(data$Date, "%d/%m/%Y")

#Define two variables with dates 2007/02/01 and 2007/02/02
t1<-strptime("2007/02/01", "%Y/%m/%d")
t2<-strptime("2007/02/02", "%Y/%m/%d")

#Only keep the rows whose Dates are between t1 and t2
res<-data[data$DateNew>=t1 & data$DateNew<=t2,]

#Concatenate columns 1 and 2, meaning, concatenate Date and Time columns into
#DateTime column
res$DateTime<-do.call(paste, res[c(1, 2)])

#Remove from the dataframe the columns Date, Time and DateNew
res<-subset(res, select=-c(Date,Time,DateNew))

#Change the DateTime column in dataset to POSIXlt
res$DateTime<-strptime(res$DateTime, "%d/%m/%Y %H:%M:%S")

#Transform the columns 1,2,3 and 7 into numeric
res[,1]<-as.numeric(as.character(res[,1])) #now the first column is Global Active Power
res[,2]<-as.numeric(as.character(res[,2])) #now the second column is Global Reactive Power
res[,3]<-as.numeric(as.character(res[,3])) #now the third column is Voltage
res[,5]<-as.numeric(as.character(res[,5])) #now the 5 column is Submetering_1
res[,6]<-as.numeric(as.character(res[,6])) #now the 6 column is Submetering_2
res[,7]<-as.numeric(as.character(res[,7])) #now the 7 column is Submetering_3

#Change locale to English
Sys.setlocale("LC_TIME", "English")

#Save plot to plot4.png
png("plot4.png", width = 480, height = 480, bg = "transparent")

#Setup the number of plots per row
par(mfrow=c(2,2))
par(bg=NA) #Allows transparent background



#Make first plot
with(res, plot(DateTime, Global_active_power, 
               type = "l", 
               xlab="", ylab="Global Active Power"))

#Make second plot
with(res, plot(DateTime, Voltage, 
               type = "l", 
               xlab="datetime", ylab="Voltage"))

#Make third plot
with(res, plot(DateTime, Sub_metering_1, 
               type = "l", 
               xlab="", ylab="Energy sub metering"))

#Add lines of DateTime vs Sub-metering 2 in red
with(res, lines(DateTime, Sub_metering_2, col = "red"))
#Add lines of DateTime vs Sub-metering 3 in blue
with(res, lines(DateTime, Sub_metering_3, col = "blue"))
#Add legend
legend("topright", 
       lty=c(1,1,1), 
       col = c("black","blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
       cex=0.5,
       bty = "n")
#Make fourth plot
with(res, plot(DateTime, Global_reactive_power, 
               type = "l", 
               xlab="datetime"))


dev.off()