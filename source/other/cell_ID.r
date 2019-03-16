require("data.table")
require("readr") #fread
require("ggplot2")
require("dplyr")

# DISTINCT VS UNIQUE
"
LonLat from CDR:
            min         max
Longitude  113.7876    114.5192
Latitude   22.48819    22.828
"
setwd("~/CODM/masters-thesis/data/")
file = paste(getwd(),"/LonLat_from_CDR_1090_pairs.RData",sep="")
load(file = file)
LonLat_CDR = LonLat

gg = ggplot()
ggplot(data = LonLat, mapping = aes(LonLat$Longitude,LonLat$Latitude)) +  geom_point(LonLat,mapping = aes(LonLat$Longitude,LonLat$Latitude),colour = 'red',size=1) + ggtitle("CDR")

Lon_Lat_CDR <- as.data.frame(paste(LonLat_CDR$Longitude,LonLat_CDR$Latitude, sep= "_")) # ..O,P, Red, Stupac
names(Lon_Lat_CDR)<-c("Lon_Lat")

"
LonLat form OpenCellID 2018 China:
openCell ID column names are: lon and lat
            min         max
Longitude  113.7877    114.519
Latitude   22.48821    22.82753
"
  setwd("~/CODM/masters-thesis/data/cell")

    file = paste(getwd(),"/454.csv",sep="")
    cells_454 = fread(file=file, sep="auto", header=T)
    file = paste(getwd(),"/455.csv",sep="")
    cells_455 = fread(file=file, sep="auto", header=T)
    file = paste(getwd(),"/460.csv",sep="")
    cells_460 = fread(file=file, sep="auto", header=T)
  
  file = "~/CODM/masters-thesis/data/cell/cells_454_455_460.RData"
  load(file = file)

  subset_454 = cells_454[lat >= 22.48819 & lat <= 22.828 & lon >= 113.7876 & lon <= 114.5192]
  subset_455 = cells_455[lat >= 22.48819 & lat <= 22.828 & lon >= 113.7876 & lon <= 114.5192]
  subset_460 = cells_460[lat >= 22.48819 & lat <= 22.828 & lon >= 113.7876 & lon <= 114.5192]

  LatLon_454 <- data.frame(Latitude = subset_454$lat, Longitude = subset_454$lon )# 4455
  LatLon_454 <- distinct(LatLon_454)

  LatLon_455 <- data.frame(Latitude = subset_455$lat, Longitude = subset_455$lon )# 4455
  LatLon_455 <- (LatLon_455)

  LatLon_460 <- data.frame(Latitude = subset_460$lat, Longitude = subset_460$lon )# 4455
  LatLon_460 <- distinct(LatLon_460)

  LatLon<-rbind(LatLon_454,LatLon_455,LatLon_460)
  LatLon<-distinct(LatLon)
  nrow(LatLon)# 25309 #25309
  
  LonLat<-data.frame(LatLon$Longitude, LatLon$Latitude)
  names(LonLat) <- c("Longitude", "Latitude")
  save(LonLat, file = paste(getwd(),"/LonLat_from_OpenCellID_25309_pairs.RData",sep=""))

setwd("~/CODM/masters-thesis/data/cell")
file = paste(getwd(),"/LonLat_from_OpenCellID_25309_pairs.RData",sep="")
load(file = file)
LonLat_2018 = LonLat

gg = ggplot()
ggplot(data = LonLat, mapping = aes(LonLat$Longitude,LonLat$Latitude)) +  geom_point(LonLat,mapping = aes(LonLat$Longitude,LonLat$Latitude),colour = 'red',size=1) + ggtitle("OpenCellID China 454 455 460")

"
LonLat form OpenCellID 2017 entire world database:
openCell ID column names are: lon and lat
            min         max
Longitude  113.7876    114.5191
Latitude   22.4882     22.82795
"
  setwd("~/CODM/masters-thesis/data/cell")
  file = paste(getwd(),"/cell_towers_2017.csv",sep="")
  system.time(cells <- fread(file=file, sep="auto", header=T))
  subset = cells[lat >= 22.48819 & lat <= 22.828 & lon >= 113.7876 & lon <= 114.5192]
  nrow(subset)
  LonLat<-data.frame(subset$lon, subset$lat)
  names(LonLat) <- c("Longitude", "Latitude")
  LonLat<-distinct(LonLat)
  nrow(LonLat) #43705
  save(LonLat, file = paste(getwd(),"/LonLat_from_OpenCellID_2017_43705_pairs.RData",sep=""))

setwd("~/CODM/masters-thesis/data/cell")
file = paste(getwd(),"/LonLat_from_OpenCellID_2017_43705_pairs.RData",sep="")
load(file = file)
LonLat_2017 = LonLat


gg = ggplot()
ggplot(data = LonLat, mapping = aes(LonLat$Longitude,LonLat$Latitude)) +  geom_point(LonLat,mapping = aes(LonLat$Longitude,LonLat$Latitude),colour = 'red',size=1) + ggtitle("OpenCellID 2017")

"
LonLat form OpenCellID 2019 entire world database:
openCell ID column names are: lon and lat
            min         max
Longitude  113.7876    114.5191
Latitude   22.4882     22.82795
"
setwd("~/CODM/masters-thesis/data/cell")
file = paste(getwd(),"/cell_towers_2019-03-16-T000000.csv",sep="")
system.time(cells <- fread(file=file, sep="auto", header=T))
subset = cells[lat >= 22.48819 & lat <= 22.828 & lon >= 113.7876 & lon <= 114.5192]
nrow(subset)
LonLat<-data.frame(subset$lon, subset$lat)
names(LonLat) <- c("Longitude", "Latitude")
LonLat<-distinct(LonLat)
nrow(LonLat) #25922
save(LonLat, file = paste(getwd(),"/LonLat_from_OpenCellID_2019_25922_pairs.RData",sep=""))

setwd("~/CODM/masters-thesis/data/cell")
file = paste(getwd(),"/",sep="")
load(file = file)
LonLat_2019 = LonLat


gg = ggplot()
ggplot(data = LonLat, mapping = aes(LonLat$Longitude,LonLat$Latitude)) +  geom_point(LonLat,mapping = aes(LonLat$Longitude,LonLat$Latitude),colour = 'red',size=1) + ggtitle("OpenCellID 2017")

"
LonLat form SC:
            min         max
Longitude  113.7876    114.2274
Latitude   22.50583    22.828
"
  setwd("~/CODM/masters-thesis/data/cell")

  file = paste(getwd(),"/LatLonSH.csv",sep="")
  LatLonSH = fread(file = file, sep="auto", header=T)
  names(LatLonSH) <- c("ID","Longitude", "Latitude")

  LonLat = data.table(LatLonSH$Longitude,LatLonSH$Latitude)
  names(LonLat) <- c("Longitude", "Latitude")
  LonLat = distinct(LonLat)

  save(LonLat, file = paste(getwd(),"/LonLat_from_SC_2016_943_pairs.RData",sep=""))

setwd("~/CODM/masters-thesis/data/cell")
file = paste(getwd(),"/LonLat_from_SC_2016_943_pairs.RData",sep="")
load(file = file)
LonLat_SC = LonLat
#1090 -> 943 # obuhvaćeno područje je manje

gg = ggplot()
ggplot(data = LonLat, mapping = aes(LonLat$Longitude,LonLat$Latitude)) +  geom_point(LonLat,mapping = aes(LonLat$Longitude,LonLat$Latitude),colour = 'red',size=1) + ggtitle("SC 2016")

library(dplyr)
intersection = intersect(LonLat_CDR, LonLat_SC) #nrow(intersection) 943
intersection = intersect(LonLat_CDR, LonLat_ODM) #nrow(intersection) 675
intersection = intersect(LonLat_ODM, LonLat_SC) # 675 943 nrow(intersection) 670

intersection = intersect(LonLat_CDR, LonLat_2019) #nrow(intersection) 0
intersection = intersect(LonLat_CDR, LonLat_2018) #nrow(intersection) 0
intersection = intersect(LonLat_CDR, LonLat_2017) #nrow(intersection) 0

intersection = intersect(LonLat_2018, LonLat_2017)#nrow(intersection) 0 #HOW?!?!?!

intersection = intersect(LonLat_2019, LonLat_2018)#nrow(intersection) 25118 (25922 and 25309)


