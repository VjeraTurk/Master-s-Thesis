"
Journey Identification: Stop sequences were then converted into a set of journeys for each subscriber.
A journey is defined as 2 contiguous 'stops' that are separated by a period of at least t_min, but no more
than t_max. The value for t_min ensures that false movement hasn't slipped through the net(a double check
of the solution discussed in section 5.3). Setting t_max ensures that we are unlikely to have reconstructed
a journey that, in actually, is missing a midpoint destination.
"
#Journey Identification
to_keep_df<<-data.frame()
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
    }
  }
}
t_min = difftime(parse_date_time("00:10:00", "H%:M%:S%"), parse_date_time("00:00:00", "H%:M%:S%"))  
t_max = difftime(parse_date_time("04:00:00", "H%:M%:S%"), parse_date_time("00:00:00", "H%:M%:S%"))

#1094. observations -> 547 journeys
# sugesting 198 000 journeys in a day from 36 000 000 events
# which makes average of 24750 journeys per 3 hour period


system.time(sapply(unique(df$ID), function (value) journey_identification(df[df$ID == value, ],t_min,t_max),simplify = FALSE))
journey_set<-to_keep_df

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


