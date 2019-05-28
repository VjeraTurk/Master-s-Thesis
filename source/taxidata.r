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
"
  Relation: Shenzhen City (3464353)
  on map: 
            22.8040
  113.6604          114.6217
            22.4402
"
  #trimming mora ići kasnije, na tripovima inace ce moze desiti da ce se spojiti 2 putovanja u jedno
  #max(coordinates(vor)[,1])
  "
  latmin = 22.48793    # 22.50583 #22.48793
  latmax = 22.84685    # 22.828  #22.84685
  lonmin = 113.7604   # 113.7876 #113.7604
  lonmax = 114.2277     # 114.2274 #114.2277
  system.time(TaxiData<-subset(TaxiData,TaxiData$Latitude<latmax & TaxiData$Latitude > latmin & TaxiData$Longitude> lonmin & TaxiData$Longitude<lonmax))
  "
df = TaxiData
k = 2
system.time(df_2k<-df %>% group_by(ID) %>% filter(length(Status)>=2*k & sum(Status)>0 & sum(Status)<length(Status)))
#38360243 obs.
#37156321 obs.
#39151964 obs.

df1m = head(df_2k, 1000000)
df = df1m

"
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
"

#file = paste(getwd(),"/LatLon.RData", sep="")
#system.time(load(file = file))
# Longitude min->max (CDR su samo po longitude!!!!)
# latitude min->max
#TODO: ORDER LON_LAT!!
setorder(LonLat,Longitude)
system.time(Lon_Lat <- paste(LonLat$Longitude,LonLat$Latitude, sep= "_"))

require("optimbase")
OD_0_24_SH<<-zeros(length(Lon_Lat),length(Lon_Lat))
#names(OD_0_24_SH)<- Lon_Lat# names je krivo, treba dimnames()
#http://www.r-tutor.com/r-introduction/matrix

dimnames(OD_0_24_SH)<-list(Lon_Lat,Lon_Lat)

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
      
      o<-SpatialPoints(cbind(c(trip$first.Longitude),c(trip$first.Latitude),c(trip$ID)),proj4string = slot(vor,'proj4string'))
      d<-SpatialPoints(cbind(c(trip$last.Longitude),c(trip$last.Latitude),c(trip$ID)),proj4string = slot(vor,'proj4string')) #id as third coord

      spoints<-rbind(o,d)

      x<-spoints %over% vor #ne baca error ako točka nije ni u jednom
      
      orig = paste(x[1,]$Longitude,x[1,]$Latitude,sep = "_")
      dest = paste(x[2,]$Longitude,x[2,]$Latitude,sep = "_")
      
      if(orig!=dest)# cel 79 has 1757 internal trips
      try(OD_0_24_SH[orig,dest]<<- OD_0_24_SH[orig,dest] + 1)
      
      start_confirmed=FALSE
    }
    i=i+1
  }  
}

valid_trip_df<<-data.frame()
#11512 obs.

system.time(sapply(unique(df$ID), function (value) stop_indentification(df[df$ID == value, ]),simplify = TRUE))
require(superheat)
superheat(OD_0_24_SH, heat.pal= heat.colors(256))
superheat(OD_0_24_SH,scale=TRUE,  heat.col.scheme = "red")
heatmap(OD_0_24_SH,Rowv=NA,Colv=NA,col=paste("gray",1:99,sep=""))
hist(OD_0_24_SH[ OD_0_24_SH>10 & OD_0_24_SH<1757 ], breaks=255)

#sum(OD_0_24_SH) 11953 > 11512 ?!

#     user   system  elapsed 
#1m  1108.220    9.796  584.454 
#12738 obs.
#   user   system  elapsed 
#1m 1292.532   21.268  939.673 
#9859 obs.

#   user  system elapsed 
#1m 596.612   5.736 321.148 -> 5.3525 min : 4.188 h?
#1m 556.300   5.480 293.776 
#10284 obs.

# user   system  elapsed 
# 1420.052    0.592 1422.481 
#11512 obs. + matrix
valid_taxi_trip_df_1m <- valid_trip_df
save(valid_taxi_trip_df_1m, file = paste(getwd(),"/valid_taxi_trip_df_1m.RData", sep=""))

df<-valid_taxi_trip_df_1m
library(tidyverse)
df <- tibble::rowid_to_column(df, "ID")

#taxiSP<-SpatialPoints(cbind(c(df$first.Longitude),c(df$first.Latitude),c(df$ID)),proj4string = slot(vor,'proj4string')) #id as third coord
taxiSP<-SpatialPoints(cbind(c(df$last.Longitude),c(df$last.Latitude),c(df$ID)),proj4string = slot(vor,'proj4string')) #id as third coord

list<-list()

for(i in 1:length(vor)){
  nodes_subset<-taxiSP[vor[i,]]
  #plot(nodes_subset)
  node_ids<-nodes_subset$coords.x3
  
#  print(node_ids)
  l<-list(node_ids = node_ids)
  print(l$node_ids)
  
  nodes_s<-base::subset(df, ID == node_ids)
  print(nodes_s)
  list[[i]]<-nodes_s
  
  #print(paste(vor[i,]$x, vor[i,]$y, sep="_"))
  
  id<-paste(vor[i,]$x, vor[i,]$y, sep="_")
  #print(id)
  
  pom_list<-list()
  pom_list[[1]]<-id
  pom_list[[2]]<-nodes_s
  
  list[[i]]<-pom_list
  
}


gg <- ggplot()
# base map
#gg <- gg + geom_map(data=states, map=states, aes(x=long, y=lat, map_id=region), color="white", fill="#cccccc", size=0.5)
gg <- gg + geom_point(data=LonLat, aes(x=Longitude, y=Latitude),size=1, shape=21, color="white", fill="steelblue")
# voronoi layer
gg <- gg + geom_map(data=vor_df, map=vor_df, aes(x=long, y=lat, map_id=id), color="#a5a5a5", fill="#FFFFFF00", size=0.25)
#gg <- gg + geom_point(data=LonLat, aes(x=Longitude, y=Latitude),size=1, shape=21, color="white", fill="red")

taxi_points <- data.frame(taxiSP)
names(taxi_points) <-c("Longitude","Latitude","ID")
taxi_points
latmin = 22.4402
latmax = 22.8040
lonmin = 113.6604
lonmax = 114.27 #114.6217 
#taxi_points<-subset(taxi_points,taxi_points$Latitude<latmax & taxi_points$Latitude > latmin & taxi_points$Longitude> lonmin & taxi_points$Longitude<lonmax)

gg<- gg + geom_point(data=taxi_points, aes(x=Longitude, y=Latitude), size=1, shape=21, color="black", fill="gray")
gg


###############################################
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

