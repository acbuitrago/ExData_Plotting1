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

#Transform the columns 5,6 and 7 into numeric
res[,5]<-as.numeric(as.character(res[,5])) #now the 5 column is Submetering_1
res[,6]<-as.numeric(as.character(res[,6])) #now the 6 column is Submetering_2
res[,7]<-as.numeric(as.character(res[,7])) #now the 7 column is Submetering_3

#Change locale to English
Sys.setlocale("LC_TIME", "English")

par(bg=NA) #Allows transparent background

#Save plot to plot3.png
png("plot3.png", width = 480, height = 480, bg = "transparent")


#Plot DateTime vs Sub-metering 1 as lines
with(res, plot(DateTime, Sub_metering_1, 
               type = "l", xlab="", ylab="Energy sub metering"))
#Add lines of DateTime vs Sub-metering 2 in red
with(res, lines(DateTime, Sub_metering_2, col = "red"))
#Add lines of DateTime vs Sub-metering 3 in blue
with(res, lines(DateTime, Sub_metering_3, col = "blue"))
#Add legend
legend("topright", 
       lty=c(1,1,1), #Three lines
       col = c("black","blue", "red"), #Colors of the legends
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3")) #Text in legend


dev.off()