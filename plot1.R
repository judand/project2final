# Read the datas 
sumary <- readRDS("summarySCC_PM25.rds")
source <- readRDS("Source_Classification_Code.rds")

#create the device
png(filename = "plot1.png", width = 640, height = 480, units = "px")

# Plot the graph
with(sumary, plot(unique(year),  tapply(Emissions, year, sum), 
               type = "l", lwd = 2, 
               xlab = "Year", ylab = expression("Total PM"[2.5]*" Emissions"), 
               main = "Total Emissions from 1998 to 2008"))

dev.off()
