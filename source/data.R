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
  ##### Order by Time
  system.time(setorder(PhoneData, Time))#radi!! after added quote=""
  
  # save()/load() - save multiple objects to a file - RDATA, saveRDS()/loadRDS() - for one object to a file - RDS, save.image() save workspace 
  system.time(fwrite(PhoneData, file = paste(getwd(),"/PhoneData_ordered_by_Time.csv", sep="" )))# size 1,5 GB
  save(PhoneData, file = paste(getwd(),"/PhoneData_ordered_by_Time.RData", sep="")) #file ima samo 254,8 MB 
  save(PhoneData, file = paste(getwd(),"/PhoneData_Time_POSIXct.RData", sep=""))
  system.time(fwrite(PhoneData, file = paste(getwd(),"/PhoneData_Time_POSIXct.csv", sep="" )))
  
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
  # 35.772   1.540 103.500 

  ### Import PhoneData_Time_POSIXct.csv  ###

  file = paste(getwd(),"/PhoneData_Time_POSIXct.csv", sep="")
  phone = c("SIM Card ID", "Time", "Latitude", "Longitude")
  system.time( PhoneData <- fread(file = file, sep="auto", header=FALSE, col.names = phone, quote = "")) # bitno je da ima quote 
  #  user  system elapsed 
  # 39.388   1.604  78.404

  require(ff)
  file = paste(getwd(),"/PhoneData_Time_POSIXct.csv", sep="")
  phone = c("SIM_Card_ID", "Time", "Latitude", "Longitude") #stavi točku umjesto razmaka
  system.time(PhoneData <- read.csv.ffdf(file = file, col.names = phone, VERBOSE= TRUE, colClass = c('numeric','POSIXct','numeric','numeric')))
  # user  system elapsed 
  # 59.76    2.10   76.57
  
  ### load PhoneData_Time_POSIXct.RData  ###
  file = paste(getwd(),"/PhoneData_Time_POSIXct.RData", sep="")
  system.time(load(file = file))
  # user  system elapsed 
  # 6.692   0.624   7.679 
    
###### set time type to POSIXct #############

  # Rstudio freeza sve, katastrofa:
  # PhoneData[, Time:= as.POSIXct(paste(Time),format("%H:%M:%S"),tz="GTM")]
  # PhoneData[, posixct:= as.POSIXct(paste(Time),format("%T"),tz="GTM")]

  system.time( t1 <- strptime(PhoneData$Time,"%T")) #doda danasnji datum "2019-01-09 01:20:18 CET" POSIXlt
  #t = t1 # 2.5 MB

  system.time( t2 <- parse_date_time(PhoneData$Time, "H%:M%:S%")) #doda datum, ali ne danasnji "0-01-01 01:20:10 UTC" POSIXct
  t = t2 # 291,6 KB
  save(t2, file = paste(getwd(),"/Time_POSIXct.RData", sep="")) 
  system.time(PhoneData$Time <- t2)

####### split into intervals ################
   
  system.time(onlytime <- lubridate::hms(PhoneData$Time))
  # Error: cannot allocate vector of size 2.0 Gb
  # Error: cannot allocate vector of size 291.6 Mb
  # Timing stopped at: 4.908 3.772 124.8
  # traje dugo (ne dovrsava se)
  # zablokira mi Linux, cak ni Ctrl+Alt+F* ne reagira
  # PhoneData[, .(count = .N), by = .(Time, interval = hour(lubridate::hms(PhoneData$Time)) %/% 3)]

  #system.time(cut(PDsample$Time), breaks = c("00:03:00","00:09:00","00:012:00","00:15:00","00:18:00","00:21:00", right=FALSE))
  # pogresni argumenti
  PhoneData = split(PhoneData$Time) #Error in split.default(PhoneData$Time) : argument "f" is missing, with no default


require(ff)
file = paste(getwd(),"/PhoneData_Time_POSIXct.csv", sep="")
phone = c("SIM_Card_ID", "Time", "Latitude", "Longitude") #stavi točku umjesto razmaka
system.time(PhoneData <- read.csv.ffdf(file = file, col.names = phone, VERBOSE= TRUE, colClass = c('numeric','POSIXct','numeric','numeric')))
# user  system elapsed 
# 59.76    2.10   76.57 

require(ffbase)
t = as.data.frame(PhoneData$Time)
PhoneData$Time <- with(PhoneData, as.POSIXct(as.character(Time)), by = 10000)
ramclass(xff$time)

###Test these:
PhoneData[, Time:= as.POSIXct(paste(PhoneData$Time),format("%H:%M:%S"),tz="GTM")]
require(lubridate)
t = parse_date_time(PhoneData$Time, "H%:M%:S%")
t = strptime(PhoneData$Time,"%T")
PhoneData$Time= ff(as.POSIXct(PhoneData$Time,format("%H:%M:%S"),tz="GTM"))



### load PhoneData_Time_POSIXct.RData  ###
file = paste(getwd(),"/PhoneData_Time_POSIXct.RData", sep="")
system.time(load(file = file))
# user  system elapsed 
# 6.692   0.624   7.679 




require(dplyr)
library(chron)



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

