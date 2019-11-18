require("dplyr")
require("data.table")
require("varhandle")
require("stringr")
require("tidyr")
require("optimbase")

LonLat<-cent_df
distances<-zeros(length(LonLat),length(LonLat))
require("fields")
distances<- rdist.earth(LonLat, miles=FALSE) 
diag(distances)<-0 #https://stackoverflow.com/questions/49245720/r-distance-matrix-with-non-zero-values-on-diagonal-rdist-earth

Lon_Lat <- paste(LonLat$Longitude,LonLat$Latitude, sep= "_")
dimnames(distances)<-list(Lon_Lat,Lon_Lat)
isSymmetric(distances)#[1] TRUE
length(distances[distances==0])
mean(distances) #15.78 #16.32
min(distances[distances!=0])# 0.07854 #HOW? #0.0620017 sa complete

#############################
require(spdep)
nb_q<-poly2nb(vor)#lista susjeda svih ćelija

#LonLat form ODM:
#  min           max
#Longitude  113.7876389  114.2274306
#Latitude   22.5058333   22.827995

n=200
nb_q[[n]]

plot(vor[n,], col = "red")
for (i in 1:nb_q[[n]]){
  plot(vor[nb_q[[n]][i],],add=TRUE, col = "green")
}

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

############ for each cell remove trips to all neighbouring voronoi cells
#m<-TAXI_SH_21_24
load("/home/adminuser/CODM/masters-thesis/data/zODout_SH_15_18.RData")
m<-zODout_SH_15_18
for( i in 1:size(m)[1]){
  for (j in 1:nb_q[[i]]) {
    m[i,j] = 0
  }
}

#Samo test
# sum(TAXI_SH_0_3)[1] 43201
# sum(m) [1] 30048

#1 - sum(m)/sum(TAXI_SH_0_3)
# 0_3 ...         -> 30% putovanja je u susjedne ćelije
# 3_6   0.3160517 -> 31% putovanje je u susjedne ćelije
# 6_9   0.3499161 -> 34%
# 9_12  0.3232531 -> 32%
# 12_15 0.3249923
# 15_18 0.3140546
# 18_21 0.313719
# 21_24 0.3121036

1 - sum(m)/sum(zODout_SH_15_18)

heatmap(zODout_SH_15_18, Colv = NA, Rowv = NA, main = "CDR 15_18")
heatmap(m, Colv = NA, Rowv = NA, main = "CDR 15_18 (bez_susjeda)")

heatmap(m, breaks = col_breaks, col = colPal, Colv = NA, Rowv = NA, main = "CDR 15_18 (bez_susjeda)")
#zCDR 15_18 -> 0.4673548 -> 47% ukupne širine toka je u susjedne ćelije
#sačuvana rezolucija
