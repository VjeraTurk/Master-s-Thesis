system('free -m') 
 gc()
#stackoverlfow "R: running function on multiple rows (groups) in data.frame" # view Do any of these answer your question?
require("data.table")
require("readr")
setwd("~/CODM/masters-thesis/data")

file = paste(getwd(),"/PhoneData_no_unique_ID.RData", sep="")# POGRESNO LON/LAT
system.time(load(file = file))
#38170135 obs. of 4 variables 38,170,135
  any(is.na(PhoneData)) #ne daje rezultat uz system.time(), bez system.time FALSE

  df1m = head(PhoneData, 1000000)
  df100k = head(PhoneData,100000)
  df10k = head(PhoneData,10000)
  df49 = head(PhoneData,49)

df = PhoneData
  df = df1m
  df = df100k
  df = df10k
  df = df49

#https://www.dummies.com/programming/r/how-to-count-unique-data-values-in-r/
sapply(df, function(x) length(unique(x)))
        #ID      Time  Latitude Longitude
#49      18        49        16        16 
#10k    258      9059       271       279 
#100k  1319     42453       586       599 
#1m    9514                 717       752

#    365689     83493       824       859 

# sa 1090 -> 859
#installing fields : https://stackoverflow.com/questions/34939878/error-in-installing-r-package-appliedpredictivemodeling
require("fields")
require("optimbase")
require("dplyr")

LonLat<-data.frame(df$Latitude,df$Longitude)
names(LonLat)<- c("Longitude","Latitude")

  #file = paste(getwd(),"/LonLat_from_CDR_1090_pairs.RData", sep="")
  #system.time(load(file = file))

  #za boga miloga ne pokreci system.time(LonLat<-unique(LonLat))
  system.time(LonLat<-distinct(LonLat))#1027
  file = paste(getwd(),"/LonLat_from_CDR_1027_pairs.RData", sep="")
  save(LonLat, file=file)

file = paste(getwd(),"/LonLat_from_CDR_1027_pairs.RData", sep="")
load(file=file)

#in no particular order!

Lon_Lat <- paste(LonLat$Longitude,LonLat$Latitude, sep= "_") # ..O,P, Red, Stupac

require("magrittr")
require("dplyr")
  frequency<-PhoneData %>% group_by(Latitude,Longitude) %>%
    summarize(n=n())
  frequency<-as.data.frame(frequency) #nrow 1027 ?!?!

#### Proximity Merging - TODO
      distances<-zeros(length(Lon_Lat),length(Lon_Lat))
      ##dimnames(distances)<-list(Lon_Lat,Lon_Lat) iz nekog glupog razloga nakon rdist.earth() dimnames atribute vise ne postoji
      distances<- rdist.earth(LonLat, miles=FALSE)
      dimnames(distances)<-list(Lon_Lat,Lon_Lat)
      
      # threshold value in km ( 75 m)
      sum(distances < 0) #1358 -> 679 celija bi trebalo spojiti 
      pm = 0.075
      treshold<-matrix(pm, nrow= length(Lon_Lat),ncol=length(Lon_Lat))
      distances<-distances-treshold
      #gdje je vrijednost negativna tu treba merge?
      
      require(sp) 
      system.time(i <- apply(spDists(as.matrix(LatLon[, c('Latitude', 'Longitude')])), 2, function(x) paste(which(x < pm & x != 0), collapse=', ')))
      closest_LatLon<-data.frame(Latitude=LatLon$Latitude, Longitude=LatLon$Longitude, Closest=i)
      #dst <- as.matrix(dist(LatLon[-1])) ; diag(dst) <- NA ; apply(dst, 1, function(x) paste(which(x < 75), collapse=", "))                                                   
      #dst <- as.matrix(dist(LatLon[-1])) ; diag(dst) <- NA ; apply(dst, 1, function(x) paste(which(x < pm), collapse=", "))
      #blocka komp
      
      M = LatLon
      DM = as.matrix(dist(M))
      neighbors = which(DM < 0.075, arr.ind=T)
      neighbors= neighbors[neighbors[,1]!=neighbors[,2]]
      
      plot(M)
      points(M[neighbors,], col="red" )
      
      require("hutils")
      haversine_distance(LatLon$Latitude, LatLon$Longitude, LatLon$Latitude, LatLon$Longitude) < 0.075

"
False Movement reduction: At this point any events occurring at a new tower that occur within a
duration s of a prior event at a different tower are assumed to be load balancing artifacts and
removed from the dataset. 

This was set at a very conservative value of 2 minutes to ensure protection
of false movement (a direct implementation of the solution discussed in section 5.3);

Note, that if the minimum time threshold is set to zero, OD matrices will degenerate to what is known 
as a transient approach containing all sub-journeys - and won’t truly describe movements between
origins and destinations at all per se. Elimination of static trips/false positives is therefore 
the priority
"
### False movement reduction
  #s= 2 min, k = 2, d = 10 min, g = 4 hours
  to_remove_df<<-data.frame() #GLOBALNA_VARIJABLA <<- 
  
  false_movement_reduction<-function(dataframe,s){
    
    df<-tail(dataframe, -1) - head(dataframe, -1) #vektorizirana verzija?
    for(i in 1:nrow(df)){
      #Load Balancing
      if((df[i,]$Latitude != 0 || df[i,]$Longitude != 0 ) && (df[i,]$Time < s))
       to_remove_df<<- rbind(to_remove_df,dataframe[i+1,])
    }
  }

require("lubridate")
require("dplyr")
  s = difftime( parse_date_time("00:02:00", "H%:M%:S%"),parse_date_time("00:00:00", "H%:M%:S%")) 
  system.time(sapply(unique(df$ID), function (value) false_movement_reduction(df[df$ID == value, ],s),simplify = FALSE))
        #user  system elapsed 
  #10k   3.264   0.000   3.268
  #100k 35.068   0.000  35.107 
  #1m  742.648  10.324 753.960 
  save(to_remove_df, file = paste(getwd(),"/to_remove_df_PhoneData.RData", sep=""))
    load(file = paste(getwd(),"/to_remove_df_PhoneData.RData", sep=""))
  system.time(df_fmr<-setdiff(df,to_remove_df)) #37483509
  #   user  system elapsed 
  # 87.232   5.684 903.039 

  #TODO I want sth. like: df_fmr <- df[sapply(unique(df$ID), function (value) false_movement_reduction(df[df$ID == value, ],s),simplify = FALSE)]
  #again remove 
  # rijesi se svih usera s < k evenata ili < 2k ?!
  save(df_fmr, file = paste(getwd(),"/df_fmr_PhoneData.RData", sep=""))

  file = paste(getwd(),"/df_fmr_PhoneData.RData", sep="")
  load(file=file)
  df<-df_fmr

  #Remove users with less than 2k points 
  # I guess k * 2 events is needed to confirm 2 stops (confirm movement) #TODO test this
  # rijesi se svih usera s < k evenata ili < 2k ?! 
  k = 2
  system.time( df_2k <- df[as.logical(ave(1:nrow(df), df$ID, FUN=function(x) length(x) >= 2*k)), ]) #37358454
  #system.time( df <- df[as.logical(ave(1:nrow(df), df$ID, FUN=function(x) length(x) >= 2*k)), ])
  #user  system elapsed 
  #61.524   1.764  63.320 
  save(df_2k, file = paste(getwd(),"/df_2k_PhoneData.RData", sep=""))

file = paste(getwd(),"/df_2k_PhoneData.RData", sep="")
load(file=file)
df<-df_2k

  delta_df<-tail(df, -1) - head(df, -1) #vektorizirana verzija?
  file = paste(getwd(),"/delta_df_PhoneData.RData", sep="")
  save(delta_df,file=file)
    
  temp_df<-data.frame(head(df, -1)$ID,delta_df$Time,delta_df$Latitude,delta_df$Longitude)
  names(temp_df)<-c("ID","time_dif","lon_dif","lat_dif")
  
  file = paste(getwd(),"/temp_df_PhoneData.RData", sep="")
  save(temp_df,file=file)
  temp_df_2<-data.frame(head(df, -1)$ID, delta_df$ID, delta_df$Time, delta_df$Latitude, delta_df$Longitude)
  names(temp_df_2)<-c("ID","ID-ID","time_dif","lon_dif","lat_dif")
  
  file = paste(getwd(),"/temp_df_2_PhoneData.RData", sep="")
  save(temp_df_2,file=file)
  
file = paste(getwd(),"/delta_df_PhoneData.RData", sep="")
load(file=file)  
file = paste(getwd(),"/temp_df_PhoneData.RData", sep="")
load(file=file)  
file = paste(getwd(),"/temp_df_2_PhoneData.RData", sep="")
load(file=file)
#missing how to get big_df sth. like df + head(df,-1)-tail(df,-1)
save(big_df,file=file)
names(big_df)<-c("ID","Time","Longitude","Latitude","ID-ID","time_dif","lon_dif","lat_dif")

file = paste(getwd(),"/big_df_PhoneData.RData", sep="")
load(file=file)


###Dovde dosla sa full data

#TODO: makni one ID koji imaju manje od k-1 puta redak 0,0 
  # za k=2 (moze i umnožak svih lat i lon !=0?) #nisu stajali
#(izbaci i one kojima je zbroj 0?) #nisu se micali

#system.time( temp_df_00 <- temp_df_2[as.logical(ave(1:nrow(temp_df_2), temp_df_2$ID, FUN=function(x) with(x,x$lon_dif,x$lat_dif) == 0)), ])
#Error: numeric 'envir' arg not of length one
#Timing stopped at: 57.74 0.94 58.78

#system.time( temp_df_00 <- temp_df_2[as.logical(ave(1:nrow(temp_df_2), temp_df_2$ID, FUN=function(x) x$lon_dif*x$lat_dif == 0)), ])
#Error in x$lon_dif : $ operator is invalid for atomic vectors
#Timing stopped at: 56.58 1.108 64.66

#system.time( temp_df_00 <- temp_df_2[as.logical(ave(1:nrow(temp_df_2), temp_df_2$ID, FUN=function(x) x*x == 0)), ])

#### Stop Indentification
#TODO: Confidence Assessment
# 1 - ratio of the longest event gap to the whole duration period of the stop


require("lubridate")
require("dplyr")

k = 2
d = difftime(parse_date_time("00:10:00", "H%:M%:S%"),parse_date_time("00:00:00", "H%:M%:S%")) 
g = difftime(parse_date_time("04:00:00", "H%:M%:S%"),parse_date_time("00:00:00", "H%:M%:S%")) # period definition

# if pozicija ostala ista && vrijeme manje od 4 h 
  # korak ++
  #if (skupis k ili > koraka) i (istekne 10 min od prve) 
    #potvrdi stop
#else 
  # prva pozicija = nova pozicija

# substract time as later - earlier
#ofc ne radi za nrow(dataframe) = 1, 
stop_indentification<-function(dataframe,k,d,g){
  n<-1
  stop_comfirmed <-FALSE
  first = dataframe[1,]
  
  #try doing this with apply/dplyr!!:
  #https://stackoverflow.com/questions/2275896/is-rs-apply-family-more-than-syntactic-sugar?rq=1
  for(i in 2:(nrow(dataframe))){
    curr = dataframe[i,]
    prev = dataframe[i-1 ,]
    
    if(curr$Latitude == first$Latitude && curr$Longitude == first$Longitude && ((curr$Time - prev$Time) < g)){
        n = n + 1
      if (n >= k && ((curr$Time - first$Time) >= d) && (stop_comfirmed == FALSE)){
        #valid_stop_df<<-rbind(valid_stop_df, first) # ja sam stavljala samo firs, tako da imam arrival time, a nemam departure time
        #valid_stop_df<<-rbind(valid_stop_df, cbind(first,curr$Time)) # ja sam stavljala samo first, tako da imam arrival time, a nemam departure time
        stop_comfirmed <-TRUE
      }
        
    }else{
      
      if(stop_comfirmed==TRUE)valid_stop_df<<-rbind(valid_stop_df, cbind(first,prev$Time)) #Arrival i Departure Time
      first = curr
      n<-1
      stop_comfirmed<-FALSE
    }
  }
  
  if(stop_comfirmed==TRUE)valid_stop_df<<-rbind(valid_stop_df, cbind(first,prev$Time)) #Arrival i Departure Time
  
}

#sum pocenu vrijednost staviti ko globalnu varijablu
s<<-difftime(parse_date_time("00:00:00", "H%:M%:S%"),parse_date_time("00:00:00", "H%:M%:S%")) # period definition
stop_indentification_big<-function(dataframe,k,d,g){
  
  n<-1
  stop_comfirmed <-FALSE
  first = dataframe[1,]
  #sum = difftime(parse_date_time("00:00:00", "H%:M%:S%"),parse_date_time("00:00:00", "H%:M%:S%")) # period definition
  sum = s
  
 for(i in 1:nrow(dataframe)){
    curr = dataframe[i,]

    if(curr$lat_dif == 0 && curr$lon_dif == 0 && (curr$time_dif < g)){
      n = n + 1
      sum=sum+curr$time_dif
      if (n >= (k-1) && (sum >= d) && (stop_comfirmed == FALSE)){
        stop_comfirmed <-TRUE
      }
      
    }else{
      
      #if(stop_comfirmed==TRUE)valid_stop_df<<-rbind(valid_stop_df, cbind(first,dataframe[i-1,]$Time)) #Arrival i Departure Time
      if(stop_comfirmed==TRUE)valid_stop_df<<-rbind(valid_stop_df, cbind(first$ID,dataframe[i-1,]$Time,first$Time,first$Longitude,first$Latitude)) #Arrival i Departure Time
      first = curr
      n<-1
      stop_comfirmed<-FALSE
      #sum = difftime(parse_date_time("00:00:00", "H%:M%:S%"),parse_date_time("00:00:00", "H%:M%:S%")) # period definition
      sum = s
    }
  }
  
  if(stop_comfirmed==TRUE)valid_stop_df<<-rbind(valid_stop_df, cbind(first$ID,dataframe[i-1,]$Time,first$Time,first$Longitude,first$Latitude)) #Arrival i Departure Time
  
}
valid_stop_df<<-data.frame()

system.time(sapply(unique(df$ID), function (value) stop_indentification(df[df$ID == value, ],k,d,g),simplify = TRUE))
#    user     system    elapsed 
# 1m 595.116  1.448     597.260 

#big_df_1m<-head(big_df,1000000)
#df<-big_df_1m
df<-big_df
system.time(sapply(unique(df$ID), function (value) stop_indentification_big(df[df$ID == value, ],k,d,g),simplify = TRUE))
save(valid_stop_df, file = paste(getwd(),"/valid_stop_big_df.RData", sep=""))
print("dada")
##tu sa full data?
#   user      system    elapsed 
#1m 516.224   1.932     518.782 = 8.64 min
#1m                 cca 474.999 =  min izmjena + bez monitora


df<-valid_stop_df
system.time( df <- df[as.logical(ave(1:nrow(df), df$ID, FUN=function(x) length(x) >= 2)), ])

valid_stop_df<-df
valid_stop_df_1m<-data.frame()
valid_stop_df_1m<-df
#1m ->14389 obs. ?!
#1m ->17042 obs. ?!

save(valid_stop_df, file = paste(getwd(),"/valid_stop_df_1m.RData", sep=""))

 #system.time(sapply(unique(PhoneData$ID), function (value) foo(PhoneData[PhoneData$ID == value, ]),simplify = FALSE))

require("doMC")
require("dplyr")
#system.time(group_by(PhoneData_ffdf,ID))
#Error in UseMethod("group_by_") : 
#no applicable method for 'group_by_' applied to an object of class "ffdf"
#Timing stopped at: 0 0 0.002

require("gapminder") # "Mind the gap"
gapminder %>%
  group_by(ID) %>%
  do()

gapminder %>%
  group_by(continent) %>%
  summarize(qdiff = qdiff(lifeExp, probs = c(0.2, 0.8)))

# 5 sati minumum racunajuci 2 usera po sekundi
#ima dosta usera koji imaju samo 1 zapis, mozda je najpametnije njih prvo izbaciti 
#definitivno algoritam testirati na dijelu podataka dok se ne usavrsi pokrenuti na svima
# isprobati dply i ostale prijedloge, usporediti brzine, vazno je jer planiram pokretati sa vise razlicitih 
# parametara/izvora



#mjesto za ovo:
sapply(df, function(x) length(unique(x)))
#ID      Time  Latitude Longitude 
#365689     83493       824       859 

LonLat<-data.frame(df$Latitude,df$Longitude)
names(LonLat)<- c("Longitude","Latitude")
#za boga miloga ne pokreci system.time(LonLat<-unique(LonLat))
system.time(LonLat<-distinct(LonLat))# ostalo 1027
file = paste(getwd(),"/LonLat_from_CDR_1027_pairs.RData", sep="")
save(LonLat, file=file)

file = paste(getwd(),"/LonLat_from_CDR_1027_pairs.RData", sep="")
load(file=file)
Lon_Lat <- paste(LonLat$Longitude,LonLat$Latitude, sep= "_") # ..O,P, Red, Stupac






############## journey generation ##################

require("optimbase")

file = paste(getwd(),"/valid_stop_df_1m.RData", sep="")
system.time(load(file = file))


file = paste(getwd(),"/LatLon.RData", sep="")
system.time(load(file = file))
system.time(Lon_Lat <- paste(LatLon$Latitude,LatLon$Longitude, sep= "_"))

OD_0_24_SH<<-zeros(length(Lon_Lat),length(Lon_Lat))
#names(OD_0_24_SH)<- Lon_Lat# names je krivo, treba dimnames()
#http://www.r-tutor.com/r-introduction/matrix

dimnames(OD_0_24_SH)<-list(Lon_Lat,Lon_Lat)
"
Journey Identification: Stop sequences were then converted into a set of journeys for each subscriber.
A journey is defined as 2 contiguous 'stops' that are separated by a period of at least t_min, but no more
than t_max. The value for t_min ensures that false movement hasn't slipped through the net(a double check
of the solution discussed in section 5.3). Setting t_max ensures that we are unlikely to have reconstructed
a journey that, in actually, is missing a midpoint destination.
"
#Journey Identification
to_keep_df<<-data.frame()
#journeys<<-data.frame()
#c("Start_Time","Stop_Time","Origin","Destinaton")

journey_identification<-function(dataframe,t_min, t_max){
  
  for(i in 2:nrow(dataframe)){
    curr = dataframe[i,]
    prev = dataframe[i-1 ,]
    
    if((curr$Latitude != prev$Latitude || curr$Longitude != prev$Longitude ) 
       && (curr$Time - prev$Time > t_min)
       && (curr$Time - prev$Time < t_max) )
    {
      #stop ce dodati 2 puta, jednom kao destination, jednom kao origin
      to_keep_df<<- rbind(to_keep_df, prev) 
      to_keep_df<<- rbind(to_keep_df, curr)
      
      orig = paste(prev$Latitude,prev$Longitude,sep = "_")
      dest = paste(curr$Latitude,curr$Longitude,sep = "_")
      OD_0_24_SH[orig,dest]<<- OD_0_24_SH[orig,dest] + 1
    }
  }
}
t_min = difftime(parse_date_time("00:10:00", "H%:M%:S%"), parse_date_time("00:00:00", "H%:M%:S%"))  
t_max = difftime(parse_date_time("04:00:00", "H%:M%:S%"), parse_date_time("00:00:00", "H%:M%:S%"))

#1094. observations -> 547 journeys
# sugesting 198 000 journeys in a day from 36 000 000 events
# which makes average of 24750 journeys per 3 hour period

df<-valid_stop_df
system.time(sapply(unique(df$ID), function (value) journey_identification(df[df$ID == value, ],t_min,t_max),simplify = FALSE))
#user  system elapsed 
#16.196   0.000  16.213
# 9086 obs.

save(OD_0_24_SH, file = paste(getwd(),"/OD_0_24_SH.RData", sep=""))

load(file = paste(getwd(),"/OD_0_24_SH.RData", sep=""))

journey_set<-to_keep_df
journey_set_1m<-journey_set

save(journey_set_1m, file = paste(getwd(),"/journey_set_1m.RData", sep=""))

#### Confidence Tresholding
#### Journey Cleansing
"
 Matrix Generation: From this journey set a corresponding OD matrix was created (via a simple process
of counting the number of journeys identified between each BTS). The input journey set used was also
varied through filtering to allow various forms of analysis: time of day, day of week, time of year,
minimum journey duration, minimum journey distance or journey purpose (based on work, home or
other), etc. However, at this point journey counts are restricted to our sample size.
"
### Matrix Generation
system.time(setorder(journey_set,Latitude,Longitude))

require("future.apply")
