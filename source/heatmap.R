"
Import CDR_TAXSI_ODMs.RData
It contains 8 original CDR and 8 TAXI ODMs.


1.  Heatmap in Grid with normalized color intensity based on 
    highest value among all heatmaps

https://stackoverflow.com/questions/37665619/heatmap-in-grid-with-normalized-color-intensity-based-on-highest-value-among-all

2. heatmap {stats}	R Documentation
   Draw a Heat Map
  
Unless Rowv = NA (or Colw = NA), the original rows and columns are reordered 
in any case to match the dendrogram, e.g., the rows by order.dendrogram(Rowv)
where Rowv is the (possibly reorder()ed) row dendrogram.
"
require(gplots)

ran = c(ODout_SH_0_3,ODout_SH_12_15, ODout_SH_15_18, ODout_SH_18_21, ODout_SH_21_24, ODout_SH_3_6, ODout_SH_6_9, ODout_SH_9_12,
        TAXI_SH_0_3, TAXI_SH_12_15,  TAXI_SH_15_18,  TAXI_SH_18_21,  TAXI_SH_21_24,  TAXI_SH_3_6, TAXI_SH_6_9, TAXI_SH_9_12) 
  #ran = c(ODout_SH_0_3,ODout_SH_12_15, ODout_SH_15_18, ODout_SH_18_21, ODout_SH_21_24, ODout_SH_3_6, ODout_SH_6_9, ODout_SH_9_12) 
  #ran = c(TAXI_SH_0_3, TAXI_SH_12_15,  TAXI_SH_15_18,  TAXI_SH_18_21,  TAXI_SH_21_24,  TAXI_SH_3_6, TAXI_SH_6_9, TAXI_SH_9_12) 

col_breaks = seq (0, max(ran),length = 100)

colPal = colorRampPalette(c('red'))(99)
  #colPal = colorRampPalette(c('red', 'yellow', 'green'))(99)


#####CDR####
heatmap(ODout_SH_15_18, breaks = col_breaks, col = colPal, Colv = NA, Rowv = NA)
#DIMENZIJA MATRICE 502 x 492
nrow(ODout_SH_15_18)#502
ncol(ODout_SH_15_18)#492
#NAJVEĆA VRIJEDNOST
summary(as.vector(ODout_SH_15_18)) # Max. 17
#ukupna širina toka 
sum(ODout_SH_15_18)#3875
# broj elemenata manjih od 10 koji nisu 0
size(ODout_SH_15_18[ODout_SH_15_18<10 & ODout_SH_15_18!=0])#2657 / 246000
size(ODout_SH_15_18[ODout_SH_15_18==0]) #   244315 / 246000
#hist(ODout_SH_15_18[ ODout_SH_15_18>10 &ODout_SH_15_18<260 ], breaks=255)
hist(ODout_SH_15_18[ ODout_SH_15_18>0], breaks=25)
hist(ODout_SH_15_18[ ODout_SH_15_18>1], breaks=25)
hist(ODout_SH_15_18[ ODout_SH_15_18>2], breaks=25)

####TAXI####
heatmap(TAXI_SH_15_18, breaks = col_breaks, col = colPal, Colv = NA, Rowv = NA)
#DIMENZIJA MATRICE 1090 x 1090
nrow(TAXI_SH_15_18)#1090
ncol(TAXI_SH_15_18)#1090
summary(as.vector(TAXI_SH_15_18)) # Max. 2484
#ukupna širina toka 
sum(TAXI_SH_15_18)#58977
# broj elemenata manjih od 10 koji nisu 0
size(TAXI_SH_15_18[TAXI_SH_15_18<10 & TAXI_SH_15_18!=0])#    23921 / 1188100
size(TAXI_SH_15_18[TAXI_SH_15_18==0]) #   1163676 / 1188100
hist(TAXI_SH_15_18[ TAXI_SH_15_18>0], breaks=250)
hist(TAXI_SH_15_18[ TAXI_SH_15_18>50], breaks=25)

#CDR matrice ne obuhvaćaju svih 1090 ćelija već samo jedan dio područja
#Vraćanje 0 redova i stupaca u CDR matricu
library(reshape2)
z<-zeros(nrow(TAXI_SH_0_3),ncol(TAXI_SH_0_3)) # 1090 x 1090!
dimnames(z)<-dimnames(TAXI_SH_0_3)
zODout_SH_0_3<-acast(rbind(melt(ODout_SH_0_3), melt(z)), Var1~Var2, sum) # 

heatmap(zODout_SH_0_3, breaks = col_breaks, col = colPal, Colv = NA, Rowv = NA)


# dio TAXI matrice ekvivalentan području koje pokriva original CDR matrica
cdr_rows<-data.frame(dimnames(ODout_SH_0_3)[1])
cdr_columns<-data.frame(dimnames(ODout_SH_0_3)[2])
names(cdr_rows)<-c("Lon_Lat")
names(cdr_columns)<-c("Lon_Lat")
sTAXI_SH_0_3 <-TAXI_SH_0_3[unlist(cdr_rows),unlist(cdr_columns)]
heatmap(sTAXI_SH_0_3, breaks = col_breaks, col = colPal, Colv = NA, Rowv = NA)
