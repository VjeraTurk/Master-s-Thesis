require(dplyr)
require(data.table)
require("varhandle")
require("stringr")
require(tidyr)

require(optimbase)
distances<-zeros(length(LonLat),length(LonLat))
##dimnames(distances)<-list(Lon_Lat,Lon_Lat) iz nekog glupog razloga nakon rdist.earth() dimnames atribute vise ne postoji
require("fields")
distances<- rdist.earth(LonLat, miles=FALSE)
#dimnames(distances)<-list(Lon_Lat,Lon_Lat)<- ne radi?!
Lon_Lat <- paste(LonLat$Longitude,LonLat$Latitude, sep= "_")
dimnames(distances)<-list(Lon_Lat,Lon_Lat)
isSymmetric(distances)#[1] TRUE

length(distances[distances==0])#785#33
mean(distances)#15.78593 #2.914

#install.packages("spdep")
require(spdep)
nb_q<-poly2nb(vor)#lista susjeda svih ćelija

#LonLat form ODM:
#  min           max
#Longitude  113.7876389  114.2274306
#Latitude   22.5058333   22.827995


plot(vor[nb_q[[100]][1],],xlim=c(113.7876389,114.2274306),ylim=c(22.5058333,22.827995))
plot(vor[nb_q[[100]][2],],add=TRUE)

"
        46.2026
16.7246         16.9392
        46.1232
"
plot(vor[nb_q[[10]][1],],xlim=c(16.7246,16.9392),ylim=c(46.1232,46.2026))
plot(vor[nb_q[[10]][2],],add=TRUE)
plot(vor[nb_q[[10]][3],],add=TRUE)
plot(vor[nb_q[[10]][4],],add=TRUE)
plot(vor[nb_q[[10]][5],],add=TRUE)

i=1
j=1
paste(vor[nb_q[[i]][j],]$Longitude,vor[nb_q[[i]][j],]$Latitude,sep="_")
# dohvati element ^, sumiraj
# sumiraj cijeli red i vidi postotak toka iz susjednih ćelija

