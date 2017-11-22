# Load the  packages
library(ggplot2)

# Read the data 
sumary <- readRDS("summarySCC_PM25.rds")
source <- readRDS("Source_Classification_Code.rds")

# Merge the two datasets
neiscc <- merge(sumary, source, by = "SCC")
neiscc <- transform(neiscc, year = factor(year))

# Gather the subset of the NEI data which corresponds to vehicles
vehicles <- grepl("vehicle", neiscc$SCC.Level.Two, ignore.case=TRUE)
vehiclesNEI <- neiscc[vehicles,]

# Subset the vehicles NEI data to Baltimore's fip
baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]

aggregatedTotalByYear <- aggregate(Emissions ~ year, baltimoreVehiclesNEI, sum)

# new graphics device in png
png("plot5.png",width=640,height=480,units="px")


# Plot 
g <- ggplot(aggregatedTotalByYear,aes(year,Emissions))
g <- g + geom_bar(stat="identity", width = 0.5) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission")) + 
  labs(title = "Motor Vehicle Source Emissions in Baltimore from 1999-2008")
print(g)
dev.off()
