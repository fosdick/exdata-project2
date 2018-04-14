source("downloadArchive.R")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI data by Baltimore's fip.
baltimoreNEI <- NEI[NEI$fips=="24510",]


# Aggregate using sum the Baltimore emissions data by year
aggTotalsBaltimore <- aggregate(Emissions ~ year, baltimoreNEI,sum)

png("plot2.png",width=480,height=480,units="px",bg="white")

#par(mfrow=c(1,2), mar = c(4, 4, 2, 1))

barplot(
  aggTotalsBaltimore$Emissions,
  names.arg=aggTotalsBaltimore$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions From all Baltimore City Sources",
  col="dodgerblue1"
)
#simple check
s08 <- baltimoreNEI[baltimoreNEI$year == 2008,]
abline(h = sum(s08$Emissions, na.rm = T), col="green")   

dev.off()



