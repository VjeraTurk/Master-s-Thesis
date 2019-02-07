require("data.table")
require("readr")

########## Import PhoneData ################

##########  Random sample 50k  ############
#PDsample = head(PhoneData,50000)
system.time( PDsample <- PhoneData[sample(nrow(PhoneData), 50000), ])
#random sample https://stat.ethz.ch/pipermail/r-help/2007-February/125860.html,  zdere ram, blocka se ako nema dosta
system.time(setorder(PDsample, Time))

PDsample_50k = PDsample 
system.time(save( PDsample_50k, file = paste(getwd(),"/PDsample_50k.RData", sep="")))

##########  Random sample 500k  ############
#PDsample = head(PhoneData,500000)
system.time( PDsample <- PhoneData[sample(nrow(PhoneData), 500000), ])
# user   system  elapsed 
# 2.036    8.120 1487.620
system.time(setorder(PDsample, Time))

PDsample_500k = PDsample 
system.time(save( PDsample_500k, file = paste(getwd(),"/PDsample_500k.RData", sep="")))

##########  Random sample 1 M  ############
#PDsample = head(PhoneData,1000000)
system.time( PDsample <- PhoneData[sample(nrow(PhoneData), 1000000), ])

system.time(setorder(PDsample, Time))

PDsample_1M = PDsample 
system.time(save( PDsample_1M, file = paste(getwd(),"/PDsample_1M.RData", sep="")))

##########  Import sample 50k  ############
file = paste(getwd(),"/PDsample_50k.RData",sep="")
system.time( load(file = file))
PDsample = PDsample_50k

##########  Import sample 500k  ############
file = paste(getwd(),"/PDsample_500k.RData",sep="")
system.time( load(file = file))
PDsample = PDsample_500k

#### Sample #### Good for both 50k and 500k samples

PDsample_backup = copy(PDsample) # copy, inace pointer
PDsample = copy(PDsample_backup)
# PDsample[, Time:= as.POSIXct(paste(Time),format("%H:%M:%S"),tz="GTM")]
# POSIX jednostavno nema format, klasa je datetime i tjt.
#require(hsm)
#PDsample$Time = as.hsm(PDsample$Time)
require(lubridate)
system.time(onlytime <- lubridate::hms(PDsample$Time))
PDsample[, .(count = .N), by = .(Time, interval = hour(onlytime) %/% 3)] #GOOD # rijesenje su stupci Time interval i count, no nisu pridodani kao dio PDsample

t1 = strptime(PDsample$Time,"%T") #doda danasnji datum "2019-01-09 01:20:18 CET" POSIXlt
t2 = parse_date_time(PDsample$Time, "H%:M%:S%") #doda datum, ali ne danasnji "0-01-01 01:20:10 UTC" POSIXct

t = t1 # 2.5 MB
t = t2 # 391.2 KB
#######