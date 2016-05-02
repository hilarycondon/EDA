## Question:
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? 
##Findings: Decrease

##Findings:

SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

## Get the emissions from motor vehicle sources (type = ON-ROAD) in Baltimore City (fips code: '24510')
baltimoreMotor <- NEI[NEI$type == 'ON-ROAD' & NEI$fips == '24510', ]
baltimoreMotorByYear <-  aggregate(Emissions ~ year, data = baltimoreMotor, FUN = sum)


# Print numeric values in fixed notation
options(scipen=10)
par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "./figure/plot5.png", 
    width = 480, height = 480, 
    units = "px")

with(baltimoreMotorByYear, {
        plot(year, Emissions, type = 'b',
             xlab="Year",
             ylab='PM2.5 Emissions (tons)',
             main='PM2.5 Emissions from motor vehicle sources in Baltimore City')
})
dev.off()