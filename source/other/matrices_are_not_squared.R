 "
Matrice nisu kvadratne.

1) Smanjene isključivo na zajedničke ćelije
2) Proširene, popunjene nulama
 "

 #241462
  x<-ODout_SH_3_6[rowSums(ODout_SH_3_6)==0]
  x<-ODout_SH_3_6[colSums(ODout_SH_3_6)==0]
  #x ne postoje reci i stupci gdje je suma 0-> bili su maknuti iz matrica

setwd("/home/adminuser/CODM/masters-thesis/data")
file = paste(getwd(),"/OD_0_24_SH.RData",sep="")
load(file = file)
cdrODM<-OD_0_24_SH


file = paste(getwd(),"/OD_0_24_SH_1m_taxi.RData",sep="")
load(file = file)
taxiODM<-OD_0_24_SH
remove(OD_0_24_SH)  


taxiODM<-TAXI_SH_0_3
cdrODM<-ODout_SH_0_3

#ONE WAY
  x<-subset(taxiODM, rowSums(taxiODM)!=0 & colSums(taxiODM)!=0)
  #455625 to 280125
  y<-subset(cdrODM, rowSums(taxiODM)!=0 & colSums(taxiODM)!=0)
  #1188100 to 655090

  #OR ANOTHER
    x<-taxiODM
    y<-cdrODM
  
#ROWS - ORIGINS of both matrices
d_x_1<-data.frame(dimnames(x)[1]) #415      #675
d_y_1<-data.frame(dimnames(y)[1]) #601      #1090 ->many are empty
names(d_x_1)<-c("Lon_Lat")
names(d_y_1)<-c("Lon_Lat")

#COLUMNS - DESTINATIONS of both matrices -> shoud be reordered to match 
d_x_2<-data.frame(dimnames(x)[2]) #675      #675
d_y_2<-data.frame(dimnames(y)[2]) #1090     #1090
names(d_x_2)<-c("Lon_Lat")
names(d_y_2)<-c("Lon_Lat")

library(dplyr)

  #INTERSECT
  d_1<-intersect(d_x_1,d_y_1)#SAMO 268 zajedničkih ćelija 
  #Warning message: Column `Lon_Lat` joining factors with different levels, coercing to character vector
  d_1<-list(d_1)
  
  d_2<-intersect(d_x_2,d_y_2)#675
  d_2<-list(d_2)
  
  #matrice 268 x 675
  x<-x[unlist(d_1),unlist(d_2)]
  y<-y[unlist(d_1),unlist(d_2)]

    #OR ANOTHER
    #UNION, leave the empty zero cells, fill cells with zeros
    "d_1<-union(d_x_1,d_y_1)  #1090 ofc
    d_1<-list(d_1)
    
    d_2<-union(d_x_2,d_y_2) #1090 ofc
    d_2<-list(d_2) 
    
    require(optimbase)
    z<-zeros(nrow(d_1),nrow(d_2))
    dimnames(z)<-list(unlist(d_1),unlist(d_2))
    " #NE RADI?
  
    z<-zeros(1090,1090)
    library(reshape2)
    n<-acast(rbind(melt(y), melt(z)), Var1~Var2, sum) 
    "> summary(as.vector(n))
        Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
     0.00000  0.00000  0.00000  0.01569  0.00000 22.00000 
    > summary(as.vector(y))
        Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
     0.00000  0.00000  0.00000  0.01575  0.00000 22.00000 
    prosječna vrijednost manja je u n jer su dodani redovi i stupci sa sumom 0
    "
    
    m<-acast(rbind(melt(x), melt(z)), Var1~Var2, sum) 
    
    superheat(n)
    superheat(m)
    SSIM(m,n,5)# 0.9271069
    SSIM(m,n,256)# 0.9053707
    
    MSE(m,n) # 2.944812
    MSE(n,m) # 2.944812
    
    # R2_Score not the same!!
    R2_Score(m,n) #  -262.367
    R2_Score(n,m) #  -0.00378831

    sum(m) #11953
    sum(n) #4544
    
    max(m) #1757 
    max(m[m<1757]) #396
    max(n) #11 ->smješno
    
       
heatmap(x, col = heat.colors(256),Rowv=NA, Colv=NA)# ->TAXI
heatmap(y, col = heat.colors(256), Rowv=NA, Colv=NA)# ->CDR

require("superheat")

superheat(x)#
superheat(y)#

require("SPUTNIK")
require("MLmetrics")

SSIM(x,y,500) # 0.8330692

SSIM(x,y,256) # 0.8326957
SSIM(y,x,256) # 0.8326957


SSIM(x,y,5) # 0.8751913

require("MLmetrics")

MSE(x,y) # 1.84314
MSE(y,x) # 1.84314

# R2_Score not the same!!
R2_Score(x,y) #  -90.31154
R2_Score(y,x) #  -0.009956078

#Ukupan broj odlazaka/dolazaka za cijelu matricu (ali ne po vremenskom okviru)
sum(cdrODM)#4544
sum(taxiODM)#11953

sum(x) #6909
sum(y) #1311

max(x) #396
max(y) #11

rowSums(x)
