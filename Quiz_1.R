## Question 1
## The American Community Survey distributes downloadable data about 
## United States communities. Download the 2006 microdata survey about housing 
## for the state of Idaho using download.file() from here: 
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
## and load the data into R. The code book, describing the variable names is here: 
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
## How many properties are worth $1,000,000 or more?

# set directory and download file from the website
setwd("D:/R/Course_3_Q1")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "housing_data")

# read data in R
housing_data<- read.csv("housing_data")

# tabulate data and extract properties which are worth $1,000,000 or more (code 24)
table(housing_data$VAL)[[24]]

## Question 3
## Download the Excel spreadsheet on Natural Gas Aquisition Program here: 
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx 
## Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:dat 
## What is the value of:
## sum(dat$Zip*dat$Ext,na.rm=T) 
## (original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program)

# download file and read in xlsx package
# download mode needs to be set properly as write-binary (wb) since xlsx is basically a binary file (zip)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", destfile = "gas_acq.xlsx", mode="wb")
library(xlsx)

# assign rows and columns as numeric vectors, read the content and run analysis
rowIndex<- 18:23
colIndex<- 7:15

dat<- read.xlsx("gas_acq.xlsx", sheetIndex=1,rowIndex=rowIndex, colIndex=colIndex)
sum(dat$Zip*dat$Ext,na.rm=T)


## Question 4
## Read the XML data on Baltimore restaurants from here: 
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml 
## How many restaurants have zipcode 21231?

## install xml package and read in XML data
library(XML)
fileUrl<- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
restaurants<- xmlTreeParse(fileUrl, useInternal=TRUE)
## use xmlRoot method for providing easy access to the top-level XMLNode object
rootNode<- xmlRoot(restaurants)
## to extract all the values from xml use: xmlSApply(rootNode, xmlValue)
## to look at the single tag use: rootNode[[1]]
## to extract values for zip code use:
xpathSApply(rootNode, "//zipcode", xmlValue)

## count how many restaurants have zipcode 21231
sum(xpathSApply(rootNode, "//zipcode", xmlValue)==21231)

## Question 5
## The American Community Survey distributes downloadable data about United States communities. 
## Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
## using the fread() command load the data into an R object
## Which of the following is the fastest way to calculate the average value of the variable
## pwgtp15 
## broken down by sex (I choosed TYPE instead) using the data.table package?

library(data.table)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "housing_data.csv")

DT<- fread("housing_data.csv")
## file.info("housing_data")$size = 4253051 bytes

system.time(DT[,mean(wgtp15),by=TYPE])
system.time(sapply(split(DT$wgtp15,DT$TYPE),mean))
rowMeans(DT)[DT$TYPE==1]; rowMeans(DT)[DT$TYPE==2]
mean(DT[DT$TYPE==1,]$wgtp15);mean(DT[DT$TYPE==2,]$wgtp15)
tapply(DT$wgtp15,DT$TYPE,mean)
mean(DT$wgtp15,by=DT$TYPE)