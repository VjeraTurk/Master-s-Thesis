library(ggplot2)
library("trajectories")
library(rlist)
require("dplyr")  
df<-PhoneData

l<<-list()

phoneDataToTracks<-function(activities){
  l<<-list.append(l,as.Track(activities$Longitude, activities$Latitude,activities$Time))#?
}

system.time(sapply(unique(df$ID), function (value) phoneDataToTracks(df[df$ID == value, ]),simplify = FALSE))
#Timing stopped at: 2369 372.6 2735
save(l, file = "listOfTracksFromPhoneData_.RData")

plot(l[[1]],xlim=c(113.60000,114.5000),ylim=c(22.40000,23.10000),lwd=2)
for(i in 2:length(l)){
  plot(l[[i]],add=T,col=i,lwd=2)
}

for(i in 2:2639){
  plot(l[[i]],add=T,col=i,lwd=2)
}

colnames(TaxiData)<-c("ID","Time","Longitude","Latitude","Status","Speed")
df<-TaxiData


taxiDataToTracks<-function(activities){
    taxi<<-list.append(taxi,as.Track(activities$Longitude, activities$Latitude,activities$Time))
}

taxi<<-list()

system.time(sapply(unique(df$ID), function (value) taxiDataToTracks(df[df$ID == value, ]),simplify = FALSE))
"Error in data.frame(distance = distance, duration = duration, speed = speed,  : 
arguments imply differing number of rows: 1, 0
In addition: There were 50 or more warnings (use warnings() to see the first 50)
"
#Timing stopped at: 687 216.9 901.5
save(taxi, file = "listOfTracksFromTaxiData.RData")#2639 elements
plot(taxi[[1]],xlim=c(113.60000,114.5000),ylim=c(22.40000,23.10000),lwd=2)

for(i in 2:200){
  plot(taxi[[i]],add=T,col=i,lwd=2)
}

for(i in 2:length(taxi)){
  plot(taxi[[i]],add=T,col=i,lwd=2)
}