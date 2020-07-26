scc <-readRDS("Source_Classification_Code.rds")
nei <-readRDS("summarySCC_PM25.rds")
emissions <- tapply(nei$Emissions, nei$year, sum)
plot(names(emissions), emissions, type = "o", col = "red", lwd = 2, xlab = "year",
     ylab = "total emission (tons)", main = "Total Emissions Vs Year")
dev.copy(png, "plot1.png")
dev.off()