source("downloadArchive.R")

# Load the NEI & SCC data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# 
# s99 <- NEI[NEI$year == 1999,]
# s99m = sum(s99$Emissions)/10^6
# 
# s02 <- NEI[NEI$year == 2002,]
# s02m = sum(s02$Emissions)/10^6
# 
# s05 <- NEI[NEI$year == 2005,]
# s05m = sum(s05$Emissions)/10^6
# 
s08 <- NEI[NEI$year == 2008,]
s08m = sum(s08$Emissions)/10^6


png("plot1.png",width=480,height=480,units="px",bg="white")
#par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
# ys = c('1999','2002', '2005', '2008')
# ms = c(s99m, s02m, s05m, s08m)
# plot(ys, ms, ylab="Total PM2.5 Emissions", xlab="Years", col="navy", type="h", lwd=4
#      , main="Mean PM2.5 Emissions From ALL US Sources")
#abline(h=mean(ms))
#abline(h=s08m)
# Aggregate by sum the total emissions by year
aggTotals <- aggregate(Emissions ~ year,NEI, sum)



barplot(
  (aggTotals$Emissions)/10^6,
  names.arg=aggTotals$year,
  xlab="Year",
  ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM2.5 Emissions From All US Sources",
  col="dodgerblue3"
)
#extra check
abline(h=s08m)
#sends png to file
dev.off()

