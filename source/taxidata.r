require("plyr")  
require("dplyr")

require("data.table")

setwd("~/CODM/masters-thesis/data")
load("/home/adminuser/CODM/masters-thesis/data/TaxiData.RData")

taxi = c("ID", "Time", "Longitude", "Latitude", "Status", "Speed") #CORRECTED
names(TaxiData)<- taxi
system.time(setorder(TaxiData,"ID","Time"))

####### 3. set Time format to POSIXct #####
require(lubridate)
system.time( t2 <- parse_date_time(TaxiData$Time, "H%:M%:S%")) # doda datum, ali ne danasnji "0-01-01 01:20:10 UTC" POSIXct
# user  system elapsed 
# 16.240   3.148 180.255 
t = t2 
#save(t, file = paste(getwd(),"/Time_POSIXct.RData", sep="")) 
system.time(TaxiData$Time <- t) # long, but works
# user  system elapsed 
# 1.384   1.924  45.489 
save(TaxiData, file = paste(getwd(),"/TaxiData_ID_Time_POSIXct.RData", sep=""))# good

###POSIXct
file = paste(getwd(),"/TaxiData_ID_Time_POSIXct.RData", sep="")
system.time(load(file = file))

k = 2
df = TaxiData


system.time(df_2k<-df %>% group_by(ID) %>% filter(length(Status)>=2*k & sum(Status)>0 & sum(Status)<length(Status)))#apsolutno svi

df1m = head(df_2k, 1000000)
df = df1m

valid_trip_df<<-data.frame()
stop_indentification<-function(dataframe){

  start_confirmed <-FALSE
  first = dataframe[1,]
  
  for(i in 2:(nrow(dataframe))){
    curr = dataframe[i,]
    prev = dataframe[i-1 ,]
    #print(curr)
#    if(prev$Status == 0 & curr$Status == 1 & curr$Speed == 0){ -> zahtjeva još uvjeta
     
    if(prev$Status == 0 & curr$Status == 1){#ukrcaj
      start_confirmed <-TRUE
#    }else if(prev$Status == 1 & curr$Status == 0 & prev$Speed == 0 & start_confirmed == TRUE){
    }else if(prev$Status == 1 & curr$Status == 0 & start_confirmed == TRUE){#iskrcaj

      trip<-data.frame(first$Time,prev$Time,first$Longitude,first$Latitude,prev$Longitude,prev$Latitude)
#      trip<-cbind(first$Time,prev$Time,first$Longitude,first$Latitude,prev$Longitude,prev$Latitude)
      valid_trip_df<<-rbind(valid_trip_df, cbind(trip))
      start_confirmed <-FALSE
      first = curr
      #print(trip)
    }
  }
}

stop_indentification<-function(dataframe){

  i=1
  start_confirmed=FALSE
  
  while(i < nrow(dataframe))
  {
    status = dataframe[i,]$Status
  
    while(dataframe[i,]$Status == status & i < nrow(dataframe)-1 ){
      i=i+1
    } 

    i=i+1
    
    if(dataframe[i,]$Status == 1 & start_confirmed == FALSE) #Ukrcaj
    {
      first = dataframe[i,]
      start_confirmed=TRUE
    
    }else if(start_confirmed) #iskrcaj
    {
      last = dataframe[i,]
      trip<-data.frame(first$Time,last$Time,first$Longitude,first$Latitude,last$Longitude,last$Latitude)
       #print(trip)
      valid_trip_df<<-rbind(valid_trip_df, cbind(trip))
      start_confirmed=FALSE
    }
    
    i=i+1
  }  
}
valid_trip_df<<-data.frame()
system.time(sapply(unique(df$ID), function (value) stop_indentification(df[df$ID == value, ]),simplify = TRUE))
#     user   system  elapsed 
#1m  1108.220    9.796  584.454 
#12738 obs.
#   user   system  elapsed 
#1m 1292.532   21.268  939.673 
#9859 obs.

#user  system elapsed 
#596.612   5.736 321.148 -> 5.3525 min : 4.188 h?
#10284 obs.

TaxiData0 = subset(TaxiData,Speed == 0) # ne daje error ako je "Speed"

#Remove users with less than 2k points 
# I guess k * 2 events is needed to confirm 2 stops (confirm movement) #TODO test this
# rijesi se svih usera s < k evenata ili < 2k ?! 
# eliminirati i one koji su stalno 0 ili stalno 1
k=2
df = TaxiData0
system.time(df_2k<-df %>% group_by(ID) %>% filter(length(Status)>=2*k & sum(Status)>0 & sum(Status)<length(Status)))
save(df_2k, file = paste(getwd(),"/df_2k_TaxiData0.RData", sep=""))

file = paste(getwd(),"/df_2k_TaxiData0.RData", sep="")
load(file=file)
df<-df_2k

delta_df<-tail(df, -1) - head(df, -1)

temp_df<-data.frame(delta_df$Time,delta_df$Latitude,delta_df$Longitude,delta_df$Status)
names(temp_df)<-c("time_dif","lon_dif","lat_dif","stat_dif")

big_df<-data.frame(head(df, -1),temp_df)

