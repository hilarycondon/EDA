## This will construct a plot using the base plotting system and save it to a png file. 

## The purpose of this plot is to answer the question: 
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland dropped from 1999 to 2008? 
## Findings:  Emissions have fluctuated in Baltimore City, Maryland, but appear to have dropped from 2005. 

library(dplyr)

# Check if both data exist in the environment. If not, load the data.
if (!"NEI" %in% ls()) {
        NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
        SCC <- readRDS("./data/Source_Classification_Code.rds")
}

##Subset NEI Table for Baltimore City Only
EmissionSub <- subset(NEI, fips=="24510")


## Calculate the TOTAL emissions for each year being reviewed. 
##Set Years to Factors and Group by YEars, sum emmissions by year 
##Store to New Data frame

Emission <- EmissionSub %>%
        mutate(year = as.factor(year)) %>%
        group_by(year) %>%
        summarise(Sum_Emission = sum(Emissions)) %>%
        data.frame()

##Format the Graphics Device Defaults
par(mar=c(5.1, 4.1, 4.1, 3.1),mgp=c(3,5,0),las=1, mfrow=c(1,1))

# Open Connection to PNG Graphics Device to Write Plot
png(filename = "./figure/plot2.png", 
    width = 480, height = 480, 
    units = "px")

##Create Sum Labels to Use On Plot
labels <- Emission$Sum_Emission
labelNames <- prettyNum(labels,big.mark=",",preserve.width="none")

#Construct Plot
plot(Emission$year, 
     Emission$Sum_Emission, 
     type="l",
     xlab = "Year",
     ylab= "Total Annual Emission in Tons",
     boxwex = 0.01, 
     ylim=c(1600,4000),
     cex.main = 1,
     cex.axis=1,
     las=1,
     main=expression('Total Annual PM' [2.5]* " Emissions in Baltimore City, 1999-2008"))

##Format Points, Lines, Labels 

points(Emission$year, Emission$Sum_Emission, pch = 19)
lines(Emission$year, Emission$Sum_Emission,col="cyan3")
text(Emission$year, (Emission$Sum_Emission) + 300, labels = labelNames, col="darkblue")

##Stop the Connection

dev.off()


