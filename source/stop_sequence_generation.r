#system('free -m')

# installing package TSdist
# probem regarding rgl package
# https://stackoverflow.com/questions/15292905/how-to-solve-the-error-missing-required-header-gl-gl-h-while-installing-the-p
# apt-get install  libx11-dev mesa-common-dev libglu1-mesa-dev


require("data.table")
require("readr")
require("ff")
require("ffbase")

setwd("~/CODM/masters-thesis/data")

  ### %H:%M:%S OK ali POSIXct ima diffTime
  #file = paste(getwd(),"/PhoneData_ordered_by_ID_Time.RData", sep="")
  #system.time(load(file = file))

  file = paste(getwd(),"/PhoneData_ID_Time_POSIXct.RData", sep="")
  system.time(load(file = file))
  system.time(PhoneData_ffdf <- as.ffdf(PhoneData))
  system.time(ffsave(PhoneData_ffdf, file = paste(getwd(),"/PhoneData_ffdf",sep="")))

system.time(ffload(paste(getwd(),"/PhoneData_ffdf",sep="")))
# user  system elapsed 
# 6.756   0.880  28.701

i = 1

abc<-function(){
  i = i+1
  print(i) # ne povecava se
}

abcd<-function(){
  
}

ffrowapply(X = PhoneData_ffdf, abcd())

#TODO, define FROM and TO (one user)
trip<-function(){
  i = 1
  while (i<nrow(PhoneData_ffdf)) {
    print(i)
    id = PhoneData_ffdf$ID[i]
    f = i
    while(PhoneData_ffdf$ID[i] == id){
      i = i+1  
    }
    t = i
    #ffapply(X = PhoneData_ffdf, FROM = paste("i",i,sep=""), TO  = paste("i",t,sep=""), abc)
    i = i +1
  }
}

system.time(trip())
#[1] 556186
#Timing stopped at: 259.4 0.852 258.9
#((nrow(PhoneData_ffdf)/556186) * 259.4 )/60/60
#[1] 4.951349 - pet sati? mora postojati bolje rjesenje

#

require(doMC)
register





phone = c("ID", "Time", "Latitude", "Longitude")
stops_df<-data.frame(phone)
starts_df<-data.frame(phone)


require("dplyr")




#ja ovo valjda smijem i u pythonu...

#s= 2 min, k = 2, d = 10 min, g = 4 hours

false_movement_reduction<-function(s){
  
}

detect_trip_start() 

detect_trip_end()

stop_indentification<-function(k,d,g){
    
}



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
#end



