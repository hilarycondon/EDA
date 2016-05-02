## This will construct a plot using the base plotting system and save it to a png file. 

## The purpose of this plot is to answer the question: 
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
## Which have seen increases in emissions from 1999-2008? 


## Findings: 
        ##Decreases: Non-Point, Non-Road, and Road (all have fluctuated but 2008 number is lower than 1999, and general downward trend)
        ## Increases: Point 

##Clear Environment
rm(list=ls())

##Load Packages

library(scales)
library(plyr)
library(dplyr)
library(ggplot2)

##Read Data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subset NEI Table for Baltimore City Only

baltimoreData <- ddply(NEI[NEI$fips == "24510", ],.(type,year), summarise,TotalEmissions = sum(Emissions))
par("mar"=c(5.1, 4.5, 4.1, 2.1))

png(filename = "./figure/plot3.png", 
    width = 480, height = 480, 
    units = "px")

##Construct Plot
print(ggplot(baltimoreData,aes(year,TotalEmissions,color=type))+geom_line()+geom_point()+labs(title = "Total Emissions by Type in Baltimore",x="Year",y="Total Emissions"))

##Deconnect
dev.off()

