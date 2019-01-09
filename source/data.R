#TODO: install.packages(<list all required packages>)
#install.packages()

require("data.table")
require("readr")
#require("fasttime")

setwd("~/CODM/masters-thesis/data/samples")
setwd("~/CODM/masters-thesis/data")

########## Import PhoneData ################
file = paste(getwd(),"/PhoneData", sep="")
phone = c("SIM Card ID", "Time", "Latitude", "Longitude")
system.time( PhoneData <- fread(file=file, sep="auto", header=FALSE, colClasses = c('numeric','numeric','numeric','numeric'), col.names = phone, quote=""))
    #38218717 obs. of  4 variables
str(PhoneData)##Time je chr -> "ignorira" colClasses, cak ne baci ni warning da Time ne moze ucitati ko numeric
system.time(setorder(PhoneData, Time))#radi!! after added quote=""

  # save()/load() - save multiple objects to a file - RDATA, saveRDS()/loadRDS() - for one object to a file - RDS, save.image() save workspace 
system.time(fwrite(PhoneData, file = paste(getwd(),"/PhoneData_ordered_by_Time.csv", sep="" )))# size 1,5 GB
save(PhoneData, file = paste(getwd(),"/PhoneData_ordered_by_Time.RData", sep="")) #file ima samo 254,8 MB 

### Import PhoneData_ordered_by_Time.csv  ###
file = paste(getwd(),"/PhoneData_ordered_by_Time.csv", sep="")
phone = c("SIM Card ID", "Time", "Latitude", "Longitude")
system.time( PhoneData <- fread(file=file, sep="auto", header=FALSE, col.names = phone, quote="")) # bitno je da ima quote 
  #38218718 obs. of  4 variables
  #   user  system elapsed 
  # 37.640   1.308  70.624 

### load PhoneData_ordered_by_Time.RData  ###
file = paste(getwd(),"/PhoneData_ordered_by_Time.RData", sep="")
system.time(load(file = file))
  #  user  system elapsed 
  # 17.132   0.636  18.107

##########  Random sample 50k  ############
#PDsample = head(PhoneData,50000)
system.time( PDsample <- PhoneData[sample(nrow(PhoneData), 50000), ])
#random sample https://stat.ethz.ch/pipermail/r-help/2007-February/125860.html,  zdere ram, blocka se ako nema dosta
system.time(setorder(PDsample, Time))

PDsample_50k = PDsample 
system.time(save( PDsample_50k, file = paste(getwd(),"/PDsample_50k.RData", sep="")))

##########  Random sample 500k  ############
#PDsample = head(PhoneData,500000)
system.time( PDsample <- PhoneData[sample(nrow(PhoneData), 500000), ])
# user   system  elapsed 
# 2.036    8.120 1487.620
system.time(setorder(PDsample, Time))

PDsample_500k = PDsample 
system.time(save( PDsample_500k, file = paste(getwd(),"/PDsample_500k.RData", sep="")))


##########  Import sample 50k  ############
file = paste(getwd(),"/PDsample_50k.RData",sep="")
system.time( load(file = file))

PDsample = PDsample_50k

#### Sample #### Good for both 50k and 500k samples

PDsample_backup = copy(PDsample) # copy, inace pointer
PDsample = copy(PDsample_backup)

#require(hsm)
#PDsample$Time = as.hsm(PDsample$Time)
#strptime(PDsample$Time, format ="%H:%M:%S")#returns class POSIXlt- a list

#PDsample[, (PDsample$Time):=lapply(PDsample$Time, function(x) as.POSIXct(strptime(x,"%H:%M%S"))), .SDcols=cols]#nisu dobri argumenti
#PDsample[, posixct:= as.POSIXct(paste(Time),format("%H:%M:%S"),tz="GTM")]
#PDsample[, posixct:= as.POSIXct(paste(Time),format("%T"),tz="GTM")]
# POSIX jednostavno nema format, klasa je datetime i tjt.

require(lubridate)

t1 = strptime(PDsample$Time,"%T") #doda danasnji datum "2019-01-09 01:20:18 CET" POSIXlt
t2 = parse_date_time(PDsample$Time, "H%:M%:S%") #doda datum, ali ne danasnji "0-01-01 01:20:10 UTC" POSIXct

t = t1 # 2.5 MB
t = t2 # 391.2 KB

#require(chron)
#onlytime <- times(t) #izgleda ne radi

system.time(onlytime <- lubridate::hms(PDsample$Time))
PDsample[, .(count = .N), by = .(Time, interval = hour(onlytime) %/% 3)] #GOOD # rijesenje su stupci Time interval i count, no nisu pridodani kao dio PDsample


t1 = strptime(PhoneData$Time,"%T") #doda danasnji datum "2019-01-09 01:20:18 CET" POSIXlt
t = t1 # 2.5 MB

system.time( t2 = parse_date_time(PhoneData$Time, "H%:M%:S%")) #doda datum, ali ne danasnji "0-01-01 01:20:10 UTC" POSIXct
t = t2 # 391.2 KB

#traje dugo (ne dovrsava se)
system.time(onlytime <- lubridate::hms(PhoneData$Time)) 
# Error: cannot allocate vector of size 291.6 Mb
# Timing stopped at: 4.908 3.772 124.8
PhoneData[, .(count = .N), by = .(Time, interval = hour(lubridate::hms(PhoneData$Time)) %/% 3)]





"""
Analysis of large groups of time series
Time series clustering is implemented in TSclust, dtwclust, BNPTSclust and pdc.

TSdist provides distance measures for time series data.

TSrepr includes methods for representing time series using dimension reduction and feature extraction.

jmotif implements tools based on time series symbolic discretization for finding motifs in time series 
and facilitates interpretable time series classification.

rucrdtw provides R bindings for functions from the UCR Suite to enable ultrafast subsequence search for 
a best match under Dynamic Time Warping and Euclidean Distance.

Methods for plotting and forecasting collections of hierarchical and grouped time series are provided by
hts. thief uses hierarchical methods to reconcile forecasts of temporally aggregated time series. 
An alternative approach to reconciling forecasts of hierarchical time series is provided by gtop. thief
"""

require(timeSeries)#rovides a class and various tools for financial time series. This includes basic functions such as scaling and sorting, subsetting, mathematical operations and statistical functions.
require(jmotif)#jmotif implements tools based on time series symbolic discretization for finding motifs in time series and facilitates interpretable time series classification.
require(xts)
PDsample$Time



#split(PDsample, cut(PDsample$Time,breaks = "hour"))
##PDsample$group = cumsum(ifelse(difftime(PDsample$Time, shift( PDsample$Time, fill = PDsample$Time[1]),units = "hours") >=3))

require(h2o)
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

