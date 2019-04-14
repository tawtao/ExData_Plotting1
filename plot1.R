# R script to plot the "Plot 1"

# download data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataFile <- "exdata.zip"

if( !file.exists(dataFile)) {
  download.file(fileUrl, destfile=dataFile, method="curl")
}

# Assume system has command 'zcat'
df <- read.table( 
                 pipe(paste("zcat", dataFile)), 
                 header=TRUE, sep=";", na.strings="?",
                 stringsAsFactors = FALSE
                 )

# Select data on dates on 01 and 02 Feb, 2007
df <- df[df$Date %in% c("1/2/2007", "2/2/2007"), ]

# Convert date and time column
df$Time <- strptime( paste(df$Date, " ", df$Time), "%d/%m/%Y %H:%M:%S")
df$Date <- as.Date( df$Date, "%d/%m/%Y")

png("plot1.png")
hist(df$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
