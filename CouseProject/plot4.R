
##Quesiton: 
##Across the United States, how have emissions from coal combustion-related sources 
##changed from 1999–2008?

##Findings: General Decrease


require(plyr)
require(ggplot2)

SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

##Coal Combustion Sources: 
SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

merge <- merge(x=NEI, y=SCC.coal, by='SCC')
merge.sum <- aggregate(merge[, 'Emissions'], by=list(merge$year), sum)
colnames(merge.sum) <- c('Year', 'Emissions')

par("mar"=c(5.1, 4.5, 4.1, 2.1))

png(filename = "./figure/plot4.png", 
    width = 480, height = 480, 
    units = "px")

print(ggplot(data=merge.sum, aes(x=Year, y=Emissions/1000)) + 
        geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=2, col=Emissions)) + 
        ggtitle(expression('Total Emissions of PM'[2.5])) + 
        ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 
        geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) + 
        theme(legend.position='none') + scale_colour_gradient(low='black', high='blue'))

dev.off()