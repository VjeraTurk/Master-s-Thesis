anti_load_balancing(dataframe, s){
  
  if((dataframe[2]$Latitude != dataframe[1,]$Latitude || dataframe[2,]$Longitude != dataframe[1,]$Longitude ) 
     && (dataframe[2,]$Time - dataframe[1]$Time < s)){
   
    to_remove_df<<- rbind(to_remove_df, curr)
  }

}

false_movement_reduction<-function(dataframe,s){
  sapply(dataframe, function(value)anti_load_balancing(),simplify = FALSE) 
  print("done")
}

df=df49
require(lubridate)
s = difftime( parse_date_time("00:02:00", "H%:M%:S%"),parse_date_time("00:00:00", "H%:M%:S%")) 
system.time(sapply(unique(df$ID), function (value) false_movement_reduction(df[df$ID == value, ],s),simplify = FALSE))


df49/rbind(NA,head(df49,-1))-1

sapply(df49, function(x) head(x,-1) - 1 )


##vektorizacija

#Time-Time
sapply(df49, function(x) c(NA,head(x,-1)) - 1 )

library(zoo)
coredata(diff(as.zoo(df49), arithmetic = FALSE)) - 1

tail(df, -1) - head(df, -1) #very nice

