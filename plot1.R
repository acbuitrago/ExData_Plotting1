#Read data file named household_power_consumption.txt. Also, read '?' as NA values
res <-read.csv2("household_power_consumption.txt", na.strings="?")

#Change the Date column in dataset to POSIXlt
res$Date<-strptime(res$Date, "%d/%m/%Y")

#Define two variables with dates 2007/02/01 and 2007/02/02
t1<-strptime("2007/02/01", "%Y/%m/%d")
t2<-strptime("2007/02/02", "%Y/%m/%d")

#Only keep the rows whose Dates are between t1 and t2
res<-res[res$Date>=t1 & res$Date<=t2,]

#Transform the third column into numeric
res[,3]<-as.numeric(as.character(res[,3]))
par(bg=NA) #Allows transparent background

#Save histogram to plot1.png
png("plot1.png", width = 480, height = 480, bg = "transparent")


#Make histogram
hist(res$Global_active_power, 
     main="Global Active Power", 
     xlab = "Global Active Power (kilowattts)", 
     col="red")


dev.off()