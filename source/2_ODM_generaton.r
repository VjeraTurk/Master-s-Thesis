"
    Relation: Shenzhen City (3464353)
    on map: 
              22.8040
    113.6604          114.6217
              22.4402
"
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

    df = TaxiData
    k = 2
  "
  0->1 + 1->0                       useful ID contains at least 4 records (2*k) to confirm entering an empty taxi 0->1, and taking off 1->0
  sum(status) >= 2                  At last 2 statuses must be 1 (taxi occupied at origin,taxi occpied at destination)
  sum(Status)<lenght(Status)-1 ->   At least 2 statuses must be 0 (empty taxi at origin before trip, empty taxi at destination after trip)
  "
    #system.time(df_2k<-df %>% group_by(ID) %>% filter(length(Status)>=2*k & sum(Status)>0 & sum(Status)<length(Status)))
    system.time(df_2k<-df %>% group_by(ID) %>% filter(length(Status)>=2*k & sum(Status)>=2 & sum(Status)<(length(Status)-1)))
  
    df<-as.data.table(df_2k)
    save(df, file = paste(getwd(),"/taxi_df_from_df_2k.RData", sep=""))#took longer than minute
  
  file = paste(getwd(),"/taxi_df_from_df_2k.RData", sep="")
  load(file=file)

    #podjela na 10 grupa po cca 4 milijuna zapisa 
    #(ručno pronađen kraj svih zapisa za granične ID)
    
    # 1-4002181
    df_1<-df[1:4002181]
    # 4002182-8006254
    df_2<-df[4002182:8006254]
    # 8006255-12000823
    df_3<-df[8006255:12000823]
    # 12000824-16001357
    df_4<-df[12000824:16001357]
    # 16001358-2002755
    df_5<-df[16001358:20002755]
    # 2002756-24003967
    df_6<-df[20002756:24003967]
    # 24003968-28001782
    df_7<-df[24003968:28001782]
    # 28001783-32001639
    df_8<-df[28001783:32001639]
    # 32001640-36001471
    df_9<-df[32001640:36001471]
    # 36001472-39065311
    df_10<-df[36001472:39065311]
    
    df_n<<-list(df_1,df_2,df_3,df_4,df_5,df_6,df_7,df_8,df_9,df_10)
    for(i in 1:length(df_n)){
      print(system.time(df_n[[i]]<-df_n[[i]] %>% group_by(ID)))
    }

    save(df_n, file = paste(getwd(),"/taxi_df_n.RData", sep=""))#took longer than minute

file = paste(getwd(),"/LonLat_from_CDR_1090_pairs.RData", sep="")
system.time(load(file = file))
setorder(LonLat,Longitude,Latitude) #"order by Longitude"
system.time(Lon_Lat <- paste(LonLat$Longitude,LonLat$Latitude, sep= "_"))

require("optimbase")
  #names(OD_0_24_SH)<- Lon_Lat# names je krivo, treba dimnames()
  #http://www.r-tutor.com/r-introduction/matrix

z<-zeros(length(Lon_Lat),length(Lon_Lat))
dimnames(z)<-list(Lon_Lat,Lon_Lat)
matrices<<-list(z,z,z,z,z,z,z,z) #<<- gobalna varijabla

require(sp)
"Import vor from .RData"
single_user_journey_counter<-function(user_activity){
  
  i=1
  start_confirmed=FALSE
  
  while(i < nrow(user_activity))
  {
    status = user_activity[i,]$Status
    while(user_activity[i,]$Status == status & i < nrow(user_activity)-1 ){
      i=i+1
    } 
    
    i=i+1
    
    #TODO: ispravi ovo
    if(user_activity[i,]$Status == 1 & start_confirmed == FALSE) #Ukrcaj #2 provjere-> priznaj samo ako su tocke dovoljno blizu, vremenski i prostorno!!(u istj ćeliji?!)
    {

      #off<-SpatialPoints(cbind(c(user_activity[i,]$Longitude),c(tuser_activity[i,]$Latitude),c(user_activity[i,]$ID)),proj4string = slot(vor,'proj4string'))
      #on<-SpatialPoints(cbind(c(user_activity[i,]$Longitude),c(trip$last.Latitude),c(trip$ID)),proj4string = slot(vor,'proj4string')) #id as third coord
      
      #spoints<-rbind(off,on)
      
      #x<-spoints %over% vor #ne baca error ako točka nije ni u jednom
      
      
        #if(x[1,]$Longitude == x[2,]$Longitude & x[1,]$Latitude == x[2,]$Latitude)
      #{
        first = user_activity[i,]
        start_confirmed=TRUE
      #}
      
      
      
    }else if(start_confirmed) #iskrcaj
    {
      last = user_activity[i,]
      trip<-data.frame(first$Time,last$Time,first$Longitude,first$Latitude,last$Longitude,last$Latitude)

      o<-SpatialPoints(cbind(c(trip$first.Longitude),c(trip$first.Latitude),c(trip$ID)),proj4string = slot(vor,'proj4string'))
      d<-SpatialPoints(cbind(c(trip$last.Longitude),c(trip$last.Latitude),c(trip$ID)),proj4string = slot(vor,'proj4string')) #id as third coord
      
      spoints<-rbind(o,d)
      
      x<-spoints %over% vor #ne baca error ako točka nije ni u jednom
      
      orig = paste(x[1,]$Longitude,x[1,]$Latitude,sep = '_')
      dest = paste(x[2,]$Longitude,x[2,]$Latitude,sep = '_')
      
      t<-as.integer(cut(as.POSIXct(format(first$Time,'%T'), format='%T'), breaks = seq(as.POSIXct(paste(Sys.Date(),'00:00:00')), as.POSIXct(paste(Sys.Date()+1,'00:00:00')), by = '3 hours')))

      try(matrices[[t]][orig,dest]<<- matrices[[t]][orig,dest] + 1) ##<<- gobalna varijabla
      
      #valid_trip_df<<-rbind(valid_trip_df, cbind(trip))
      start_confirmed=FALSE
      }
    i=i+1
  }  
}
"
stop_indentification<-function(dataframe){

  start_confirmed <-FALSE
  first = dataframe[1,]
  
  for(i in 2:(nrow(dataframe))){
    curr = dataframe[i,]
    prev = dataframe[i-1 ,]
    #print(curr)
#    if(prev$Status == 0 & curr$Status == 1 & curr$Speed == 0){ -> zahtjeva joÅ¡ uvjeta
     
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

    
    #Testing on d_1 approximate duration of execution 2 hours 37 minutes
    system.time(sapply(unique(df_1$ID), function (value) stop_indentification_by_period(df_1[df_1$ID == value, ]),simplify = TRUE))
    save(matrices, file = paste(getwd(),"/matrices_df_1.RData", sep=""))
    #user   system  elapsed 
    #8856.516   25.064 7812.097 


for(i in 2:length(df_n)){
  print(i)
  system.time(sapply(unique(df_n[[i]]$ID), function (value) stop_indentification_by_period(df_n[[i]][df_n[[i]]$ID == value, ]),simplify = TRUE))
    #name<-paste("matrices_",i,sep = "")
    #assign(name,matrices)
  save(matrices, file = paste(getwd(),"/matrices_df_",i,".RData", sep=""))
  #paziti kod importa jer se sve varijable zovu "matrices"
  #df_10 će biti ona koja će se koristiti, ostale se spremaju u za slučaj da se izvršavanje prekine u nekom trenutku
}


#Iscrtavanje Taxi podataka na karti
#taxiSP<-SpatialPoints(cbind(c(df$first.Longitude),c(df$first.Latitude),c(df$ID)),proj4string = slot(vor,'proj4string')) #id as third coord
taxiSP<-SpatialPoints(cbind(c(df$last.Longitude),c(df$last.Latitude),c(df$ID)),proj4string = slot(vor,'proj4string')) #id as third coord

list<-list()

for(i in 1:length(vor)){
  nodes_subset<-taxiSP[vor[i,]]
  #plot(nodes_subset)
  node_ids<-nodes_subset$coords.x3
  

  l<-list(node_ids = node_ids)
  print(l$node_ids)
  
  nodes_s<-base::subset(df, ID == node_ids)
  print(nodes_s)
  list[[i]]<-nodes_s
  
  id<-paste(vor[i,]$x, vor[i,]$y, sep='_')
  
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