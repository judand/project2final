# Read the data 
sumary <- readRDS("summarySCC_PM25.rds")
source <- readRDS("Source_Classification_Code.rds")

# Merge the two datasets
neiscc <- merge(sumary, source, by = "SCC")
neiscc <- transform(neiscc, year = factor(year))

# Gather the subset of the NEI data which corresponds to vehicles
vehicles <- grepl("vehicle", neiscc$SCC.Level.Two, ignore.case=TRUE)
vehiclesNEI <- neiscc[vehicles,]

# Subset the vehicles NEI data to Baltimore's & LA's fip
baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]
baltimoreVehiclesNEI$city <- "Baltimore City"

LAvehiclesNEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
LAvehiclesNEI$city <- "Los Angeles County"

# Combine the two subsets with city name into one data frame
bothNEI <- rbind(baltimoreVehiclesNEI,LAvehiclesNEI)

# Open a new graphics device 
png("plot6.png",width=640,height=480,units="px")


# Plot 
g <- ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(stat="identity") +
  facet_grid(.~city) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission")) + 
  labs(title=expression("Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

print(g)

dev.off()
