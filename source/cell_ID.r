require("data.table")

setwd("~/CODM/masters-thesis/data/cell")

"""
##zz=gzfile('454.csv.gz','rt')
##c454=read.csv(zz,header=T)
1: In read.table(file = file, header = header, sep = sep, quote = quote,  :
  seek on a gzfile connection returned an internal error
2: In read.table(file = file, header = header, sep = sep, quote = quote,  :
  seek on a gzfile connection returned an internal error
"""

file = paste(getwd(),"/454.csv",sep="")
cells_454 = fread(file=file, sep="auto", header=T)

file = paste(getwd(),"/455.csv",sep="")
cells_455 = fread(file=file, sep="auto", header=T)

file = paste(getwd(),"/460.csv",sep="")
cells_460 = fread(file=file, sep="auto", header=T)

