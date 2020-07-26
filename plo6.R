scc <-readRDS("Source_Classification_Code.rds")
nei <-readRDS("summarySCC_PM25.rds")
s <- grep("Motor", scc$Short.Name, value = TRUE)
id <- scc[scc$Short.Name %in% s, c(1, 3)]
nei <- nei[nei$SCC %in% id$SCC & nei$fips %in% c("24510", "06037"), c("fips", "SCC", "Emissions", "year")]
renaming <- function(x){
  y <- character(0)
  if(x == "24510"){
    y <- "Baltimore City"
    }
  else{
    y <- "Los Angeles County"
  }
  y
}
nei$County <- sapply(nei$fips, renaming)
library(tidyverse)
emissions <- data.frame(nei %>% group_by(year, County) %>% summarise(emissions = sum(Emissions)))
library(ggplot2)
g <- ggplot(emissions, aes(year, emissions))
g <- g + geom_line() + facet_grid(.~County) + labs(x = "Year") + labs(y = "Emission (tons)") +
  labs(title = "Emissions from motor vehicles sources in Baltimore & Los Angeles County over 1999-2008") +
  theme(plot.title = element_text(hjust = 0.5))
print(g)
dev.copy(png, "plot6.png")
dev.off()