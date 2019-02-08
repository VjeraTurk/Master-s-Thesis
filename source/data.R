#TODO: install.packages(<list all required packages>)
#install.packages()
require("data.table")
require("readr")
setwd("~/CODM/masters-thesis/data")

  ########## Import PhoneData ################
  file = paste(getwd(),"/PhoneData", sep="")
  phone = c("ID", "Time", "Latitude", "Longitude")
  system.time( PhoneData <- fread(file=file, sep="auto", header=FALSE, colClasses = c('numeric','numeric','numeric','numeric'), col.names = phone, quote=""))
    # user  system elapsed 
    # 26.160   1.492  41.811 
    #38218717 obs. of  4 variables
  str(PhoneData)##Time je chr -> "ignorira" colClasses, cak ne baci ni warning da Time ne moze ucitati ko numeric
  save(PhoneData, file = paste(getwd(),"/PhoneData.RData", sep="")) #"ID" instead of "SIM card ID"

  file = paste(getwd(),"/PhoneData.RData", sep="")
  system.time(load(file = file))

  # save()/load() - save multiple objects to a file - RDATA, saveRDS()/loadRDS() - for one object to a file - RDS, save.image() save workspace
  
  ##### Order by Time
  system.time(setorder(PhoneData, Time))#radi!! after added quote=""
  system.time(fwrite(PhoneData, file = paste(getwd(),"/PhoneData_ordered_by_Time.csv", sep="" )))# size 1,5 GB
  save(PhoneData, file = paste(getwd(),"/PhoneData_ordered_by_Time.RData", sep="")) #file ima samo 254,8 MB 
  system.time(setorder(PhoneData, "ID"))

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
  
  ##### Order by ID, Time  
  
  #PhoneData[order(PhoneData[,"SIM Card ID"], PhoneData[,"Time"])]
  
  # https://github.com/tidyverse/dplyr/issues/2944
  #system.time(arrange(PhoneData,"SIM Card ID",Time))
  #Error in arrange_impl(.data, dots) : 
  #  incorrect size (1) at position 1, expecting : 38218717
  #Timing stopped at: 0.056 0.004 0.13
  #cols<-c('SIM Card ID','Time')
  #system.time(setorder(PhoneData,cols))
  #vars<-c('SIM Card ID','Time')
  #system.time(PhoneData <-arrange(PhoneData, UQS(syms(vars))))
  #system.time(arrange(PhoneData,UQ(sym('SIM Card ID')),UQ(sym('Time'))))

  
  #system.time(arrange(PhoneData,ID,Time))# bad - why would you do that
  #system.time(arrange(PhoneData,c(ID,Time)))
  # Error in arrange_impl(.data, dots) : 
  #  incorrect size (76437434) at position 1, expecting : 38218717
  # Timing stopped at: 56.27 0.64 66.73  


  require(plyr)  
  require(dplyr)  
  system.time(setorder(PhoneData,ID,Time)) # good
  # user  system elapsed 
  # 12.932   0.712  27.864 
  save(PhoneData, file = paste(getwd(),"/PhoneData_ordered_by_ID_Time.RData", sep="")) #"ID" instead of "SIM card ID"

file = paste(getwd(),"/PhoneData_ordered_by_ID_Time.RData", sep="")
system.time(load(file = file))

  ##### set time format to POSIXct #####
  # Rstudio freeza sve, katastrofa:
  # PhoneData[, Time:= as.POSIXct(paste(Time),format("%H:%M:%S"),tz="GTM")]
  # PhoneData[, Time:= as.POSIXct(paste(PhoneData$Time),format("%H:%M:%S"),tz="GTM")]
  # PhoneData[, posixct:= as.POSIXct(paste(Time),format("%T"),tz="GTM")]
  # t = as.data.frame(PhoneData$Time)
  # PhoneData$Time <- with(PhoneData, as.POSIXct(as.character(Time)), by = 10000)
  
  require(lubridate)
  #system.time(PhoneData$Time <- ff(as.POSIXct(PhoneData$Time,format("%H:%M:%S"),tz="GTM")))
  #Error: cannot allocate vector of size 291.6 Mb

  # system.time( t1 <- strptime(PhoneData$Time,"%T")) # doda danasnji datum "2019-01-09 01:20:18 CET" POSIXlt
  # t = t1 # 2.5 MB
  
  system.time( t2 <- parse_date_time(PhoneData$Time, "H%:M%:S%")) # doda datum, ali ne danasnji "0-01-01 01:20:10 UTC" POSIXct
  # user  system elapsed 
  # 16.240   3.148 180.255 
  t = t2 # 291,6 KB
  save(t, file = paste(getwd(),"/Time_POSIXct.RData", sep="")) 
  
  system.time(PhoneData$Time <- t) # long, but works
  save(PhoneData, file = paste(getwd(),"/PhoneData_ID_Time_POSIXct.RData", sep=""))# good

file = paste(getwd(),"/PhoneData_ID_Time_POSIXct.RData", sep="")
system.time(load(file = file))
    
  # system.time(fwrite(PhoneData, file = paste(getwd(),"/PhoneData_Time_POSIXct.csv", sep="" )))# bad
  #         SIM_Card_ID       Time   Latitude  Longitude
  # 38218717  55969559   T23:59:59Z 114.0272   22.67493  
  # fwrite doesn't save Time in POSIXct format!!!

    ### Import PhoneData_Time_POSIXct.csv  ### NOT ACTUALLY POSIXct because of fwrite
    file = paste(getwd(),"/PhoneData_Time_POSIXct.csv", sep="")
    phone = c("SIM Card ID", "Time", "Latitude", "Longitude")
    system.time( PhoneData_fread <- fread(file = file, sep="auto", header=TRUE, col.names = phone, quote = "")) # bitno je da ima quote 
    #  user  system elapsed 
    # 39.388   1.604  78.404
    
    require(ff)
    file = paste(getwd(),"/PhoneData_Time_POSIXct.csv", sep="")
    phone = c("SIM_Card_ID", "Time", "Latitude", "Longitude") #stavi točku umjesto razmaka
    system.time(PhoneData_ffdf <- read.csv.ffdf(file = file, col.names = phone, VERBOSE= TRUE, colClass = c('numeric','ordered','numeric','numeric')))
    # user  system elapsed 
    # 59.76    2.10   76.57

    
    
require("data.table")
require("readr")
setwd("~/CODM/masters-thesis/data")

### %H:%M:%S
file = paste(getwd(),"/PhoneData_ordered_by_ID_Time.RData", sep="")
system.time(load(file = file))

###POSIXct
file = paste(getwd(),"/PhoneData_ID_Time_POSIXct.RData", sep="")
system.time(load(file = file))
# user  system elapsed 
# 6.692   0.624   7.679 

require(ff)
require(ffbase)

PhoneData_ffdf = as.ffdf(PhoneData)
#no point in saving, can't load
#save(PhoneData_ffdf, file = paste(getwd(),"/PhoneData_ffdf.RData", sep=""))# good
#file = paste(getwd(),"/PhoneData_ffdf.RData", sep="")
#system.time(load(file = file))
# opening ff /tmp/RtmpK7mu6e/ffdf772251af9fd.ff
# Error in open.ff(x, assert = TRUE) : 
# file.access(filename, 0) == 0 is not TRUE

####### split into intervals ################
   
  # system.time(onlytime <- lubridate::hms(PhoneData$Time))
  # Error: cannot allocate vector of size 2.0 Gb
  # Error: cannot allocate vector of size 291.6 Mb
  # Timing stopped at: 4.908 3.772 124.8
  # traje dugo (ne dovrsava se)
  # zablokira mi Linux, cak ni Ctrl+Alt+F* ne reagira
  # PhoneData[, .(count = .N), by = .(Time, interval = hour(lubridate::hms(PhoneData$Time)) %/% 3)]

  #system.time(cut(PDsample$Time), breaks = c("00:03:00","00:09:00","00:012:00","00:15:00","00:18:00","00:21:00", right=FALSE))
  # pogresni argumenti
  #PhoneData = split(PhoneData$Time) #Error in split.default(PhoneData$Time) : argument "f" is missing, with no default

require(lubridate)
ramclass(PhoneData$Time)

system.time(onlytime <- lubridate::hms(PhoneData_ffdf$Time))
PDsample[, .(count = .N), by = .(Time, interval = hour(onlytime) %/% 3)] #GOOD # rijesenje su stupci Time interval i count, no nisu pridodani kao dio PDsample

# Error in matrix(.Call(C_parse_hms, hms, order), nrow = 3L, dimnames = list(c("H",  : 
# HMS argument must be a character vector
# Timing stopped at: 96.67 3.688 194.2

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

