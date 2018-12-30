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
require("fasttime")

setwd("~/CODM/masters-thesis/data/samples")
setwd("~/CODM/masters-thesis/data")
########################################
file = paste(getwd(),"/PhoneData",sep="")
phone = c("SIM Card ID", "Time", "Latitude", "Longitude")

setClass('myTime')
setAs('character','myTime', function(from) as.Date(from, format='%H:%M:%S'))

colCl = c("numeric","myTime","numeric","numeric")

system.time( PhoneData <- fread(file=file, sep="auto", header=FALSE, colClasses = c('numeric','myTime','numeric','numeric'), col.names = phone, quote=""))
str(PhoneData)

system.time(setorder(PhoneData, Time))#radi!! after added quote=""

########################################

file = paste(getwd(),"/PhoneData_ordered_by_Time.csv",sep="")
phone = c("SIM Card ID", "Time", "Latitude", "Longitude")
system.time( PhoneData <- fread(file=file, sep="auto", header=FALSE, col.names = phone, quote=""))

PDsample = head(PhoneData,50000)
PDsample_backup = copy(PDsample)
PDsample = copy(PDsample_backup)


#require(hsm)
#PDsample$Time = as.hsm(PDsample$Time)

#strptime(PDsample$Time, format ="%H:%M:%S")#returns class POSIXlt- a list

#PDsample[, (PDsample$Time):=lapply(PDsample$Time, function(x) as.POSIXct(strptime(x,"%H:%M%S"))), .SDcols=cols]#nisu dobri argumenti
PDsample[, posixct:= as.POSIXct(paste(Time),format("%H%M%S"),tz="GTM")]

PDsample[, .(count = .N), by = .(Time, interval = hour(Time) %/% 3)]

#split(PDsample, cut(PDsample$Time,breaks = "hour"))
##PDsample$group = cumsum(ifelse(difftime(PDsample$Time, shift( PDsample$Time, fill = PDsample$Time[1]),units = "hours") >=3))

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

