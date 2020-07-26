scc <-readRDS("Source_Classification_Code.rds")
nei <-readRDS("summarySCC_PM25.rds")
s <- grep("Motor", scc$Short.Name, value = TRUE)
id <- scc[scc$Short.Name %in% s, c(1, 3)]
nei <- nei[nei$SCC %in% id$SCC & nei$fips == "24510", c("fips", "SCC", "Emissions", "year")]
library(tidyverse)
emissions <- data.frame(nei %>% group_by(year) %>% summarise(emissions = sum(Emissions)))
library(ggplot2)
g <- ggplot(emissions, aes(year, emissions))
g <- g + geom_line() + labs(x = "Year") + labs(y = "Emission (tons)") +
  labs(title = "Emissions from motor vehicles related sources in Baltimore City over 1999-2008") +
  theme(plot.title = element_text(hjust = 0.5))
print(g)
dev.copy(png, "plot5.png")
dev.off()