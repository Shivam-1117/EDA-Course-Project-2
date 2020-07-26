scc <-readRDS("Source_Classification_Code.rds")
nei <-readRDS("summarySCC_PM25.rds")
nei <-  nei[nei$fips == "24510", ]
emissions <- tapply(nei$Emissions, nei$year, sum)
plot(names(emissions), emissions, type = "o", col = "red", lwd = 2, xlab = "year",
     ylab = "total emission (tons)", main = "Total Emissions Vs Year for Baltimore city")
dev.copy(png, "plot2.png")
dev.off()