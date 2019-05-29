cdrODM<-OD_0_24_SH
taxiODM<-OD_0_24_SH

  #241462
  x<-ODout_SH_3_6[rowSums(ODout_SH_3_6)==0]
  x<-ODout_SH_3_6[colSums(ODout_SH_3_6)==0]
  #x ne postoje takvi reci i stupci ->pobriši iz taxi

#455625
x<-subset(taxiODM, rowSums(taxiODM)!=0 & colSums(taxiODM)!=0)
#280125

#1188100
y<-subset(cdrODM, rowSums(taxiODM)!=0 & colSums(taxiODM)!=0)
#655090

d_x_1<-data.frame(dimnames(x)[1])
d_y_1<-data.frame(dimnames(y)[1])
names(d_x_1)<-c("Lon_Lat")
names(d_y_1)<-c("Lon_Lat")


library(dplyr)
d_1<-intersect(d_x_1,d_y_1)#268

d_x_2<-data.frame(dimnames(x)[2])
d_y_2<-data.frame(dimnames(y)[2])
names(d_x_2)<-c("Lon_Lat")
names(d_y_2)<-c("Lon_Lat")

d_2<-intersect(d_x_2,d_y_2)#675

d_1<-list(d_1)
d_2<-list(d_2)

x<-x[unlist(d_1),unlist(d_2)]

y<-y[unlist(d_1),unlist(d_2)]


heatmap(x, col = heat.colors(256),Rowv=NA,Colv=NA)
heatmap(y, col = heat.colors(256), Rowv=NA,Colv=NA)

SSIM(x,y,500) # 0.8330692

SSIM(x,y,256) # 0.8326957
SSIM(y,x,256) # 0.8326957


SSIM(x,y,5) # 0.8751913

MSE(x,y) # 1.84314
MSE(y,x) # 1.84314

# R2_Score not the same!!
R2_Score(x,y) #  -90.31154
R2_Score(y,x) #  -0.009956078



