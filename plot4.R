scc <-readRDS("Source_Classification_Code.rds")
nei <-readRDS("summarySCC_PM25.rds")
s <- intersect(grep("COAL|coal|Coal", scc$Short.Name, value = TRUE), grep("COMB|comb|Comb", scc$Short.Name, value = TRUE))
id <- scc[scc$Short.Name %in% s, c(1, 3)]
nei <- nei[nei$SCC %in% id$SCC, c("fips", "SCC", "Emissions", "year")]
library(tidyverse)
emissions <- data.frame(nei %>% group_by(year) %>% summarise(emissions = sum(Emissions)))
library(ggplot2)
g <- ggplot(emissions, aes(year, emissions))
g <- g + geom_line() + labs(x = "Year") + labs(y = "Emission (tons)") +
  labs(title = "Emissions from coal combustion related sources in US over 1999-2008") +
  theme(plot.title = element_text(hjust = 0.5))
print(g)
dev.copy(png, "plot4.png")
dev.off()