scc <-readRDS("Source_Classification_Code.rds")
nei <-readRDS("summarySCC_PM25.rds")
nei <-  nei[nei$fips == "24510", ]
library(tidyverse)
em_nei <- nei %>% group_by(year, type) %>% summarise(emissions = sum(Emissions))
em_nei <- data.frame(em_nei)
library(ggplot2)
g <- ggplot(em_nei, aes(year, emissions))
g <- g + geom_line() + facet_grid(.~type) +
  labs(title = "Emissions in Baltimore from different sources over 1999-2008") +
  labs(x = "Year") + labs(y = "Emissions (tons)") +
  theme(plot.title = element_text(hjust = 0.5))
print(g)