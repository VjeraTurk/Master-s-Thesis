"
Import CDR_TAXSI_ODMs.RData
It contains 8 original CDR and 8 TAXI ODMs


1.  Heatmap in Grid with normalized color intensity based on 
    highest value among all heatmaps

https://stackoverflow.com/questions/37665619/heatmap-in-grid-with-normalized-color-intensity-based-on-highest-value-among-all

2. heatmap {stats}	R Documentation
   Draw a Heat Map
  
Unless Rowv = NA (or Colw = NA), the original rows and columns are reordered 
in any case to match the dendrogram, e.g., the rows by order.dendrogram(Rowv)
where Rowv is the (possibly reorder()ed) row dendrogram.
"
setwd("~/CODM/masters-thesis/data")

require(gplots)
require(optimbase)
ran = c(ODout_SH_0_3,ODout_SH_12_15, ODout_SH_15_18, ODout_SH_18_21, ODout_SH_21_24, ODout_SH_3_6, ODout_SH_6_9, ODout_SH_9_12,
        TAXI_SH_0_3, TAXI_SH_12_15,  TAXI_SH_15_18,  TAXI_SH_18_21,  TAXI_SH_21_24,  TAXI_SH_3_6, TAXI_SH_6_9, TAXI_SH_9_12) 
  #ran = c(ODout_SH_0_3,ODout_SH_12_15, ODout_SH_15_18, ODout_SH_18_21, ODout_SH_21_24, ODout_SH_3_6, ODout_SH_6_9, ODout_SH_9_12) 
  #ran = c(TAXI_SH_0_3, TAXI_SH_12_15,  TAXI_SH_15_18,  TAXI_SH_18_21,  TAXI_SH_21_24,  TAXI_SH_3_6, TAXI_SH_6_9, TAXI_SH_9_12) 

col_breaks = seq (0, max(ran),length = 100)

colPal = colorRampPalette(c('red'))(99)
  #colPal = colorRampPalette(c('red', 'yellow', 'green'))(99)


#####CDR####
heatmap(ODout_SH_15_18, breaks = col_breaks, col = colPal, Colv = NA, Rowv = NA, main="CDR 15_18")
#DIMENZIJA MATRICE 502 x 492 = 246984
size(ODout_SH_15_18) #502 492
#NAJVEĆA VRIJEDNOST
summary(as.vector(ODout_SH_15_18)) # Max. 17
#ukupna širina toka 
sum(ODout_SH_15_18)# 3875
# broj elemenata manjih od 10 koji nisu 0
length(ODout_SH_15_18[ODout_SH_15_18<10 & ODout_SH_15_18!=0])# 2657/246000 -> 10.76 %
length(ODout_SH_15_18[ODout_SH_15_18!=0]) 
#244315/246000 -> 98.92 % je null ćelija 
# 2669 !null ćelija -> 2669 / 1188100 samo 0.25 % !null ćelija

#hist(ODout_SH_15_18[ ODout_SH_15_18>10 &ODout_SH_15_18<260 ], breaks=255)
hist(ODout_SH_15_18[ ODout_SH_15_18>0], breaks=25)
hist(ODout_SH_15_18[ ODout_SH_15_18>1], breaks=25)
hist(ODout_SH_15_18[ ODout_SH_15_18>2], breaks=25)

####TAXI####
heatmap(TAXI_SH_15_18, breaks = col_breaks, col = colPal, Colv = NA, Rowv = NA, main = "TAXI 15_18")
#DIMENZIJA MATRICE 1090 x 1090
size(TAXI_SH_15_18)
summary(as.vector(TAXI_SH_15_18)) # Max. 2484
#ukupna širina toka 
sum(TAXI_SH_15_18)#58977
# broj elemenata manjih od 10 koji nisu 0
length(TAXI_SH_15_18[TAXI_SH_15_18<10 & TAXI_SH_15_18!=0])#
length(TAXI_SH_15_18[TAXI_SH_15_18==0]) #   1163676 / 1188100 -> 97.94 % je null ćelija -> 2% je !null ćelija
hist(TAXI_SH_15_18[ TAXI_SH_15_18>0], breaks=25)
hist(TAXI_SH_15_18[ TAXI_SH_15_18>50], breaks=25)
hist(TAXI_SH_15_18[ TAXI_SH_15_18>0 & TAXI_SH_15_18<50], breaks=50)

#"Normalnost"
library("ggpubr")
ggdensity(TAXI_SH_15_18[TAXI_SH_15_18>0])
ggdensity(TAXI_SH_15_18[TAXI_SH_15_18>0 & TAXI_SH_15_18<40])
ggdensity(ODout_SH_15_18[ ODout_SH_15_18>0])

# scripta 3_outliers.R

#CDR matrice ne obuhvaćaju svih 1090 ćelija već samo jedan dio područja
#Vraćanje 0 redova i stupaca u CDR matricu
  require(reshape2)
  z<-zeros(nrow(TAXI_SH_3_6),ncol(TAXI_SH_3_6)) # 1090 x 1090!
  dimnames(z)<-dimnames(TAXI_SH_3_6)
  
  #https://stackoverflow.com/questions/26042738/r-add-matrices-based-on-row-and-column-names
  cAB <- colnames(z)
  rAB <- rownames(z)
  A1 <- matrix(0, ncol=length(cAB), nrow=length(rAB), dimnames=list(rAB, cAB))
  B1 <- A1
  indxA <- outer(rAB, cAB, FUN=paste) %in% outer(rownames(ODout_SH_3_6), colnames(ODout_SH_3_6), FUN=paste) 
  indxB <- outer(rAB, cAB, FUN=paste) %in% outer(rownames(z), colnames(z), FUN=paste)
  A1[indxA] <- ODout_SH_3_6
  B1[indxB] <- z
  zODout_SH_3_6=A1+B1
  save(zODout_SH_21_24, file="zODout_SH_6_9.RData")

load("zODout_SH_15_18.RData")
heatmap(zODout_SH_15_18, breaks = col_breaks, col = colPal, Colv = NA, Rowv = NA, main = "CDR 15_18 (proširena)")

"
AA<-as.numeric(TAXI_SH_15_18)
BB<-as.numeric(zODout_SH_15_18)
mod1 <- lm(BB ~ AA)
plot(AA, BB) #traje fajn dugo
abline(mod1, lwd=2, col='red')

res <- signif(residuals(mod1), 5)
pre <- predict(mod1) # plot distances between points and the regression line
segments(AA, BB, AA, pre, col='gray')
"


# dio TAXI matrice ekvivalentan području koje pokriva original CDR matrica
  
  #nije radilo kako se spada:
  #cdr_rows<-data.frame(dimnames(ODout_SH_15_18)[1])
  #cdr_columns<-data.frame(dimnames(ODout_SH_15_18)[2])
  #names(cdr_rows)<-c("Lon_Lat")
  #names(cdr_columns)<-c("Lon_Lat")
  #sTAXI_SH_15_18 <-TAXI_SH_15_18[unlist(cdr_rows),unlist(cdr_columns)]

  sTAXI_SH_15_18 <-TAXI_SH_15_18[unlist(dimnames(ODout_SH_15_18)[1]),unlist(dimnames(ODout_SH_15_18)[2])]
  save(sTAXI_SH_15_18, file="sTAXI_SH_15_18.RData")
load("sTAXI_SH_15_18.RData")
heatmap(sTAXI_SH_15_18, breaks = col_breaks, col = colPal, Colv = NA, Rowv = NA, main="TAXI 15_18 (smanjena)")

require(graphics)
ODout_SH <-list(ODout_SH_0_3,ODout_SH_3_6,ODout_SH_6_9, ODout_SH_9_12, ODout_SH_12_15, ODout_SH_15_18, ODout_SH_18_21, ODout_SH_21_24 )
par(mfrow = c(2,2))
for (i in 1:8) {
  sirina_toka<-ODout_SH[[i]]
  hist(sirina_toka[ sirina_toka>0], breaks=25, main=paste("CDR:", i))
}

TAXI_SH <-list(TAXI_SH_0_3,  TAXI_SH_3_6, TAXI_SH_6_9, TAXI_SH_9_12, TAXI_SH_12_15,  TAXI_SH_15_18,  TAXI_SH_18_21,  TAXI_SH_21_24 )
for (i in 1:8) {
  sirina_toka<-TAXI_SH[[i]]
  hist(sirina_toka[ sirina_toka>50], breaks=25, main=paste("TAXI:", i))
}
"
AA<-as.numeric(sTAXI_SH_15_18)
BB<-as.numeric(ODout_SH_15_18)
mod1 <- lm(BB ~ AA)
plot(AA, BB) 
abline(mod1, lwd=2, col='red')

res <- signif(residuals(mod1), 5)
pre <- predict(mod1) # plot distances between points and the regression line
segments(AA, BB, AA, pre, col='gray')
"

#### 1 m 
require(gplots)
require(optimbase)
require(reshape2)

  z<-zeros(nrow(cdr),ncol(cdr)) # 1090 x 1090!
  dimnames(z)<-dimnames(cdr)
  
  #https://stackoverflow.com/questions/26042738/r-add-matrices-based-on-row-and-column-names
  cAB <- colnames(z)
  rAB <- rownames(z)
  
  A1 <- matrix(0, ncol=length(cAB), nrow=length(rAB), dimnames=list(rAB, cAB))
  B1 <- A1
  
  indxA <- outer(rAB, cAB, FUN=paste) %in% outer(rownames(taxi), colnames(taxi), FUN=paste) 
  indxB <- outer(rAB, cAB, FUN=paste) %in% outer(rownames(z), colnames(z), FUN=paste)
  A1[indxA] <- taxi
  B1[indxB] <- z
  
  ztaxi=A1+B1

load("24_h_cdr_all_vs_taxi_1m.RData")
heatmap(ztaxi, Colv = NA, Rowv = NA, main = "taxi (proširena)")
heatmap(cdr, Colv = NA, Rowv = NA, main = "cdr")

"1 new CDR matrix, for entire day 24 h
"

load("/home/adminuser/CODM/masters-thesis/data/matrices_df_10.RData")
cdr<-matrices[[1]]+matrices[[2]]+matrices[[3]]+matrices[[4]]+matrices[[5]]+matrices[[6]]+matrices[[7]]+matrices[[8]]

AA<-as.numeric(ztaxi)#taxi
BB<-as.numeric(cdr) #CDR
mod1 <- lm(BB ~ AA)
plot(AA, BB) 
abline(mod1, lwd=2, col='red')

res <- signif(residuals(mod1), 5)
pre <- predict(mod1) # plot distances between points and the regression line
segments(AA, BB, AA, pre, col='gray')


