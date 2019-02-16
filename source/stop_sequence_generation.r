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
  #   user  system elapsed 
  # 5.416   0.572   6.122 
  
  system.time(PhoneData_ffdf <- as.ffdf(PhoneData))
  system.time(ffsave(PhoneData_ffdf, file = paste(getwd(),"/PhoneData_ffdf",sep="")))
  system.time(ffload(paste(getwd(),"/PhoneData_ffdf",sep="")))
  # user  system elapsed 
  # 6.756   0.880  28.701
  #PhoneData = as.data.frame(PhoneData_ffdf) #bad idea

  ######## remove unique ID rows
  df = PhoneData
  system.time( PhoneData <- df[as.logical(ave(1:nrow(df), df$ID, FUN=function(x) length(x) > 1)), ])
  save(PhoneData, file = paste(getwd(),"/PhoneData_no_unique_ID.RData", sep=""))
  #user  system elapsed
  #66.268   4.760 245.830
  ########

#prepared for trip extraction
file = paste(getwd(),"/PhoneData_no_unique_ID.RData", sep="")
system.time(load(file = file))
#38170135 obs. of 4 variables 38,170,135
system.time(any(is.na(PhoneData))) #ne daje rezultat uz system.time(), bez system.time FALSE

#### Proximity Merging

### False movement reduction
#s= 2 min, k = 2, d = 10 min, g = 4 hours
to_remove_df<<-data.frame()

false_movement_reduction<-function(dataframe,s){

  for(i in 2:nrow(dataframe)){
    curr = dataframe[i,]
    prev = dataframe[i-1 ,]
    
    #Load Balancing
    if((curr$Latitude != prev$Latitude || curr$Longitude != prev$Longitude ) && (curr$Time - prev$Time < s))
    {
      #remove row curr from df
      #Load balancing
      print((curr$Time - prev$Time))
      to_remove_df<<- rbind(to_remove_df, curr)
    }
  }
}
require(lubridate)
s = difftime( parse_date_time("00:02:00", "H%:M%:S%"),parse_date_time("00:00:00", "H%:M%:S%")) 
sapply(unique(df$ID), function (value) false_movement_reduction(df[df$ID == value, ],s),simplify = FALSE)

require(dplyr)
df_fmr<-setdiff(df,to_remove_df)

#I want sth like: df_fmr <- df[sapply(unique(df$ID), function (value) false_movement_reduction(df[df$ID == value, ],s),simplify = FALSE)]

#### Stop Indentification
k = 2
d = difftime( parse_date_time("00:10:00", "H%:M%:S%"),parse_date_time("00:00:00", "H%:M%:S%")) 
g = difftime( parse_date_time("04:00:00", "H%:M%:S%"),parse_date_time("00:00:00", "H%:M%:S%")) 

valid_stop_df<<-data.frame()

#tako dugo dok stojis, broji "korake" i cekaj ili da istekne 10 min ili da skupis k koraka
  #kad istekne 10 min provjeri kolko koraka imas,
    #ako imas >=k -> potvrdi stop
    #ako imas <k - broji dalje -> cekaj hoces doc do k ili ces se pomaknuti
      #ako imas >=k -> potvrdi stops
      #pomaknuo si se ->nije stop

  #kad skupis k koraka provjeri jel proslo 10 min
    #ako je proslo -> potvrdi stop
    #ako nije proslo -> cekaj hoce proci ili ces se pomaknuti
      #proslo je -> potvrdi stop n > k
      #pomaknuo si se ->nije stop

  #if skupis k ili > koraka i istekne 10 min potvrdi stop
  #else if pozicija ostala ista && vrijeme manje od 4 h 
      # korak ++


stop_indentification<-function(dataframe, k,d,g){

  for(i in 2:nrow(dataframe)){
    curr = dataframe[i,]
    prev = dataframe[i-1 ,]
    
    trip_active = TRUE
    if(n < k || trip_acive ){
  
      if((curr$Latitude == prev$Latitude && curr$Longitude == prev$Longitude ) && (curr$Time - prev$Time < g) )
      {
        n = n + 1
      }
      else{
        
        trip_acive = FALSE
      }
      
    }
    
    valid_stop_df<<- rbind(valid_stop_df , ) #prva od registriranih tocaka
  
    }
}
sapply(unique(df$ID), function (value) stop_indentification(df[df$ID == value, ],k,d,g),simplify = FALSE)


#alternative:
#detect_trip_start() 
#detect_trip_end()

phone = c("ID", "Time", "Latitude", "Longitude")
stops_df<-data.frame(phone)
starts_df<-data.frame(phone)


#GLOBALNA VARIJABLA
count <<- 0
foo <- function (dataframe) {
  #print(size(dataframe))
  if(nrow(dataframe)==1){
    #assign("count", count+1, envir = .GlobalEnv )
    count <<- count + 1
    print(count)
  }
    
  #dataframe[sample(nrow(dataframe), 1), ]
}

df100 = head(PhoneData,100000)
df10 = head(PhoneData,10000)
df = df100
df = df10

any(is.na(df100)) #ne daje rezultat uz system.time(), bez system.time FALSE


system.time(sapply(unique(df$ID), function (value) foo(df[df$ID == value, ]),simplify = FALSE))


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
