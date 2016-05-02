## This will construct a plot using the base plotting system and save it to a png file. 

## The purpose of this plot is to answer the question: 
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater changes over time in motor vehicle emissions?
## Findings:  Emissions have fluctuated in Baltimore City, Maryland, but appear to have dropped from 2005. 
library(ggplot2)
library(dplyr)


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
        

EmitSub <- NEI[NEI$fips == "24510"|NEI$fips == "06037", ]

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "./figure/plot6.png", 
    width = 480, height = 480, 
    units = "px")
motor <- grep("motor", SCC$Short.Name, ignore.case = T)
motor <- SCC[motor, ]
motor <- EmitSub[EmitSub$SCC %in% motor$SCC, ]

g <- ggplot(motor, aes(year, Emissions, color = fips))
g<- g + geom_line(stat = "summary", fun.y = "sum") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle("Comparison of Total Emissions From Motor\n Vehicle Sources in Baltimore City\n and Los Angeles County from 1999 to 2008") +
        scale_colour_discrete(name = "Group", label = c("Los Angeles","Baltimore"))
print(g)
dev.off()