"""
Data descriptions

Smartcard ID, Time, Transaction type (21, 22, 31), Metro Station or Bus Line
Transaction Type:  31-Bus Boarding & 21-Subway Swiped-In  & 22-Subway Swiped-Out

SIM Card ID, Time, Latitude, Longitude

Taxi ID, Time, Latitude, Longitude, Occupancy Status, Speed
Occupancy Status: 1-with passengers & 0-with passengers

BUS ID, Time, PlateID, Latitude, Longitude, Speed

Truck ID, Date Time, Latitude, Longitude, Speed
"""
#install.packages()
library("data.table")
library("h2o")
library("ff")

#setwd("~/Vjera/DIPLOMSKI RAD/data/samples")
#setwd("~/Vjera/DIPLOMSKI RAD/data")

setwd("~/CODM/masters-thesis/data/samples")
setwd("~/CODM/masters-thesis/data")

file = file.choose()
#data <- read.csv(file)
##Error: cannot allocate vector of size 125.0 Mb

#TaxiData = fread(file=file, sep="auto", VERBOSE=TRUE)
##Windows:
##Error in fread(file = file, sep = "auto") : 
##Opened 0TB (1947283562 bytes) file ok but could not memory map it. This is a 32bit process. Please upgrade to 64bit.

#data<-read_delim_chunked(file, delim=",", chunk_size = 10000, col_names=TRUE,progress=TRUE)
##Using ',' as decimal and '.' as grouping mark. Use read_delim() for more control.
##Error in guess_header_(datasource, tokenizer, locale) : 
##Cannot read file C:/Users/admin/Documents/Vjera/DIPLOMSKI RAD/data/BusData: Not enough storage is available to process this command.

##TaxiData <- read.csv.ffdf(file=file, header=FALSE, col.names=taxi, VERBOSE=TRUE)#fileEncoding 
##csv-read=621.46sec  ffdf-write=72.23sec  TOTAL=693.69sec

file = paste(getwd(),"/TaxiData",sep="")
taxi = c("Taxi ID", "Time", "Latitude", "Longitude", "Occupancy Status", "Speed")
TaxiData = fread(file=file, sep="auto", header=FALSE)

file = paste(getwd(),"/BusData",sep="")
bus = c("BUS", "ID", "Time", "PlateID", "Latitude", "Longitude", "Speed")
BusData = fread(file=file, sep="auto", header=FALSE)

#BusData <- read.csv.ffdf(file=file, header=FALSE, col.names=bus, VERBOSE=TRUE)#fileEncoding 
#x<- read.csv.ffdf(file=file, header=FALSE, VERBOSE=TRUE, first.rows=10000, next.rows=50000, colClasses=NA, col.names=bus)

file = "~/Vjera/DIPLOMSKI RAD/data/PhoneData"

library("readr")

