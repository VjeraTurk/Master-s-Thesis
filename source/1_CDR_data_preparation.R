#TODO: install.packages(<list all required packages>)
#install.packages()

setwd("~/CODM/masters-thesis/data")

########## 1. Import Raw PhoneData ##############
require("data.table")
require("readr")
file = paste(getwd(),"/PhoneData", sep="")
##phone = c("ID", "Time", "Latitude", "Longitude") #WRONG
phone = c("ID", "Time", "Longitude", "Latitude") #CORRECTED
system.time( PhoneData <- fread(file=file, sep="auto", header=FALSE, colClasses = c('numeric','numeric','numeric','numeric'), col.names = phone, quote=""))
# user  system elapsed 
# 26.160   1.492  41.811 
#38218717 obs. of  4 variables
str(PhoneData)##Time je chr -> "ignorira" colClasses, cak ne baci ni warning da Time ne moze ucitati ko numeric
save(PhoneData, file = paste(getwd(),"/PhoneData.RData", sep="")) #"ID" instead of "SIM card ID"
# save()/load() - save multiple objects to a file - RDATA, saveRDS()/loadRDS() - for one object to a file - RDS, save.image() save workspace

  file = paste(getwd(),"/PhoneData.RData", sep="")
  system.time(load(file = file))

######### 2.  Order by ID, Time ##################
require("plyr")  
require("dplyr")  
system.time(setorder(PhoneData,ID,Time)) # good
# user  system elapsed 
# 12.932   0.712  27.864 
save(PhoneData, file = paste(getwd(),"/PhoneData_ordered_by_ID_Time.RData", sep="")) #"ID" instead of "SIM card ID"

####### 3. set Time format to POSIXct #####
require(lubridate)
system.time( t2 <- parse_date_time(PhoneData$Time, "H%:M%:S%")) # doda datum, ali ne danasnji "0-01-01 01:20:10 UTC" POSIXct
# user  system elapsed 
# 16.240   3.148 180.255 
t = t2 
save(t, file = paste(getwd(),"/Time_POSIXct.RData", sep="")) 
system.time(PhoneData$Time <- t) # long, but works
save(PhoneData, file = paste(getwd(),"/PhoneData_ID_Time_POSIXct.RData", sep=""))# good
  ###POSIXct
  file = paste(getwd(),"/PhoneData_ID_Time_POSIXct.RData", sep="")
  system.time(load(file = file))
  #user  system elapsed 
  # 5.272   0.436   5.713 
  
######## 4. Get Base Stations locaton from CDR #########
require("data.table")
require(dplyr)
  
LonLat<-data.frame(PhoneData$Longitude,PhoneData$Latitude)
names(LonLat) <- c("Longitude", "Latitude")
#system.time(LonLat<-select(PhoneData, Longitude,Latitude))


#system.time(setorder(PhoneData,Longitude,Latitude))

system.time(LonLat<-distinct(LonLat)) 
system.time(setorder(LonLat,Longitude,Latitude))

#1090 obs.
save(LonLat, file = paste(getwd(),"/LonLat_from_CDR_1090_pairs.RData", sep=""))
file = paste(getwd(),"/LonLat_from_CDR_1090_pairs.RData", sep="")
system.time(load(file = file))

##### 5. Remove suers with one event
# remove users with less than k events! (won't confirm a single stop)
# I guess k * 2 events is needed to confirm 2 stops (confirm movement) #TODO test this
# rijesi se svih usera s < k evenata ili < 2k ?! 

#https://stackoverflow.com/questions/21946201/remove-all-unique-rows
df = PhoneData
k = 2 
system.time( PhoneData <- df[as.logical(ave(1:nrow(df), df$ID, FUN=function(x) length(x) >= k)), ])
save(PhoneData, file = paste(getwd(),"/PhoneData_no_unique_ID.RData", sep=""))
#user  system elapsed
#66.268   4.760 245.830

"
Data descriptions

Smartcard ID, Time, Transaction type (21, 22, 31), Metro Station or Bus Line
Transaction Type:  31-Bus Boarding & 21-Subway Swiped-In  & 22-Subway Swiped-Out

SIM Card ID, Time, Latitude, Longitude

Taxi ID, Time, Latitude, Longitude, Occupancy Status, Speed
Occupancy Status: 1-with passengers & 0-with passengers

BUS ID, Time, PlateID, Latitude, Longitude, Speed

Truck ID, Date Time, Latitude, Longitude, Speed
"
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