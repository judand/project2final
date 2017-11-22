# Read the data 
sumary <- readRDS("summarySCC_PM25.rds")
source <- readRDS("Source_Classification_Code.rds")

# new  device png
png(filename = "plot2.png", width = 640, height = 480, units = "px")

# Subset the data for only the Baltimore City, Maryland
bcity <- subset(sumary, fips == "24510")

# Plot the graph
with(bcity, plot(unique(year),  tapply(Emissions, year, sum), 
               type = "l", lwd = 2, 
               xlab = "Year", ylab = expression("Total PM"[2.5]*" Emissions"), 
               main = "Total Emissions in Baltimore City, Maryland from 1999 to 2008"))

dev.off()
