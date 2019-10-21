library("ggplot2")
library("trajectories")
library("rlist")
require("dplyr")  
  ############PhoneData
  df<-PhoneData
  l<<-list()
  phoneDataToTracks<-function(activities){
    l<<-list.append(l,as.Track(activities$Longitude, activities$Latitude,activities$Time))#?
  }
  
  system.time(sapply(unique(df$ID), function (value) phoneDataToTracks(df[df$ID == value, ]),simplify = FALSE))
  #Timing stopped at: 2369 372.6 2735
  save(l, file = "listOfTracksFromPhoneData_.RData")
  
  plot(l[[1]],xlim=c(113.60000,114.2000),ylim=c(22.50000,23.00000),lwd=2)
  for(i in 2:length(l)){
    plot(l[[i]],add=T,col=i,lwd=2)
  }
  
  for(i in 2:2639){
    if(nrow(l[[i]]@sp@coords)>24) plot(l[[i]],add=T,col=i,lwd=2)
  }
  
  #TODO: proučiti što postavlja uvijet "epsilon"
  
  ############TaxiData
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

#### stplanr
#require(stplanr) #pisi kuci propalo
### travelr

load("/home/adminuser/Desktop/masters-thesis/source/listOfTracksFromTaxiData.RData")
load("/home/adminuser/Desktop/masters-thesis/source/listOfTracksFromPhoneData.RData")



q <-avemove(taxi, timestamp = "20 mins")
  #q <-avemove(taxi, timestamp = "3 hours") 
  #Error in if (!ivs[i] == 0 && !ivs[i] == nrow(X)) { : 
  #missing value where TRUE/FALSE needed

plot(q,type="l",lwd=2,cex.axis=1.7,cex.lab=1.7)
qdata <- data.frame(q,attr(q,"time"))
colnames(qdata) <- c("dist","startingtime")
  q3rd <- qdata[substr(qdata$startingtime,start = 1,stop=10)=="0-01-01",]
  plot(q3rd$startingtime,q3rd$dist,type="l",xlab="time (hour)",ylab="average movement",lwd=2,cex.axis=1.7,cex.lab=1.7,xlim=c(113.60000,114.5000),ylim=c(22.40000,23.10000))

library("spatstat")
system.time(d <- density(taxi,timestamp = "20 mins",bw.ppl))#WARNING! dugo se izvršava
system.time(d <- density(taxi,timestamp = "3 hours",bw.ppl))#WARNING!!! jako dugo se izvršava -možda i satima?
#    user   system  elapsed 
#    686.804   0.368 687.522 
par(mfrow=c(1,2),mar=rep(1,4))
plot(d,main="",ribwid=0.04,ribsep=0.02,cex.axis=1.7)

#LonLat form ODM:
#  min           max
#Longitude  113.7876389  114.2274306
#Latitude   22.5058333   22.827995

#focus on the center
  w <- owin(c(440000,455000),c(4410000,4430000)) #sto su ovi brojevi?
  pps <- attr(d,"ppps")
  
  npps <- lapply(X=1:length(pps),FUN = function(i){
    pps[[i]][w]
  })
  centerimg <- lapply(X=1:length(npps),FUN = function(i){
    density(npps[[i]],bw.ppl(npps[[i]]))
  })
  
  fcenterimg <- Reduce("+",centerimg)/length(centerimg)
  plot(fcenterimg,main="",ribwid=0.04,ribsep=0.02,cex.axis=1.7)
  

  p <- avemove(phone,timestamp = "20 mins") # ne radi ni za 3/10/8 hours
  "Error in if (!ivs[i] == 0 && !ivs[i] == nrow(X)) { : 
  missing value where TRUE/FALSE needed"
  plot(p,type="l",lwd=2,cex.axis=1.7,cex.lab=1.7)
  qdata <- data.frame(p,attr(p,"time"))
  colnames(pdata) <- c("dist","startingtime")
  p3rd <- pdata[substr(pdata$startingtime,start = 1,stop=10)=="0-01-01",]
  plot(p3rd$startingtime,p3rd$dist,type="l",xlab="time (hour)",ylab="average movement",lwd=2,cex.axis=1.7,cex.lab=1.7)


plot(phone[[1]],xlim=c(113.60000,114.5000),ylim=c(22.40000,23.10000),lwd=2)
for(i in 2:length(phone)){

    plot(phone[[i]],add=T,col=i,lwd=2)
}

c_24<<-list()
c_48<<-list()
c_96<<-list()
for(i in 2:length(phone)){
  
  if(nrow(phone[[i]]@sp@coords)>=24){
    plot(phone[[i]],add=T,col=i,lwd=2)
    c_24<<-list.append(c_24,phone[[i]])

    if(nrow(phone[[i]]@sp@coords)>=48){
      c_48<<-list.append(c_48,phone[[i]])
    
      if(nrow(phone[[i]]@sp@coords)>=96){
        c_96<<-list.append(c_96,phone[[i]])
      }
    }
  }
}

plot(c_96[[1]],xlim=c(113.60000,114.5000),ylim=c(22.40000,23.10000),lwd=2)
for(i in 2:length(c_96)){
  plot(c_96[[i]],add=T,col=i,lwd=2)
}

plot(taxi[[1]],xlim=c(113.60000,114.5000),ylim=c(22.40000,23.10000),lwd=2)
for(i in 2:length(taxi)){
  plot(taxi[[i]],add=T,col=i,lwd=2)
}

