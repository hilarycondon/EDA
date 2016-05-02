## This will construct a plot using the base plotting system and save it to a png file. 

## The purpose of this plot is to answer the question: 
##Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
### Findings: Total U.S. PC 2.5 Emissions have decreased from 1999 to 2008. 
library(dplyr)
## The below code will read in data from current working directory 
##This first line will likely take a few seconds. Be patient! 
NEI <-readRDS("summarySCC_PM25.rds")
SCC <-readRDS("Source_Classification_Code.rds")

## Calculate the TOTAL emissions for each year being reviewed. 
##Set Years to Factors and Group by YEars, sum emmissions by year 
##Store to New Data frame

Emission <- NEI %>%
        mutate(year = as.factor(year)) %>%
        group_by(year) %>%
        summarise(Sum_Emission = sum(Emissions)) %>%
        data.frame()

# Set some default window settings for the plot view - margin size, axil label
# location and orientation
par(mar=c(5.1, 4.1, 4.1, 3.1),mgp=c(2.1,0.5,0),las=1, mfrow=c(1,1))

# Open Connection to PNG Graphics Device to Write Plot
png(filename = "./figure/plot1.png", 
    width = 480, height = 480, 
    units = "px")

##Create Sum Labels to Use On Plot
labels <- Emission$Sum_Emission
labelNames <- prettyNum(labels,big.mark=",",preserve.width="none")

#Construct Plot
plot(Emission$year, 
     Emission$Sum_Emission/1000000, ##Display in Millions
     type="n", 
     xlab = "Year",
     ylab = expression('Total PM'[2.5]*" Emission (Millions of Tons"),
     main = expression('Total Annual PM' [2.5]* " Emissions in the U.S, 1999-2008"), 
     yaxt="n", 
     ylim = c(2800000/1000000,8000000/1000000),
     boxwex=0.01,
     cex.axis = 1)

##Format Points, Lines, Labels 

pts <- pretty(Emission$Sum_Emission / 1000000)
axis(2, at = pts, labels = paste(pts, "M", sep = ""), las = 1)
points(Emission$year, Emission$Sum_Emission/1000000, pch = 19)
lines(Emission$year, Emission$Sum_Emission/1000000,col="cyan3")
text(Emission$year, (Emission$Sum_Emission/1000000) + 600000/1000000, labels = labelNames, col="darkblue")

##Stop the Connection

dev.off()


