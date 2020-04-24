## Get file from the Web & and exctract it into a data frame using "read.table"
temp <- tempfile()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, temp)
con <- unz(temp, "household_power_consumption.txt")
dat <- read.table(con, header=TRUE ,sep=";")
unlink(temp)

## arrange data anf get data only from 2007-02-01/02
time1 <- strptime(dat$Date,"%d/%m/%Y")
logical <- (time1 == strptime("2007-02-01","%Y-%m-%d")) | (time1 == strptime("2007-02-02","%Y-%m-%d"))
dat<-dat[logical,]


## Plot "plot3"
## dat1 = dat[!is.nan(dat$Date) && !is.nan(dat$Time)]
par(bg="white")
time1<-as.POSIXct(paste(dat$Date, dat$Time), format="%d/%m/%Y %H:%M:%S")
plot(time1,as.double(as.character(dat$Sub_metering_1)),main="",xlab="",ylab="Global Active Power (kilowatts)",type="l",col="black")
lines(time1,as.double(as.character(dat$Sub_metering_2)),col="red",type="l")
lines(time1,as.double(as.character(dat$Sub_metering_3)),col="blue",type="l")
legend(1, 95, legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),       col=c("black","red", "blue"), lty=1:2, cex=0.8)

## Save plot 3 into a png file
## dim: 480 x 480
dev.print(png, 'plot3.png',width=480, height=480)
dev.off()


