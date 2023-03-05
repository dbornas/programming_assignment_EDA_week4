getwd()
setwd("C:/Users/pet30/Google Drive/Curso R/Course Exploratory Data Analysis (EDA)/Assignment week 4")

# Data
# =============

## This first line will likely take a few seconds. Be patient!
# This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. 
# For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. 
# Here are the first few rows.
NEI <- readRDS("summarySCC_PM25.rds")

# This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. 
# The sources are categorized in a few different ways from more general to more specific and you may choose 
# to explore whatever categories you think are most useful. 
# For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.
SCC <- readRDS("Source_Classification_Code.rds")

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


# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.
years<-unique(NEI$year)

split_year<-split(NEI$Emissions, NEI$year)
emissions_year<-(sapply(split_year, sum))
emissions_year
par(mfrow=c(1,1), mar=c(5, 7, 4, 2))
barplot(emissions_year, years,
        col="blue", las=2, ylim = range(0:8e+6),
        main="PM2.5 Emissions from all sources in the USA 1999-2008")
title(ylab="Emissions in all sectors in tons", line = 4.5, cex.lab=1.3)
dev.copy(png,file="plot1.png") # This copies the plot on screen in a png
dev.off()
