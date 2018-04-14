source("downloadArchive.R")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI data by Baltimore's fip.
baltimoreNEI <- NEI[NEI$fips=="24510",]


# Aggregate using sum the Baltimore emissions data by year
aggTotalsBaltimore <- aggregate(Emissions ~ year, baltimoreNEI,sum)

png("plot2.png",width=480,height=480,units="px",bg="white")

barplot(
  aggTotalsBaltimore$Emissions,
  names.arg=aggTotalsBaltimore$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions From all Baltimore City Sources",
  col=topo.colors(4)
)

dev.off()


s99 <- baltimoreNEI[baltimoreNEI$year == 1999,]
s99m = mean(s99$Emissions, tr=0.2)
print(s99m)

s02 <- baltimoreNEI[baltimoreNEI$year == 2002,]
s02m = mean(s02$Emissions, tr=0.2)
print(s02m)

s05 <- baltimoreNEI[baltimoreNEI$year == 2005,]
s05m = mean(s05$Emissions, tr=0.2)
print(s05m)

s08 <- baltimoreNEI[baltimoreNEI$year == 2008,]
s08m = mean(s08$Emissions, tr=0.2)
print(s08m)

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))
plot(s99$year, s99$Emissions, pch = 20)
abline(h = median(s99$Emissions, na.rm = T))

plot(s02$year, s02$Emissions, pch = 20)
abline(h = median(s02$Emissions, na.rm = T))

plot(s05$year, s05$Emissions, pch = 20)
abline(h = mean(s05$Emissions, na.rm = T), col="green", tr=0.8)

hist(s99$Emissions)
     
plot(s08$year, s08$Emissions, pch = 20)
abline(h = median(s08$Emissions, na.rm = T))


par(mfrow = c(1, 1), mar = c(4, 4, 2, 1))
hist(s99$Emissions, pch = 20)

