#sudo apt-get install libgdal1-dev libgdal-dev libgeos-c1v5 libproj-dev
install.packages("rgdal", type = "source")
install.packages("rgeos", type = "source")
#sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
#sudo apt-get update
#sudo apt-get install libudunits2-dev libgdal-dev libgeos-dev libproj-dev 

##GDAL (>= 2.0.0), GEOS (>= 3.3.0) and Proj.4 (>= 4.8.0) are required.
#gdalinfo --version
#geos-config --version

install.packages("proj4")
install.packages("sf")
#Can't install SF in Ubuntu 16.04: Error "polygonize.o" failed · Issue #884 · r-spatial/sf
#https://github.com/r-spatial/sf/issues/884

setwd("~/CODM/Matrice")
get_ODM<-function(filename){
  ODout_SH = read.csv(file=filename, sep=",", header=TRUE, row.names = 1, check.names = FALSE ) # check.names! important
  ODout_SH = as.matrix(ODout_SH, row.names=1, col.names=1)
  
}

ODout_SH_3_6 = get_ODM("ODout_3_6SH.csv") # 481 x 520
ODout_SH_6_9 = get_ODM("ODout_6_9SH.csv") # 486 x 485 
ODout_SH_9_12 = get_ODM("ODout_9_12SH.csv")
ODout_SH_12_15 = get_ODM("ODout_12_15SH.csv")
ODout_SH_15_18 = get_ODM("ODout_15_18SH.csv")
ODout_SH_18_21 = get_ODM("ODout_18_21SH.csv")
ODout_SH_21_24 = get_ODM("ODout_21_24SH.csv")
heatmap(ODout_SH_3_6)

#ne radi
#delta<-ODout_SH_3_6[dimnames(as.vector(unlist(dimnames(ODout_SH_6_9)[1],use.names=FALSE))),dimnames(as.vector(unlist(dimnames(ODout_SH_6_9)[2],use.names=FALSE)))]
#intersect(ODout_SH_3_6,ODout_SH_6_9)
A<-ODout_SH_3_6
B<-ODout_SH_6_9

cAB <- intersect(colnames(A), colnames(B)) #442
rAB <- intersect(rownames(A), rownames(B)) #432

AA<-A[rAB,cAB]
BB<-B[rAB,cAB]

SSIM(AA,BB,256)


"
Lon_Lat form ODM:
            min         max
Longitude  
Latitude  
"

require(dplyr)
Lon_Lat_ODM<<-data.frame(Lon_Lat = "Lon_Lat") #tek toliko da nije empty
names(Lon_Lat_ODM)<-c("Lon_Lat")


get_Lon_Lat_form_ODM<-function(filename){

  setwd("~/CODM/Matrice")
  #ODout_SH = fread(file=filename, sep="auto", header=TRUE)
  #filename = "ODout_3_6SH.csv"
  ODout_SH = read.csv(file=filename, sep=",", header=TRUE, row.names = 1, check.names = FALSE ) # check.names! important
  
  #ODout_SH = as.data.frame(ODout_SH, row.names=1)
  #ODout_SH = as.matrix(ODout_SH, row.names=1)
  
  print(dim(ODout_SH))
  din <-dimnames(ODout_SH)
  
  df_1 <-as.data.frame(din[1])
  names(df_1)<-c("Lon_Lat")
  df_2 <-as.data.frame(din[2])
  names(df_2)<-c("Lon_Lat")
  
  df <- rbind(df_1,df_2)
  df<- distinct(df)
  
  Lon_Lat_ODM<<-union(Lon_Lat_ODM,df)
}

get_Lon_Lat_form_ODM("ODout_3_6SH.csv")
get_Lon_Lat_form_ODM("ODout_6_9SH.csv")
get_Lon_Lat_form_ODM("ODout_9_12SH.csv")
get_Lon_Lat_form_ODM("ODout_12_15SH.csv")
get_Lon_Lat_form_ODM("ODout_15_18SH.csv")
get_Lon_Lat_form_ODM("ODout_18_21SH.csv")
get_Lon_Lat_form_ODM("ODout_21_24SH.csv")

#676 how?

setorder(Lon_Lat_ODM,Lon_Lat) #ne sortira kako se spada, 114.131875_ ispred 114.13_ ali ajde
Lon_Lat_ODM_ALL <- Lon_Lat_ODM[-nrow(Lon_Lat_ODM),] #remove "Lat_Lon" row
Lon_Lat_ODM_ALL <-as.data.frame(Lon_Lat_ODM_ALL) 
names(Lon_Lat_ODM_ALL)<-c("Lon_Lat")

#efektivno postoje 668 ćelije
require("stringr")
LonLat <- as.data.frame(str_split_fixed(Lon_Lat_ODM_ALL$Lon_Lat,"_",2),as.numeric)
names(LonLat)<-c("Longitude","Latitude")


#as.numeric(levels(LonLat$Longitude))[LonLat]
#as.numeric(levels(LonLat$Latitude))[LonLat]

require("varhandle")

LonLat$Longitude <-unfactor(LonLat$Longitude)
LonLat$Latitude <- unfactor(LonLat$Latitude)
setorder(LonLat,Longitude,Latitude)
save(LonLat, file = paste(getwd(),"/LonLat_from_ODM_675_pairs.RData",sep=""))

"
LonLat form ODM:
            min           max
Longitude  113.7876389  114.2274306
Latitude   22.5058333   22.827995
"
setwd("~/CODM/Matrice")
file = paste(getwd(),"/LonLat_from_ODM_675_pairs.RData",sep="")
load(file = file)
LonLat_ODM = LonLat


require("tidyr")
require("stplanr")
require("benchmarkme")



