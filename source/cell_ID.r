require("data.table")
require("readr") #fread
require("ggplot2")
setwd("~/CODM/masters-thesis/data/")
file = paste(getwd(),"/PhoneData",sep="")
phone = c("SIM Card ID", "Time", "Latitude", "Longitude")
PhoneData = fread(file=file, sep="auto", header=FALSE, col.names = phone)

"""
##zz=gzfile('454.csv.gz','rt')
##c454=read.csv(zz,header=T)
1: In read.table(file = file, header = header, sep = sep, quote = quote,  :
  seek on a gzfile connection returned an internal error
2: In read.table(file = file, header = header, sep = sep, quote = quote,  :
  seek on a gzfile connection returned an internal error

TODO: read form gz directly or unzip files from script (FUN ultra()?)
"""
cols<-c("Latitude","Longitude")
cells = unique(PhoneData[, .SD, .SDcols = cols])


gg = ggplot()

ggplot(data = cells, aes(cells$Longitude,cells$Latitude)) +  geom_point(cells,aes(cells$Longitude,cells$Latitude),colour = 'red',size=3) 

#not working:
#cells = PhoneData[,.cols]


names = c("ID", "lon","lat")
cells = setNames(data.table(matrix(ncol = 3, nrow = 0)), names)

cells$lon = PhoneData$Longitude
cells$lat = PhoneData$Latitude


setwd("~/CODM/masters-thesis/data/cell")

file = paste(getwd(),"/454.csv",sep="")
cells_454 = fread(file=file, sep="auto", header=T)

file = paste(getwd(),"/455.csv",sep="")
cells_455 = fread(file=file, sep="auto", header=T)

file = paste(getwd(),"/460.csv",sep="")
cells_460 = fread(file=file, sep="auto", header=T)

