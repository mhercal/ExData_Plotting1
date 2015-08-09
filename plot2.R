#Read only the data we want and assign the names of columns back, and their classes.
columnas<-c("Date", "Time", "Global_active_power", "Global_reactive_power", 
            "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
col_class<-c("character", "character", "numeric", "numeric", "numeric", 
             "numeric","numeric", "numeric", "numeric")
raw_data<-read.csv("household_power_consumption.txt", sep=";", header=FALSE, 
                   colClasses = col_class, col.names = columnas, skip = 66637, nrows = 2880)

#Convert the dates and merge them with the time.

raw_data$Date<-as.Date(raw_data$Date, "%d/%m/%Y")
tiempo<-as.POSIXct(paste(raw_data$Date, raw_data$Time), format="%Y-%m-%d %H:%M:%S")

#clean the data, add the column with datetime
# I have removed the Date and Time columns, this is not necessary but de data will look clearer.
datos_limpios<-raw_data[,-(1:2)]
datos_limpios$Tiempo<-tiempo

#Print the graph in a PNG


png("plot2.png", width=480, height=480)

plot(x=datos_limpios$Tiempo, y=datos_limpios$Global_active_power, 
     type="l", ylab="Global Active Power (kilowatts)", xlab="")


dev.off()
