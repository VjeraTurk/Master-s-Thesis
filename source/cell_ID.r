require("data.table")
require("readr") #fread
require("ggplot2")

###Nema tih paketa u verziji 3.5,
### TODO: how to install the same packages for new version of R
### list of packages installed -> install.packages()

setwd("~/CODM/masters-thesis/data/")
file = paste(getwd(),"/PhoneData",sep="")
phone = c("SIM Card ID", "Time", "latitude", "longitude")
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

cols<-c("latitude","longitude")
cells = unique(PhoneData[, .SD, .SDcols = cols]) #1090 obs. of 2 variables #traje


#not working:
#cells = PhoneData[,.cols]


# aes(x,y) x- longitude  , y - latitude |

gg = ggplot()
ggplot(data = cells, mapping = aes(cells$longitude,cells$latitude)) +  geom_point(cells,mapping = aes(cells$longitude,cells$latitude),colour = 'red',size=1) 


setwd("~/CODM/masters-thesis/data/cell")

file = paste(getwd(),"/454.csv",sep="")
cells_454 = fread(file=file, sep="auto", header=T)

file = paste(getwd(),"/455.csv",sep="")
cells_455 = fread(file=file, sep="auto", header=T)

file = paste(getwd(),"/460.csv",sep="")
cells_460 = fread(file=file, sep="auto", header=T)

