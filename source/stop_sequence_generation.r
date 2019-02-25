#system('free -m') # gc()
#stackoverlfow "R: running function on multiple rows (groups) in data.frame" # view Do any of these answer your question?
#require("ff")
#require("ffbase")

# installing package TSdist
# probem regarding rgl package
# https://stackoverflow.com/questions/15292905/how-to-solve-the-error-missing-required-header-gl-gl-h-while-installing-the-p
# apt-get install  libx11-dev mesa-common-dev libglu1-mesa-dev

require("data.table")
require("readr")
setwd("~/CODM/masters-thesis/data")

file = paste(getwd(),"/PhoneData_no_unique_ID.RData", sep="")
system.time(load(file = file))
#38170135 obs. of 4 variables 38,170,135
  any(is.na(PhoneData)) #ne daje rezultat uz system.time(), bez system.time FALSE

df1m = head(PhoneData, 1000000)
df100k = head(PhoneData,100000)
df10k = head(PhoneData,10000)
df49 = head(PhoneData,49)

df = df1m
df = df100k
df = df10k
df = df49

#https://www.dummies.com/programming/r/how-to-count-unique-data-values-in-r/
sapply(df, function(x) length(unique(x)))
        #ID      Time  Latitude Longitude 
#100k  1319     42453       586       599 
#1m    9514                 717       752

#### Proximity Merging - TODO
####
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

  for(i in 2:nrow(dataframe)){
    curr = dataframe[i,]
    prev = dataframe[i-1 ,]
    
    #Load Balancing
    if((curr$Latitude != prev$Latitude || curr$Longitude != prev$Longitude ) && (curr$Time - prev$Time < s))
    {
      #remove row curr from df
      #Load balancing
      #print((curr$Time - prev$Time))
      to_remove_df<<- rbind(to_remove_df, curr)
    }
  }
}

require(lubridate)
s = difftime( parse_date_time("00:02:00", "H%:M%:S%"),parse_date_time("00:00:00", "H%:M%:S%")) 
system.time(sapply(unique(df$ID), function (value) false_movement_reduction(df[df$ID == value, ],s),simplify = FALSE))
#df100k
#user  system elapsed 
#100.044   0.400 100.602 

#df1m
#user   system  elapsed 
#1122.544    1.548 1126.023 
require(dplyr)
system.time(df_fmr<-setdiff(df,to_remove_df))

#I want sth. like: df_fmr <- df[sapply(unique(df$ID), function (value) false_movement_reduction(df[df$ID == value, ],s),simplify = FALSE)]

#again remove 
# rijesi se svih usera s < k evenata ili < 2k ?!
df<-df_fmr
k = 2
system.time( df <- df[as.logical(ave(1:nrow(df), df$ID, FUN=function(x) length(x) >= k)), ])
#1m -> 999949 obs.

#### Stop Indentification
#TODO: Confidence Assessment
# 1 - ratio of the longest event gap to the whole duration period of the stop

k = 2
d = difftime(parse_date_time("00:10:00", "H%:M%:S%"),parse_date_time("00:00:00", "H%:M%:S%")) 
g = difftime(parse_date_time("04:00:00", "H%:M%:S%"),parse_date_time("00:00:00", "H%:M%:S%")) # period definition

# if pozicija ostala ista && vrijeme manje od 4 h 
  # korak ++
  #if (skupis k ili > koraka) i (istekne 10 min od prve) 
    #potvrdi stop
#else 
  # prva pozicija = nova pozicija

valid_stop_df<<-data.frame()

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
        valid_stop_df<<-rbind(valid_stop_df, first)
        stop_comfirmed <-TRUE
      }
        
    }else{
      first = curr
      n<-1
      stop_comfirmed<-FALSE
    }
    
  }
}

system.time(sapply(unique(df$ID), function (value) stop_indentification(df[df$ID == value, ],k,d,g),simplify = TRUE))
# 1m
#    user   system  elapsed 
#1234.444    0.792 1237.060

df<-valid_stop_df
system.time( df <- df[as.logical(ave(1:nrow(df), df$ID, FUN=function(x) length(x) >= 2)), ])

valid_stop_df<-df
valid_stop_df_1m<-data.frame()
valid_stop_df_1m<-df
#1m ->14389 obs. 
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

############## journey generation ##################

require("optimbase")

file = paste(getwd(),"/valid_stop_df_1m.RData", sep="")
system.time(load(file = file))


file = paste(getwd(),"/LatLon.RData", sep="")
system.time(load(file = file))
system.time(Lat_Lon <- paste(LatLon$Latitude,LatLon$Longitude, sep= "_"))

OD_0_24_SH<<-zeros(length(Lat_Lon),length(Lat_Lon))
#names(OD_0_24_SH)<- Lat_Lon# names je krivo, treba dimnames()
#http://www.r-tutor.com/r-introduction/matrix

dimnames(OD_0_24_SH)<-list(Lat_Lon,Lat_Lon)
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
      
      OD_0_24_SH[origin,dest] = OD_0_24_SH[orig,dest] + 1
      
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


