require("data.table")
require("readr") #fread
require("ggplot2")
setwd("~/CODM/masters-thesis/data/")

file = paste(getwd(),"/LatLon_from_CDR_1090_pairs.RData",sep="") 
load(file = file)
#WRONG!!!! Change names/places Latitude/Longitude
names(LatLon) <- c("Longitude", "Latitude")
LonLat<-LatLon
save(LonLat, file = paste(getwd(),"/LonLat_from_CDR_1090_pairs.RData",sep=""))

file = paste(getwd(),"/LatLon_from_CDR_1090_pairs.RData",sep="") 
load(file = file)
lat=LatLon$Latitude
LatLon$Latitude=LatLon$Longitude
LatLon$Longitude=lat
save(LatLon, file = paste(getwd(),"/LatLon_CORRECTED_from_CDR_1090_pairs.RData",sep="") )

gg = ggplot()
ggplot(data = LonLat, mapping = aes(LonLat$Longitude,LonLat$Latitude)) +  geom_point(LonLat,mapping = aes(LonLat$Longitude,LonLat$Latitude),colour = 'red',size=1) 

"
LonLat from CDR:
            min         max
Longitude  113.7876    114.5192
Latitude   22.48819    22.828

Relation: Shenzhen City (3464353)
on map: 
          22.8040
113.6604          114.6217
          22.4402

pair format: Longitude_Latitude
"

"openCell ID column names are: lon and lat"

setwd("~/CODM/masters-thesis/data/cell")
file = paste(getwd(),"/454.csv",sep="")
cells_454 = fread(file=file, sep="auto", header=T)
file = paste(getwd(),"/455.csv",sep="")
cells_455 = fread(file=file, sep="auto", header=T)
file = paste(getwd(),"/460.csv",sep="")
cells_460 = fread(file=file, sep="auto", header=T)

save.image("~/CODM/masters-thesis/data/cell/cells_454_455_460.RData")
file="~/CODM/masters-thesis/data/cell/cells_454_455_460.RData"
load(file = file)


subset_454 = cells_454[lat >= 22.48819 & lat <= 22.828 & lon >= 113.7876 & lon <= 114.5192]
subset_455 = cells_455[lat >= 22.48819 & lat <= 22.828 & lon >= 113.7876 & lon <= 114.5192]
subset_460 = cells_460[lat >= 22.48819 & lat <= 22.828 & lon >= 113.7876 & lon <= 114.5192]
