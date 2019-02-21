#system('free -m') # gc()
#stackoverlfow "R: running function on multiple rows (groups) in data.frame" # view Do any of these answer your question?
require("data.table")
require("readr")
require("ff")
require("ffbase")
setwd("~/CODM/masters-thesis/data")

  ### %H:%M:%S OK ali POSIXct ima diffTime
  #file = paste(getwd(),"/PhoneData_ordered_by_ID_Time.RData", sep="")
  #system.time(load(file = file))

#"raw" CDR
  file = paste(getwd(),"/PhoneData_ID_Time_POSIXct.RData", sep="")
  system.time(load(file = file))
  #user  system elapsed 
  # 5.272   0.436   5.713 
  
  require(dplyr)
  system.time(setorder(PhoneData,Latitude,Longitude))
  system.time(LatLon<-select(PhoneData, Latitude, Longitude))
  system.time(LatLon<-distinct(LatLon)) 
  #1090 obs.
  save(LatLon, file = paste(getwd(),"/LatLon.RData", sep=""))
  
  system.time(PhoneData_ffdf <- as.ffdf(PhoneData))
  system.time(ffsave(PhoneData_ffdf, file = paste(getwd(),"/PhoneData_ffdf",sep="")))
  system.time(ffload(paste(getwd(),"/PhoneData_ffdf",sep="")))
  # user  system elapsed 
  # 6.756   0.880  28.701
  #PhoneData = as.data.frame(PhoneData_ffdf) #bad idea

######## remove users with less than k events! (won't confirm a single stop)
# I guess k * 2 events is needed to confirm 2 stops (confirm movement) #TODO test this
# rijesi se svih usera s < k evenata ili < 2k ?! 

  #https://stackoverflow.com/questions/21946201/remove-all-unique-rows
  df = PhoneData
  k = 2 
  system.time( PhoneData <- df[as.logical(ave(1:nrow(df), df$ID, FUN=function(x) length(x) >= k)), ])
  save(PhoneData, file = paste(getwd(),"/PhoneData_no_unique_ID.RData", sep=""))
  #user  system elapsed
  #66.268   4.760 245.830
  ########

#prepared for trip extraction
file = paste(getwd(),"/PhoneData_no_unique_ID.RData", sep="")
system.time(load(file = file))
#38170135 obs. of 4 variables 38,170,135
  any(is.na(PhoneData)) #ne daje rezultat uz system.time(), bez system.time FALSE

df100k = head(PhoneData,100000)
df10k = head(PhoneData,10000)
df49 = head(PhoneData,49)

df = df100k
df = df10k
df = df49

#https://www.dummies.com/programming/r/how-to-count-unique-data-values-in-r/
sapply(df, function(x) length(unique(x)))
#ID      Time  Latitude Longitude 
#1319     42453       586       599 

#### Proximity Merging
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

require(dplyr)
df_fmr<-setdiff(df,to_remove_df) #I want sth. like: df_fmr <- df[sapply(unique(df$ID), function (value) false_movement_reduction(df[df$ID == value, ],s),simplify = FALSE)]

#again remove 
# rijesi se svih usera s < k evenata ili < 2k ?!
df<-df_fmr
#k = 2
system.time( df <- df[as.logical(ave(1:nrow(df), df$ID, FUN=function(x) length(x) >= k)), ])

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
df<-valid_stop_df
system.time( df <- df[as.logical(ave(1:nrow(df), df$ID, FUN=function(x) length(x) >= 2)), ])
valid_stop_df<-df






phone = c("ID", "Time", "Latitude", "Longitude")
stops_df<-data.frame(phone)
starts_df<-data.frame(phone)

 #system.time(sapply(unique(PhoneData$ID), function (value) foo(PhoneData[PhoneData$ID == value, ]),simplify = FALSE))

require(doMC)
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


# main()
#for each user u
# for each day a
#   for each CDR event k
#     let puak = position for event k
#     if(trip_active == false)
#        trip_active = detect_trip_start()
#     end
#     if(trip_active == true)
#       trip_ended = detect_trip_end()
#     end
#       if(trip_ended)
#       store_trip()
#     end
#   end
# end
#end

#if (trip_set empty)
#  if(p uak != homebase and d(puak,homebase) < dmax and
#        d(puak,homebase) > dmin)
#    trip_active = true
#    origin = homebase
#  end
#  if(p uak != homebase and d(puak,homebase) > dmax)
#    trip_active = true
#    origin = puak
#  end
#  if(p uak == workbase and d(puak,homebase) > d max)
#    trip_active = true
#    origin = homebase
#    destination = workbase
#  end
#else
#  if(p uak != previous_trip_start(trip_set) and
#        d(previous_trip_start(trip_set), puak) > dmin)
#    origin = previous_trip_start(trip_set)
#  end
#endID Time location


# installing package TSdist
# probem regarding rgl package
# https://stackoverflow.com/questions/15292905/how-to-solve-the-error-missing-required-header-gl-gl-h-while-installing-the-p
# apt-get install  libx11-dev mesa-common-dev libglu1-mesa-dev
