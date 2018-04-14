source("downloadArchive.R")

# Load the NEI & SCC data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Gather the subset of the NEI data which corresponds to vehicles
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# Subset the vehicles NEI data by each city's fip and add city name.
vehiclesBaltimoreNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]
vehiclesBaltimoreNEI$city <- "Baltimore City"

vehiclesLANEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles County"

# Combine the two subsets with city name into one data frame
bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)

png("plot6.png",width=480,height=480,units="px",bg="transparent")

library(ggplot2)
 
head(vehiclesBaltimoreNEI, 2)
yb99 = vehiclesBaltimoreNEI[bothNEI$year == 1999 & bothNEI$city == "Baltimore City",]
mb99 = sum(yb08$Emissions)

yLA99 = vehiclesLANEI[vehiclesLANEI$year == 1999,]
mLA99 = sum(yLA08$Emissions)

yb08 = vehiclesBaltimoreNEI[bothNEI$year == 2008 & bothNEI$city == "Baltimore City",]
mb08 = sum(yb08$Emissions)

yLA08 = vehiclesLANEI[vehiclesLANEI$year == 2008,]
mLA08 = sum(yLA08$Emissions)

yLA05 = vehiclesLANEI[vehiclesLANEI$year == 2005,]
mLA05 = sum(yLA05$Emissions)
print((mLA05 - mLA99) / mLA05)
print(c(((mb99 - mb08) / mb99), ((mLA08 - mLA99) / mLA08)))


ld = data.frame(c(mb08),c(mLA08))
colnames(ld) = c("Baltimore City", "Los Angeles County")
ldData = c(mb99, mLA99);

ggp <- ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +
 geom_bar(aes(fill=year),stat="identity") +
 facet_grid(scales="free", space="free", .~city) +
 geom_hline(data=ld, aes(yintercept = ldData), color = "green") +
 guides(fill=FALSE) + theme_bw() +
 labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
 labs(title=expression("PM"[2.5]*" Motor Vehicle Emissions in Baltimore & LA, 1999-2008"))
 
print(ggp)

dev.off()

