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
res$DateTime<-do.call(paste, res[c(1, 2)]) #This could be done in line 5 but is better to do it now that we have just the rows that we need (might more efficient)

#Remove from the dataframe the columns Date, Time and DateNew
res<-subset(res, select=-c(Date,Time,DateNew))

#Change the DateTime column in dataset to POSIXlt
res$DateTime<-strptime(res$DateTime, "%d/%m/%Y %H:%M:%S")

#Transform the first column into numeric
res[,1]<-as.numeric(as.character(res[,1])) #now the first column is Global Active Power

#Change locale to English
Sys.setlocale("LC_TIME", "English")

par(bg=NA) #Allows transparent background

#Save plot to plot2.png
png("plot2.png", width = 480, height = 480, bg = "transparent")


#Make the plot
with(res, plot(DateTime, Global_active_power, 
               type = "l",
               xlab="", 
               ylab="Global Active Power (kilowatts)"))


dev.off()