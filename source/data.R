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
#TODO: install.packages(<list all required packages>)
#install.packages()

require("data.table")
require("readr")

setwd("~/CODM/masters-thesis/data/samples")
setwd("~/CODM/masters-thesis/data")

#file = file.choose()
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
## variable size 3.6 Mb ?!

file = paste(getwd(),"/PhoneData",sep="")
phone = c("SIM Card ID", "Time", "Latitude", "Longitude")

#system.time( PhoneData = fread(file=file, sep="auto", header=FALSE, col.names = phone))
## Error in system.time(PhoneData = fread(file = file, sep = "auto", header = FALSE,  : 
## unused argument (PhoneData = fread(file = file, sep = "auto", header = FALSE, col.names = phone))
                                       
system.time( PhoneData <- fread(file=file, sep="auto", header=FALSE, col.names = phone, quote=""))


# neka komanda
##Error: C stack usage  343997353 is too close to the limit

setorder(PhoneData, Time)#radi!! after added quote=""


#Cstack_info()
##size    current  direction eval_depth 
##7969177      25240          1          2 

#PhoneData[order(Time)]
##"never" ends

#system.time(setorderv(PhoneData,PhoneData$Time))
## Error: C stack usage  344004761 is too close to the limit
## Timing stopped at: 55.25 1.528 115.3

require(h2o)


########################################

file = paste(getwd(),"/TaxiData",sep="")
taxi = c("Taxi ID", "Time", "Latitude", "Longitude", "Occupancy Status", "Speed")
TaxiData = fread(file=file, sep="auto", header=FALSE, col.names = taxi)

file = paste(getwd(),"/BusData",sep="")
bus = c("BUS", "ID", "Time", "PlateID", "Latitude", "Longitude", "Speed")
BusData = fread(file=file, sep="auto", header=FALSE, col.names = bus)

file = paste(getwd(),"/SmartCardData",sep="")
smartCard = c("Smartcard ID", "Time", "Transaction type", "Metro Station or Bus Line")
SmartCardData = fread(file=file, sep="auto", header=FALSE)

file = paste(getwd(),"/TruckData",sep="")
truck = c("Truck ID", "Date Time", "Latitude", "Longitude", "Speed")
TruckData = fread(file=file, sep="auto", header=FALSE, col.names = truck)

## data.table -> matrix or data.frame
### save Environment
save.image("~/CODM/masters-thesis/source/data.RData")

