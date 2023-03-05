# Data
# =============

## This first line will likely take a few seconds. Be patient!
# This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. 
# For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. 
# Here are the first few rows.
NEI <- readRDS("../summarySCC_PM25.rds")

# This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. 
# The sources are categorized in a few different ways from more general to more specific and you may choose 
# to explore whatever categories you think are most useful. 
# For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.
SCC <- readRDS("../Source_Classification_Code.rds")

# We merge the 2 files per SCC
NEI <- merge(NEI, SCC, by = "SCC",all.x=TRUE)

# VARIABLES
# ==========
# fips: A five-digit number (represented as a string) indicating the U.S. county
# SCC: The name of the source as indicated by a digit string (see source code classification table)
# Pollutant: A string indicating the pollutant
# Emissions: Amount of PM2.5 emitted, in tons
# type: The type of source (point, non-point, on-road, or non-road)
# year: The year of emissions recorded

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

NEI_Baltimore<-NEI[NEI$fips=="24510",c(2,4,5,6)]

plot_NEI_Baltimore<-ggplot(NEI_Baltimore,aes(factor(year), Emissions, fill=type)) +
    geom_bar(stat="identity") +
    facet_grid(.~type) + 
    labs(title="Evolution 1998-2008 of the emissions by type of source in Baltimore City", )+
    labs(x="Year", y="Emission in tons")+
    theme(plot.title = element_text(hjust = 0.5))
plot_NEI_Baltimore

dev.copy(png,file="plot3.png", width = 800, height = 600) # This copies the plot on screen in a png
dev.off()
